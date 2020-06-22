Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D82C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F73B2073E
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 13:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFVNBv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgFVNBv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 09:01:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B8B20732;
        Mon, 22 Jun 2020 13:01:50 +0000 (UTC)
Date:   Mon, 22 Jun 2020 09:01:48 -0400
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
Message-ID: <20200622090148.6e0f2ac9@oasis.local.home>
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
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 22 Jun 2020 08:27:53 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> Can you kprobe guys improve the implementation for covering this case?
> For example, put probe on 3) in case the above situation is recognized.

To do so would require solving the halting problem.

  https://en.wikipedia.org/wiki/Halting_problem

Or perhaps reading the DWARF output of the compiler to determine if it
optimized the location you are looking for.

The first case is impossible to solve, the second would take a lot of
work, (are you going to fund it?)

Your comment about tracing internals is valid, but if you can't
understand the optimization of the compiler on the kernel, I suggest
you stick with the static trace events. kprobes can be added virtual
anywhere in the kernel. It's very function requires a kprobe *user* to
understand the internals of the kernel as well as its executable binary
code, and not expect the kprobe to figure it out for you.

We are all for adding infrastructure to make kprobes easier. But
figuring out that the kernel optimized a function call so that we can
add some wrapper to *simulate* the optimized out function call is
something I believe is out of scope for a kprobe. In fact, I would call
that a feature! I would like to know that a function was optimized out.
When I add a kprobe, I'm more interested in what the compiler actually
did to the kernel than what the source code shows us. That is very
useful information.

-- Steve
