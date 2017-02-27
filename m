Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35465 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdB0Opy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 09:45:54 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so13761942wmu.2
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2017 06:45:54 -0800 (PST)
Subject: Re: nvmf regression with mq-deadline
To: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
References: <8384a5c8-c8e6-4e46-65d6-208b802f6957@grimberg.me>
 <34fb43d6-37e7-feb3-73c6-63140993ba7c@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0f06d732-fe32-bca0-8a4d-299a6cce7a6e@grimberg.me>
Date: Mon, 27 Feb 2017 16:39:03 +0200
MIME-Version: 1.0
In-Reply-To: <34fb43d6-37e7-feb3-73c6-63140993ba7c@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Now I'm getting a NULL deref with nvme-rdma [1].
>
> For some reason blk_mq_tag_to_rq() is returning NULL on
> tag 0x0 which is io queue connect.
>
> I'll try to see where this is coming from.
> This does not happen with loop though...

That's because the loop driver does not rely on the
cqe.command_id to resolve the submitted request (I'll
fix that).

Looks like blk_mq_alloc_request_hctx was overlooked when
the back assignment of the request to the rq_map...

This patch solves the issue for fabrics:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d84c66fb37b7..9611cd9920e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -312,6 +312,7 @@ struct request *blk_mq_alloc_request_hctx(struct 
request_queue *q, int rw,
                 ret = -EWOULDBLOCK;
                 goto out_queue_exit;
         }
+       alloc_data.hctx->tags->rqs[rq->tag] = rq;

         return rq;
--

If its agreed with everyone I'll send a proper patch
for this and the blk_mq_sched_setup fix?
