Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH blktests] scsi/004: add regression test for false
 BLK_STS_OK with non good SAM status
To: Omar Sandoval <osandov@osandov.com>, Steffen Maier <maier@linux.ibm.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>, Johannes Thumshirn <jthumshirn@suse.de>,
 Bart Van Assche <bart.vanassche@wdc.com>, Hannes Reinecke <hare@suse.com>,
 Douglas Gilbert <dgilbert@interlog.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 Lee Duncan <lduncan@suse.com>
References: <1523955817-15790-1-git-send-email-maier@linux.ibm.com>
 <20180419185330.GA20941@vader> <20180419191320.GB20941@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2f661ad2-ecbd-0fdf-6188-4f900f539504@kernel.dk>
Date: Thu, 19 Apr 2018 14:04:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180419191320.GB20941@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/19/18 1:13 PM, Omar Sandoval wrote:
> On Thu, Apr 19, 2018 at 11:53:30AM -0700, Omar Sandoval wrote:
>> Thanks for the test! Applied.
> 
> Side note, it's unfortunate that this test takes 180 seconds to run only
> because we have to wait for the command timeout. We should be able to
> export request_queue->rq_timeout writeable in sysfs. Would you be
> interested in doing that?

Here's one, I even tested it.


diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d00d1b0ec109..d5d628c3c12d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -496,6 +496,27 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t queue_timeout_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%u\n", q->rq_timeout / HZ);
+}
+
+static ssize_t queue_timeout_store(struct request_queue *q, const char *page,
+				   size_t count)
+{
+	unsigned long timeout;
+	ssize_t ret;
+
+	ret = queue_var_store(&timeout, page, count);
+	if (ret < 0)
+		return ret;
+	if (!timeout)
+		return -EINVAL;
+
+	blk_queue_rq_timeout(q, timeout * HZ);
+	return count;
+}
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_requests_show,
@@ -678,6 +699,12 @@ static struct queue_sysfs_entry throtl_sample_time_entry = {
 };
 #endif
 
+static struct queue_sysfs_entry queue_timeout_entry = {
+	.attr = {.name = "timeout", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_timeout_show,
+	.store = queue_timeout_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -714,6 +741,7 @@ static struct attribute *default_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
+	&queue_timeout_entry.attr,
 	NULL,
 };
 

-- 
Jens Axboe
