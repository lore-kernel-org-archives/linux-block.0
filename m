Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93882C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D82F20859
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 19:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfAITGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:06:40 -0500
Received: from verein.lst.de ([213.95.11.211]:43542 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfAITGk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 14:06:40 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 79DEC67358; Wed,  9 Jan 2019 20:06:38 +0100 (CET)
Date:   Wed, 9 Jan 2019 20:06:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 14/16] io_uring: support kernel side submission
Message-ID: <20190109190638.GB22645@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-15-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-15-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +struct iocb_submit {
> +	const struct io_uring_iocb *iocb;
> +	unsigned int index;
> +};
> +
> +struct io_work {
> +	struct work_struct work;
> +	struct io_ring_ctx *ctx;
> +	struct io_uring_iocb iocb;
> +	unsigned iocb_index;
> +};

I think we should use struct iocb_submit everywhere where we pass
an iocb + index, including in the io_work structure.  Here is how
I did that to my old tree:

http://git.infradead.org/users/hch/misc.git/commitdiff/65929ed6f143a1c996305a10a15fd7f64d32595f

Btw, I think we can also remove the separate io_work allocation,
just do the io_get_req in the submission context, and overlay
the io_work onto the iocb in a union of some sort.  This avoids
a whole memory allocation.
