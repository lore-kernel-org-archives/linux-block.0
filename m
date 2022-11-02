Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BFC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 14:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKBOwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKBOwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 10:52:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0A2A266
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 07:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB205B822EF
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 14:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC94DC433D6;
        Wed,  2 Nov 2022 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667400738;
        bh=23NKhgHnZWlfaYPr3GcK3F1bLvQlNIvVQwPNhseXmD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9rdbhUuzxQon+VnOqaLcd/tE7h8Mj1WlezAavzjktxtCYh+0kWQthi3C6SHbectj
         Wwwo5sS3JNdchNpKRphI8OuSXz1nsXKXLjIEAbUJpuCn0s1sDQ78aHaIFW5t949HY3
         Y/0OAZy0rxu7db9jEd2sL2bMkyCSpASAIKaBCWyvbr4Lq+2w5zKyRt4fSURaSjhedm
         kG5kg2WRtcdcNjqpgfBMm8zgPyI46I+rwBLLcTRpgLI/HqD44/3ahHJRdUwT9XnMJl
         lM8ZmiTs53zFnQMnMMGgrj0oZrJLiO5lwD443Bg5xb5FfYQw1q4v7G3lKfNodYe2Z7
         RzFkBkOtHO1fw==
Date:   Wed, 2 Nov 2022 08:52:15 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dmitrii Tcvetkov <me@demsh.org>
Subject: Re: Regression: wrong DIO alignment check with dm-crypt
Message-ID: <Y2KEH6OZ0MDf5cSh@kbusch-mbp.dhcp.thefacebook.com>
References: <Y2Hf08vIKBkl5tu0@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Hf08vIKBkl5tu0@sol.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[Cc'ing Dmitrii, who also reported the same issue]

On Tue, Nov 01, 2022 at 08:11:15PM -0700, Eric Biggers wrote:
> Hi,
> 
> I happened to notice the following QEMU bug report:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/1290
> 
> I believe it's a regression from the following kernel commit:
> 
>     commit b1a000d3b8ec582da64bb644be633e5a0beffcbf
>     Author: Keith Busch <kbusch@kernel.org>
>     Date:   Fri Jun 10 12:58:29 2022 -0700
> 
>         block: relax direct io memory alignment
> 
> The bug is that if a dm-crypt device is set up with a crypto sector size (and
> thus also a logical_block_size) of 4096, then the block layer now lets through
> direct I/O requests to dm-crypt when the user buffer has only 512-byte
> alignment, instead of the 4096-bytes expected by dm-crypt in that case.  This is
> because the dma_alignment of the device-mapper device is only 511 bytes.
> 
> This has two effects in this case:
> 
>     - The error code for DIO with a misaligned buffer is now EIO, instead of
>       EINVAL as expected and documented.  This is because the I/O reaches
>       dm-crypt instead of being rejected by the block layer.
> 
>     - STATX_DIOALIGN reports 512 bytes for stx_dio_mem_align, instead of the
>       correct value of 4096.  (Technically not a regression since STATX_DIOALIGN
>       is new in v6.1, but still a bug.)
> 
> Any thoughts on what the correct fix is here?  Maybe the device-mapper layer
> needs to set dma_alignment correctly?  Or maybe the block layer needs to set it
> to 'logical_block_size - 1' by default?

I think the quick fix is to have the device mapper override the default
queue stacking limits to align the dma mask to logical block size.

Does dm-crypt strictly require memory alignment to match the block size,
or is this just the way the current software works that we can change?
It may take me a moment to get to the bottem of that, but after a quick
glance, it looks like dm-crypt will work fine with the 512 offsets if we
happen to have a physically contiguous multi-page bvec, and will fail
otherwise due to a predetermined set of sg segments (looking at
crypt_convert_block_aead()).
