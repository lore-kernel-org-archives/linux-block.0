Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40746 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeDKNYu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Apr 2018 09:24:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id x4so3759401wmh.5
        for <linux-block@vger.kernel.org>; Wed, 11 Apr 2018 06:24:49 -0700 (PDT)
Subject: Re: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>
 <20180408104433.GB29020@ming.t460p> <20180408104801.GC29020@ming.t460p>
 <343d151b-c953-c5d6-0ce6-f08c390ae8aa@grimberg.me>
 <20180408110417.GA19252@ming.t460p>
 <2ed81c04-b5e4-7d87-5311-34975fd67f98@grimberg.me>
 <20180408125735.GA23106@ming.t460p>
 <f5b97687-b8e6-d1f7-1588-0cfa0883f92d@grimberg.me>
 <20180409024722.GC26619@ming.t460p>
 <3760790a-e3c9-73d4-5191-16320f6cdbde@grimberg.me>
 <20180409121536.GA31165@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7ba84c0f-1f1e-770d-f99d-3526526b9a98@grimberg.me>
Date: Wed, 11 Apr 2018 16:24:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180409121536.GA31165@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 75336848f7a7..81ced3096433 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -444,6 +444,10 @@ struct request *blk_mq_alloc_request_hctx(struct
>> request_queue *q,
>>                  return ERR_PTR(-EXDEV);
>>          }
>>          cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
>> +       if (cpu >= nr_cpu_ids) {
>> +               pr_warn("no online cpu for hctx %d\n", hctx_idx);
>> +               cpu = cpumask_first(alloc_data.hctx->cpumask);
>> +       }
> 
> We may do this way for the special case, but it is ugly, IMO.

Christoph?
