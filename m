Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAA0C07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1699861988
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhGFFxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:53:51 -0400
Received: from verein.lst.de ([213.95.11.211]:59208 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhGFFxu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 01:53:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F54968BEB; Tue,  6 Jul 2021 07:51:10 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:51:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 1/6] loop: clean up blkcg association
Message-ID: <20210706055109.GF17027@lst.de>
References: <20210705102607.127810-1-ming.lei@redhat.com> <20210705102607.127810-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705102607.127810-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Did I mention that all this loop blkcg integration is complete and utter
garbage and should have never been merged?


>  	struct list_head *cmd_list;
> +	struct cgroup_subsys_state *blkcg_css = NULL;
> +#ifdef CONFIG_BLK_CGROUP
> +	struct request *rq = blk_mq_rq_from_pdu(cmd);
> +
> +	if (rq->bio && rq->bio->bi_blkg)
> +		blkcg_css = &bio_blkcg(rq->bio)->css;
> +#endif

This kind of junk has no business in a driver.  The blkcg code
need to provide a helper for retreiving the blkcg_css from a request,
including a stub for the the !CONFIG_BLK_CGROUP case.

>  		cur_worker = container_of(*node, struct loop_worker, rb_node);
> -		if (cur_worker->blkcg_css == cmd->blkcg_css) {
> +		if (cur_worker->blkcg_css == blkcg_css) {
>  			worker = cur_worker;
>  			break;
> -		} else if ((long)cur_worker->blkcg_css < (long)cmd->blkcg_css) {
> +		} else if ((long)cur_worker->blkcg_css < (long)blkcg_css) {

No need for an else after a break.  And more importantly no need to cast
a pointer to compare it to another pointer of the same type.

> +	struct mem_cgroup *old_memcg = NULL;
> +	struct cgroup_subsys_state *memcg_css = NULL;
> +
> +	kthread_associate_blkcg(worker->blkcg_css);
> +#ifdef CONFIG_MEMCG
> +	memcg_css = cgroup_get_e_css(worker->blkcg_css->cgroup,
> +			&memory_cgrp_subsys);
> +#endif
> +	if (memcg_css)
> +		old_memcg = set_active_memcg(
> +				mem_cgroup_from_css(memcg_css));
> +

This kind of crap also has absolutely no business in a block driver
and the memcg code should provide a proper helper.
