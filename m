Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05F7C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 05:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B294A20738
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 05:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592890108;
	bh=hXx1AoyMhAAH4V2F+L7ruURvcKfaPHtYRAUW+1pvx4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=I8hVNUxbycHTANwP9cqf5M4U7IL+hFWOPppDvFc1QxaUXWPII+XYNlhFA+0xabui4
	 7KuawI+apIFYI5nnQubso2nyKH+uoq0DYebC00UOCS+qpzX7FTguNvWntubH7mxykL
	 fkwPB9Lc59P0Yt0Xkpnt+iXu4VlcO/8NZarJCeng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgFWF22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgFWF21 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 01:28:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6592E20716;
        Tue, 23 Jun 2020 05:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592890107;
        bh=hXx1AoyMhAAH4V2F+L7ruURvcKfaPHtYRAUW+1pvx4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Me1WQehU/cJKvXiO6fvSIbp3GZeSa46KS8e+Iz/R0XIc6/NN7kUn5QjG4/yWNtq/Y
         qgnXvP8f8egr6ramEu2OiNtvbeAP5a0BS6isi4LJPytVu0xr8U7KelPcXwZdHU7lTS
         K2oQp90JdsMj1P2xnnuEk3eqs4X4qFhnhkI36r9w=
Date:   Tue, 23 Jun 2020 14:28:22 +0900
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
Message-Id: <20200623142822.371012c66baf2cc7a631e6a3@kernel.org>
In-Reply-To: <20200623093801.db9d2ca9c3bfef61ef6a2a58@kernel.org>
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
        <20200623093801.db9d2ca9c3bfef61ef6a2a58@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Jun 2020 09:38:01 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 23 Jun 2020 08:47:06 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Mon, 22 Jun 2020 09:01:48 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Mon, 22 Jun 2020 08:27:53 +0800
> > > Ming Lei <ming.lei@redhat.com> wrote:
> > > 
> > > > Can you kprobe guys improve the implementation for covering this case?
> > > > For example, put probe on 3) in case the above situation is recognized.
> > > 
> > > To do so would require solving the halting problem.
> > > 
> > >   https://en.wikipedia.org/wiki/Halting_problem
> > > 
> > > Or perhaps reading the DWARF output of the compiler to determine if it
> > > optimized the location you are looking for.
> > 
> > As far as I can see, gcc-9.3 doesn't generate this information :(
> > Maybe the optimizer forgot to push the tail-call callsite information
> > to dwarf generator when making a recursive tail-call to a loop.
> > 
> > > The first case is impossible to solve, the second would take a lot of
> > > work, (are you going to fund it?)
> > 
> > What I can provide is "--skip-prologue" option for the perf-probe
> > which will be similar to the "-P" option. If the compiler correctly
> > generates the information, we can enable it automatically. But
> > as far as I can see, it doesn't.
> > 
> > [OT] DWARF has its option(and GNU extension) but it seems not correctly
> > implemented yet.
> >  
> > http://www.dwarfstd.org/ShowIssue.php?issue=100909.2
> 
> Oops, sorry, I missed the following sentences.
> 
> "Tail calls are jump-like instructions which transfer control to the start
> of some subprogram, but the call site location address isn't visible in the
> unwind information."
> 
> "Tail recursion is a call to the current function which is compiled as a
> loop into the middle of the current function."
> 
> "The DW_TAG_call_site entries describe normal and tail calls."
> 
> This means, the gcc is correctly implemented and this __blkdev_put() case
> is NOT covered by DT_TAG_call_site.
> So we can not detect it from the debuginfo.

Hmm, BTW, if optimization is further advanced, it is possible that
the loop start position is not always at the beginning of the function.
It is easy to provide --skip-prologue to perf probe but it doesn't
ensure that works always as you expected.

For example,

func()
{
1:
	{ /* block which doesn't executed in tail-recursion call */
	...
	}
2:
	{ /* block which always executed in tail-recursion call */
	...
	}
	func()
}

In this case, it is natural that the optimizer put a jump to 2 instead
of 1. Moreover, if the number of recursion is fixed, the optimizer
can unroll the loop. In that case there are no jumps. 

So, as Steve pointed, strictly speaking, the developer needs to understand
what the source code was compiled into, before tracing/debuging it.

For the perf-probe case, I'm now thinking it is better user to
choose the line in the function explicitly. I wish I had another flag
that there was a tail-recursion, then I can warn users...

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
