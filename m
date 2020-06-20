Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1ECC433E0
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 00:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B481A22B51
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 00:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgFTA7s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgFTA7s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 20:59:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A794D22B4D;
        Sat, 20 Jun 2020 00:59:46 +0000 (UTC)
Date:   Fri, 19 Jun 2020 20:59:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-ID: <20200619205944.4c9bb076@oasis.local.home>
In-Reply-To: <20200619232820.GE353853@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
        <20200618125438.GA191266@T590>
        <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
        <20200618231901.GA196099@T590>
        <20200619141239.56f6dda0976453b790190ff7@kernel.org>
        <20200619072859.GA205278@T590>
        <20200619081954.3d72a252@oasis.local.home>
        <20200619133240.GA351476@T590>
        <20200620003509.9521053fbd384f4f5d23408f@kernel.org>
        <20200619232820.GE353853@T590>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 20 Jun 2020 07:28:20 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> Thanks for your investigation.
> 
> Some trace tools can just trace on function entry, such as bcc, and some
> user script always trace on function entry.
> 
> I guess the issue should belong to kprobe implementation:

The issue is that kprobes is to dynamically add trace events into an
already compiled kernel. I'm guessing you would get the same result
from ftrace's function tracer. That's because the compiler has no idea
about what or where you intend to add these dynamically created trace
events (that's basically the point of kprobes). But if you add static
events (and this includes trace_printk()), the compiler knows about
them, because they exist at compile time, and will make sure they
execute the number of times the code shows it. But if you don't have
these events at compile time, the compiler is free to modify the code
in such a way it doesn't make sense if you add a probe at run time.

gdb suffers the same problem on user space debugging if you let the
compiler aggressively optimize the code. If you step through highly
optimized user space code with gdb, the position jumps all over the
place. This is basically the same effect.

> 
> 1) __blkdev_put() is capable of being kprobed, so from user view, the
> probe on entry of __blkdev_put() should be triggered
> 
> 2) from implementation view, I understand exception should be trapped
> on the entry of __blkdev_put(), looks it isn't done.

But it is done! But the compiler removed the second call and basically
just inlined it. So that entry no longer exists. When you added a
"trace_printk()" in there, the compiler is not allowed to skip that
trace call. But because there's nothing in here to tell the compiler
that it can't just remove the second call (which it did, and the kprobe
is just showing you what the compiler did!) then there's nothing
kprobes can do about it.

> 
> Correct me if the above is wrong, and is it possible to fix it in kprobe?

No.

-- Steve
