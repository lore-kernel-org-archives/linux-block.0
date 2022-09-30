Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA9C433FE
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 18:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiI3SeT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiI3SeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 14:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788AB1B7D95
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664562856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blyeoX43uCWFLodZ33Eb0oRW8hMqk+cpk/XX0tInob4=;
        b=Nc+YfXK3JBfebFDJR9yL0lwGnVQHeMks+CO1/REw8NcijxONA+D9vLamaGTqQpikaXRJgg
        qBm/MUxDtMl5Lu2NatdKW8zmj4rZeWqVaZ7gUyiE8oFZUieKt7d+s7FnI0XwiEhfLBlx7I
        sL/YTd2GmEITse8DF0FOOF9cqR+OrJA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-L-J_e4LYMs6y3hPWUm8hPw-1; Fri, 30 Sep 2022 14:34:12 -0400
X-MC-Unique: L-J_e4LYMs6y3hPWUm8hPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6126E80C8C1;
        Fri, 30 Sep 2022 18:34:12 +0000 (UTC)
Received: from [10.22.32.123] (unknown [10.22.32.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF813C15BA4;
        Fri, 30 Sep 2022 18:34:11 +0000 (UTC)
Message-ID: <93cb697d-3bd5-65f9-96c4-662345360337@redhat.com>
Date:   Fri, 30 Sep 2022 14:34:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com>
 <20220608165732.GB19399@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220608165732.GB19399@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/22 12:57, Michal Koutný wrote:
> @@ -2011,9 +2092,16 @@ void blk_cgroup_bio_start(struct bio *bio)
>>   	}
>>   	bis->cur.ios[rwd]++;
>>   
>> +	if (!READ_ONCE(bis->lnode.next)) {
>> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>> +
>> +		llist_add(&bis->lnode, lhead);
>> +		percpu_ref_get(&bis->blkg->refcnt);
>> +	}
>> +
> When a blkg's cgroup is rmdir'd, what happens with the lhead list?
> We have cgroup_rstat_exit() in css_free_rwork_fn() that ultimately flushes rstats.
> init_and_link_css however adds reference form blkcg->css to cgroup->css.
> The blkcg->css would be (transitively) pinned by the lhead list and
> hence would prevent the final flush (when refs drop to zero). Seems like
> a cyclic dependency.

That is not true. The percpu lhead list is embedded in blkcg but it does 
not pin blkcg. What the code does is to pin the blkg from being freed 
while it is on the lockless list. I do need to move the percpu_ref_put() 
in blkcg_rstat_flush() later to avoid use-after-free though.


>
> Luckily, there's also per-subsys flushing in css_release which could be
> moved after rmdir (offlining) but before last ref is gone:
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index adb820e98f24..d830e6a8fb3b 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5165,11 +5165,6 @@ static void css_release_work_fn(struct work_struct *work)
>
>          if (ss) {
>                  /* css release path */
> -               if (!list_empty(&css->rstat_css_node)) {
> -                       cgroup_rstat_flush(cgrp);
> -                       list_del_rcu(&css->rstat_css_node);
> -               }
> -
>                  cgroup_idr_replace(&ss->css_idr, NULL, css->id);
>                  if (ss->css_released)
>                          ss->css_released(css);
> @@ -5279,6 +5274,11 @@ static void offline_css(struct cgroup_subsys_state *css)
>          css->flags &= ~CSS_ONLINE;
>          RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
>
> +       if (!list_empty(&css->rstat_css_node)) {
> +               cgroup_rstat_flush(css->cgrp);
> +               list_del_rcu(&css->rstat_css_node);
> +       }
> +
>          wake_up_all(&css->cgroup->offline_waitq);
>   }
>
> (not tested)

I don't think that code is necessary. Anyway, I am planning go make a 
parallel set of helpers for a lockless list with sentinel variant as 
suggested.

Thanks,
Longman

