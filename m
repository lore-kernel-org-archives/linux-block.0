Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5C4C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EBF206FA
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580926;
	bh=maaYENQJ8ZL0EP/jDZtR5Sg7D2VvDgzl8nJ0dHfmwGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XqCpdP8An+yTBKec9FWpWbcND9Z8SByW/MswYYh+kOa8qFgYAIjpzoW/CQVyQSeHH
	 9VSWOPbe+meuhOQUJS2TwXfg5OsdsjCLR3AwfZc3yJ81HxHoIeVkZEZcwztUjpdPSq
	 ZVqXzvt8aYpdJlHSi/9jRPK+uJtCVoAJEgRDdCvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404791AbgFSPfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393535AbgFSPfO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 11:35:14 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1772D2166E;
        Fri, 19 Jun 2020 15:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580914;
        bh=maaYENQJ8ZL0EP/jDZtR5Sg7D2VvDgzl8nJ0dHfmwGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QKFkMf6CmSPcqyw5qJm923cZaKitao9xyRits+mLT1o5loUnNh9K3nPqJkQc3Eopa
         vbf0NKpPB7Oqt6MXd5rtg+oOe9i4+XnBk2Z9AzigcDiUgFhM4RAoKOeSoCqYwuED/K
         92nB46mQZbrh6THXGBQS7WhYLNzuQLqRWfR6wW/I=
Date:   Sat, 20 Jun 2020 00:35:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-Id: <20200620003509.9521053fbd384f4f5d23408f@kernel.org>
In-Reply-To: <20200619133240.GA351476@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
        <20200618125438.GA191266@T590>
        <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
        <20200618231901.GA196099@T590>
        <20200619141239.56f6dda0976453b790190ff7@kernel.org>
        <20200619072859.GA205278@T590>
        <20200619081954.3d72a252@oasis.local.home>
        <20200619133240.GA351476@T590>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Fri, 19 Jun 2020 21:32:40 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> On Fri, Jun 19, 2020 at 08:19:54AM -0400, Steven Rostedt wrote:
> > On Fri, 19 Jun 2020 15:28:59 +0800
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > > 
> > > > OK, then let's make events (for sure)
> > > > 
> > > > root@devnote2:/sys/kernel/debug/tracing# echo p __blkdev_put >> kprobe_events 
> > > > root@devnote2:/sys/kernel/debug/tracing# echo r __blkdev_put >> kprobe_events 
> > > > root@devnote2:/sys/kernel/debug/tracing# echo p blkdev_put >> kprobe_events 
> > 
> > Hi Ming,
> > 
> > Do you have the kprobe_events file?
> > 
> > > > root@devnote2:/sys/kernel/debug/tracing# echo 1 > events/kprobes/enable   
> > > 
> > > I can't find 'events/kprobes' in my VM with upstream kernel, also not found
> > > the dir under fedora31(5.5.15-200) & rhel8(v4.18 based).
> > 
> > The events/kprobes directly will be created when you create a
> > kprobe_event. It wont exist until then.
> 
> Hi Steven and Masami,
> 
> Got it, thanks for your help, now I can run the test, follows the steps
> and results, and there is still one __blkdev_put probed.

Hmm, strange...

> And it is observed in my VM reliably with 5.7+ or Fedora kernel reliably,
> kernel config is attached.

Thanks for sharing it.

> 
> [root@ktest-01 tracing]# uname -a
> Linux ktest-01 5.7.0+ #1900 SMP Fri Jun 19 16:26:47 CST 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@ktest-01 tracing]#
> [root@ktest-01 tracing]# cat kprobe_events
> [root@ktest-01 tracing]#
> [root@ktest-01 tracing]# echo p blkdev_put >> kprobe_events
> [root@ktest-01 tracing]# echo p __blkdev_put >> kprobe_events
> [root@ktest-01 tracing]# echo r __blkdev_put >> kprobe_events
> [root@ktest-01 tracing]#
> [root@ktest-01 tracing]# echo 1 > events/kprobes/enable
> [root@ktest-01 tracing]# blockdev --getbsz /dev/sda1
> 4096
> [root@ktest-01 tracing]# echo 0 > events/kprobes/enable
> [root@ktest-01 tracing]# cat trace
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
>         blockdev-970   [005] .... 17603.447236: p_blkdev_put_0: (blkdev_put+0x0/0xb4)
>         blockdev-970   [005] .... 17603.447244: p___blkdev_put_0: (__blkdev_put+0x0/0x19d)
>         blockdev-970   [005] d... 17603.447251: r___blkdev_put_0: (blkdev_close+0x22/0x25 <- __blkdev_put)

