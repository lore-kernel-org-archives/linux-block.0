Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E519FC433ED
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69356108D
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 12:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbhEQM21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 08:28:27 -0400
Received: from verein.lst.de ([213.95.11.211]:57313 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhEQM21 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 08:28:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E31967373; Mon, 17 May 2021 14:27:09 +0200 (CEST)
Date:   Mon, 17 May 2021 14:27:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: linux 5.12 - fails to boot - soft lockup - CPU#0 stuck for
 23s! - RIP smp_call_function_single
Message-ID: <20210517122709.GC15150@lst.de>
References: <3516e776-6c69-2a83-6da4-19de77621b18@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3516e776-6c69-2a83-6da4-19de77621b18@nurealm.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any information of the system?  What block driver(s) do you use, how
many CPUs, kernel config?

On Fri, May 14, 2021 at 12:39:59PM -0600, James Feeney wrote:
> With the patch to kernel/smp.c in linux 5.12.4, "smp: Fix smp_call_function_single_async prototype", by Arnd Bergmann, I thought maybe there was a fix.  But no.  The error is the same, except the top of the Call Trace is different:
> 
> ...
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! ...
> ...
> RIP: 0010:smp_call_function_single+0xeb/0x130
> ...
> Call Trace:
> ? text_poke_loc_init+0x160/0x160
> ? text_poke_loc_init+0x160/0x160
> on_each_cpu+0x39/0x90
> ...
> 
> and repeats indefinitely.
> 
> Again, smp_call_function_single is defined in kernel/smp.c
> 
> It seems that my git bisect is probably off, since apparently the system may sometimes boot to a temporarily working state, and some "exercise" is needed to identify the failure.  However, see another git bisect for possibly the same issue at
> 
>  https://bugs.archlinux.org/task/70663#comment199765
> 
> with "bisect-result.txt"
> 
>  https://bugs.archlinux.org/task/70663?getfile=20255
> 
> Markus says, in part:
> 
> ====
> Trying to bisect, I arrived at a different set of commits though.
> 7a800a20ae6329e803c5c646b20811a6ae9ca136 showed the issue described, where a seemingly working kernel will lock up rather quickly.
> f007a3d66c5480c8dae3fa20a89a06861ef1f5db worked flawlessly, without any hiccups doing random internet browsing while I was compiling the next bisect step.
> However, there are six commits between those, that did not boot and left me stuck with a black screen right after the bootloader (so no systemd startup message or similar). The system did not react to any inputs (Alt+SysRq) or to a short press of the PC's power button, and thus a hard shutdown was necessary.
> ====
> 
> These 8 commits - total - are from Christopher Hellwig, 2021 Feb 02.  Perhaps something closer to the real issue is in there.  As with Markus, I've also noticed that a "warm" reboot can result in a frozen system immediately after the boot loader has run.  A full power-off reboot is needed to get past the early screen initialization.
> 
> I'll have to re-do my git bisect, with more extensive system "exercise", to see if something more useful results.
> 
> James
---end quoted text---
