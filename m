Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD218C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB70720786
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfcYrZzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgFSH3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:29:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730584AbgFSH3Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 03:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592551754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4S66t3bFBiXC3/NacHByHSFWv56WO9n+Qt501pepyU=;
        b=NfcYrZzAXA5ZyHXszel8jRnZhNoZSi5TwNVJzPYyKlyybYTvIUXEguNm6NGKrLcTNYdhLV
        tsVHt/pCSuvwHy2H0CiofsDhgp3pAuhRzmp5NhSpsDarCEHW2b2Mx4sPAzrbgZVNl95Ey8
        Y+pNN1Q7QHW17YivC2owwtEdoYRdhMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-qGr9ZZVMOFeFaZphOI4qbQ-1; Fri, 19 Jun 2020 03:29:12 -0400
X-MC-Unique: qGr9ZZVMOFeFaZphOI4qbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACD5F18585A3;
        Fri, 19 Jun 2020 07:29:10 +0000 (UTC)
Received: from T590 (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E15381000239;
        Fri, 19 Jun 2020 07:29:03 +0000 (UTC)
Date:   Fri, 19 Jun 2020 15:28:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-ID: <20200619072859.GA205278@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
 <20200618125438.GA191266@T590>
 <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
 <20200618231901.GA196099@T590>
 <20200619141239.56f6dda0976453b790190ff7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619141239.56f6dda0976453b790190ff7@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Masami,

On Fri, Jun 19, 2020 at 02:12:39PM +0900, Masami Hiramatsu wrote:
> Hi Ming,
> 
> On Fri, 19 Jun 2020 07:19:01 +0800
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > > I'm using 5.4 on ubuntu and can not reproduce it with kprobe_event.
> > > 
> > > root@devnote2:/sys/kernel/tracing# uname -a
> > > Linux devnote2 5.4.0-37-generic #41-Ubuntu SMP Wed Jun 3 18:57:02 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > root@devnote2:/sys/kernel/tracing# echo p __blkdev_put > kprobe_events 
> > > root@devnote2:/sys/kernel/tracing# echo 1 > events/kprobes/p___blkdev_put_0/enable 
> > > root@devnote2:/sys/kernel/tracing# cat trace
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 0/0   #P:8
> > > #
> > > #                              _-----=> irqs-off
> > > #                             / _----=> need-resched
> > > #                            | / _---=> hardirq/softirq
> > > #                            || / _--=> preempt-depth
> > > #                            ||| /     delay
> > > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > > #              | |       |   ||||       |         |
> > > root@devnote2:/sys/kernel/tracing# blockdev --getbsz /dev/nvme0n1
> > > 4096
> > > root@devnote2:/sys/kernel/tracing# cat trace
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 1/1   #P:8
> > > #
> > > #                              _-----=> irqs-off
> > > #                             / _----=> need-resched
> > > #                            | / _---=> hardirq/softirq
> > > #                            || / _--=> preempt-depth
> > > #                            ||| /     delay
> > > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > > #              | |       |   ||||       |         |
> > >            <...>-111740 [002] .... 301734.476991: p___blkdev_put_0: (__blkdev_put+0x0/0x1e0)
> > > 
> > > Hmm, maybe some issue in the latest kernel...?
> > 
> > Hello Masami,
> > 
> > I am testing the latest upstream kernel, your trace actually reproduces
> > this issue.
> 
> OK.
> 
> > 
> > After 'blockdev --getbsz /dev/nvme0n1' returns, __blkdev_put() should
> > have been called two times(one for partition, and the other for disk),
> > however kprobe trace just shows one time of calling this function.
> > 
> > If trace_printk() is added at the entry of __blkdev_put() manually,
> > you will see that __blkdev_put() is called two times in 'blockdev
> > --getbsz /dev/nvme0n1'.
> 
> OK, let me check again on the latest kernel.
> Here I tested with qemu.
> 
> root@devnote2:/sys/kernel/debug/tracing# uname -a
> Linux devnote2 5.8.0-rc1+ #26 SMP PREEMPT Fri Jun 19 12:12:53 JST 2020 x86_64 x86_64 x86_64 GNU/Linux
> 
> And we have a (virtual) sda with 1 partition.
> 
> root@devnote2:/sys/kernel/debug/tracing# cat /proc/partitions 
> major minor  #blocks  name
> 
>    8        0      10240 sda
>    8        1       9216 sda1
> 
> OK, then let's make events (for sure)
> 
> root@devnote2:/sys/kernel/debug/tracing# echo p __blkdev_put >> kprobe_events 
> root@devnote2:/sys/kernel/debug/tracing# echo r __blkdev_put >> kprobe_events 
> root@devnote2:/sys/kernel/debug/tracing# echo p blkdev_put >> kprobe_events 
> 
> There are 3 events in the kernel, blkdev_put() and __blkdev_put() and
> the return of __blkdev_put().
> Then enable it and access to */dev/sda* (a disk)
> 
> root@devnote2:/sys/kernel/debug/tracing# echo 1 > events/kprobes/enable 
> root@devnote2:/sys/kernel/debug/tracing# blockdev --getbsz /dev/sda
> 4096
> root@devnote2:/sys/kernel/debug/tracing# echo 0 > events/kprobes/enable 
> root@devnote2:/sys/kernel/debug/tracing# cat trace 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 3/3   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>         blockdev-185   [002] ...1    72.604266: p_blkdev_put_0: (blkdev_put+0x0/0x130)
>         blockdev-185   [002] ...1    72.604276: p___blkdev_put_0: (__blkdev_put+0x0/0x220)
>         blockdev-185   [002] d..2    72.604288: r___blkdev_put_0: (blkdev_put+0x50/0x130 <- __blkdev_put)
> 
> So the __blkdev_put() is called once from blkdev_put().
> Next, we do same trace with accessing */dev/sda1* (a partition).
> 
> root@devnote2:/sys/kernel/debug/tracing# echo > trace 
> root@devnote2:/sys/kernel/debug/tracing# echo 1 > events/kprobes/enable 

I can't find 'events/kprobes' in my VM with upstream kernel, also not found
the dir under fedora31(5.5.15-200) & rhel8(v4.18 based).

Could you share me how to enable the kprobes event? I guess some kernel
config options are required.

> root@devnote2:/sys/kernel/debug/tracing# blockdev --getbsz /dev/sda1 
> 4096
> root@devnote2:/sys/kernel/debug/tracing# echo 0 > events/kprobes/enable 

I used samples/kprobes/kprobe_example.c by replacing __do_fork with
__blkdev_put for confirming this issue, and only one __blkdev_put trace is
observed in dmesg log when running 'blockdev --getbsz /dev/sda1'.


Thanks,
Ming

