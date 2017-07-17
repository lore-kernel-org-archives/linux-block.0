Return-Path: <BATV+0dcb2ced70f4a2e24250+5076+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 17 Jul 2017 00:53:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tomi Sarvela <tomi.p.sarvela@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: linux-next scsi-mq hang in suspend-resume
Message-ID: <20170717075341.GA19733@infradead.org>
References: <21128504.iYAzanzLsA@fractal.fi.intel.com>
 <dd9daa92-0c9c-51dd-95b5-961cfd1fca36@kernel.dk>
 <20170713071220.GA19972@infradead.org>
 <20170714124424.GA28150@infradead.org>
 <d455b080-13ff-af9c-c793-7a47356fee6f@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
In-Reply-To: <d455b080-13ff-af9c-c793-7a47356fee6f@intel.com>
List-ID: <linux-block@vger.kernel.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I still haven't gotten hold of an i915 machine where I could
run the actua ltest suite.

But I did some audit of the code, and it seems blk-mq is lacking
support for the RQF_PM flag.  While I can't directly see how
this would cause the hang your caused it's a least easy to test.

Can you apply the patch below and test with the use_blk_mq=0 parameter?

Note that implementing RQF_PM for blk-mq shouldn't be too hard either,
but if we don't get rid of the nr_pending counter somehow it would
be a severe performance penalty for all scsi devices.

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sd.diff"

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index bea36adeee17..5c3818ebee9c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -554,7 +554,7 @@ static struct scsi_driver sd_template = {
 		.probe		= sd_probe,
 		.remove		= sd_remove,
 		.shutdown	= sd_shutdown,
-		.pm		= &sd_pm_ops,
+//		.pm		= &sd_pm_ops,
 	},
 	.rescan			= sd_rescan,
 	.init_command		= sd_init_command,
@@ -3249,7 +3249,7 @@ static void sd_probe_async(void *data, async_cookie_t cookie)
 		gd->events |= DISK_EVENT_MEDIA_CHANGE;
 	}
 
-	blk_pm_runtime_init(sdp->request_queue, dev);
+//	blk_pm_runtime_init(sdp->request_queue, dev);
 	device_add_disk(dev, gd);
 	if (sdkp->capacity)
 		sd_dif_config_host(sdkp);

--KsGdsel6WgEHnImy--
