Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
To: Stephen Bates <sbates@raithlin.com>, Omar Sandoval <osandov@osandov.com>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
 <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
 <20170420202039.GB24823@vader.DHCP.thefacebook.com>
 <808e7f83-9f55-29cf-7472-c09daea665bd@kernel.dk>
 <0E9E52B3-977A-4159-83B3-758564FF67AD@raithlin.com>
 <6617fde7-4866-4a2d-6cf5-dc8b2c678186@kernel.dk>
 <D356CC80-F509-4427-B999-641636131E8D@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ca5bec05-ba3c-55db-6f3d-ef0965a79737@kernel.dk>
Date: Thu, 20 Apr 2017 14:53:08 -0600
MIME-Version: 1.0
In-Reply-To: <D356CC80-F509-4427-B999-641636131E8D@raithlin.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 02:47 PM, Stephen  Bates wrote:
> 
>> I agree, it's fine as-is. We should queue it up for 4.12.
> 
> Great. I will get something based on Omar’s latest comments asap.
> 
>>> However right now I am stuck as I am seeing the kernel oops I reported
>>> before in testing of my latest patchset [1]. I will try and find some
>>> time to bisect that but it looks like it was introduced when the
>>> support for mq schedulers was added (on or around bd166ef18).
> 
>> Just replied to that one, let me know if the suggestion works.
> 
> That suggestion worked. Do you want me to send a patch for it?

Is the patch going to be different than the one I sent? Here it
is, with a comment added. Can I add you tested-by?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 572966f49596..c7836a1ded97 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2928,8 +2928,17 @@ bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 	if (!blk_qc_t_is_internal(cookie))
 		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else
+	else {
 		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
+		/*
+		 * With scheduling, if the request has completed, we'll
+		 * get a NULL return here, as we clear the sched tag when
+		 * that happens. The request still remains valid, like always,
+		 * so we should be safe with just the NULL check.
+		 */
+		if (!rq)
+			return false;
+	}
 
 	return __blk_mq_poll(hctx, rq);
 }

-- 
Jens Axboe
