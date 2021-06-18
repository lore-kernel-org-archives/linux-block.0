Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF77C48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB68611B0
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhFROJk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:09:40 -0400
Received: from verein.lst.de ([213.95.11.211]:35059 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFROJj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 10:09:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96BAB68D0A; Fri, 18 Jun 2021 16:07:28 +0200 (CEST)
Date:   Fri, 18 Jun 2021 16:07:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix an IS_ERR() vs NULL bug
Message-ID: <20210618140728.GA17914@lst.de>
References: <YMyjci35WBqrtqG+@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMyjci35WBqrtqG+@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 18, 2021 at 04:45:22PM +0300, Dan Carpenter wrote:
> The __blk_mq_alloc_disk() function doesn't return NULLs it returns
> error pointers.
> 
> Fixes: b461dfc49eb6 ("blk-mq: add the blk_mq_alloc_disk APIs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
