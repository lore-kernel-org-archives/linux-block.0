Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCCC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48A96108E
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhJRIY6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:24:58 -0400
Received: from verein.lst.de ([213.95.11.211]:60933 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhJRIY5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 04:24:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 27F0368BEB; Mon, 18 Oct 2021 10:22:45 +0200 (CEST)
Date:   Mon, 18 Oct 2021 10:22:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] block: Fix partition check for host-aware zoned block
 devices
Message-ID: <20211018082244.GA30388@lst.de>
References: <20211015020740.506425-1-shinichiro.kawasaki@wdc.com> <20211016043450.GA27231@lst.de> <YWrhCiWGjfxqAca2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWrhCiWGjfxqAca2@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 03:26:18PM +0100, Matthew Wilcox wrote:
> Do I understand the problem correctly, that you don't actually want to
> know whether there's more than one entry in the array, but rather that
> there's an entry at an index other than 0?

In this case both checks are equivalemt because index 0 is always
present once the disk is life.
