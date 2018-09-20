Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537457441.204730.7.camel@acm.org>
Subject: Re: [PATCH v9 1/8] blk-mq: Document the functions that iterate over
 requests
From: Bart Van Assche <bvanassche@acm.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Jianchao Wang
 <jianchao.w.wang@oracle.com>,  Hannes Reinecke <hare@suse.com>
Date: Thu, 20 Sep 2018 08:30:41 -0700
In-Reply-To: <20180920073527.GB5637@linux-x5ow.site>
References: <20180919224530.222469-1-bvanassche@acm.org>
	 <20180919224530.222469-2-bvanassche@acm.org>
	 <20180920073527.GB5637@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-09-20 at 09:35 +-0200, Johannes Thumshirn wrote:
+AD4 On Wed, Sep 19, 2018 at 03:45:23PM -0700, Bart Van Assche wrote: 
+AD4 +AD4 +-/+ACo
+AD4 +AD4 +- +ACo Call function +AEA-fn(+AEA-hctx, rq, +AEA-data, +AEA-reserved) for each request
+AD4 +AD4 queued on
+AD4 +AD4 +- +ACo +AEA-hctx that has been assigned a driver tag. +AEA-reserved indicates
+AD4 +AD4 whether +AEA-bt
+AD4 +AD4 +- +ACo is the breserved+AF8-tags member or the bitmap+AF8-tags member of
+AD4 +AD4 struct
+AD4 +AD4 +- +ACo blk+AF8-mq+AF8-tags.
+AD4 +AD4 +- +ACo-/
+AD4 +AD4  static void bt+AF8-for+AF8-each(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, struct
+AD4 +AD4 sbitmap+AF8-queue +ACo-bt,
+AD4 +AD4  			busy+AF8-iter+AF8-fn +ACo-fn, void +ACo-data, bool
+AD4 +AD4 reserved)
+AD4 
+AD4 One minor nit and only if you have to re-send the series, can you
+AD4 please also add the usual kernel-doc headers to the comments, i.e.:

OK, I will use the kernel-doc format.

+AD4 Otherwise:
+AD4 Reviewed-by: Johannes Thumshirn +ADw-jthumshirn+AEA-suse.de+AD4

Thanks+ACE

Bart.
