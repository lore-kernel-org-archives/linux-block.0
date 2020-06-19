Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1272EC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D974322252
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 23:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjfAujOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgFSX2l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:28:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32978 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730379AbgFSX2l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 19:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592609318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6KuP+dnQ/2eA0xYymSKw60P3LotdbYNacwkMXMs+fg=;
        b=VjfAujOXUCkqGIDBL4sElgKY4rk+MH13ENPigSO+vNSYUvalHZ8CvaER8a4dx4aXXWe1pZ
        q9l/DSb6TraubEG7RjpBqn96i7K0X54WoQyufXlon9vcdpr9KMsetYWbHDJyBC1dgQJijV
        TC8bE/am/Nxi6fljtLeG1FtSvnrZJeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-5OiyHahcMMWb-fXu0JdEBw-1; Fri, 19 Jun 2020 19:28:36 -0400
X-MC-Unique: 5OiyHahcMMWb-fXu0JdEBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5A218015CE;
        Fri, 19 Jun 2020 23:28:34 +0000 (UTC)
Received: from T590 (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CD757C1E4;
        Fri, 19 Jun 2020 23:28:24 +0000 (UTC)
Date:   Sat, 20 Jun 2020 07:28:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-ID: <20200619232820.GE353853@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
 <20200618125438.GA191266@T590>
 <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
 <20200618231901.GA196099@T590>
 <20200619141239.56f6dda0976453b790190ff7@kernel.org>
 <20200619072859.GA205278@T590>
 <20200619081954.3d72a252@oasis.local.home>
 <20200619133240.GA351476@T590>
 <20200620003509.9521053fbd384f4f5d23408f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620003509.9521053fbd384f4f5d23408f@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Masami,

On Sat, Jun 20, 2020 at 12:35:09AM +0900, Masami Hiramatsu wrote:
> Hi Ming,
> 
> On Fri, 19 Jun 2020 21:32:40 +0800
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Fri, Jun 19, 2020 at 08:19:54AM -0400, Steven Rostedt wrote:
> > > On Fri, 19 Jun 2020 15:28:59 +0800
> > > Ming Lei <ming.lei@redhat.com> wrote:
> > > 
> > > > > 
> > > > > OK, then let's make events (for sure)
> > > > > 
> > > > > root@devnote2:/sys/kernel/debug/tracing# echo p __blkdev_put >> kprobe_events 
> > > > > root@devnote2:/sys/kernel/debug/tracing# echo r __blkdev_put >> kprobe_events 
> > > > > root@devnote2:/sys/kernel/debug/tracing# echo p blkdev_put >> kprobe_events 
> > > 
> > > Hi Ming,
> > > 
> > > Do you have the kprobe_events file?
> > > 
> > > > > root@devnote2:/sys/kernel/debug/tracing# echo 1 > events/kprobes/enable   
> > > > 
> > > > I can't find 'events/kprobes' in my VM with upstream kernel, also not found
> > > > the dir under fedora31(5.5.15-200) & rhel8(v4.18 based).
> > > 
> > > The events/kprobes directly will be created when you create a
> > > kprobe_event. It wont exist until then.
> > 
> > Hi Steven and Masami,
> > 
> > Got it, thanks for your help, now I can run the test, follows the steps
> > and results, and there is still one __blkdev_put probed.
> 
> Hmm, strange...
> 
> > And it is observed in my VM reliably with 5.7+ or Fedora kernel reliably,
> > kernel config is attached.
> 
> Thanks for sharing it.
> 
> > 
> > [root@ktest-01 tracing]# uname -a
> > Linux ktest-01 5.7.0+ #1900 SMP Fri Jun 19 16:26:47 CST 2020 x86_64 x86_64 x86_64 GNU/Linux
> > [root@ktest-01 tracing]#
> > [root@ktest-01 tracing]# cat kprobe_events
> > [root@ktest-01 tracing]#
> > [root@ktest-01 tracing]# echo p blkdev_put >> kprobe_events
> > [root@ktest-01 tracing]# echo p __blkdev_put >> kprobe_events
> > [root@ktest-01 tracing]# echo r __blkdev_put >> kprobe_events
> > [root@ktest-01 tracing]#
> > [root@ktest-01 tracing]# echo 1 > events/kprobes/enable
> > [root@ktest-01 tracing]# blockdev --getbsz /dev/sda1
> > 4096
> > [root@ktest-01 tracing]# echo 0 > events/kprobes/enable
> > [root@ktest-01 tracing]# cat trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 3/3   #P:8
> > #
> > #                              _-----=> irqs-off
> > #                             / _----=> need-resched
> > #                            | / _---=> hardirq/softirq
> > #                            || / _--=> preempt-depth
> > #                            ||| /     delay
> > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > #              | |       |   ||||       |         |
> >         blockdev-970   [005] .... 17603.447236: p_blkdev_put_0: (blkdev_put+0x0/0xb4)
> >         blockdev-970   [005] .... 17603.447244: p___blkdev_put_0: (__blkdev_put+0x0/0x19d)
> >         blockdev-970   [005] d... 17603.447251: r___blkdev_put_0: (blkdev_close+0x22/0x25 <- __blkdev_put)
> 
> This shows __blkdev_put() is a tail-call. It is possible that the
> internal (nested) __blkdev_put() call becomes a goto inside the
> function by the gcc optimization.
> 
> Ah, after all it is as expected. With your kconfig, the kernel is
> very agressively optimized.
> 
> $ objdump -dS vmlinux | less
> ...
> ffffffff81256dc3 <__blkdev_put>:
> {
> ffffffff81256dc3:       e8 98 85 df ff          callq  ffffffff8104f360 <__fentry__>
> ffffffff81256dc8:       41 57                   push   %r15
> ffffffff81256dca:       41 56                   push   %r14
> ffffffff81256dcc:       41 55                   push   %r13
> ...
> ffffffff81256f05:       75 02                   jne    ffffffff81256f09 <__blkdev_put+0x146>
>         struct block_device *victim = NULL;
> ffffffff81256f07:       31 db                   xor    %ebx,%ebx
>                 bdev->bd_contains = NULL;
> ffffffff81256f09:       48 c7 45 60 00 00 00    movq   $0x0,0x60(%rbp)
> ffffffff81256f10:       00 
>                 put_disk_and_module(disk);
> ffffffff81256f11:       4c 89 f7                mov    %r14,%rdi
> ffffffff81256f14:       e8 c6 3d 11 00          callq  ffffffff8136acdf <put_disk_and_module>
>         mutex_unlock(&bdev->bd_mutex);
> ffffffff81256f19:       4c 89 ff                mov    %r15,%rdi
>                 __blkdev_put(victim, mode, 1);
> ffffffff81256f1c:       41 bc 01 00 00 00       mov    $0x1,%r12d
>         mutex_unlock(&bdev->bd_mutex);
> ffffffff81256f22:       e8 8d d7 48 00          callq  ffffffff816e46b4 <mutex_unlock>
>         bdput(bdev);
> ffffffff81256f27:       48 89 ef                mov    %rbp,%rdi
> ffffffff81256f2a:       e8 f0 e9 ff ff          callq  ffffffff8125591f <bdput>
>         if (victim)
> ffffffff81256f2f:       48 85 db                test   %rbx,%rbx
> ffffffff81256f32:       74 08                   je     ffffffff81256f3c <__blkdev_put+0x179>
> ffffffff81256f34:       48 89 dd                mov    %rbx,%rbp
> ffffffff81256f37:       e9 b4 fe ff ff          jmpq   ffffffff81256df0 <__blkdev_put+0x2d> <<-----THIS!!
> }
> ffffffff81256f3c:       48 8b 44 24 28          mov    0x28(%rsp),%rax
> ffffffff81256f41:       65 48 33 04 25 28 00    xor    %gs:0x28,%rax
> ffffffff81256f48:       00 00 
> ffffffff81256f4a:       74 05                   je     ffffffff81256f51 <__blkdev_put+0x18e>
> ffffffff81256f4c:       e8 5a 4e 48 00          callq  ffffffff816dbdab <__stack_chk_fail>
> ffffffff81256f51:       48 83 c4 30             add    $0x30,%rsp
> ffffffff81256f55:       5b                      pop    %rbx
> ffffffff81256f56:       5d                      pop    %rbp
> ffffffff81256f57:       41 5c                   pop    %r12
> ffffffff81256f59:       41 5d                   pop    %r13
> ffffffff81256f5b:       41 5e                   pop    %r14
> ffffffff81256f5d:       41 5f                   pop    %r15
> ffffffff81256f5f:       c3                      retq   
> 
> 
> As you can see, the nested __blkdev_put() is coverted to a loop.
> If you put kprobe on __blkdev_put+0x2d, you'll see the event twice.

Thanks for your investigation.

Some trace tools can just trace on function entry, such as bcc, and some
user script always trace on function entry.

I guess the issue should belong to kprobe implementation:

1) __blkdev_put() is capable of being kprobed, so from user view, the
probe on entry of __blkdev_put() should be triggered

2) from implementation view, I understand exception should be trapped
on the entry of __blkdev_put(), looks it isn't done.

Correct me if the above is wrong, and is it possible to fix it in kprobe?


Thanks,
Ming

