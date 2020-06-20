Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17874C433E1
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 01:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6C722D00
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 01:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592617080;
	bh=27uEGde3cS/BL9hltSLdg6dNULTrZtpxAPFo35C7kw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=twANj1BnkG6cAJV+xN+VJCUzqSqVUsKD7KTtjFBHlFWutd+3uuEeVlMYZiT3q5lPw
	 Y/C951AVv9M6L3upiJK9wSsEtmm4EHkUEkns0jfUSq/mTq/fcsLi0d3M24Fm52TWX+
	 oo/GdAXrz+pUqTra/FWjcaqzpB/8dyUhmg7HI5Zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgFTBh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731418AbgFTBhx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 21:37:53 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4166622CAE;
        Sat, 20 Jun 2020 01:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592617072;
        bh=27uEGde3cS/BL9hltSLdg6dNULTrZtpxAPFo35C7kw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tk5t6SG9TGdp7HD/ryYTe0tswlBBPG1dMWhIKXwp43KKiuT4mmebafpvfvXQDSo2o
         kgMglDrny0RHE0eYSApu/SeSx7Otom4Wd/Q4aFNONBv9RZcP1Y2DdgMbC4Vpw9Ipwh
         TIEWsPrLwZwVj6QJ+S031DxQWUPVo4n9nDbepJiI=
Date:   Sat, 20 Jun 2020 10:37:47 +0900
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
Message-Id: <20200620103747.fb83f804083ef9956740acee@kernel.org>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Sat, 20 Jun 2020 07:28:20 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> > 
> > Ah, after all it is as expected. With your kconfig, the kernel is
> > very agressively optimized.
> > 
> > $ objdump -dS vmlinux | less
> > ...
> > ffffffff81256dc3 <__blkdev_put>:
> > {
> > ffffffff81256dc3:       e8 98 85 df ff          callq  ffffffff8104f360 <__fentry__>
> > ffffffff81256dc8:       41 57                   push   %r15
> > ffffffff81256dca:       41 56                   push   %r14
> > ffffffff81256dcc:       41 55                   push   %r13
> > ...
> > ffffffff81256f05:       75 02                   jne    ffffffff81256f09 <__blkdev_put+0x146>
> >         struct block_device *victim = NULL;
> > ffffffff81256f07:       31 db                   xor    %ebx,%ebx
> >                 bdev->bd_contains = NULL;
> > ffffffff81256f09:       48 c7 45 60 00 00 00    movq   $0x0,0x60(%rbp)
> > ffffffff81256f10:       00 
> >                 put_disk_and_module(disk);
> > ffffffff81256f11:       4c 89 f7                mov    %r14,%rdi
> > ffffffff81256f14:       e8 c6 3d 11 00          callq  ffffffff8136acdf <put_disk_and_module>
> >         mutex_unlock(&bdev->bd_mutex);
> > ffffffff81256f19:       4c 89 ff                mov    %r15,%rdi
> >                 __blkdev_put(victim, mode, 1);
> > ffffffff81256f1c:       41 bc 01 00 00 00       mov    $0x1,%r12d
> >         mutex_unlock(&bdev->bd_mutex);
> > ffffffff81256f22:       e8 8d d7 48 00          callq  ffffffff816e46b4 <mutex_unlock>
> >         bdput(bdev);
> > ffffffff81256f27:       48 89 ef                mov    %rbp,%rdi
> > ffffffff81256f2a:       e8 f0 e9 ff ff          callq  ffffffff8125591f <bdput>
> >         if (victim)
> > ffffffff81256f2f:       48 85 db                test   %rbx,%rbx
> > ffffffff81256f32:       74 08                   je     ffffffff81256f3c <__blkdev_put+0x179>
> > ffffffff81256f34:       48 89 dd                mov    %rbx,%rbp
> > ffffffff81256f37:       e9 b4 fe ff ff          jmpq   ffffffff81256df0 <__blkdev_put+0x2d> <<-----THIS!!
> > }
> > ffffffff81256f3c:       48 8b 44 24 28          mov    0x28(%rsp),%rax
> > ffffffff81256f41:       65 48 33 04 25 28 00    xor    %gs:0x28,%rax
> > ffffffff81256f48:       00 00 
> > ffffffff81256f4a:       74 05                   je     ffffffff81256f51 <__blkdev_put+0x18e>
> > ffffffff81256f4c:       e8 5a 4e 48 00          callq  ffffffff816dbdab <__stack_chk_fail>
> > ffffffff81256f51:       48 83 c4 30             add    $0x30,%rsp
> > ffffffff81256f55:       5b                      pop    %rbx
> > ffffffff81256f56:       5d                      pop    %rbp
> > ffffffff81256f57:       41 5c                   pop    %r12
> > ffffffff81256f59:       41 5d                   pop    %r13
> > ffffffff81256f5b:       41 5e                   pop    %r14
> > ffffffff81256f5d:       41 5f                   pop    %r15
> > ffffffff81256f5f:       c3                      retq   
> > 
> > 
> > As you can see, the nested __blkdev_put() is coverted to a loop.
> > If you put kprobe on __blkdev_put+0x2d, you'll see the event twice.
> 
> Thanks for your investigation.
> 
> Some trace tools can just trace on function entry, such as bcc, and some
> user script always trace on function entry.
> 
> I guess the issue should belong to kprobe implementation:
> 
> 1) __blkdev_put() is capable of being kprobed, so from user view, the
> probe on entry of __blkdev_put() should be triggered

Yes, it is correctly triggered.

> 
> 2) from implementation view, I understand exception should be trapped
> on the entry of __blkdev_put(), looks it isn't done.

No, it is correctly trapped the function entry address. The problem is
that the gcc optimized the nested function call into jump to the
beginning of function body (skip prologue).

Usually, a function is compiled as below

func()     (1) the entry address (func:)
{          (2) the function prologue (setup stackframe)  
  int a    (3) the beginning of function body 
   ...
  func()   (4) the nested function call

And in this case, the gcc optimized (4) into jump to (3) instead of
actual function call instruction. Thus, for the nested case (1) and
(2) are skipped.
 IOW, the code flow becomes
  (1)->(2)->(3)->(4)->(3)
 instead of 
  (1)->(2)->(3)->(4)->(1)->(2)->(3)

In this case, if we put a probe on (1) or (2), those are disappeared
in the nested call. Thus if you put a probe on (3) ('perf probe __blkdev_put:2')
you'll see the event twice.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
