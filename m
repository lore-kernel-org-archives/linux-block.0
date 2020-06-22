Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C6C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 00:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6A72531B
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 00:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5Jquwx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgFVA2L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jun 2020 20:28:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34762 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730974AbgFVA2K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jun 2020 20:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592785688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pL3pqVHLXm3NBNiDm2mhZms72TO4yAdGCyBJAb8m28=;
        b=Z5Jquwx7VlTyxSG1+xtKTAibJfyXbLkN9ym8BjJY01A/4PWUbiShwf5RqKLq22dLRNvKvV
        inLyycMvDLTVTd7fPsfeyWKXoOR+bsYXZXtHeI7BXDSKkjqlR8fSLbaIiZk1Sc6dKYhSAM
        Ahl+vk9U9xGvPvGsVx7A1yViFw4h4+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-kLYIcos7OuGsBtyuXZlGSA-1; Sun, 21 Jun 2020 20:28:06 -0400
X-MC-Unique: kLYIcos7OuGsBtyuXZlGSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1073C835B40;
        Mon, 22 Jun 2020 00:28:05 +0000 (UTC)
Received: from T590 (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E587166D;
        Mon, 22 Jun 2020 00:27:57 +0000 (UTC)
Date:   Mon, 22 Jun 2020 08:27:53 +0800
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
Message-ID: <20200622002753.GC670933@T590>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620103747.fb83f804083ef9956740acee@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Masami,

On Sat, Jun 20, 2020 at 10:37:47AM +0900, Masami Hiramatsu wrote:
> Hi Ming,
> 
> On Sat, 20 Jun 2020 07:28:20 +0800
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > > 
> > > Ah, after all it is as expected. With your kconfig, the kernel is
> > > very agressively optimized.
> > > 
> > > $ objdump -dS vmlinux | less
> > > ...
> > > ffffffff81256dc3 <__blkdev_put>:
> > > {
> > > ffffffff81256dc3:       e8 98 85 df ff          callq  ffffffff8104f360 <__fentry__>
> > > ffffffff81256dc8:       41 57                   push   %r15
> > > ffffffff81256dca:       41 56                   push   %r14
> > > ffffffff81256dcc:       41 55                   push   %r13
> > > ...
> > > ffffffff81256f05:       75 02                   jne    ffffffff81256f09 <__blkdev_put+0x146>
> > >         struct block_device *victim = NULL;
> > > ffffffff81256f07:       31 db                   xor    %ebx,%ebx
> > >                 bdev->bd_contains = NULL;
> > > ffffffff81256f09:       48 c7 45 60 00 00 00    movq   $0x0,0x60(%rbp)
> > > ffffffff81256f10:       00 
> > >                 put_disk_and_module(disk);
> > > ffffffff81256f11:       4c 89 f7                mov    %r14,%rdi
> > > ffffffff81256f14:       e8 c6 3d 11 00          callq  ffffffff8136acdf <put_disk_and_module>
> > >         mutex_unlock(&bdev->bd_mutex);
> > > ffffffff81256f19:       4c 89 ff                mov    %r15,%rdi
> > >                 __blkdev_put(victim, mode, 1);
> > > ffffffff81256f1c:       41 bc 01 00 00 00       mov    $0x1,%r12d
> > >         mutex_unlock(&bdev->bd_mutex);
> > > ffffffff81256f22:       e8 8d d7 48 00          callq  ffffffff816e46b4 <mutex_unlock>
> > >         bdput(bdev);
> > > ffffffff81256f27:       48 89 ef                mov    %rbp,%rdi
> > > ffffffff81256f2a:       e8 f0 e9 ff ff          callq  ffffffff8125591f <bdput>
> > >         if (victim)
> > > ffffffff81256f2f:       48 85 db                test   %rbx,%rbx
> > > ffffffff81256f32:       74 08                   je     ffffffff81256f3c <__blkdev_put+0x179>
> > > ffffffff81256f34:       48 89 dd                mov    %rbx,%rbp
> > > ffffffff81256f37:       e9 b4 fe ff ff          jmpq   ffffffff81256df0 <__blkdev_put+0x2d> <<-----THIS!!
> > > }
> > > ffffffff81256f3c:       48 8b 44 24 28          mov    0x28(%rsp),%rax
> > > ffffffff81256f41:       65 48 33 04 25 28 00    xor    %gs:0x28,%rax
> > > ffffffff81256f48:       00 00 
> > > ffffffff81256f4a:       74 05                   je     ffffffff81256f51 <__blkdev_put+0x18e>
> > > ffffffff81256f4c:       e8 5a 4e 48 00          callq  ffffffff816dbdab <__stack_chk_fail>
> > > ffffffff81256f51:       48 83 c4 30             add    $0x30,%rsp
> > > ffffffff81256f55:       5b                      pop    %rbx
> > > ffffffff81256f56:       5d                      pop    %rbp
> > > ffffffff81256f57:       41 5c                   pop    %r12
> > > ffffffff81256f59:       41 5d                   pop    %r13
> > > ffffffff81256f5b:       41 5e                   pop    %r14
> > > ffffffff81256f5d:       41 5f                   pop    %r15
> > > ffffffff81256f5f:       c3                      retq   
> > > 
> > > 
> > > As you can see, the nested __blkdev_put() is coverted to a loop.
> > > If you put kprobe on __blkdev_put+0x2d, you'll see the event twice.
> > 
> > Thanks for your investigation.
> > 
> > Some trace tools can just trace on function entry, such as bcc, and some
> > user script always trace on function entry.
> > 
> > I guess the issue should belong to kprobe implementation:
> > 
> > 1) __blkdev_put() is capable of being kprobed, so from user view, the
> > probe on entry of __blkdev_put() should be triggered
> 
> Yes, it is correctly triggered.

I mean it isn't from user's viewpoint, and the binary code is usually a
black box for final kprobe user.

IMO, all your and Steven's input are just from kprobe/trace developer's viewpoint.
Can you think about the issue from kprobe real/final user?

Trace is very useful tools to observe system internal, and people often
relies on trace to understand system. However, missed probe often causes
trouble for us to understand the system correctly.

> 
> > 
> > 2) from implementation view, I understand exception should be trapped
> > on the entry of __blkdev_put(), looks it isn't done.
> 
> No, it is correctly trapped the function entry address. The problem is
> that the gcc optimized the nested function call into jump to the
> beginning of function body (skip prologue).
> 
> Usually, a function is compiled as below
> 
> func()     (1) the entry address (func:)
> {          (2) the function prologue (setup stackframe)  
>   int a    (3) the beginning of function body 
>    ...
>   func()   (4) the nested function call
> 
> And in this case, the gcc optimized (4) into jump to (3) instead of
> actual function call instruction. Thus, for the nested case (1) and
> (2) are skipped.
>  IOW, the code flow becomes
>   (1)->(2)->(3)->(4)->(3)
>  instead of 
>   (1)->(2)->(3)->(4)->(1)->(2)->(3)
> 
> In this case, if we put a probe on (1) or (2), those are disappeared
> in the nested call. Thus if you put a probe on (3) ('perf probe __blkdev_put:2')
> you'll see the event twice.

Thanks for your explanation.

Can you kprobe guys improve the implementation for covering this case?
For example, put probe on 3) in case the above situation is recognized.



Thanks,
Ming

