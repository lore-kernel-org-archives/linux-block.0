Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD59C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiKJSYI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJSYH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:24:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC2B1F5
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:24:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC6361DEF
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 18:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E8AC433D6;
        Thu, 10 Nov 2022 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668104645;
        bh=8JVRz5p4kXMBlx2NUiQBUoloHovl2gcMMyb7oaEudjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzFmVaTg9798HfoH4ebo1aP9h+W+G9CkBKiV/Dau9Q18ZaTfJqouwMhQ+Y/nXe6NI
         nUzfNWu+nECANdzaBxxr9C8CVTlFFyVsn8eLzB+fqAGuGCBvj8cQ4mhFsAtL3N2CEg
         JK/oyPPDgIpBWfQ/nZwdGF6qWruPpOQQ6xyJ6MDKkj/La6nzdlzpT9nx2quImX1p3q
         ppqhJBBrR6zmr0gViABTt8NgaFUpqR5X9r9v0ecWzWtvVTWalxwfeDTSCHbOObNKU4
         8Pj4eFKurYthQhMYsaCV5lFY6xbXVku3ssme0wAuacWhDTcfhwKrlDGcSH+xQ6ky1m
         34RmFaZJINkfw==
Date:   Thu, 10 Nov 2022 18:24:03 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, me@demsh.org, mpatocka@redhat.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/3] fix direct io errors on dm-crypt
Message-ID: <Y21BwxCkeaONcYK5@gmail.com>
References: <20221103152559.1909328-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103152559.1909328-1-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 03, 2022 at 08:25:56AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The 6.0 kernel made some changes to the direct io interface to allow
> offsets in user addresses. This based on the hardware's capabilities
> reported in the request_queue's dma_alignment attribute.
> 
> dm-crypt requires direct io be aligned to the block size. Since it was
> only ever using the default 511 dma mask, this requirement may fail if
> formatted to something larger, like 4k, which will result in unexpected
> behavior with direct-io.
> 
> There are two parts to fixing this:
> 
>   First, the attribute needs to be moved to the queue_limit so that it
>   can properly stack with device mappers.
> 
>   Second, dm-crypt provides its minimum required limit to match the
>   logical block size.
> 
> Keith Busch (3):
>   block: make dma_alignment a stacking queue_limit
>   dm-crypt: provide dma_alignment limit in io_hints
>   block: make blk_set_default_limits() private

Hi Keith, can you send out an updated version of this patch series that
addresses the feedback?

I'd really like for this bug to be fixed before 6.1 is released, so that there
isn't a known bug in STATX_DIOALIGN already upon release.

Thanks!

- Eric
