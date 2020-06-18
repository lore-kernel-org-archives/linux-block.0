Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F173C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 23:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B562078D
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 23:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZsK6YRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgFRXTY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:19:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728049AbgFRXTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 19:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592522361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWRu5ynq63s6rvxwcBKG7uOd/H0E0TsjTr5wvg/oOPE=;
        b=QZsK6YRihKX9lDYJ9YuxAAT3dbG/I9EdwuszP5k8L1t2HcnYBzl450SXYlSiAWsxOoCxUt
        dytzzKYYBQ/ag/dURTe80+NV8xk5nxhNBj8GKvIiSLh6NyBbRcsyuppzNMRl5ViyIbBveT
        Ek0IWssPTsbybgr7fcZ8O3AggUsrfeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460--WN60a8zPlubEq7twmzMJg-1; Thu, 18 Jun 2020 19:19:17 -0400
X-MC-Unique: -WN60a8zPlubEq7twmzMJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2641108BD15;
        Thu, 18 Jun 2020 23:19:15 +0000 (UTC)
Received: from T590 (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 697C389283;
        Thu, 18 Jun 2020 23:19:05 +0000 (UTC)
Date:   Fri, 19 Jun 2020 07:19:01 +0800
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
Message-ID: <20200618231901.GA196099@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
 <20200618125438.GA191266@T590>
 <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 18, 2020 at 10:56:02PM +0900, Masami Hiramatsu wrote:
> Hi Ming,
> 
> On Thu, 18 Jun 2020 20:54:38 +0800
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Wed, Jun 17, 2020 at 06:30:39PM +0800, Ming Lei wrote:
> > > Hello Guys,
> > > 
> > > I found probe on __blkdev_put is missed, which can be observed
> > > via bcc/perf reliably:
> > > 
> > > 1) start trace
> > > - perf probe __blkdev_put
> > > - perf trace -a  -e probe:__blkdev_put
> 
> Could you dump the kprobe_event as below?
> 
> # cat /sys/kernel/tracing/kprobe_events
> 
> 
> > > 
> > > or
> > > 
> > > /usr/share/bcc/tools/stackcount __blkdev_put
> > > 
> > > 2) run the following command:
> > > blockdev --getbsz /dev/sda1
> 
> And dump the kprobe profile?
> 
> # cat /sys/kernel/tracing/kprobe_profile
> 
> > > 
> > > 3) 'perf trace'  or stackcount just  dumps one trace event, and it
> > > should have been two
> > > __blkdev_put() traces, since one __blkdev_put() is called for
> > > partition(/dev/sda1),
> > > and another is for disk(/dev/sda). If trace_printk() is added in __blkdev_put(),
> > > two events will be captured from ftrace.
> > > 
> > 
> > The issue can be shown by loading a kprobe module which registers on
> > __blkdev_put(), just by replacing _do_fork with __blkdev_put on
> > samples/kprobes/kprobe_example.c.
> 
> Could you tell me what kernel are you using?
> 
> I'm using 5.4 on ubuntu and can not reproduce it with kprobe_event.
> 
> root@devnote2:/sys/kernel/tracing# uname -a
> Linux devnote2 5.4.0-37-generic #41-Ubuntu SMP Wed Jun 3 18:57:02 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> root@devnote2:/sys/kernel/tracing# echo p __blkdev_put > kprobe_events 
> root@devnote2:/sys/kernel/tracing# echo 1 > events/kprobes/p___blkdev_put_0/enable 
> root@devnote2:/sys/kernel/tracing# cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 0/0   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
> root@devnote2:/sys/kernel/tracing# blockdev --getbsz /dev/nvme0n1
> 4096
> root@devnote2:/sys/kernel/tracing# cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 1/1   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>            <...>-111740 [002] .... 301734.476991: p___blkdev_put_0: (__blkdev_put+0x0/0x1e0)
> 
> Hmm, maybe some issue in the latest kernel...?

Hello Masami,

I am testing the latest upstream kernel, your trace actually reproduces
this issue.

After 'blockdev --getbsz /dev/nvme0n1' returns, __blkdev_put() should
have been called two times(one for partition, and the other for disk),
however kprobe trace just shows one time of calling this function.

If trace_printk() is added at the entry of __blkdev_put() manually,
you will see that __blkdev_put() is called two times in 'blockdev
--getbsz /dev/nvme0n1'.


Thanks,
Ming

