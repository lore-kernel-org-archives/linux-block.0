Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C63C43217
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 18:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiKNSMk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiKNSMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 13:12:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D6D24976
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 10:12:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8400561342
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 18:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BD8C433D6;
        Mon, 14 Nov 2022 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668449541;
        bh=rR6p9mCylDPSNDzrBso16rE7PC2mLZj0DgfpLFq9shg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLCyD/OSk38dLY0ZVjjD87dwje/zJDu3FI2QZCObfkInJqjQ8Ad44ZhdwxhMaweXE
         b/FFQNzySq4Nz4C/y7xNwS47JaMDqby4TCuxPJhEAMMfSubSmDPJ0OW9p+FYiDk0yq
         aseYg3TJhr69hcvD1e1RJU/VFyxGxMi0U+4mdz4ek3ArqYMrRS5/Fg9dPYUBqczHXA
         pSvnq+qb3OoC5sk889CdyjGOylgMaOB3FSwjT9inS6IDsK5ZWvuiizwzdrUV3/vffS
         HL5jimtsYmvAVS/jeNnexF7kDjJ72NomOUBEVdRUsoqD3IHUl+5C3aQ71b2J2KcbeA
         epNK15Bup5ihg==
Date:   Mon, 14 Nov 2022 11:12:18 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org
Subject: Re: [PATCHv2 0/5] fix direct io device mapper errors
Message-ID: <Y3KFAr16W/LfJ5ms@kbusch-mbp.dhcp.thefacebook.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
 <Y26PSYu2nY/AE5Xh@redhat.com>
 <Y26U91eH7NcXTlbj@kbusch-mbp.dhcp.thefacebook.com>
 <alpine.LRH.2.21.2211140627080.25281@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2211140627080.25281@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 14, 2022 at 06:31:36AM -0500, Mikulas Patocka wrote:
> 
> 
> On Fri, 11 Nov 2022, Keith Busch wrote:
> 
> > > There are other DM targets that override logical_block_size in their
> > > .io_hints hook (writecache, ebs, zoned). Have you reasoned through why
> > > those do _not_ need updating too?
> > 
> > Yeah, that's a good question. The ones that have a problem all make
> > assumptions about a bio's bv_offset being logical block size aligned,
> > and each of those is accounted for here. Everything else looks fine with
> > respect to handling offsets.
> 
> Unaligned bv_offset should work - because XFS is sending such bios. If you 
> compile the kernel with memory debugging, kmalloc returns unaligned 
> memory. XFS will allocate a buffer with kmalloc, test if it crosses a page 
> boundary, if not, use the buffer, if yes, free the buffer and allocate a 
> full page.
> 
> There have been device mapper problems about unaligned bv_offset in the 
> past and I have fixed them.
> 
> Unaligned bv_length is a problem for the affected targets.

kmalloc is physically contiguous, and bio's support multi-page bvecs for
these, so the bv_len is always aligned if the kmalloc is sized
correctly. The unaligned offsets become a problem with virtually
contiguous buffers since individual bv lengths might not be block size
aligned when bv offsets exist.
