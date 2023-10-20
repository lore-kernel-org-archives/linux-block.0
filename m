Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3D9C001DF
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 19:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjJTThh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 15:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjJTThg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 15:37:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2608D52;
        Fri, 20 Oct 2023 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OqG2k9lr6dVMFkOpECp/c1ub/4t138Vh/alrnSJkgp4=; b=mVT7G4PTZUpU2DyGmj0CTOhr66
        V3a0KA+XFiAsKOjtW3YWc1GG4+UGNx4oNZKhcB8204smplJBgUZRziMTJ+0ah3C7FfMbSIdDjeKh9
        ZjWGt/dX8LeFDomzR/GHIrOZT2fXGV/XNtRAtQILp9z4qnuQGDwd9u6Ohktfw1DW7S/LHp3GGGob3
        qmzpPgJZvBGh+m8kJ+WTrtDeupYm/e7d1FOvK2EuUwutN2YDe40VLJER++094CoFGBlRnzWlF2P2g
        wEYcqvsn8fhfdRxc3mGUHVyn90pCx50KM4h959pwKldfH2vi+boj7KgsLhe6xBbIxuCIdelvd+FGl
        b71tTnxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtvJG-00EuML-1x; Fri, 20 Oct 2023 19:37:26 +0000
Date:   Fri, 20 Oct 2023 20:37:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/18] fs/buffer.c: use accessor function to translate
 page index to sectors
Message-ID: <ZTLW9jOJ0Crt/ZD3@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918110510.66470-5-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 18, 2023 at 01:04:56PM +0200, Hannes Reinecke wrote:
> Use accessor functions block_index_to_sector() and block_sector_to_index()
> to translate the page index into the block sector and vice versa.

You missed two in grow_dev_page() (which I just happened upon):

        bh = folio_buffers(folio);
        if (bh) {
                if (bh->b_size == size) {
                        end_block = folio_init_buffers(folio, bdev,
                                        (sector_t)index << sizebits, size);
                        goto done;
                }
...
        spin_lock(&inode->i_mapping->private_lock);
        link_dev_buffers(folio, bh);
        end_block = folio_init_buffers(folio, bdev,
                        (sector_t)index << sizebits, size);

Can UBSAN be of help here?  It should catch shifting by a negative
amount.  That sizebits is calculated in grow_buffers:

        sizebits = PAGE_SHIFT - __ffs(size);

