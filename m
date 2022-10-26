Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7377FA373E
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 13:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiJZNBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiJZNBJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 09:01:09 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7D394136
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 06:01:05 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id jb18so6718637wmb.4
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ck2ik0fe+i8crSJiNtn0gF6zzg9wdmgr7S9E9ek1RyY=;
        b=FSEt+XQVS49CjCwTYRXeRzNa9i2FBIEbTi8XT2aswIQ7+toxhynsoO+K6k5/6+vlNp
         Qss1JA8buHYB0IQS4VnY+RqM+Cqq4RKzpvVLwZXiPm/4KzU5GC9FGRKxtDENH+7jpn+M
         zmQIEeivxFbS5qWp28TIN+Vz/eYme5Ix9FBm4ICotORRudjO02SOO/MYOKbTYy17LPpV
         6uMYlY8H9/x4KeMjqVFkJSPJocFpqiGZDi9r/gRMrEKtL9FB4A+1lAh+g6IPb51rT18M
         wQYsZ56qhxxRft9iVr9hIlY/jF2/7writnEzZdhrfTiirr754+Pe69s2Og2j02ByX5Sf
         dfnw==
X-Gm-Message-State: ACrzQf0xdeMepYtcZlJEj6G0J4B9PO87JPNNaGtVHWgFu4QeUXJC4C4Y
        1lxhuelvkkmTvXi8Uoggmhc=
X-Google-Smtp-Source: AMsMyM5f+6HjwRJ+Gam5Jyfzk+NxsDN1TXYyMOFk+kg5W5LC2wzBbdOzLBU92n6VjKrOZzUKMpf92Q==
X-Received: by 2002:a05:600c:4587:b0:3c6:f645:dbc2 with SMTP id r7-20020a05600c458700b003c6f645dbc2mr2393525wmo.83.1666789264226;
        Wed, 26 Oct 2022 06:01:04 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d17-20020adf9b91000000b0022e55f40bc7sm5360470wrc.82.2022.10.26.06.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 06:01:03 -0700 (PDT)
Message-ID: <73072365-adc5-1430-0b12-f552fd99b96e@grimberg.me>
Date:   Wed, 26 Oct 2022 16:01:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 14/17] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-15-hch@lst.de>
 <12eb7ad8-6b70-092a-978c-a2c1ba595ad4@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <12eb7ad8-6b70-092a-978c-a2c1ba595ad4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/26/22 11:48, Chao Leng wrote:
