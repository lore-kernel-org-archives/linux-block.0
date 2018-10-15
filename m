Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
To: Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-um@lists.infradead.org,
 anton.ivanov@cambridgegreys.com, dwalter@google.com
References: <20181015065637.1860-1-hch@lst.de> <1771273.Wvapsmo5cm@blindfold>
 <20181015205529.GA11086@lst.de> <48119384.A7YGth2QHM@blindfold>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a33c7dfb-3eb6-3955-0336-257b8fcbfbe7@kernel.dk>
Date: Mon, 15 Oct 2018 16:04:20 -0600
MIME-Version: 1.0
In-Reply-To: <48119384.A7YGth2QHM@blindfold>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 3:46 PM, Richard Weinberger wrote:
> Am Montag, 15. Oktober 2018, 22:55:29 CEST schrieb Christoph Hellwig:
>> On Mon, Oct 15, 2018 at 10:42:47PM +0200, Richard Weinberger wrote:
>>>> Sadly not. I'm checking now what exactly is broken.
>>>
>>> I take this back. Christoph's fixup makes reading work.
>>> The previous version corrupted my test block device in interesting ways
>>> and confused all tests.
>>> But the removal of blk_rq_map_sg() still has issues.
>>> Now the device blocks endless upon flush.
>>
>> I suspect we still need to special case flush.  Updated patch below
>> including your other suggestion:
> 
> While playing further with the patch I managed to hit
> BUG_ON(blk_queued_rq(rq)) in blk_mq_requeue_request().
> 
> UML requeues the request in ubd_queue_one_vec() if it was not able
> to submit the request to the host io-thread.
> The fd can return -EAGAIN, then UML has to try later.
> 
> Isn't this allowed in that context?

It is, the problem is that queue_one_vec() doesn't always return an
error. The caller is doing a loop per bio, so we can encounter an
error, requeue, and then the caller will call us again. We're in
an illegal state at that point, and the next requeue will make that
obvious since it's already pending. Actually, both the caller and
ubd_queue_one_vec() also requeue. So it's a bit of a mess, the below
might help.


--- arch/um//drivers/ubd_kern.c~	2018-10-15 16:01:06.813391968 -0600
+++ arch/um/drivers/ubd_kern.c	2018-10-15 16:03:51.870657352 -0600
@@ -1294,7 +1294,7 @@
 {
 	struct ubd *dev = hctx->queue->queuedata;
 	struct io_thread_req *io_req;
-	int written;
+	int ret;
 
 	io_req = kmalloc(sizeof(struct io_thread_req), GFP_ATOMIC);
 	if (!io_req)
@@ -1328,15 +1328,14 @@
 		}
 	}
 
-	written = os_write_file(thread_fd, &io_req, sizeof(io_req));
-	if (written != sizeof(io_req)) {
+	ret = os_write_file(thread_fd, &io_req, sizeof(io_req));
+	if (ret != sizeof(io_req)) {
 		if (written != -EAGAIN)
-			pr_err("write to io thread failed: %d\n", -written);
-		blk_mq_requeue_request(io_req->req, true);
+			pr_err("write to io thread failed: %d\n", -ret);
 		kfree(io_req);
 	}
 
-	return 0;
+	return ret;
 }
 
 static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,

-- 
Jens Axboe
