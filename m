Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C12C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 12:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3949206BB
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 12:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfAIMNm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:13:42 -0500
Received: from verein.lst.de ([213.95.11.211]:41166 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbfAIMNm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 07:13:42 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1052667358; Wed,  9 Jan 2019 13:13:41 +0100 (CET)
Date:   Wed, 9 Jan 2019 13:13:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 11/16] io_uring: batch io_kiocb allocation
Message-ID: <20190109121340.GD13779@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-12-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (!state)
> +		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);

Just return an error here if kmem_cache_alloc fails.

> +	if (req)
> +		io_req_init(ctx, req);

Because all the other ones can't reached this with a NULL req.
