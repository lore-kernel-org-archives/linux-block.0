Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4220FC4708E
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 20:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjAEUVt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 15:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjAEUVs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 15:21:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A9427D;
        Thu,  5 Jan 2023 12:21:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4599661C14;
        Thu,  5 Jan 2023 20:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB5BC433D2;
        Thu,  5 Jan 2023 20:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672950106;
        bh=ilMX5v3ZE/EhwtB5jOfYPI8G8uBMESmE0BRULcNsyjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBfuqzFnZoDzXlpxBLXV6lk805Xi8ih1YVM0W7jkCx6q5Y81tK/AsPId5dUbkeNA/
         17EzsVUkR1c1CfOmrKrngR435LUUyGsNLf2T2GEkSDCQP5S5x87ffjPB3Mm/C4Qg70
         pr4sPnSMS+4U/vh+LBiYdUS05IY0xFK519e+bKQ4moC7pCHk5e5uFwyJEdzv9yZ4qG
         C9KKQqFNGPXLY0ugloNE/S9nB+lT4RJPKjAE3eg/7MbIN0yg8mf6Z2uew1SgJDRuhQ
         X2I5wuZbfE22/q7UVUCynyMdfhnOCC3WVhmw+80v8jebMPWSUZyACzW42WgtFqRUiF
         WHiuJvCXfeK2w==
Date:   Thu, 5 Jan 2023 13:21:43 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org, axboe@kernel.dk,
        logang@deltatee.com, hch@lst.de, alex.williamson@redhat.com,
        leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to merge contiguous pages into the
 last SG properly
Message-ID: <Y7cxVx3qGShReJAZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230105112339.107969-1-yishaih@nvidia.com>
 <Y7ctsw8ffhSsBZ4v@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7ctsw8ffhSsBZ4v@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 05, 2023 at 04:06:11PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 05, 2023 at 01:23:39PM +0200, Yishai Hadas wrote:
> > When sg_alloc_append_table_from_pages() calls to pages_are_mergeable()
> > in its 'sgt_append->prv' flow to check whether it can merge contiguous
> > pages into the last SG, it passes the page arguments in the wrong order.
> > 
> > The first parameter should be the next candidate page to be merged to
> > the last page and not the opposite.
> > 
> > The current code leads to a corrupted SG which resulted in OOPs and
> > unexpected errors when non-contiguous pages are merged wrongly.
> > 
> > Fix to pass the page parameters in the right order.
> > 
> > Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
> > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > ---
> >  lib/scatterlist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> rdma is pretty much the only user of this API and this bug is causing
> bad data corruption, so I'm going to take it to the rdma tree and send
> it tomorrow.
> 
> Which raises the question why the original patch was done at all,
> nothing ever inputs pgmap pages into this function?

This just takes any arbitrary user addresses, right? The user could
provide addresses from mmap'ing pci resource files that resolve to pgmap
pages.
