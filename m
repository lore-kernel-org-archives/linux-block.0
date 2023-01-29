Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB87C61D97
	for <linux-block@archiver.kernel.org>; Sun, 29 Jan 2023 03:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjA2DUQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Jan 2023 22:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2DUP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2023 22:20:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8E22A18
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 19:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B761A60C53
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 03:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07665C433D2;
        Sun, 29 Jan 2023 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674962411;
        bh=giDqw3NRnrA/zcEttkXFj0m+ywtdDoRDcmiqiKswv+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZU1XwVAmqgt2ajb9YrsVfe2u/vqMfe0wIgIAEGpyPsUoFIh80CiqUV11aWPwE781
         4VFmXRQhEaNYZt1M4m375cLqvoORd/hFE/7IGAWlr4+uPcAPus7XQ/c/Lh6dulahut
         BvPNRjRHkGTnxt2SyrP7a0yUetH21+YyMDWH9MI7y/lOtdPIchuWfu9mSlhgmkg6wu
         EnUaRBFJ0ZGFQVtLSSZ5R7tLakdkiiXbtEeOehsMbDlBtqVKC1kZlJTJcLU5K7jBKV
         BzxG0dYFFLBhPKAPT5flV+gjLG0sYSuFlbkPoAod4r7MDtbhWpcwzQhBtjm9g63rwA
         S6iDrMdjxRxVQ==
Date:   Sat, 28 Jan 2023 19:20:09 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
Message-ID: <20230129031314.px2c6mcfsbl6n26m@garbanzo>
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
 <YnAgJZUzDTTbAOXY@relinquished.localdomain>
 <d78b3d02-99a5-7876-2a6a-8b5f52a05def@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d78b3d02-99a5-7876-2a6a-8b5f52a05def@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 02, 2022 at 12:24:04PM -0700, Hannes Reinecke wrote:
> On 5/2/22 11:17, Omar Sandoval wrote:
> > On Mon, May 02, 2022 at 09:21:31AM -0700, Hannes Reinecke wrote:
> > > Hi Omar,
> > > 
> > > and another topic which came up during discussion yesterday:
> > > 
> > > eBPF for block devices
> > > It would be useful to enable eBPF for block devices, such that we could do
> > > things like filtering bios on bio type, do error injection by modifying the
> > > bio result etc.
> > > This topic should be around how it could be implemented and what additional
> > > use-cases could be supported.
> > > 
> > > Cheers,
> > > 
> > > Hannes
> > 
> > Do you want to try to coordinate a joint session with BPF, or were you
> > planning on brainstorming what we need just in the IO track and tracking
> > down the BPF folks offline?
> > 
> > +Alexei and Daniel
> 
> Coordinated session, please.
> We need to get some common understandig of those things we're trying to do
> are properly eBPF-ish, and alse make the eBPF people aware of the issue
> we're facing.

We last spoke about error injection prospects with eBPF at last year's LSFMM,
and I had explained the lay of the land of pros cons, and the last incarnation
I had tried was the one with the least amount of code affected upstream, but
that was still not a viable accepted approach as we still had to sprinkle a
few branches here and there. And so curious if things have changed.

An alternative that comes to mind recently is to do use something like
ldflags-y += --wrap=upstream_call as the CXL folks do with tools/testing/cxl/Kbuild
however I'm in no way shape or form a fan of what how they did that without proper
kconfig semantics -- that has already proven to easily crash. One *can* do this
with proper Kconfig semantics.

The only downfall to this would be that we'd have live with a copy of
the routine we want elsewhere say block/alt/foo.c to debug with the deltas we
want spinkled onto it. So we'd have to then try to keep both in sync and
that seems like another pain in the ass.

Either way, consider me interested in beating the horse on error injection.

  Luis
