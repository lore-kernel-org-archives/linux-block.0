Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F8C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 01:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA7925346
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592789660;
	bh=yahWNs4iWDl8j8XDQJYi4EUPkP1e2Qp4KTUkNCO/LAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tg+ponUxo0TVOmcleKVweks9GySOuprPnyYPSAR3Qv/4DPycxXY71kT6pzuUmRQ+b
	 BYsL8LLhXYuGkrWuBxHjbr0AKQmfYA4SVGJUVXy3GjF7EaGEiGWV/3QZQnIsl2xWEm
	 djImI/xePDBmkQ4xzhtEevESPecQsDM1ABQXXajA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgFVBeT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jun 2020 21:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgFVBeT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jun 2020 21:34:19 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E661625343;
        Mon, 22 Jun 2020 01:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592789658;
        bh=yahWNs4iWDl8j8XDQJYi4EUPkP1e2Qp4KTUkNCO/LAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S38SfUEFjnwk8tffdVZPue6Ext6jGXGNadANKIvuPV2DA7ghUkFHPoyMmcnGCnSX1
         LguhZuuEeUXJZo7EvkvfOtCr+kj9V75ugrq2H3TF/2Pr4Usv1b4LjAfzSLmyDhRFF+
         EZai/Wj+p0pcWUXwU4r4vrlsRi0u2Wrrepuk1xpQ=
Date:   Mon, 22 Jun 2020 10:34:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-Id: <20200622103414.af303c4d4b0dad1c9d7262a3@kernel.org>
In-Reply-To: <20200622002753.GC670933@T590>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 22 Jun 2020 08:27:53 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> I mean it isn't from user's viewpoint, and the binary code is usually a
> black box for final kprobe user.
> 
> IMO, all your and Steven's input are just from kprobe/trace developer's viewpoint.
> Can you think about the issue from kprobe real/final user?
> 
> Trace is very useful tools to observe system internal, and people often
> relies on trace to understand system. However, missed probe often causes
> trouble for us to understand the system correctly.

Agreed. However, since kprobes related tracing tools are layered
to provide different features (e.g. kprobes abstructs sw breakpoint,
ftrace kprobe-events provides a minimum CUI, and perf-probe provides
binary analysis, etc.), this issue should be solved by user-level
binary analysis layer. (it is not good idea to analyze the optimized
code in kernel)


> > > 2) from implementation view, I understand exception should be trapped
> > > on the entry of __blkdev_put(), looks it isn't done.
> > 
> > No, it is correctly trapped the function entry address. The problem is
> > that the gcc optimized the nested function call into jump to the
> > beginning of function body (skip prologue).
> > 
> > Usually, a function is compiled as below
> > 
> > func()     (1) the entry address (func:)
> > {          (2) the function prologue (setup stackframe)  
> >   int a    (3) the beginning of function body 
> >    ...
> >   func()   (4) the nested function call
> > 
> > And in this case, the gcc optimized (4) into jump to (3) instead of
> > actual function call instruction. Thus, for the nested case (1) and
> > (2) are skipped.
> >  IOW, the code flow becomes
> >   (1)->(2)->(3)->(4)->(3)
> >  instead of 
> >   (1)->(2)->(3)->(4)->(1)->(2)->(3)
> > 
> > In this case, if we put a probe on (1) or (2), those are disappeared
> > in the nested call. Thus if you put a probe on (3) ('perf probe __blkdev_put:2')
> > you'll see the event twice.
> 
> Thanks for your explanation.
> 
> Can you kprobe guys improve the implementation for covering this case?
> For example, put probe on 3) in case the above situation is recognized.

OK, let me try to fix this in perf-probe since that is the simplest
binary analysis part in user-space.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
