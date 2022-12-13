Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B0C4332F
	for <linux-block@archiver.kernel.org>; Tue, 13 Dec 2022 00:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiLMAWh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 19:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiLMAWF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 19:22:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03E1CB2A
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 16:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670890755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gI+6HXmXS35AZXXUiiiCAtaTnfFzC0toG7xNuA9nRrA=;
        b=Tu1dO6itKgbnEFFelRlVXxzPTq6mFmu4Rkftw5zqg0dbH/wmNWUDRwKJuZ3pr+/bmC0Ntt
        2VeIX0t8BbBPXKo3i3Q+qQ2AuHxBpwaQz2B0X1yZjeXEW/z2448yAmdVBxvlRuLl3la4r6
        gTHD/he75AoLPDslFvC6u7WYNVFl6pw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-vE5xQ8OyP5a4p8qoy9ut0A-1; Mon, 12 Dec 2022 19:19:11 -0500
X-MC-Unique: vE5xQ8OyP5a4p8qoy9ut0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4248185A78B;
        Tue, 13 Dec 2022 00:19:10 +0000 (UTC)
Received: from [10.22.11.98] (unknown [10.22.11.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0B6414152F4;
        Tue, 13 Dec 2022 00:19:09 +0000 (UTC)
Message-ID: <81f14365-a153-44aa-8ee7-4910f6988d7c@redhat.com>
Date:   Mon, 12 Dec 2022 19:19:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v2 3/3] blk-cgroup: Flush stats at blkgs destruction
 path
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-4-longman@redhat.com>
 <Y5eqAtwnpfEUG0EL@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y5eqAtwnpfEUG0EL@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/12/22 17:24, Tejun Heo wrote:
> On Sun, Dec 11, 2022 at 05:20:58PM -0500, Waiman Long wrote:
>> As noted by Michal, the blkg_iostat_set's in the lockless list
>> hold reference to blkg's to protect against their removal. Those
>> blkg's hold reference to blkcg. When a cgroup is being destroyed,
>> cgroup_rstat_flush() is only called at css_release_work_fn() which is
>> called when the blkcg reference count reaches 0. This circular dependency
>> will prevent blkcg from being freed until some other events cause
>> cgroup_rstat_flush() to be called to flush out the pending blkcg stats.
>>
>> To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
>> function to flush stats for a given css and cpu and call it at the blkgs
>> destruction path, blkcg_destroy_blkgs(), whenever there are still some
>> pending stats to be flushed. This will ensure that blkcg reference
>> count can reach 0 ASAP.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> But a nit below
>
>> +	/*
>> +	 * Flush all the non-empty percpu lockless lists.
>> +	 */
> Can you please explain the deadlock that's being avoided in the above
> comment? ie. it should say why this flush is necessary.

Sure. I will expand the comment to elaborate a bit more.

Cheers,
Longman

>
>> +	for_each_possible_cpu(cpu) {
>> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>> +
>> +		if (!llist_empty(lhead))
>> +			cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
>> +	}

