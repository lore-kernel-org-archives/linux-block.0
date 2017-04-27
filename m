Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/6] Fixup mtip32xx for scheduling
To: linux-block@vger.kernel.org
References: <1493333494-600-1-git-send-email-axboe@fb.com>
Cc: ming.lei@redhat.com, hch@lst.de
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f2e9d227-3c16-1ea0-ed51-714d8783032b@kernel.dk>
Date: Thu, 27 Apr 2017 17:12:08 -0600
MIME-Version: 1.0
In-Reply-To: <1493333494-600-1-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/27/2017 04:51 PM, Jens Axboe wrote:
> This attempts a cleaner solution, where we simply mark a request
> as having come from the reserved pool. mtip32xx can then be
> converted to using that info, and moving it's internal command
> issue over to the regular block infrastructure.
> 
> First three are prep/cleanup patches for mtip32xx, which an easier
> conversion of the driver.

I forgot one hunk when I split it up. When I tested it just now, you
end up with a warning spew from blk_execute_rq_nowait(), since
the request is not marked as passthrough. This needs to go on top of
5/6 to squash that:

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index cf11d36..5c849ff 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -195,7 +195,7 @@ static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 	if (mtip_check_surprise_removal(dd->pdev))
 		return NULL;
 
-	rq = blk_mq_alloc_request(dd->queue, 0, BLK_MQ_REQ_RESERVED);
+	rq = blk_mq_alloc_request(dd->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_RESERVED);
 	if (IS_ERR(rq))
 		return NULL;
 

-- 
Jens Axboe
