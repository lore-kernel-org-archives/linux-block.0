Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38402 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDIJN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Apr 2018 05:13:59 -0400
Received: by mail-wr0-f171.google.com with SMTP id m13so8657688wrj.5
        for <linux-block@vger.kernel.org>; Mon, 09 Apr 2018 02:13:58 -0700 (PDT)
Subject: Re: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
To: Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
 <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
 <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>
 <20180408104433.GB29020@ming.t460p> <20180408104801.GC29020@ming.t460p>
 <343d151b-c953-c5d6-0ce6-f08c390ae8aa@grimberg.me>
 <20180408110417.GA19252@ming.t460p>
 <2ed81c04-b5e4-7d87-5311-34975fd67f98@grimberg.me>
 <20180408125735.GA23106@ming.t460p>
 <f5b97687-b8e6-d1f7-1588-0cfa0883f92d@grimberg.me>
 <20180409024722.GC26619@ming.t460p>
 <3760790a-e3c9-73d4-5191-16320f6cdbde@grimberg.me>
 <9eb1d6ba-3994-596f-1b90-38a9b879f416@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ed751300-fa5c-95ed-588a-7e5eac5660bc@grimberg.me>
Date: Mon, 9 Apr 2018 12:13:56 +0300
MIME-Version: 1.0
In-Reply-To: <9eb1d6ba-3994-596f-1b90-38a9b879f416@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Hi Sagi
> Sorry for the late response, bellow patch works, here is the full log:

Thanks for testing!

Now that we isolated the issue, the question is if this fix is correct
given that we are guaranteed that the connect context will run on an
online cpu?

another reference to the patch (we can make the pr_warn a pr_debug):
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
