Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749C8C7EE22
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 15:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbjEOPrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 11:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEOPrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 11:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C331FDF
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 08:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D60B61FBB
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2FC433EF;
        Mon, 15 May 2023 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684165635;
        bh=W4NQWF7lda7qu8vNpd5FlZvTG+e654oz8MJ2TScQyzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=us7fP7ymd5R5YpdWXlafSi10vkSaePrpgJtaigLDxdOoxeDzp0mpXrIMbk6gxa8Yl
         MaNFKWJeA5fj1o4u3cGCTjeCeMdryNJ1EuLOsBQhGql47fBpGU59B1cjTLENqv3KUz
         TrXRvKpHGomAOc9BYu8gQtm/Lxedc3ySkpM0SdY9PB91FUKY+qs/L4Y/oCwUxzgipy
         YzGSC/3W8h1TNW9+1nLl17PnYJzreTvjRgReFiiz3dgXeOCIG1nMipjNral4ciXOXC
         x2XZVgsLlOVcxGCGLuGj76+sP5Y+kj06SdNmK2tewowFzti3AP6dQTYN8hpwE0XGj3
         7+6Z6JlK1JwTg==
Date:   Mon, 15 May 2023 09:47:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, joshi.k@samsung.com, axboe@kernel.dk,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 1/3] nvme: skip block cgroups for passthrough commands
Message-ID: <ZGJUAMcpxQSC+m29@kbusch-mbp>
References: <20230501153306.537124-1-kbusch@meta.com>
 <20230501153306.537124-2-kbusch@meta.com>
 <20230503050414.GA19301@lst.de>
 <ZFJ84dD1FRNXJIcm@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFJ84dD1FRNXJIcm@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 09:25:21AM -0600, Keith Busch wrote:
> On Wed, May 03, 2023 at 07:04:14AM +0200, Christoph Hellwig wrote:
> > On Mon, May 01, 2023 at 08:33:04AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Passthrough requests don't go through the submit_bio() path, so all the
> > > overhead of setting up the bio's cgroup is wasted cycles. Provide a path
> > > to skip this setup.
> > 
> > These days we should not need to set bi_bdev at all for passthrough,
> > so I think we can just drop the assingment.
> 
> We can't really skip it for polling since that needs a bio with a
> bdev. I'll take another shot at detandling that requirement.

I've got a new version ready to go that removes the bio and bi_dev
requirement for polling uring commands, but passthrough still needs to
set bi_bdev for metadata since it's used in bio_integrity_add_page(). I
suppose we could have that just take the queue limits directly instead
of extracting them from an assumed bi_dev.
