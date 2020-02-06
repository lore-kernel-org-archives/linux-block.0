Return-Path: <SRS0=DGx4=32=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B02C33CAC
	for <linux-block@archiver.kernel.org>; Thu,  6 Feb 2020 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122962192A
	for <linux-block@archiver.kernel.org>; Thu,  6 Feb 2020 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0gXevC6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgBFPq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:46:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34096 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBFPq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Feb 2020 10:46:27 -0500
Received: by mail-qk1-f196.google.com with SMTP id n184so1174857qkn.1
        for <linux-block@vger.kernel.org>; Thu, 06 Feb 2020 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kRRvyBPWT8Es74STxomqTpDHCa76gQjLB2CCJUssayM=;
        b=0gXevC6aEU0IZUlb9/scF02jWHTiU00qYk9LUijF/5hdiUCvqa3NevcaCnTmUvmIZJ
         CYl8Ti03GJNi5pVRpJqPN5HOA8djad0yBQW9pK1tLsRFlhHCIXSm+pLiNRbNLQAJyYBb
         8hB7k5FpnOV9OvPz6HvFNMEhfAGLY8OO2Tbooi/mlTZ1d0gBgQ7mhUyPkm0pn09Lr09x
         dhaCfJ5w00U3iDJU2nz/apuWVj+wqT0tTZZjH+MAiTH97+aChNnm99JtRN1E3cl5C62J
         uG+Z9gfVIqQMx3/mFI+VdLgQ+QdjDNLLJ5HtIe8hotQ+LY7VXECCoCGTXi7SuNk1OtnH
         8ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRRvyBPWT8Es74STxomqTpDHCa76gQjLB2CCJUssayM=;
        b=VATQHZQ/X9Nv5KXLGbaV8tUxyom3i+csUo4+rhTkY9ngfSizd35JUFf46j9loHQNa8
         WOc6VQBQiKnPOPLyWtE2/Lt1c6cxW4RqfT672buSjczh8X/PWmdMBLrnp5lAHvqifaQd
         Ig7JhsN+NdEPTOj6R/xDuVc09uDHQ7gZPN/CaAv8+Jm0wknh9Y0SupUQWHk6gAH6GXBh
         VzGgEjQG67ciVm1q2Ezs3GBGHMzxAM/jjeMYtP82Bdq5ubA9dw49n96l2f/FLaWkhMYG
         M+EUuQQiyY8CkLqsnXT/ATMkcWeykB+gWlV7CB/Y418eyaT2IyZ4paaaeCZzm/QQJF+w
         TFhg==
X-Gm-Message-State: APjAAAXTnMe0dDtHn8l0XVNcCYRs7XesnrLZ7yWQuSqJRgI2DOUda6pm
        ZeCw+oFB7zSh+i07dpRFPK9bWA==
X-Google-Smtp-Source: APXvYqyMsmQpyg9uEjfMfe0RGA/Dtl5TtuYO75M1CcYm9p74JGnF1dhnxvivzvRQG/vj+RNZiyRUkw==
X-Received: by 2002:a05:620a:1112:: with SMTP id o18mr3046650qkk.126.1581003985950;
        Thu, 06 Feb 2020 07:46:25 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id t7sm1574736qkm.136.2020.02.06.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:46:25 -0800 (PST)
Date:   Thu, 6 Feb 2020 10:46:24 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] loop: charge i/o per cgroup
Message-ID: <20200206154624.GB24735@cmpxchg.org>
References: <20200205223348.880610-1-dschatzberg@fb.com>
 <20200205223348.880610-3-dschatzberg@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223348.880610-3-dschatzberg@fb.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Dan,

On Wed, Feb 05, 2020 at 02:33:48PM -0800, Dan Schatzberg wrote:
> @@ -1925,14 +1990,13 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	}
>  
>  	/* always use the first bio's css */
> +	cmd->blk_css = NULL;
>  #ifdef CONFIG_BLK_CGROUP
> -	if (cmd->use_aio && rq->bio && rq->bio->bi_blkg) {
> -		cmd->css = &bio_blkcg(rq->bio)->css;
> -		css_get(cmd->css);
> -	} else
> +	if (rq->bio && rq->bio->bi_blkg)
> +		cmd->blk_css = &bio_blkcg(rq->bio)->css;
>  #endif
> -		cmd->css = NULL;
> -	kthread_queue_work(&lo->worker, &cmd->work);
> +
> +	loop_queue_work(lo, cmd);
>  
>  	return BLK_STS_OK;
>  }
> @@ -1942,6 +2006,9 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>  	struct request *rq = blk_mq_rq_from_pdu(cmd);
>  	const bool write = op_is_write(req_op(rq));
>  	struct loop_device *lo = rq->q->queuedata;
> +#ifdef CONFIG_MEMCG
> +	struct cgroup_subsys_state *mem_css;
> +#endif
>  	int ret = 0;
>  
>  	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
> @@ -1949,8 +2016,24 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>  		goto failed;
>  	}
>  
> +	if (cmd->blk_css) {
> +#ifdef CONFIG_MEMCG
> +		mem_css = cgroup_get_e_css(cmd->blk_css->cgroup,
> +					&memory_cgrp_subsys);
> +		memalloc_use_memcg(mem_cgroup_from_css(mem_css));
> +#endif
> +		kthread_associate_blkcg(cmd->blk_css);
> +	}
> +
>  	ret = do_req_filebacked(lo, rq);
> - failed:
> +
> +	if (cmd->blk_css) {
> +		kthread_associate_blkcg(NULL);
> +#ifdef CONFIG_MEMCG
> +		memalloc_unuse_memcg();
> +#endif

cgroup_get_e_css() acquires a reference, it looks like you're missing
a css_put() here.

I also wonder why you look up blk_css and mem_css in separate
places. Since you already renamed cmd->css to cmd->blk_css, can you
also add cmd->mem_css and pair up their lookup and refcounting?

This should make loop_handle_cmd() a bit more straight-forward:

	if (cmd->blk_css)
		kthread_associate_blkcg(cmd->blk_css);
	if (cmd->mem_css)
		memalloc_use_memcg(mem_cgroup_from_css(mem_css));

	ret = do_req_filebacked(lo, rq);

	memalloc_unuse_memcg();
	kthread_associate_blkcg(NULL);

All these functions have dummy implementations for !CONFIG_BLK_CGROUP,
!CONFIG_MEMCG etc., so it shouldn't require any additional ifdefs.
