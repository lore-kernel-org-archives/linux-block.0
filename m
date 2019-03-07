Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9343C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 22:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C142087C
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 22:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="hg7NUf0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCGWHE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:07:04 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39213 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfCGWHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 17:07:04 -0500
Received: by mail-yw1-f66.google.com with SMTP id z191so14692309ywa.6
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 14:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5XqGPOhHxWelDgT11+htERfFUnfLr39ckjM2oBzWcuM=;
        b=hg7NUf0VaR7rWE9ExshFRFdJUBKdlHgyhBWn7fpjNak6rkxf3itb5EAT/yLjZIgs5I
         PqLKwWBjIsOsCasCwpoEFwHh16ddfXVwzx9FvJOt76zVAt4KwA9lhQLTSvqp5aVi9nfp
         OLc7ZTSc9ofuBPPFhBVgn/JjmxwiAw9grGfKYve8t2h6dJP3YdzsJykQ137aLgGZcVQQ
         VrQpJ1IQzv2koxKRIhT5auG+a8z/d8jXn2c446S8wZ18mlVD4GQIa840ydnLLmZDEn/g
         lEWpO6x46h8n6/oPsjC6Pv+gSDsVjdOI2iSkuv6c3RhQmZsXH5qCpEjvo+HCT7qI+dgu
         iS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XqGPOhHxWelDgT11+htERfFUnfLr39ckjM2oBzWcuM=;
        b=T5IEBH4B3ggsHloqD5wmmagGnToo139vmUBkbjTQP7Sj1qiLv7P9kFC0xU5tu/Z7c+
         qIZ1uv2WGM8jh7/JHhZ7PfMyo8CsiLmg57iQ10DLxpMnoDQJL7EpfUDXotYjosBxH3YF
         KpzRN+eH9cUGH9R63Y6nPfRFZW2Ztei+eYQMuDKlCGxl9vW4Ea/C9bM+BwJDtKg0uLvM
         SaQNQ6U5GpgUzLRatUs6gRkJZiz8FCHX2LCyAVuSGSi5j3kp9JlqTmDIJ8os5xpD6h+5
         60r4WIFiI71xddwy+Wfcmy0FIcWE/g7esUgZAEM09aN0TnhL7p9xn6quj2H5UVs2mfce
         fTiA==
X-Gm-Message-State: APjAAAWqRK/982no4J4+lWvgCEIfePcK4bDn99YHdORghwzK5n8UWFdB
        n+Qa1EiqYhT3BbxU/PJ+LVq1vg==
X-Google-Smtp-Source: APXvYqxHCw18zCev+Plm9gMVQweneGhgqaylB5ml13zkDQOASfRadHyY4JnucJb5+loFSggeJzfBaQ==
X-Received: by 2002:a81:b8d:: with SMTP id 135mr12004691ywl.152.1551996422797;
        Thu, 07 Mar 2019 14:07:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::be7f])
        by smtp.gmail.com with ESMTPSA id k187sm1953929ywc.47.2019.03.07.14.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:07:02 -0800 (PST)
Date:   Thu, 7 Mar 2019 17:07:01 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] blkcg: implement sync() isolation
Message-ID: <20190307220659.5qmye2pxmto7nlei@macbook-pro-91.dhcp.thefacebook.com>
References: <20190307180834.22008-1-andrea.righi@canonical.com>
 <20190307180834.22008-4-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307180834.22008-4-andrea.righi@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 07, 2019 at 07:08:34PM +0100, Andrea Righi wrote:
> Keep track of the inodes that have been dirtied by each blkcg cgroup and
> make sure that a blkcg issuing a sync() can trigger the writeback + wait
> of only those pages that belong to the cgroup itself.
> 
> This behavior is applied only when io.sync_isolation is enabled in the
> cgroup, otherwise the old behavior is applied: sync() triggers the
> writeback of any dirty page.
> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  block/blk-cgroup.c         | 47 ++++++++++++++++++++++++++++++++++
>  fs/fs-writeback.c          | 52 +++++++++++++++++++++++++++++++++++---
>  fs/inode.c                 |  1 +
>  include/linux/blk-cgroup.h | 22 ++++++++++++++++
>  include/linux/fs.h         |  4 +++
>  mm/page-writeback.c        |  1 +
>  6 files changed, 124 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 4305e78d1bb2..7d3b26ba4575 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1480,6 +1480,53 @@ void blkcg_stop_wb_wait_on_bdi(struct backing_dev_info *bdi)
>  	spin_unlock(&blkcg_wb_sleeper_lock);
>  	rcu_read_unlock();
>  }
> +
> +/**
> + * blkcg_set_mapping_dirty - set owner of a dirty mapping
> + * @mapping: target address space
> + *
> + * Set the current blkcg as the owner of the address space @mapping (the first
> + * blkcg that dirties @mapping becomes the owner).
> + */
> +void blkcg_set_mapping_dirty(struct address_space *mapping)
> +{
> +	struct blkcg *curr_blkcg, *blkcg;
> +
> +	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> +	    mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> +		return;
> +
> +	rcu_read_lock();
> +	curr_blkcg = blkcg_from_current();
> +	blkcg = blkcg_from_mapping(mapping);
> +	if (curr_blkcg != blkcg) {
> +		if (blkcg)
> +			css_put(&blkcg->css);
> +		css_get(&curr_blkcg->css);
> +		rcu_assign_pointer(mapping->i_blkcg, curr_blkcg);
> +	}
> +	rcu_read_unlock();
> +}
> +
> +/**
> + * blkcg_set_mapping_clean - clear the owner of a dirty mapping
> + * @mapping: target address space
> + *
> + * Unset the owner of @mapping when it becomes clean.
> + */
> +
> +void blkcg_set_mapping_clean(struct address_space *mapping)
> +{
> +	struct blkcg *blkcg;
> +
> +	rcu_read_lock();
> +	blkcg = rcu_dereference(mapping->i_blkcg);
> +	if (blkcg) {
> +		css_put(&blkcg->css);
> +		RCU_INIT_POINTER(mapping->i_blkcg, NULL);
> +	}
> +	rcu_read_unlock();
> +}
>  #endif
>  

Why do we need this?  We already have the inode_attach_wb(), which has the
blkcg_css embedded in it for whoever dirtied the inode first.  Can we not just
use that?  Thanks,

Josef
