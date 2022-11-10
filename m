Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2E5C4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiKJSpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiKJSpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:45:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC5DFFB
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E665CE248B
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 18:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5647BC433D6;
        Thu, 10 Nov 2022 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668105925;
        bh=BXaVTfNpyEmJmFnjGUi5nwscookyljdl+Cpy58EE1oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0I5ZhsTvoRi7IOr3LU+Wj/++R863NJlqGU5yBDJRE5J6rrjtE7dn4vEqwc7Tm+cr
         KdCRRNgzNBJ6XW3mAOTVVJYyYDDzXeTDjWZePoCUFPUa62/YYLal1hmorKcE3KX9Jj
         nZ4mK9ENLxjvV6LaX2jHVkzVHF16ZHptlsQhPuSLA0+Sj+W/9dgm1ujPJgo/hMip1p
         fecLoRq47FPQgCXrevRWatg5W8t9rqqPkwKUPhxGkjdpgkLPFvHzRAzab2uJBj80o7
         3spNu0RKWbVW+x+AgZAbK6eQW4Cgg+6vbspyTZnC6vgHaCvm4rrd3dziWnN4V7XC3M
         mcMTgvl2nquMQ==
Date:   Thu, 10 Nov 2022 11:45:21 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, axboe@kernel.dk, stefanha@redhat.com,
        me@demsh.org, mpatocka@redhat.com
Subject: Re: [PATCH 0/3] fix direct io errors on dm-crypt
Message-ID: <Y21GwRUeJVwN17rR@kbusch-mbp.dhcp.thefacebook.com>
References: <20221103152559.1909328-1-kbusch@meta.com>
 <Y21BwxCkeaONcYK5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y21BwxCkeaONcYK5@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 10, 2022 at 06:24:03PM +0000, Eric Biggers wrote:
> On Thu, Nov 03, 2022 at 08:25:56AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The 6.0 kernel made some changes to the direct io interface to allow
> > offsets in user addresses. This based on the hardware's capabilities
> > reported in the request_queue's dma_alignment attribute.
> > 
> > dm-crypt requires direct io be aligned to the block size. Since it was
> > only ever using the default 511 dma mask, this requirement may fail if
> > formatted to something larger, like 4k, which will result in unexpected
> > behavior with direct-io.
> > 
> > There are two parts to fixing this:
> > 
> >   First, the attribute needs to be moved to the queue_limit so that it
> >   can properly stack with device mappers.
> > 
> >   Second, dm-crypt provides its minimum required limit to match the
> >   logical block size.
> > 
> > Keith Busch (3):
> >   block: make dma_alignment a stacking queue_limit
> >   dm-crypt: provide dma_alignment limit in io_hints
> >   block: make blk_set_default_limits() private
> 
> Hi Keith, can you send out an updated version of this patch series that
> addresses the feedback?
> 
> I'd really like for this bug to be fixed before 6.1 is released, so that there
> isn't a known bug in STATX_DIOALIGN already upon release.

Sorry for the delay, v2 sent.
