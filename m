Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:55751 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbeDHKgb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Apr 2018 06:36:31 -0400
Received: by mail-wm0-f41.google.com with SMTP id b127so11724676wmf.5
        for <linux-block@vger.kernel.org>; Sun, 08 Apr 2018 03:36:30 -0700 (PDT)
Subject: Re: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
 <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
 <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>
Date: Sun, 8 Apr 2018 13:36:27 +0300
MIME-Version: 1.0
In-Reply-To: <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Hi Sagi
> 
> Still can reproduce this issue with the change:

Thanks for validating Yi,

Would it be possible to test the following:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 75336848f7a7..81ced3096433 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -444,6 +444,10 @@ struct request *blk_mq_alloc_request_hctx(struct 
request_queue *q,
                 return ERR_PTR(-EXDEV);
         }
         cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
+       if (cpu >= nr_cpu_ids) {
+               pr_warn("no online cpu for hctx %d\n", hctx_idx);
+               cpu = cpumask_first(alloc_data.hctx->cpumask);
+       }
         alloc_data.ctx = __blk_mq_get_ctx(q, cpu);

         rq = blk_mq_get_request(q, NULL, op, &alloc_data);
--
...


> [  153.384977] BUG: unable to handle kernel paging request at 
> 00003a9ed053bd48
> [  153.393197] IP: blk_mq_get_request+0x23e/0x390

Also would it be possible to provide gdb output of:

l *(blk_mq_get_request+0x23e)

Thanks,
