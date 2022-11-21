Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859E9C433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 22:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKUWrg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKUWre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 17:47:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9591161
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 14:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86CBC614ED
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 22:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AC9C433C1;
        Mon, 21 Nov 2022 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669070848;
        bh=rupfA7QgttNtvcAds+s7jyNT0wRc3bEiCsYNLN49KQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9ZfIsUtxeuA1852d+UCrNWaEOk6PxCV3Z3yvQyDnfHiyDQ04DqsKdUFWQV/ty+tX
         0Sa1JkpXsANIGE66aeQdWNL4S4YGCENUSga7cW6xmmZcu20mwD6C7mHYNU0S+gBOXP
         fcmKEQs4aOlTqk1qEgdADFGKrKstRlvKmGVb4KW1JbPkihku+DpIY3sl6XU1f0vacu
         oJZYySatSWBNhwHzK9qk2pv5VfPIh6sapq3vgr2DEbHgUP8CNn4oX4JdyOg47Rys/8
         Q6NrpCvUU0SWmL+P7mJt2YO8OmmdPaXFMbF7XhJpq1scpgHCNTLbVHEjJ4KBSyJOW0
         rHh2dm0ufTObQ==
Date:   Mon, 21 Nov 2022 15:47:24 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3v//NgG3xw8w/xS@kbusch-mbp>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
 <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 21, 2022 at 03:34:44PM -0700, Jonathan Derrick wrote:
> On 11/21/2022 1:55 PM, Keith Busch wrote:
> > On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
> >> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
> >> reliably segfaults my QEMU instance (something else to look into) and I don't
> >> have any 'real' hardware to test this on at the moment. It looks like several
> >> passthru commands are able to enqueue prior/during/after resetting/connecting.
> > 
> > I'm not seeing any problem with the latest nvme-qemu after several dozen
> > iterations of this test case. In that environment, the formats and
> > resets complete practically synchronously with the call, so everything
> > proceeds quickly. Is there anything special I need to change?
> >  
> I can still repro this with nvme-fixes tag, so I'll have to dig into it myself
> Does the tighter loop in the test comment header produce results?

My qemu's backing storage is a nullblk which makes format a no-op, but I
can try something slower if you think that will have different results.
These kinds of tests are definitely more pleasant to run under
emulation, so having the recipe to recreate there is a boon.
 
> >> The issue seems to be very heavily timing related, so the loop in the header is
> >> a lot more forceful in this approach.
> >>
> >> As far as the loop goes, I've noticed it will typically repro immediately or
> >> pass the whole test.
> > 
> > I can only get possible repro in scenarios that have multi-second long,
> > serialized format times. Even then, it still appears that everything
> > fixes itself after a waiting. Are you observing the same, or is it stuck
> > forever in your observations?
> In 5.19, it gets stuck forever with lots of formats outstanding and
> controller stuck in resetting. I'll keep digging. Thanks Keith

At the moment I'm interested in upstream, so either Linus' latest
6.1-rc, or the nvme-6.2 branch. If you can confirm these are okay (which
appears to be the case on my side), then I can definitely shift focus to
stable back-ports. But if they're not okay, then I want to straighten
that side out first.
