Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BA9C6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCWQAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjCWQAg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 12:00:36 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9647625290
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:00:32 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hf2so22939755qtb.3
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679587231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQQYR3tgoTZGjn44UlqD2Q/Bi/7ZZ0L1D2F+tNyu+vY=;
        b=JUSYGg90JZTT6Yd13pjG6DLnrb2PDfmyEiLktcz2+MNdTX1qhs8SEmuA54OaIlpPJb
         DxtqFpASEbLE1v0MWbPxSyp5iJvz/cWT8oHdtMYHkFXPLcVCi5GYkPZurEN1bWPwQDzC
         weuJE2NJS7RteJovT2yARUM6DjWrj4KVVFVUPsqLMqvDhc6sSQI6Mvr+an7mCsZje+Ma
         HzcrGuLfySAPmUsyXVd3Jh0ih8mkd/t0KaiLpkyblfIp5tKl5BXeCDVIuYG91jK7wKEU
         fOndc7BtP6DmMZ+/1A5temMFZBDYv1b7xByaHD0exVuhFbacP6Sn5JBtcOlh09PvP/Ah
         bUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQQYR3tgoTZGjn44UlqD2Q/Bi/7ZZ0L1D2F+tNyu+vY=;
        b=t9tMv0PUj0u62I/QK+UzqbCpZahXUB1z6ruD+YuJRE1mEUz7/tioXLdSS+s+WS+BC4
         2yF0Q9Q/VW9ZEy4axjQsDYERJSPz6SmnachEku6gk72AQrT1s3HmPx1b2Ey1XVnYujqi
         cUQcJsSA8GpeH+ptpNw5FcMtF74v4aHoiAD4xAjAR28eSliIdLHoSx/8ipXnz5g1LW7Z
         HDlWkiWADrZNva1vJnVi3FMAp2Wrw8YQZCkpcPwOWHBkPrmdUPVpSnoeTRkQ890qg4XJ
         m11MEj9lBrIVwH+esAzT7xc1mEj9y3PdubW5WQlS3aBy2qs5R7wbUrYcEFiHd26H8MQn
         hLJQ==
X-Gm-Message-State: AO0yUKXGZoayGU9SQY10B/VpcURh2FWrQGTpfrGpYKiVBH/2R6pXTeeu
        H/hjjVE1a847mJxQN8V/CRXfHg==
X-Google-Smtp-Source: AK7set87oFRPV+RhpgHybpu64glNPVjvktx8AzjXw+O057W6zUiIN3FRPNknFZPhV+tY70AZT6E7jg==
X-Received: by 2002:a05:622a:182a:b0:3e3:90fa:c5d9 with SMTP id t42-20020a05622a182a00b003e390fac5d9mr5230973qtc.40.1679587231698;
        Thu, 23 Mar 2023 09:00:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id j23-20020ac86657000000b003e0c29112b6sm7802610qtp.7.2023.03.23.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:00:31 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:00:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <20230323160030.GD739026@cmpxchg.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-7-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323040037.2389095-7-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 23, 2023 at 04:00:36AM +0000, Yosry Ahmed wrote:
> In workingset_refault(), we call mem_cgroup_flush_stats_delayed() to
> flush stats within an RCU read section and with sleeping disallowed.
> Move the call to mem_cgroup_flush_stats_delayed() above the RCU read
> section and allow sleeping to avoid unnecessarily performing a lot of
> work without sleeping.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> 
> A lot of code paths call into workingset_refault(), so I am not
> generally sure at all whether it's okay to sleep in all contexts or not.
> Feedback here would be very helpful.
> 
> ---
>  mm/workingset.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 042eabbb43f6..410bc6684ea7 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
>  	eviction <<= bucket_order;
>  
> +	/* Flush stats (and potentially sleep) before holding RCU read lock */
> +	mem_cgroup_flush_stats_delayed(true);

Btw, it might be a good time to rename this while you're in the
area. delayed suggests this is using a delayed_work, but this is
actually sometimes flushing directly from the callsite.

What it's doing is ratelimited calls. A better name would be:

	mem_cgroup_flush_stats_ratelimited()
