Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54580C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 13:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E83D2082F
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592488570;
	bh=38uTI+xDeYQSW97XKhSMUz9+QFd9HVuzaBbis5yErKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MUPEc7MnyryqnnniSBR+mBE9gKZZgRGfWNdEPdTCHdM8/yjkbn5RWlNvQ/RD6kQ0g
	 nThC0R7N2myYZzNJi1uGD4aOnWbsgrKsLPs0ryvIsAgQmTedyAMAuRx8r+LJ6qt6ol
	 3Ax/OZYhNov5KBmwvzgMzNhfz4/atBUHtDQ2+PvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgFRN4J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgFRN4I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 09:56:08 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A04F2067D;
        Thu, 18 Jun 2020 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592488567;
        bh=38uTI+xDeYQSW97XKhSMUz9+QFd9HVuzaBbis5yErKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YPZjSjtERAxYgBaBSWo7w0avxyOP7zmc//M5M0t9E7FUKRYHLCcrlYWqIRCnQuXEM
         vo+5484GeMNW6lr0aQ21UAgHD8wNUlzf+KktxYkQcckDn53lfQs9zSXQcivpVlOQmZ
         X4ULRP8t3sodH6Dw9LU0IT641NJ+FR5Ap2qIVr0w=
Date:   Thu, 18 Jun 2020 22:56:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-Id: <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
In-Reply-To: <20200618125438.GA191266@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
        <20200618125438.GA191266@T590>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Thu, 18 Jun 2020 20:54:38 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> On Wed, Jun 17, 2020 at 06:30:39PM +0800, Ming Lei wrote:
> > Hello Guys,
> > 
> > I found probe on __blkdev_put is missed, which can be observed
> > via bcc/perf reliably:
> > 
> > 1) start trace
> > - perf probe __blkdev_put
> > - perf trace -a  -e probe:__blkdev_put

Could you dump the kprobe_event as below?

# cat /sys/kernel/tracing/kprobe_events


> > 
> > or
> > 
> > /usr/share/bcc/tools/stackcount __blkdev_put
> > 
> > 2) run the following command:
> > blockdev --getbsz /dev/sda1

And dump the kprobe profile?

# cat /sys/kernel/tracing/kprobe_profile

> > 
> > 3) 'perf trace'  or stackcount just  dumps one trace event, and it
> > should have been two
> > __blkdev_put() traces, since one __blkdev_put() is called for
> > partition(/dev/sda1),
> > and another is for disk(/dev/sda). If trace_printk() is added in __blkdev_put(),
> > two events will be captured from ftrace.
> > 
> 
> The issue can be shown by loading a kprobe module which registers on
> __blkdev_put(), just by replacing _do_fork with __blkdev_put on
> samples/kprobes/kprobe_example.c.

Could you tell me what kernel are you using?

I'm using 5.4 on ubuntu and can not reproduce it with kprobe_event.

root@devnote2:/sys/kernel/tracing# uname -a
Linux devnote2 5.4.0-37-generic #41-Ubuntu SMP Wed Jun 3 18:57:02 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
root@devnote2:/sys/kernel/tracing# echo p __blkdev_put > kprobe_events 
root@devnote2:/sys/kernel/tracing# echo 1 > events/kprobes/p___blkdev_put_0/enable 
root@devnote2:/sys/kernel/tracing# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 0/0   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
root@devnote2:/sys/kernel/tracing# blockdev --getbsz /dev/nvme0n1
4096
root@devnote2:/sys/kernel/tracing# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
           <...>-111740 [002] .... 301734.476991: p___blkdev_put_0: (__blkdev_put+0x0/0x1e0)

Hmm, maybe some issue in the latest kernel...?


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
