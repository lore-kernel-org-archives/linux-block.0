Return-Path: <markus@trippelsdorf.de>
Date: Mon, 1 May 2017 18:29:28 +0200
From: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 cosmetic] Remove trailing newline in elevator switch
 error message
Message-ID: <20170501162928.GB291@x4>
References: <20170429053808.GA293@x4>
 <1493651927.2665.3.camel@sandisk.com>
 <20170501154958.GA291@x4>
 <1493654279.2665.5.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493654279.2665.5.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Trying to switch to a non-existing elevator currently results in garbled
dmesg output, e.g.:

 # echo "foo" > /sys/block/sda/queue/scheduler 

elevator: type foo not found
elevator: switch to foo
 failed

(note the unintended line break.)

Fix by stripping the trailing newline.

Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>

diff --git a/block/elevator.c b/block/elevator.c
index bf11e70f008b..1af23eee4395 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1054,7 +1054,6 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
  */
 static int __elevator_change(struct request_queue *q, const char *name)
 {
-	char elevator_name[ELV_NAME_MAX];
 	struct elevator_type *e;
 
 	/*
@@ -1063,15 +1062,14 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	if (q->mq_ops && !strncmp(name, "none", 4))
 		return elevator_switch(q, NULL);
 
-	strlcpy(elevator_name, name, sizeof(elevator_name));
-	e = elevator_get(strstrip(elevator_name), true);
+	e = elevator_get(name, true);
 	if (!e) {
-		printk(KERN_ERR "elevator: type %s not found\n", elevator_name);
+		printk(KERN_ERR "elevator: type %s not found\n", name);
 		return -EINVAL;
 	}
 
 	if (q->elevator &&
-	    !strcmp(elevator_name, q->elevator->type->elevator_name)) {
+	    !strcmp(name, q->elevator->type->elevator_name)) {
 		elevator_put(e);
 		return 0;
 	}
@@ -1112,16 +1110,19 @@ static inline bool elv_support_iosched(struct request_queue *q)
 ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 			  size_t count)
 {
+	char elevator_name[ELV_NAME_MAX];
 	int ret;
 
 	if (!(q->mq_ops || q->request_fn) || !elv_support_iosched(q))
 		return count;
 
-	ret = __elevator_change(q, name);
+	strlcpy(elevator_name, name, sizeof(elevator_name));
+	strstrip(elevator_name);
+	ret = __elevator_change(q, elevator_name);
 	if (!ret)
 		return count;
 
-	printk(KERN_ERR "elevator: switch to %s failed\n", name);
+	printk(KERN_ERR "elevator: switch to %s failed\n", elevator_name);
 	return ret;
 }
 
-- 
Markus
