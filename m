Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB14BC7EE29
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 15:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjECPUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjECPUK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 11:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2FC4EE0
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 08:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A78E62E41
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AAAC4339B;
        Wed,  3 May 2023 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683127207;
        bh=amVl4BB2D/6DfKUt8HmDKmuvu6l6ZwO3NfV6j+oHUE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPmU+XnWTww1NaLIW8r6Co2fDdP9yYBu7++2ZNZ+zqyI+4YUjk1E5oxXJCMnhROhK
         uUU5vzLkFGQjG7ZEVpDK1wwjfIol0gEMOI4PVEW/82GDPQFhEF3I3o2hPRmn/AyalM
         rGflP5nZ2GwSrZL2BjkM0AH3RTeaAnCiO/hCMGQo4f4cYLEefu44F6Q6JfXeGpu6Qw
         4U/i7hGQy9Nwv17LsxETvNHIhuHS3BpaiU5V9BrvtAOsYI61B6GiA0UKjqJP1DB6oG
         qoGSURkbORoOlUCEYBzSBG0LikMny03KXn/vCUV1eHzrUQPXJ+6HNbI4eH7BUt+e74
         YM280i9n4/IDw==
Date:   Wed, 3 May 2023 09:20:04 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 0/3] nvme uring passthrough diet
Message-ID: <ZFJ7pAuTY6ESCVgp@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947@epcas5p3.samsung.com>
 <20230501153306.537124-1-kbusch@meta.com>
 <20230503072625.GA18487@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503072625.GA18487@green245>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 12:57:17PM +0530, Kanchan Joshi wrote:
> On Mon, May 01, 2023 at 08:33:03AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > When you disable all the optional features in your kernel config and
> > request queue, it looks like the normal request dispatching is just as
> > fast as any attempts to bypass it. So let's do that instead of
> > reinventing everything.
> > 
> > This doesn't require additional queues or user setup. It continues to
> > work with multiple threads and processes, and relies on the well tested
> > queueing mechanisms that track timeouts, handle tag exhuastion, and sync
> > with controller state needed for reset control, hotplug events, and
> > other error handling.
> 
> I agree with your point that there are some functional holes in
> the complete-bypass approach. Yet the work was needed to be done
> to figure out the gain (of approach) and see whether the effort to fill
> these holes is worth.
> 
> On your specific points
> - requiring additional queues: not a showstopper IMO.
>  If queues are lying unused with HW, we can reap more performance by
>  giving those to application. If not, we fall back to the existing path.
>  No disruption as such.

The current way we're reserving special queues is bad and should
try to not extend it futher. It applies to the whole module and
would steal resources from some devices that don't want poll queues.
If you have a mix of device types in your system, the low end ones
don't want to split their resources this way.

NVMe has no problem creating new queues on the fly. Queue allocation
doesn't have to be an initialization thing, but you would need to
reserve the QID's ahead of time.

> - tag exhaustion: that is not missing, a retry will be made. I actually
>  wanted to do single command-id management at the io_uring level itself,
>  and that would have cleaned things up. But it did not fit in
>  because of submission/completion lifetime differences.
> - timeout and other bits you mentioned: yes, those need more work.
> 
> Now with the alternate proposed in this series, I doubt whether similar
> gains are possible. Happy to be wrong if that happens.

One other thing: the pure-bypass does appear better at low queue
depths, but utilizing the plug for aggregated sq doorbell writes
is a real win at higher queue depths from this series. Batching
submissions at 4 deep is the tipping point on my test box; this
series outperforms pure bypass at any higher batch count.

Part of the problem with the low queue depth for this mode is the
xarray lookup on each bio_poll, but I think that we can fix that.

> Please note that for some non-block command sets, passthrough is the only
> usable interface. So these users would want some of the functionality
> bits too (e.g. cgroups). Cgroups is broken for the passthrough at the
> moment, and I wanted to do something about that too.
> 
> Overall, the usage model that I imagine with multiple paths is this -
> 
> 1. existing block IO path: for block-friendly command-sets
> 2. existing passthrough IO path: for non-block command sets
> 3. new pure-bypass variant: for both; and this one deliberately trims all
> the fat at the expense of some features/functionality.
> 
> #2 will not have all the features of #1, but good to have all that are
> necessary and do not have semantic troubles to fit in. And these may
> grow over time, leading to a kernel that has improved parity between block
> and non-block io.
> Do you think this makes sense?


