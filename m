Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A1BC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67A064E2B
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 15:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhBBP7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:59:05 -0500
Received: from verein.lst.de ([213.95.11.211]:46862 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235911AbhBBP4b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 10:56:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DDD267373; Tue,  2 Feb 2021 16:55:48 +0100 (CET)
Date:   Tue, 2 Feb 2021 16:55:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] block: fix memory leak of bvec
Message-ID: <20210202155548.GA13979@lst.de>
References: <20210202155410.875745-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202155410.875745-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 02, 2021 at 11:54:10PM +0800, Ming Lei wrote:
> bio_init() clears bio instance, so the bvec index has to be set after
> bio_init(), otherwise bio->bi_io_vec may be leaked.

Yeah, I've got exactly the same test sitting here as part of a larger
series:

Reviewed-by: Christoph Hellwig <hch@lst.de>
