Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDF9C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiFBQ67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiFBQ65 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 12:58:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39FF2A27B;
        Thu,  2 Jun 2022 09:58:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w3so4962204plp.13;
        Thu, 02 Jun 2022 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bpaHA6RKJwrtXGcXqeUi+P0iPjqY+qIkOSMvToigMF4=;
        b=YbkF3Bopk5iHZi38j/bnSLcSgcib6kts8DPsAbi7ASX7PWFeH9aWGQPR7qEvhWPyGF
         Bzxi9qm6V9Fd7zQU6FLI5JX6Tjz+mgDPRXaBi/jXNOjQ32wHCB/nSSdrGORlCu12XvTL
         CuUVhVjfZg13kXV8ZsTc+FmAZWgjaW9KmN0VB8p4Y3V7PRvlp262bqZdy2mAYTPyKlwV
         pqenRp2LmjuA6yQWSbE7HNltyJRkJA7XAGKcXyvVwMOzpZnAA1bxou2/TNdSZyiwgCcG
         GjHPKawxnP6G+vhr4BHV2jFwQZ2oj6iGeXayhYpz+fWwz2vF7OMFkxND7qOwxVHsl975
         3V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bpaHA6RKJwrtXGcXqeUi+P0iPjqY+qIkOSMvToigMF4=;
        b=GvU54Okxu1SJd4Ww6rm9UJrN175sJfwr8AbW/VYtXfLIIkAPFuEO0X+dvz4zszeRXy
         t76sj1/rYeytK9gtXAS3yCrgJjFsnTll0HFK8+BCa2oz6QFEGp49z83S8lmcEXF/Qq5i
         wGUplC2sGYjCLjpICsmF05Tb5QmNM+ZAHsfKfRfx4iChGzls1E+xifz33edVye96ftxS
         6VGkJY5u/4L0ejQ6ie9Tb/c3JyzYYB89sXqcoB0W2vHpRegBfcd07VU4zk/xWu5IlGI6
         Qi7Uz0kIdhBd5hs0xT6RvGI+b30pNhSdiJQ+AnXgErWqIOgyxY3yFxnei5tVMbnV4a8z
         gCTg==
X-Gm-Message-State: AOAM532i8vPFCBD7AR73TjNrKS9KQ7fIkG/k8tjw9jfWfVueeFSZMxKh
        6DBWySHEsUmz5z9yGAbk6VA=
X-Google-Smtp-Source: ABdhPJwEnDVX8zzHkYAAmoExZ8oCt6O2WT1vvFEmSa4EaKqyN9tIyLWO99drw6peL7QAiDzTJtupuA==
X-Received: by 2002:a17:90a:de0b:b0:1e3:33e9:6665 with SMTP id m11-20020a17090ade0b00b001e333e96665mr6168197pjv.27.1654189134784;
        Thu, 02 Jun 2022 09:58:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:49ff])
        by smtp.gmail.com with ESMTPSA id p127-20020a622985000000b0050dc76281e7sm3740687pfp.193.2022.06.02.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 09:58:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Jun 2022 06:58:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v5 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YpjsTNZx4DG+kot4@slm.duckdns.org>
References: <20220601211824.89626-1-longman@redhat.com>
 <20220602133543.128088-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602133543.128088-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Jun 02, 2022 at 09:35:43AM -0400, Waiman Long wrote:
> @@ -2011,9 +2076,16 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	}
>  	bis->cur.ios[rwd]++;
>  
> +	if (!READ_ONCE(bis->lnode.next)) {
> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> +
> +		llist_add(&bis->lnode, lhead);
> +		percpu_ref_get(&bis->blkg->refcnt);

Hmm... what guarantees that more than one threads race here? llist assumes
that there's a single writer for a given llist_node and the ref count would
be off too, right?

Thanks.

-- 
tejun
