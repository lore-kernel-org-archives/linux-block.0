Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4767C4332F
	for <linux-block@archiver.kernel.org>; Sat, 24 Dec 2022 10:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiLXKLq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Dec 2022 05:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLXKLp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Dec 2022 05:11:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E72AEE;
        Sat, 24 Dec 2022 02:11:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DDB760A5C;
        Sat, 24 Dec 2022 10:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CD7C433D2;
        Sat, 24 Dec 2022 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671876702;
        bh=Og4/i2N2GU2fHSbMoasfQOW1B25W94LO3VVi0+hvbpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjrnyvRLkV2dcwRYtOrxUP4SWkKMzNjKEX3OweCWHPuPUEZtf8X8eSnkO6On6WaGC
         cmkQzp+gMBgtPS6tXVLFtBsOPL6QY1ud1M6wPptxFrc1PvJz95b1AMoA1EXlQtzPF5
         HBEPHFy/ZpkEmN2UEfOyqHQuLyuviu8IhZLhi5mlpnAuOyA5HltJPLz9inWK1tzT2n
         kcy3V7ZvCCxbnlo1DoXLJSRIyVT/R4ICeq3bHIj70GpkhA8eOyLpyyXnARBtuVuti7
         v6CnEg6QIv8pnB0XQY2j9eQ76fwZCw7JbRP8Ebafjsch65GXAcxBq8qiK5E+Ad8c/0
         JxKFKDLXMINzQ==
Received: by pali.im (Postfix)
        id C7E4E720; Sat, 24 Dec 2022 11:11:39 +0100 (CET)
Date:   Sat, 24 Dec 2022 11:11:39 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <20221224101139.sgvhr2n3pbrs4agm@pali>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <20221224095353.w32xhmyzlft6qi4v@pali>
 <Y6bObzIoHrJMotI3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6bObzIoHrJMotI3@kroah.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Saturday 24 December 2022 11:03:27 Greg Kroah-Hartman wrote:
> On Sat, Dec 24, 2022 at 10:53:53AM +0100, Pali Rohár wrote:
> > On Friday 02 December 2022 19:27:58 Greg Kroah-Hartman wrote:
> > > Way back in 2016 in commit 5a8b187c61e9 ("pktcdvd: mark as unmaintained
> > > and deprecated") this driver was marked as "will be removed soon".  5
> > > years seems long enough to have it stick around after that, so finally
> > > remove the thing now.
> > 
> > Why to remove? This driver is still widely used, userspace in active
> > maintenance and in last two years userspace software received more fixes
> > for CD-RW support and pktcdvd.
> 
> It was marked as "please remove" back in 2016, why wasn't that changed
> if people were actually using this?

And how should I know it if I was informed about it just today?

> > Just now community person informed me that somebody is going to remove
> > kernel support.
> 
> Isn't there better ways to support the hardware needed than this driver?

Is there any other driver in kernel which provide block layer for it?
I do not know about any other.