> 
> 
> On 2022/10/25 22:40, Christoph Hellwig wrote:
>> All I/O submissions have fairly similar latencies, and a tagset-wide
>> quiesce is a fairly common operation.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Keith Busch <kbusch@kernel.org>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>> Reviewed-by: Chao Leng <lengchao@huawei.com>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   block/blk-core.c       | 27 +++++----------------------
>>   block/blk-mq.c         | 33 +++++++++++++++++++++++++--------
>>   block/blk-mq.h         | 14 +++++++-------
>>   block/blk-sysfs.c      |  9 ++-------
>>   block/blk.h            |  9 +--------
>>   block/genhd.c          |  2 +-
>>   include/linux/blk-mq.h |  4 ++++
>>   include/linux/blkdev.h |  9 ---------
>>   8 files changed, 45 insertions(+), 62 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 17667159482e0..3a2ed8dadf738 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -65,7 +65,6 @@ DEFINE_IDA(blk_queue_ida);
>>    * For queue allocation
>>    */
>>   struct kmem_cache *blk_requestq_cachep;
>> -struct kmem_cache *blk_requestq_srcu_cachep;
>>   /*
>>    * Controlling structure to kblockd
>> @@ -373,26 +372,20 @@ static void blk_timeout_work(struct work_struct 
>> *work)
>>   {
>>   }
>> -struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>> +struct request_queue *blk_alloc_queue(int node_id)
>>   {
>>       struct request_queue *q;
>> -    q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
>> -            GFP_KERNEL | __GFP_ZERO, node_id);
>> +    q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | 
>> __GFP_ZERO,
>> +                  node_id);
>>       if (!q)
>>           return NULL;
>> -    if (alloc_srcu) {
>> -        blk_queue_flag_set(QUEUE_FLAG_HAS_SRCU, q);
>> -        if (init_srcu_struct(q->srcu) != 0)
>> -            goto fail_q;
>> -    }
>> -
>>       q->last_merge = NULL;
>>       q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
>>       if (q->id < 0)
>> -        goto fail_srcu;
>> +        goto fail_q;
>>       q->stats = blk_alloc_queue_stats();
>>       if (!q->stats)
>> @@ -435,11 +428,8 @@ struct request_queue *blk_alloc_queue(int 
>> node_id, bool alloc_srcu)
>>       blk_free_queue_stats(q->stats);
>>   fail_id:
>>       ida_free(&blk_queue_ida, q->id);
>> -fail_srcu:
>> -    if (alloc_srcu)
>> -        cleanup_srcu_struct(q->srcu);
>>   fail_q:
>> -    kmem_cache_free(blk_get_queue_kmem_cache(alloc_srcu), q);
>> +    kmem_cache_free(blk_requestq_cachep, q);
>>       return NULL;
>>   }
>> @@ -1184,9 +1174,6 @@ int __init blk_dev_init(void)
>>               sizeof_field(struct request, cmd_flags));
>>       BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
>>               sizeof_field(struct bio, bi_opf));
>> -    BUILD_BUG_ON(ALIGN(offsetof(struct request_queue, srcu),
>> -               __alignof__(struct request_queue)) !=
>> -             sizeof(struct request_queue));
>>       /* used for unplugging and affects IO latency/throughput - 
>> HIGHPRI */
>>       kblockd_workqueue = alloc_workqueue("kblockd",
>> @@ -1197,10 +1184,6 @@ int __init blk_dev_init(void)
>>       blk_requestq_cachep = kmem_cache_create("request_queue",
>>               sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
>> -    blk_requestq_srcu_cachep = kmem_cache_create("request_queue_srcu",
>> -            sizeof(struct request_queue) +
>> -            sizeof(struct srcu_struct), 0, SLAB_PANIC, NULL);
>> -
>>       blk_debugfs_root = debugfs_create_dir("block", NULL);
>>       return 0;
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 802fdd3d737e3..6cbf34921e33f 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -261,8 +261,8 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>>    */
>>   void blk_mq_wait_quiesce_done(struct request_queue *q)
>>   {
>> -    if (blk_queue_has_srcu(q))
>> -        synchronize_srcu(q->srcu);
>> +    if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
>> +        synchronize_srcu(q->tag_set->srcu);
>>       else
>>           synchronize_rcu();
>>   }
>> @@ -3971,7 +3971,7 @@ static struct request_queue 
>> *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
>>       struct request_queue *q;
>>       int ret;
>> -    q = blk_alloc_queue(set->numa_node, set->flags & BLK_MQ_F_BLOCKING);
>> +    q = blk_alloc_queue(set->numa_node);
>>       if (!q)
>>           return ERR_PTR(-ENOMEM);
>>       q->queuedata = queuedata;
>> @@ -4138,9 +4138,6 @@ static void blk_mq_update_poll_flag(struct 
>> request_queue *q)
>>   int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>>           struct request_queue *q)
>>   {
>> -    WARN_ON_ONCE(blk_queue_has_srcu(q) !=
>> -            !!(set->flags & BLK_MQ_F_BLOCKING));
>> -
>>       /* mark the queue as mq asap */
>>       q->mq_ops = set->ops;
>> @@ -4398,9 +4395,19 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set 
>> *set)
>>        */
>>       if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
>>           set->nr_hw_queues = nr_cpu_ids;
>> +
>> +    if (set->flags & BLK_MQ_F_BLOCKING) {
>> +        set->srcu = kmalloc(sizeof(*set->srcu), GFP_KERNEL);
> Memory with contiguous physical addresses is not necessary, maybe it is 
> a better choice to use kvmalloc,
> because sizeof(*set->srcu) is a little large.
> kvmalloc() is more friendly to scenarios where memory is insufficient 
> and running for a long time.

Huh?

(gdb) p sizeof(struct srcu_struct)
$1 = 392

