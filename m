Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD00C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 00:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA85206C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 00:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873193;
	bh=+Rfs2P3f9qiHGH9rZa3+k/ZNXOeCJS7o7S/X4xAuHic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YtykeatZlyDEYmGHIRIkeT93ABxqOx6QVjlUyRnG3VRBO4ZS1L93R/qJN70E5vMeq
	 foXP81y+2YM7ifqeDOVmD4WHVaoqpjqCcQ46gcGYlzJhBkTQEyVHhqjKubyjAtk+yE
	 m+A9PBpxoZNdDA1/RLNusD1EVvl0DutyZ0DXM3Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgFWAqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731671AbgFWAqV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 20:46:21 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C008E2098B;
        Tue, 23 Jun 2020 00:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872686;
        bh=+Rfs2P3f9qiHGH9rZa3+k/ZNXOeCJS7o7S/X4xAuHic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tUpEUuCdwp7MpgIflhPpLT87I/iLWPZlzvRDundSXhoMGGazFoBiRdRw4sMpewk8g
         cmU00xXn16jxMaT4ukp4Y2Qtzv/7twFhdvM8zrhKfZlvIRI7v/qXldeWdxs14+LFDW
         8x0uv5DMNsy9F1/Tgc+2dWC1mLEp/xz4jB9OqVNs=
Date:   Tue, 23 Jun 2020 09:38:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ming Lei <ming.lei@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-Id: <20200623093801.db9d2ca9c3bfef61ef6a2a58@kernel.org>
In-Reply-To: <20200623084706.e6e99e99d7da6690e7a6c199@kernel.org>
References: <20200618125438.GA191266@T590>
        <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
        <20200618231901.GA196099@T590>
        <20200619141239.56f6dda0976453b790190ff7@kernel.org>
        <20200619072859.GA205278@T590>
        <20200619081954.3d72a252@oasis.local.home>
        <20200619133240.GA351476@T590>
        <20200620003509.9521053fbd384f4f5d23408f@kernel.org>
        <20200619232820.GE353853@T590>
        <20200620103747.fb83f804083ef9956740acee@kernel.org>
        <20200622002753.GC670933@T590>
        <20200622090148.6e0f2ac9@oasis.local.home>
        <20200623084706.e6e99e99d7da6690e7a6c199@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Jun 2020 08:47:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 22 Jun 2020 09:01:48 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 22 Jun 2020 08:27:53 +0800
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > Can you kprobe guys improve the implementation for covering this case?
> > > For example, put probe on 3) in case the above situation is recognized.
> > 
> > To do so would require solving the halting problem.
> > 
> >   https://en.wikipedia.org/wiki/Halting_problem
> > 
> > Or perhaps reading the DWARF output of the compiler to determine if it
> > optimized the location you are looking for.
> 
> As far as I can see, gcc-9.3 doesn't generate this information :(
> Maybe the optimizer forgot to push the tail-call callsite information
> to dwarf generator when making a recursive tail-call to a loop.
> 
> > The first case is impossible to solve, the second would take a lot of
> > work, (are you going to fund it?)
> 
> What I can provide is "--skip-prologue" option for the perf-probe
> which will be similar to the "-P" option. If the compiler correctly
> generates the information, we can enable it automatically. But
> as far as I can see, it doesn't.
> 
> [OT] DWARF has its option(and GNU extension) but it seems not correctly
> implemented yet.
>  
> http://www.dwarfstd.org/ShowIssue.php?issue=100909.2

Oops, sorry, I missed the following sentences.

"Tail calls are jump-like instructions which transfer control to the start
of some subprogram, but the call site location address isn't visible in the
unwind information."

"Tail recursion is a call to the current function which is compiled as a
loop into the middle of the current function."

"The DW_TAG_call_site entries describe normal and tail calls."

This means, the gcc is correctly implemented and this __blkdev_put() case
is NOT covered by DT_TAG_call_site.
So we can not detect it from the debuginfo.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
