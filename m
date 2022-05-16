Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E0AC433F5
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 14:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiEPOcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 10:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiEPOcc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 10:32:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4529D5F
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 07:32:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B75D1B81247
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 14:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E599DC385AA;
        Mon, 16 May 2022 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652711545;
        bh=JXYhyrnaEDrK1QCzu+M3wxM4XWKmKG9GhC8Ll/PpKio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vi/lv9rYH+Yvg9UGANUYJT9VKofkt/29Jp+0uVRm+xgsUgpCvAS5jdku/GJQvy44n
         Tz2hdubE0z0o6oRwK8xDXEVm3S2Qnb4CVGaAWTXal8OrvU8uMes+ubWnOCjwKGLy9I
         aYc7uwwftnpJAFwEqFwei9QdcZ8gEmLIPY6VWMIwCF+DPOBb5Um6UlJFyTGTazxJ1J
         McSVG+8KIF7rFHDdRvkKZRXFtcMgC6ow8rgG7jN0yhpJBOUS//zmV/526R6SoLfUEK
         JYqezJBMAJPvTUcGLjkof5r7644UTXvq2j+wVRNvqdSr5GGcpY0am2Unq/NdUbKYwo
         lyla6hbTUCYDA==
Date:   Mon, 16 May 2022 08:32:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 1/3] block: export dma_alignment attribute
Message-ID: <YoJgdrMpIiobiDy3@kbusch-mbp.dhcp.thefacebook.com>
References: <20220513161339.1580042-1-kbusch@fb.com>
 <YoH0vuUA4KdcpEAz@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoH0vuUA4KdcpEAz@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 15, 2022 at 11:52:46PM -0700, Christoph Hellwig wrote:
> I'm not against the sysfs file, but for applications this is a
> horrible interface.  We really need something that works on the fd.

Yeah, sysfs is not very convenient for the intended use.
 
> The XFS_IOC_DIOINFO ioctl from xfs is one, although ugly, option.
> The other is to export the alignment requirements through statx.
> We had that whole discussion with the inline crypto direct I/O support,
> and we really need to tackle it rather sooner than later.

I'll try out assigning one of the spares in 'struct statx' for the purpose. I
like the interface for that, and looks easy enough to pass along the dma
alignment requirement through it.
