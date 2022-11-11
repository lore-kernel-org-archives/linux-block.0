Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB9DC43217
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKKSbo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Nov 2022 13:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiKKSb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2022 13:31:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AA36DCD3
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 10:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E76CB826E8
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 18:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528BFC433D6;
        Fri, 11 Nov 2022 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668191483;
        bh=mqHRaFw9Xft7x5R8hniLax7Hzd4+8BiuWjDO6iFeN/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMnTABnYdW6B62v/QCNrU/NZIBCROCYaFK++Oc13EHFVezdaYREPgk8CZEyznWhJo
         C8Du2rgcfdTtnE3CUBi/cv67z7SNv+MOJUI1p16kl3nWNdkjlYQ+nX4iZ0pQB8N1O0
         c6xQyUJrBgrGHIMVpw5fOrYbNr4osNFjJEP4SMrelGJSUrUslQXzwC/8rGZP2+EuME
         u8daGSlzEQ04EDUcYBN8TSw+cLk4Wzt8IeI0aN16z0/SOVwXJDKtZ9x/qzxXM2gACe
         U96+/ILoLWrrYcJx6zxCQJaJ9RAl2samADvbxtoU3NsD+7qfhDny9D4A/I2Pv0iMWm
         PdbIRFU0pANNg==
Date:   Fri, 11 Nov 2022 11:31:19 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, axboe@kernel.dk, stefanha@redhat.com,
        ebiggers@kernel.org, me@demsh.org, mpatocka@redhat.com
Subject: Re: [PATCHv2 0/5] fix direct io device mapper errors
Message-ID: <Y26U91eH7NcXTlbj@kbusch-mbp.dhcp.thefacebook.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
 <Y26PSYu2nY/AE5Xh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26PSYu2nY/AE5Xh@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 11, 2022 at 01:07:05PM -0500, Mike Snitzer wrote:
> On Thu, Nov 10 2022 at  1:44P -0500,
> Keith Busch <kbusch@meta.com> wrote:
> 
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The 6.0 kernel made some changes to the direct io interface to allow
> > offsets in user addresses. This based on the hardware's capabilities
> > reported in the request_queue's dma_alignment attribute.
> > 
> > dm-crypt, -log-writes and -integrity require direct io be aligned to the
> > block size. Since it was only ever using the default 511 dma mask, this
> > requirement may fail if formatted to something larger, like 4k, which
> > will result in unexpected behavior with direct-io.
> > 
> > Changes since v1: Added the same fix for -integrity and -log-writes
> > 
> > The first three were reported successfully tested by Dmitrii Tcvetkov,
> > but I don't have an official Tested-by: tag.
> > 
> >   https://lore.kernel.org/linux-block/20221103194140.06ce3d36@xps.demsh.org/T/#mba1d0b13374541cdad3b669ec4257a11301d1860
> > 
> > Keitio errors on Busch (5):
> >   block: make dma_alignment a stacking queue_limit
> >   dm-crypt: provide dma_alignment limit in io_hints
> >   block: make blk_set_default_limits() private
> >   dm-integrity: set dma_alignment limit in io_hints
> >   dm-log-writes: set dma_alignment limit in io_hints
> > 
> >  block/blk-core.c           |  1 -
> >  block/blk-settings.c       |  9 +++++----
> >  block/blk.h                |  1 +
> >  drivers/md/dm-crypt.c      |  1 +
> >  drivers/md/dm-integrity.c  |  1 +
> >  drivers/md/dm-log-writes.c |  1 +
> >  include/linux/blkdev.h     | 16 ++++++++--------
> >  7 files changed, 17 insertions(+), 13 deletions(-)
> > 
> > -- 
> > 2.30.2
> > 
> 
> There are other DM targets that override logical_block_size in their
> .io_hints hook (writecache, ebs, zoned). Have you reasoned through why
> those do _not_ need updating too?

Yeah, that's a good question. The ones that have a problem all make
assumptions about a bio's bv_offset being logical block size aligned,
and each of those is accounted for here. Everything else looks fine with
respect to handling offsets.

> Is there any risk of just introducing a finalization method in block
> core (that DM's .io_hints would call) that would ensure limits that
> are a funtion of another are always in sync?  Would avoid whack-a-mole
> issues in the future.

I don't think we can this particular limit issue. A lot of drivers and
devices can use a smaller dma_alignment than the logical block size, so
the generic block layer wouldn't really know the driver's intentions for
the relationship of these limits.
