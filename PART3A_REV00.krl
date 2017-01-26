ruleset trip_store {
  meta {
    name "trip_store"
    logging on
    sharing on
  }
  rule collect_trips {
	select when explicit trip_processed
	pre {
      mileage = event:attr("mileage").defaultsTo(0).klog("explicit collect_trips event selected; mileage is ");
	  timestamp = time:now();
	}		
	always {
		set ent:all_trips{timestamp} mileage;
	}
  }
  rule collect_long_trips {
	select when explicit found_long_trip
	pre {
      mileage = event:attr("mileage").defaultsTo(0).klog("explicit processed_trip event selected; mileage is ");
	  timestamp = time:now();
	}		
	always {
		set ent:longest_trip mileage;
		set ent:long_trips{timestamp} mileage;
	}

  }
  rule clear_trips {
	select when car trip_reset
	always {
		log("event clear_trips seelcted");
		clear ent:all_trips;
		clear ent:long_trips;
	}
  }
}