This shows __blkdev_put() is a tail-call. It is possible that the
internal (nested) __blkdev_put() call becomes a goto inside the
function by the gcc optimization.

Ah, after all it is as expected. With your kconfig, the kernel is
very agressively optimized.

$ objdump -dS vmlinux | less
...
ffffffff81256dc3 <__blkdev_put>:
{
ffffffff81256dc3:       e8 98 85 df ff          callq  ffffffff8104f360 <__fentry__>
ffffffff81256dc8:       41 57                   push   %r15
ffffffff81256dca:       41 56                   push   %r14
ffffffff81256dcc:       41 55                   push   %r13
...
ffffffff81256f05:       75 02                   jne    ffffffff81256f09 <__blkdev_put+0x146>
        struct block_device *victim = NULL;
ffffffff81256f07:       31 db                   xor    %ebx,%ebx
                bdev->bd_contains = NULL;
ffffffff81256f09:       48 c7 45 60 00 00 00    movq   $0x0,0x60(%rbp)
ffffffff81256f10:       00 
                put_disk_and_module(disk);
ffffffff81256f11:       4c 89 f7                mov    %r14,%rdi
ffffffff81256f14:       e8 c6 3d 11 00          callq  ffffffff8136acdf <put_disk_and_module>
        mutex_unlock(&bdev->bd_mutex);
ffffffff81256f19:       4c 89 ff                mov    %r15,%rdi
                __blkdev_put(victim, mode, 1);
ffffffff81256f1c:       41 bc 01 00 00 00       mov    $0x1,%r12d
        mutex_unlock(&bdev->bd_mutex);
ffffffff81256f22:       e8 8d d7 48 00          callq  ffffffff816e46b4 <mutex_unlock>
        bdput(bdev);
ffffffff81256f27:       48 89 ef                mov    %rbp,%rdi
ffffffff81256f2a:       e8 f0 e9 ff ff          callq  ffffffff8125591f <bdput>
        if (victim)
ffffffff81256f2f:       48 85 db                test   %rbx,%rbx
ffffffff81256f32:       74 08                   je     ffffffff81256f3c <__blkdev_put+0x179>
ffffffff81256f34:       48 89 dd                mov    %rbx,%rbp
ffffffff81256f37:       e9 b4 fe ff ff          jmpq   ffffffff81256df0 <__blkdev_put+0x2d> <<-----THIS!!
}
ffffffff81256f3c:       48 8b 44 24 28          mov    0x28(%rsp),%rax
ffffffff81256f41:       65 48 33 04 25 28 00    xor    %gs:0x28,%rax
ffffffff81256f48:       00 00 
ffffffff81256f4a:       74 05                   je     ffffffff81256f51 <__blkdev_put+0x18e>
ffffffff81256f4c:       e8 5a 4e 48 00          callq  ffffffff816dbdab <__stack_chk_fail>
ffffffff81256f51:       48 83 c4 30             add    $0x30,%rsp
ffffffff81256f55:       5b                      pop    %rbx
ffffffff81256f56:       5d                      pop    %rbp
ffffffff81256f57:       41 5c                   pop    %r12
ffffffff81256f59:       41 5d                   pop    %r13
ffffffff81256f5b:       41 5e                   pop    %r14
ffffffff81256f5d:       41 5f                   pop    %r15
ffffffff81256f5f:       c3                      retq   


As you can see, the nested __blkdev_put() is coverted to a loop.
If you put kprobe on __blkdev_put+0x2d, you'll see the event twice.

Thank you,
 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
