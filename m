Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7C9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 02:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbiDTCEZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 22:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347593AbiDTCEY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 22:04:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B71ADBD
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 19:01:39 -0700 (PDT)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KjkR941G3z1J9pl;
        Wed, 20 Apr 2022 10:00:53 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:01:37 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:01:37 +0800
Subject: Re: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
 <20220318130144.1066064-3-ming.lei@redhat.com>
 <eac2af72d9e73f79bbdbe8253f7562d9f17046b3.camel@intel.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <292908e4-8721-20a0-2720-e60641a1fbe4@huawei.com>
Date:   Wed, 20 Apr 2022 10:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eac2af72d9e73f79bbdbe8253f7562d9f17046b3.camel@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/04/20 9:46, Williams, Dan J 写道:
> On Fri, 2022-03-18 at 21:01 +0800, Ming Lei wrote:
>> In the whole lifetime of blkcg_gq instance, ->q will be referred, such
>> as, ->pd_free_fn() is called in blkg_free, and throtl_pd_free() still
>> may touch the request queue via &tg->service_queue.pending_timer which
>> is handled by throtl_pending_timer_fn(), so it is reasonable to grab
>> request queue's refcnt by blkcg_gq instance.
>>
>> Previously blkcg_exit_queue() is called from blk_release_queue, and it
>> is hard to avoid the use-after-free. But recently commit 1059699f87eb ("block:
>> move blkcg initialization/destroy into disk allocation/release handler")
>> is merged to for-5.18/block, it becomes simple to fix the issue by simply
>> grabbing request queue's refcnt.
> 
> This patch, upstream as commit 0a9a25ca7843 ("block: let blkcg_gq grab
> request queue's refcnt") causes the nvdimm unit tests to spam messages
> like:
> 
> [   51.439133] debugfs: Directory 'pmem2' with parent 'block' already present!
> [   52.095679] debugfs: Directory 'pmem3' with parent 'block' already present!
> [   52.505613] block device autoloading is deprecated and will be removed.
> [   52.791693] debugfs: Directory 'pmem2' with parent 'block' already present!
> [   53.240314] debugfs: Directory 'pmem3' with parent 'block' already present!
> [   53.373472] debugfs: Directory 'pmem3' with parent 'block' already present!
> [   53.688876] nd_pmem btt2.0: No existing arenas
> [   53.773097] debugfs: Directory 'pmem2s' with parent 'block' already present!
> [   53.884493] debugfs: Directory 'pmem2s' with parent 'block' already present!
> [   54.042946] debugfs: Directory 'pmem2s' with parent 'block' already present!
> [   54.195954] debugfs: Directory 'pmem2s' with parent 'block' already present!
> [   54.383989] debugfs: Directory 'pmem2' with parent 'block' already present!
> [   54.577206] nd_pmem btt3.0: No existing arenas
> 
Hi,

I saw the same warning in our test, and I posted a patch to fix the
problem:

https://patchwork.kernel.org/project/linux-block/patch/20220415035607.1836495-1-yukuai3@huawei.com/

The root cause is not relate to the above commit, see details in
the commit message.

Thanks,
Kuai
> ...on a test doing block device setup/teardown.
> 
> It is still reproducible in v5.18-rc3 and I bisected manually applying
> commit d578c770c852 ("block: avoid calling blkg_free() in atomic
> context") to avoid the other identified regression with this change.
> 
> I'll take a deeper look tomorrow. It could be this is triggering a
> latent bug in the pmem driver, but wanted to send this in case someone
> saw an immediate ordering problem caused by this change besides the one
> fixed by d578c770c852.
> 
>>
>> Reported-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>   block/blk-cgroup.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index fa063c6c0338..d53b0d69dd73 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -82,6 +82,8 @@ static void blkg_free(struct blkcg_gq *blkg)
>>                  if (blkg->pd[i])
>>                          blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>>   
>> +       if (blkg->q)
>> +               blk_put_queue(blkg->q);
>>          free_percpu(blkg->iostat_cpu);
>>          percpu_ref_exit(&blkg->refcnt);
>>          kfree(blkg);
>> @@ -167,6 +169,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
>>          if (!blkg->iostat_cpu)
>>                  goto err_free;
>>   
>> +       if (!blk_get_queue(q))
>> +               goto err_free;
>> +
>>          blkg->q = q;
>>          INIT_LIST_HEAD(&blkg->q_node);
>>          spin_lock_init(&blkg->async_bio_lock);
> 
