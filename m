Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD120C001B2
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLHXAX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLHXAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 18:00:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9C7BC3A
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 15:00:13 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t2so24526ply.2
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qA/8x3qQdNdaodHCr0eE0GAtxigSH4TPjOKKEAO/Bfs=;
        b=yTcgxVv5xnN6FJi+ORQzlz6vau8+1mowWfm4xWV7+tRilP8R1pp7r2blxMovsaU9dw
         G7q08tOeuCHieA88tqcVOI664eu6JoUcCuS2RCS0+daHrqOPLD+bgYd3PItoWq4xE1LQ
         HSnyEcrB7QcC2PJ3x+50gqo1BJBqtGSWrsSg2WjFOINYgGtsyH6RQ5K6bLaPz9g8XqPs
         6SEvntKD+/SZl3BgcbEQZTwX+oKOzqcoBInz7tR9w4xOTLS1ho+ZRpDNpLxqN30vbeBj
         l4EMgdll5K3roSPmsGNkvpLTCyIvwNzA4gVTQhsn7YZV++H1Jiz7C0hDFw6XjnMFCpRa
         j6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qA/8x3qQdNdaodHCr0eE0GAtxigSH4TPjOKKEAO/Bfs=;
        b=FAZKh+QguVdtyqzgKAmVcInsajoHJS5c5Tga6FdVoS/YZMpeGaQUmxeSUcufTE9kZ9
         /I4JTit8UswXf77DqsFozVyAdEiDm+wkzPzpn2XIyR5p0Bwrpv/LepUjjhwHUIPHfjCi
         CTWcY3RCJELBEwv8Xw44DoQP3+t6UXNqujSk2aFk9su7i5/KQxRa5nvgKJwZvzzojWcZ
         4G3BQhg7ormOjUhqi9CSA6Dw2BmmZs2ppAClYBrSZHLGqasWwLdbE4624dOPR7ozG5tY
         zjjPLYrEa8nsAGN7lXaZaELYlVdAfelpXhByC5DaUTexjTOLFmh4y4EuqlCCG0a5ZArA
         IHmg==
X-Gm-Message-State: ANoB5pkwbBYPdnLxrE3uqPGm1RjEFMP0gTceSXRvkBPXTbgkOndtQkxf
        IK34KxhSj9xp40tSIYJtMGViBA==
X-Google-Smtp-Source: AA0mqf630rvvC/n5u3xrY1usx1wprEKA+LVGZdu5kB34zojm+nhtIXgF0xOrLXwJsdMiwuiSRa0H2A==
X-Received: by 2002:a05:6a20:c197:b0:a8:a203:ec90 with SMTP id bg23-20020a056a20c19700b000a8a203ec90mr1468445pzb.0.1670540413369;
        Thu, 08 Dec 2022 15:00:13 -0800 (PST)
Received: from ?IPV6:2600:380:b444:c00:74e0:9880:f256:e2b6? ([2600:380:b444:c00:74e0:9880:f256:e2b6])
        by smtp.gmail.com with ESMTPSA id 33-20020a630b21000000b0046ffe3fea77sm13570293pgl.76.2022.12.08.15.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 15:00:12 -0800 (PST)
Message-ID: <e8a09f5d-afce-608f-220b-6b32b3ae37b9@kernel.dk>
Date:   Thu, 8 Dec 2022 16:00:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH-block 3/3] blk-cgroup: Flush stats at blkgs destruction
 path
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221208220141.2625775-1-longman@redhat.com>
 <20221208220141.2625775-4-longman@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221208220141.2625775-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/8/22 3:01?PM, Waiman Long wrote:
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 793ecff29038..910e633869b0 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -281,6 +281,26 @@ void cgroup_rstat_flush_release(void)
>  	spin_unlock_irq(&cgroup_rstat_lock);
>  }
>  
> +/**
> + * cgroup_rstat_css_cpu_flush - flush stats for the given css and cpu
> + * @css: target css to be flush
> + * @cpu: the cpu that holds the stats to be flush
> + *
> + * A lightweight rstat flush operation for a given css and cpu.
> + * Only the cpu_lock is being held for mutual exclusion, the cgroup_rstat_lock
> + * isn't used.
> + */
> +void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int cpu)
> +{
> +	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
> +
> +	raw_spin_lock_irq(cpu_lock);
> +	rcu_read_lock();
> +	css->ss->css_rstat_flush(css, cpu);
> +	rcu_read_unlock();
> +	raw_spin_unlock_irq(cpu_lock);
> +}
> +
>  int cgroup_rstat_init(struct cgroup *cgrp)
>  {
>  	int cpu;

As I mentioned last time, raw_spin_lock_irq() will be equivalent to an
RCU protected section anyway, so you don't need to do both. Just add a
comment on why rcu_read_lock()/rcu_read_unlock() isn't needed inside the
raw irq safe lock.

-- 
Jens Axboe

