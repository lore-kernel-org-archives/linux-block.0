Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCDDC77B7C
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 15:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjEXPqo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbjEXPqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 11:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B291A1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684943030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=go9RJx+lgX4qOrtsLx/9OhFpQNTZr1n8I6Ri6mX7g3A=;
        b=OY7Ji2etzLebMoU0QM/1Q6JsBoiZsez7PNU4e1MKFrtTjGQb3W1JvA48PbE/fSNSQcx3Ga
        4PEWqMbtntNiDkBL5TOWCcMP6D2mD3sV4YkHhZiab99ak/Q0tEMjTxcmHFk2OAL8ZaM5cO
        fDkjO2EZt+NDoRgy2vWRp3i9a300oDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-BDVEDZY2OeKAoesJqrJYuA-1; Wed, 24 May 2023 11:43:44 -0400
X-MC-Unique: BDVEDZY2OeKAoesJqrJYuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56CC7185A792;
        Wed, 24 May 2023 15:43:44 +0000 (UTC)
Received: from [10.22.17.224] (unknown [10.22.17.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C6E240C6EC4;
        Wed, 24 May 2023 15:43:43 +0000 (UTC)
Message-ID: <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
Date:   Wed, 24 May 2023 11:43:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>
References: <20230524035150.727407-1-ming.lei@redhat.com>
 <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/23 00:26, Ming Lei wrote:
> On Wed, May 24, 2023 at 12:19:57AM -0400, Waiman Long wrote:
>> On 5/23/23 23:51, Ming Lei wrote:
>>> As noted by Michal, the blkg_iostat_set's in the lockless list hold
>>> reference to blkg's to protect against their removal. Those blkg's
>>> hold reference to blkcg. When a cgroup is being destroyed,
>>> cgroup_rstat_flush() is only called at css_release_work_fn() which
>>> is called when the blkcg reference count reaches 0. This circular
>>> dependency will prevent blkcg and some blkgs from being freed after
>>> they are made offline.
>>>
>>> It is less a problem if the cgroup to be destroyed also has other
>>> controllers like memory that will call cgroup_rstat_flush() which will
>>> clean up the reference count. If block is the only controller that uses
>>> rstat, these offline blkcg and blkgs may never be freed leaking more
>>> and more memory over time.
>>>
>>> To prevent this potential memory leak:
>>>
>>> - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
>>> can be added
>>>
>>> - don't grab bio->bi_blkg reference when adding the stats into blkcg's
>>> per-cpu stat list since all stats are guaranteed to be consumed before
>>> releasing blkg instance, and grabbing blkg reference for stats was the
>>> most fragile part of original patch
>>>
>>> Based on Waiman's patch:
>>>
>>> https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
>>>
>>> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: mkoutny@suse.com
>>> Cc: Yosry Ahmed <yosryahmed@google.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>> V2:
>>> 	- remove kernel/cgroup change, and call blkcg_rstat_flush()
>>> 	to flush stat directly
>>>
>>>    block/blk-cgroup.c | 29 +++++++++++++++++++++--------
>>>    1 file changed, 21 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index 0ce64dd73cfe..ed0eb8896972 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -34,6 +34,8 @@
>>>    #include "blk-ioprio.h"
>>>    #include "blk-throttle.h"
>>> +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
>>> +
>>>    /*
>>>     * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
>>>     * blkcg_pol_register_mutex nests outside of it and synchronizes entire
>>> @@ -163,10 +165,21 @@ static void blkg_free(struct blkcg_gq *blkg)
>>>    static void __blkg_release(struct rcu_head *rcu)
>>>    {
>>>    	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
>>> +	struct blkcg *blkcg = blkg->blkcg;
>>> +	int cpu;
>>>    #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>>>    	WARN_ON(!bio_list_empty(&blkg->async_bios));
>>>    #endif
>>> +	/*
>>> +	 * Flush all the non-empty percpu lockless lists before releasing
>>> +	 * us, given these stat belongs to us.
>>> +	 *
>>> +	 * cgroup locks aren't needed here since __blkcg_rstat_flush just
>>> +	 * propagates delta into blkg parent, which is live now.
>>> +	 */
>>> +	for_each_possible_cpu(cpu)
>>> +		__blkcg_rstat_flush(blkcg, cpu);
>>>    	/* release the blkcg and parent blkg refs this blkg has been holding */
>>>    	css_put(&blkg->blkcg->css);
>>> @@ -951,17 +964,12 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
>>>    	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
>>>    }
>>> -static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>>> +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>>>    {
>>> -	struct blkcg *blkcg = css_to_blkcg(css);
>>>    	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>>>    	struct llist_node *lnode;
>>>    	struct blkg_iostat_set *bisc, *next_bisc;
>>> -	/* Root-level stats are sourced from system-wide IO stats */
>>> -	if (!cgroup_parent(css->cgroup))
>>> -		return;
>>> -
>>>    	rcu_read_lock();
>>>    	lnode = llist_del_all(lhead);
>>> @@ -991,13 +999,19 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>>>    		if (parent && parent->parent)
>>>    			blkcg_iostat_update(parent, &blkg->iostat.cur,
>>>    					    &blkg->iostat.last);
>>> -		percpu_ref_put(&blkg->refcnt);
>>>    	}
>>>    out:
>>>    	rcu_read_unlock();
>>>    }
>>> +static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>>> +{
>>> +	/* Root-level stats are sourced from system-wide IO stats */
>>> +	if (cgroup_parent(css->cgroup))
>>> +		__blkcg_rstat_flush(css_to_blkcg(css), cpu);
>>> +}
>>> +
>> I think it may not safe to call __blkcg_rstat_flus() directly without taking
>> the cgroup_rstat_cpu_lock. That is why I added a helper to
>> kernel/cgroup/rstat.c in my patch to meet the locking requirement.
> All stats are removed from llist_del_all(), and the local list is
> iterated, then each blkg & its parent is touched in __blkcg_rstat_flus(), so
> can you explain it a bit why cgroup locks are needed? For protecting
> what?

You are right. The llist_del_all() call in blkcg_rstat_flush() is 
atomic, so it is safe for concurrent execution which is what the 
cgroup_rstat_cpu_lock protects against. That may not be the case for 
rstat callbacks of other controllers. So I will suggest you to add a 
comment to clarify that point. Other than that, you patch looks good to me.

Reviewed: Waiman Long <longman@redhat.com>

