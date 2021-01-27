Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C1C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B7E207B1
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbhA0QNG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:13:06 -0500
Received: from verein.lst.de ([213.95.11.211]:53580 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235382AbhA0QMt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 11:12:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5197D68AFE; Wed, 27 Jan 2021 17:12:05 +0100 (CET)
Date:   Wed, 27 Jan 2021 17:12:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "block: simplify set_init_blocksize" to regain
 lost performance
Message-ID: <20210127161205.GA21325@lst.de>
References: <20210126195907.2273494-1-maxtram95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126195907.2273494-1-maxtram95@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While this code is gross, I think we need to add it back for now:

Acked-by: Christoph Hellwig <hch@lst.de>

I'll put converting the block device buffered I/O path to iomap or
an iomap lookalike on the backburner to fix this..
