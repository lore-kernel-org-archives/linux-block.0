Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B1C48BE6
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 09:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C6661357
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 09:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhFNJv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 05:51:28 -0400
Received: from verein.lst.de ([213.95.11.211]:43413 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232718AbhFNJv0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 05:51:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 62CAC67373; Mon, 14 Jun 2021 11:49:19 +0200 (CEST)
Date:   Mon, 14 Jun 2021 11:49:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>,
        Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] ubd: use blk_mq_alloc_disk and blk_cleanup_disk
Message-ID: <20210614094919.GA9501@lst.de>
References: <20210614060759.3965724-1-hch@lst.de> <20210614060759.3965724-3-hch@lst.de> <847f7608-1d11-1410-5394-b5aa5de9f45e@cambridgegreys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847f7608-1d11-1410-5394-b5aa5de9f45e@cambridgegreys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 14, 2021 at 09:26:58AM +0100, Anton Ivanov wrote:
> This does not build for me when applied to master:

Yes, as mentioned in the cover letter it needs for-5.14/block branch
from here:

   git://git.kernel.dk/linux-block for-5.14/block

Gitweb:

   https://git.kernel.dk/cgit/linux-block/log/?h=for-5.14/block
