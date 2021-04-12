Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF1C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD776128A
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhDLKRX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhDLKRW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 06:17:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF58C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WTvPD46g2q8trOCLl4Uhn+tLIWuoy1Yp9UfY60Ss47Q=; b=Ck7Ne9kVDsvce1CoQLIgLoxnU7
        qq4aIzD+VRZzTBJtdLGOZBOyl3a2TP9+oIlFU+OpxAERsRbA+oB+Z4w7QUXupG3LVnxe0vT5HxzXC
        X1WyGFWQpEymBlaohnSm6+CAYvSNJan3nu6JHydvw0C8fXfCfvVQ2jk4a4Pg6SF4AhBePuvPPY43i
        YupCpnSuyjhzeUd6MVvomnmW1XgAB73/axZqlCTyqyTM4DhBzevEskG9OY1xUDlw1ztHQrtT8cq/r
        U5xdK0R6WjcOUwIkYEkdlSruTV3P8RfgmbnOatI71laiz8roG0eqkljTYMXBoGvejucarHAaCMCbL
        AItG6RuA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtcp-004AsT-ID; Mon, 12 Apr 2021 10:17:00 +0000
Date:   Mon, 12 Apr 2021 11:16:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 08/12] block: use per-task poll context to implement
 bio based io polling
Message-ID: <20210412101659.GA993044@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-9-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static int blk_bio_poll_io(struct io_context *submit_ioc,
> +		struct io_context *poll_ioc)

Givem that poll_ioc is always current->io_context there is no
need to pass it.

> +	struct blk_bio_poll_ctx *poll_ctx = poll_ioc ?
> +		poll_ioc->data : NULL;

and it really should not be NULL here, should it?

> +static int __blk_bio_poll(blk_qc_t cookie)
> +{
> +	struct io_context *poll_ioc = current->io_context;
> +	pid_t pid;
> +	struct task_struct *submit_task;
> +	int ret;
> +
> +	pid = (pid_t)cookie;
> +
> +	/* io poll often share io submission context */
> +	if (likely(current->pid == pid && blk_bio_ioc_valid(current)))
> +		return blk_bio_poll_io(poll_ioc, poll_ioc);
> +
> +	submit_task = find_get_task_by_vpid(pid);
> +	if (likely(blk_bio_ioc_valid(submit_task)))
> +		ret = blk_bio_poll_io(submit_task->io_context, poll_ioc);
> +	else
> +		ret = 0;
> +	if (likely(submit_task))
> +		put_task_struct(submit_task);

Wouldn't it make more sense to just store the submitting context
in the bio, even if that uses more space?  Having to call
find_get_task_by_vpid in the poll context seems rather problematic.

Note that this requires doing the refacoring to get rid of the separate
blk_qc_t passed up the stack I asked for earlier, but hiding all these
details seems like a really useful change anyway.
