Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68866EB64DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 06:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGDGyG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 02:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGDGyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 02:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A29E107;
        Mon,  3 Jul 2023 23:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9251361161;
        Tue,  4 Jul 2023 06:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A806FC433C8;
        Tue,  4 Jul 2023 06:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688453644;
        bh=GtIczgk+uy3osy7x9+LMppBWIexhfEBaDf1y+GtXuOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0Sfiz666GIquZN774fyO/HYD0OxF6kbKYxIzORPfezfLMdgekmO9mtgLwkYi4ZK6
         Gf16w3QlDzWzmZDWmU0cl2BktjdL/lKIXxHdvISyt9Mf+hD3x8+xXyJ5iCVlKpaQFK
         ALcaHuJ1arOrVGWw8jcTSa3HgvKnVbD8zc8bh0aM=
Date:   Tue, 4 Jul 2023 07:54:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] block: bugfix for Amiga partition overflow check patch
Message-ID: <2023070456-vertigo-fanfare-1a8e@gregkh>
References: <20230704054955.16906-1-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704054955.16906-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 04, 2023 at 05:49:55PM +1200, Michael Schmitz wrote:
> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
> fails the 'blk>0' test in the partition block loop if a
> value of (signed int) -1 is used to mark the end of the
> partition block list.
> 
> This bug was introduced in patch 3 of my prior Amiga partition
> support fixes series, and spotted by Christian Zigotzky when
> testing the latest block updates.
> 
> Explicitly cast 'blk' to signed int to allow use of -1 to
> terminate the partition block linked list.
> 
> Testing by Christian also exposed another aspect of the old
> bug fixed in commits fc3d092c6b ("block: fix signed int
> overflow in Amiga partition support") and b6f3f28f60
> ("block: add overflow checks for Amiga partition support"):
> 
> Partitions that did overflow the disk size (due to 32 bit int
> overflow) were not skipped but truncated to the end of the
> disk. Users who missed the warning message during boot would
> go on to create a filesystem with a size exceeding the
> actual partition size. Now that the 32 bit overflow has been
> corrected, such filesystems may refuse to mount with a
> 'filesystem exceeds partition size' error. Users should
> either correct the partition size, or resize the filesystem
> before attempting to boot a kernel with the RDB fixes in
> place.
> 
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")

That commit is not in:

> Cc: <stable@vger.kernel.org> # 6.4

6.4.  It's in Linus's tree only right now.

But yes, it's tagged for 5.2 and older kernels to be added to the stable
tree, so why is this one limited only to 6.4 and not also for 5.2 and
newer?

thanks,

greg k-h
