Return-Path: <axboe@kernel.dk>
Date: Wed, 5 Apr 2017 12:06:53 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: ->retries fixups V2
Message-ID: <20170405180653.GA5548@kernel.dk>
References: <20170405171812.19911-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170405171812.19911-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 05 2017, Christoph Hellwig wrote:
> This series fixes a few lose bits in terms of how nvme uses ->retries,
> including fixing it for non-PCIe transports.  While at it I noticed that
> nvme and scsi use the field in entirely different ways, and no other
> driver uses it at all.  So I decided to move it into the nvme_request and
> scsi_request structures instead.
> 
> Changes since V1:
>  - better changelog for one patch
>  - move the new retries field to the end of struct nvme_request

Applied for 4.12. If we do the below on my box, we remove the (now) 2
holes from struct request and shrink it 8 bytes.

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ce6f9a6534c9..3cf241b0814d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -215,6 +215,8 @@ struct request {
 
 	unsigned short ioprio;
 
+	unsigned int timeout;
+
 	void *special;		/* opaque pointer available for LLD use */
 
 	int errors;
@@ -223,7 +225,6 @@ struct request {
 
 	unsigned long deadline;
 	struct list_head timeout_list;
-	unsigned int timeout;
 
 	/*
 	 * completion callback.

-- 
Jens Axboe
