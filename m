Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C97ECAAA1
	for <linux-block@archiver.kernel.org>; Tue,  6 Sep 2022 21:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIFVsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIFVsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Sep 2022 17:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C93804A2
        for <linux-block@vger.kernel.org>; Tue,  6 Sep 2022 14:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E40616EF
        for <linux-block@vger.kernel.org>; Tue,  6 Sep 2022 21:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFA6C433D6;
        Tue,  6 Sep 2022 21:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662500896;
        bh=8vgpKeAV2cJUA6tfBfYc+UIphSdbmCSC9Mpg2TLEHf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REpkMKw8WMqflmEdYV2KWo+cPYDxY2ugTbfQsK2b8wcc24vXpsUGtLZwKnjHnRPT1
         QCb7cErsbc2ddw/d5WRPg9/qM5kcWV0wEVe3aeYIllzBa/uBsOfY0kdN8/Tqx/oCWl
         MKVspjzhoxsiaufH3I3uGRr2nXNzM83L0Rwq0lDe2nYxF3WePN6NkoA1Bn9ez98VW4
         h1wk6WHDxfeIMWjo7Jj1vbU1V0PJEW1qdZy0pAVXOo9SWBFIZ8NmwiT+4fuDCN7Eiy
         NrkQuFFTAhCxjkEFIxG6hGryNxjqS6FfBXsgpVFJClAl+VXDiqfzDIBkf+AlJU+wPZ
         ue60oRvl+MAuw==
Date:   Tue, 6 Sep 2022 15:48:13 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Keith Busch <kbusch@fb.com>,
        pankydev8@gmail.com, hare@suse.de
Subject: Re: [PATCHv3] sbitmap: fix batched wait_cnt accounting
Message-ID: <YxfAHRC7IlshWj+t@kbusch-mbp.dhcp.thefacebook.com>
References: <20220825145312.1217900-1-kbusch@fb.com>
 <166205058410.59240.3725947759855970973.b4-ty@kernel.dk>
 <e742813b-ce5c-0d58-205b-1626f639b1bd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e742813b-ce5c-0d58-205b-1626f639b1bd@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 04, 2022 at 06:39:14AM -0600, Jens Axboe wrote:
> On 9/1/22 10:43 AM, Jens Axboe wrote:
> > On Thu, 25 Aug 2022 07:53:12 -0700, Keith Busch wrote:
> >> From: Keith Busch <kbusch@kernel.org>
> >>
> >> Batched completions can clear multiple bits, but we're only decrementing
> >> the wait_cnt by one each time. This can cause waiters to never be woken,
> >> stalling IO. Use the batched count instead.
> >>
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] sbitmap: fix batched wait_cnt accounting
> >       commit: 16ede66973c84f890c03584f79158dd5b2d725f5
> 
> This is causing CPU stalls for me running make -j256 with the source
> hosted on an ATA device with QD=32. It's not running with a scheduler.
> It just goes spammy on most/all CPUs so  hard to get a real trace out of
> it, but it looks like we're just looping forever off
> sbitmap_queue_wake_up().
> 
> I'm going to revert this one for now until we can investigate what is
> going on here.

I was able to reproduce this without much trouble. I think it needs to restore
the wait_cnt if we're racing with wait_active. I think the problem even exists
without this patch ([1]), but you'd be unlikely to hit it decrementing wait_cnt
just one at a time when the wait_batch is > 1. The diff on top of this patch
should fix it:

---
-	if (!waitqueue_active(&ws->wait))
+	if (!waitqueue_active(&ws->wait)) {
+		atomic_add(nr, &ws->wait_cnt);
		return true;
+	}
--

[1] https://lore.kernel.org/linux-block/Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com/T/#t
