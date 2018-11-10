Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541811591.10602.10.camel@acm.org>
Subject: Re: [PATCH 7/7] block: remove the BLKPREP_* values.
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Date: Fri, 09 Nov 2018 16:59:51 -0800
In-Reply-To: <20181109134241.29346-8-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
	 <20181109134241.29346-8-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-11-09 at 14:42 +-0100, Christoph Hellwig wrote:
+AD4 Unused now.
+AD4 
+AD4 Signed-off-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4
+AD4 ---
+AD4  include/linux/blkdev.h +AHw 10 ----------
+AD4  1 file changed, 10 deletions(-)
+AD4 
+AD4 diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
+AD4 index 9b1f470cc784..55597948868b 100644
+AD4 --- a/include/linux/blkdev.h
+AD4 +-+-+- b/include/linux/blkdev.h
+AD4 +AEAAQA -778,16 +-778,6 +AEAAQA static inline unsigned int blk+AF8-queue+AF8-depth(struct request+AF8-queue +ACo-q)
+AD4  	return q-+AD4-nr+AF8-requests+ADs
+AD4  +AH0
+AD4  
+AD4 -/+ACo
+AD4 - +ACo q-+AD4-prep+AF8-rq+AF8-fn return values
+AD4 - +ACo-/
+AD4 -enum +AHs
+AD4 -	BLKPREP+AF8-OK,		/+ACo serve it +ACo-/
+AD4 -	BLKPREP+AF8-KILL,		/+ACo fatal error, kill, return -EIO +ACo-/
+AD4 -	BLKPREP+AF8-DEFER,		/+ACo leave on queue +ACo-/
+AD4 -	BLKPREP+AF8-INVALID,	/+ACo invalid command, kill, return -EREMOTEIO +ACo-/
+AD4 -+AH0AOw
+AD4 -
+AD4  extern unsigned long blk+AF8-max+AF8-low+AF8-pfn, blk+AF8-max+AF8-pfn+ADs
+AD4  
+AD4  /+ACo

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
