Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AEDC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 05:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A993D20FC3
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 05:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592543565;
	bh=QVNKMxbWIq7XLlJL0MehvoZpWnGUrjeyAMPYeky8naw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q7+yOsK2g7wYQ8LOXRiLle6uZJ0PIt4iU9gEgey98u/0wKNi5fGsx0ngysOJMJPxV
	 RCNwyUxlU62nBQf1PiZdWM2jhNunbwwPXhJJ91ltRMMInwXXRSpLJiLvvE3CfhXx2B
	 7/Snremfytk7G0IZrktb1gLWIH4C8HvfonGz5OrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgFSFMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFSFMo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 01:12:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B6220DD4;
        Fri, 19 Jun 2020 05:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592543563;
        bh=QVNKMxbWIq7XLlJL0MehvoZpWnGUrjeyAMPYeky8naw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VuVvV1PwGfdS/HmHbWPB7AaJArIGuSwK7Yc/SY8XbGrN4ySR+wz5E2X7S6oRJ0DKG
         I6bIFGmWkcTFP7fILQMnVErGDXxxzv/apW+74iCdIKfEBvXqcpuJD2owishBl8F8zx
         fFWH4SEDTqUMTNi9uGSFXIQ+mMh7EmcxuL7evQDo=
Date:   Fri, 19 Jun 2020 14:12:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-Id: <20200619141239.56f6dda0976453b790190ff7@kernel.org>
In-Reply-To: <20200618231901.GA196099@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
        <20200618125438.GA191266@T590>
        <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
        <20200618231901.GA196099@T590>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Fri, 19 Jun 2020 07:19:01 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> > I'm using 5.4 on ubuntu and can not reproduce it with kprobe_event.
> > 
> > root@devnote2:/sys/kernel/tracing# uname -a
> > Linux devnote2 5.4.0-37-generic #41-Ubuntu SMP Wed Jun 3 18:57:02 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > root@devnote2:/sys/kernel/tracing# echo p __blkdev_put > kprobe_events 
> > root@devnote2:/sys/kernel/tracing# echo 1 > events/kprobes/p___blkdev_put_0/enable 
> > root@devnote2:/sys/kernel/tracing# cat trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 0/0   #P:8
> > #
> > #                              _-----=> irqs-off
> > #                             / _----=> need-resched
> > #                            | / _---=> hardirq/softirq
> > #                            || / _--=> preempt-depth
> > #                            ||| /     delay
> > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > #              | |       |   ||||       |         |
> > root@devnote2:/sys/kernel/tracing# blockdev --getbsz /dev/nvme0n1
> > 4096
> > root@devnote2:/sys/kernel/tracing# cat trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 1/1   #P:8
> > #
> > #                              _-----=> irqs-off
> > #                             / _----=> need-resched
> > #                            | / _---=> hardirq/softirq
> > #                            || / _--=> preempt-depth
> > #                            ||| /     delay
> > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > #              | |       |   ||||       |         |
> >            <...>-111740 [002] .... 301734.476991: p___blkdev_put_0: (__blkdev_put+0x0/0x1e0)
> > 
> > Hmm, maybe some issue in the latest kernel...?
> 
> Hello Masami,
> 
> I am testing the latest upstream kernel, your trace actually reproduces
> this issue.

OK.

> 
> After 'blockdev --getbsz /dev/nvme0n1' returns, __blkdev_put() should
> have been called two times(one for partition, and the other for disk),
> however kprobe trace just shows one time of calling this function.
> 
> If trace_printk() is added at the entry of __blkdev_put() manually,
> you will see that __blkdev_put() is called two times in 'blockdev
> --getbsz /dev/nvme0n1'.

OK, let me check again on the latest kernel.
Here I tested with qemu.

root@devnote2:/sys/kernel/debug/tracing# uname -a
Linux devnote2 5.8.0-rc1+ #26 SMP PREEMPT Fri Jun 19 12:12:53 JST 2020 x86_64 x86_64 x86_64 GNU/Linux

And we have a (virtual) sda with 1 partition.

root@devnote2:/sys/kernel/debug/tracing# cat /proc/partitions 
major minor  #blocks  name

   8        0      10240 sda
   8        1       9216 sda1

OK, then let's make events (for sure)

root@devnote2:/sys/kernel/debug/tracing# echo p __blkdev_put >> kprobe_events 
root@devnote2:/sys/kernel/debug/tracing# echo r __blkdev_put >> kprobe_events 
root@devnote2:/sys/kernel/debug/tracing# echo p blkdev_put >> kprobe_events 

There are 3 events in the kernel, blkdev_put() and __blkdev_put() and
the return of __blkdev_put().
Then enable it and access to */dev/sda* (a disk)

root@devnote2:/sys/kernel/debug/tracing# echo 1 > events/kprobes/enable 
root@devnote2:/sys/kernel/debug/tracing# blockdev --getbsz /dev/sda
4096
root@devnote2:/sys/kernel/debug/tracing# echo 0 > events/kprobes/enable 
root@devnote2:/sys/kernel/debug/tracing# cat trace 
# tracer: nop
#
# entries-in-buffer/entries-written: 3/3   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
        blockdev-185   [002] ...1    72.604266: p_blkdev_put_0: (blkdev_put+0x0/0x130)
        blockdev-185   [002] ...1    72.604276: p___blkdev_put_0: (__blkdev_put+0x0/0x220)
        blockdev-185   [002] d..2    72.604288: r___blkdev_put_0: (blkdev_put+0x50/0x130 <- __blkdev_put)

So the __blkdev_put() is called once from blkdev_put().
Next, we do same trace with accessing */dev/sda1* (a partition).

root@devnote2:/sys/kernel/debug/tracing# echo > trace 
root@devnote2:/sys/kernel/debug/tracing# echo 1 > events/kprobes/enable 
root@devnote2:/sys/kernel/debug/tracing# blockdev --getbsz /dev/sda1 
4096
root@devnote2:/sys/kernel/debug/tracing# echo 0 > events/kprobes/enable 
root@devnote2:/sys/kernel/debug/tracing# cat trace 
# tracer: nop
#
# entries-in-buffer/entries-written: 5/5   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
        blockdev-191   [005] ...1   194.401517: p_blkdev_put_0: (blkdev_put+0x0/0x130)
        blockdev-191   [005] ...1   194.401527: p___blkdev_put_0: (__blkdev_put+0x0/0x220)
        blockdev-191   [005] ...1   194.401529: p___blkdev_put_0: (__blkdev_put+0x0/0x220)
        blockdev-191   [005] d..2   194.401535: r___blkdev_put_0: (__blkdev_put+0x1ea/0x220 <- __blkdev_put)
        blockdev-191   [005] d..2   194.401536: r___blkdev_put_0: (blkdev_put+0x50/0x130 <- __blkdev_put)

In this case, we can see the __blkdev_put() is called twice, from
blkdev_put() and __blkdev_put() itself (nested call).

So, it seems that the kprobe event correctly works.

Could you do same thing on your environment, and share the result?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
