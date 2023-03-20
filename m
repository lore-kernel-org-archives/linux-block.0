Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5108AC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 09:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCTJhA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCTJgi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 05:36:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB823D86;
        Mon, 20 Mar 2023 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tqALbZ5OD+GvIZ79Hn4bb3l4PzR7mUDvgsif1iZUWmw=; b=DSDp52qf3yBjZLxsGm62G6Pf4T
        uqDeOgVWr3ykHJqXSRHqsRagNKKOXdDo0fOWb51S+e0GPR/qTpf4dsPXudoRisSNmrSdg4uiWSbC9
        gvrLpP0Asc5xZEK4m9ByF43fnfomcJ8p0ecQJPwjtLsiA3DtRtwIfK12cdTTzXix64Mpz0f/Yfu/j
        0D2IqKRdEo6HIPoQVMw4aA02e6u5/We7l4jba/mIzYuxufnFM7YI2UYDj7kgAllDG61bqBi4F96SY
        dptQekvT5zyxbEvx1aQ6VKhQovL4H4EkRgGf7obXJLiEEVXyNEhDKX/JZu9FAMVuitipeESl0lDZ+
        0YmRkElQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peBw8-000sob-9k; Mon, 20 Mar 2023 09:36:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8727300288;
        Mon, 20 Mar 2023 10:36:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E98420EEFFC2; Mon, 20 Mar 2023 10:36:14 +0100 (CET)
Date:   Mon, 20 Mar 2023 10:36:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Klimov <alexey.klimov@linaro.org>
Cc:     draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, bvanassche@acm.org, klimova@google.com
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
Message-ID: <20230320093614.GB2196776@hirez.programming.kicks-ass.net>
References: <20230314230004.961993-1-alexey.klimov@linaro.org>
 <20230315111606.GB2006103@hirez.programming.kicks-ass.net>
 <CANgGJDpd4Gm5HhQW__oMAv1yUqSPZ7FSGoQLYTmug=TUk4cn4g@mail.gmail.com>
 <20230320090558.GF2194297@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320090558.GF2194297@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 20, 2023 at 10:05:58AM +0100, Peter Zijlstra wrote:
> On Fri, Mar 17, 2023 at 02:11:25AM +0000, Alexey Klimov wrote:
> > On Wed, 15 Mar 2023 at 11:16, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > >
> > > (could you wrap your email please)
> > 
> > Ouch. Sorry.
> > 
> > > On Tue, Mar 14, 2023 at 11:00:04PM +0000, Alexey Klimov wrote:
> > > > #regzbot introduced: 0c5ffc3d7b15 #regzbot title:
> > > > CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck
> > > > reboots
> > > >
> > > > The upstream changes are being merged into android-mainline repo and
> > > > at some point we started to observe kernel panics on reboot or long
> > > > reboot times.
> > >
> > > On what hardware? I find it somewhat hard to follow this DT code :/
> > 
> > Pixel 6.
> 
> What actual cpuidle driver is that thing using? Is there any out-of-tree
> code involved? Mark tells me anything arm64 should be using PSCI, so let
> me to stare hard at that again.

So specifically, your problem sounds like rcu_synchronize() is taking
very much longer than it used to. Specifically combined with the patch
that makes it 'go-away' this seems to indicate you lost a
ct_cpuidle_enter() call, which is what ends up telling RCU the cpu is
idle and no longer partakes in the whole grace period machinery. Not
telling RCU this results in RCU waiting for an idle cpu to report back
on it's RCU progress, but it being idle means it's not going to be doing
that and things sorta wait around until RCU gets fed up and starts
spraying IPIs to try and get things moving.


Now...  if a driver sets CPUIDLE_FLAG_RCU_IDLE it promises to call
ct_cpuidle_{enter,exit}() itself. Hence for any driver that does *NOT*
set that flag, cpuidle_enter_state() calls these functions.

Now, fo PSCI, the DT handler is psci_enter_idle_state(), which uses
CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(), which per the other email, means that
it's low_level_idle_enter := psci_cpu_suspend_enter(), *will* call
ct_cpuidle_{enter,exit}().

Then if we look at psci_cpu_suspend_enter(), it has two cases depending
on psci_power_state_loses_context(). If it doesn't lose context it does
ct_cpuidle_enter() right there and proceeds to call
psci_ops.cpu_suspend() -- whatever that does.

If it does lose state, then it depends on CONFIG_ARM64, on arm64 we do
not call ct_cpuidle_{enter,exit}() but proceed into cpu_suspend().

We can find that function in arch/arm64/kernel/suspend.c, and if you
look at it, you'll note it does in fact call ct_cpuidle_{enter,exit}()
as per promises made.

So AFAICT every path into idle will pass through ct_cpuidle_enter().



