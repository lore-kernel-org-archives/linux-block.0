Return-Path: <SRS0=EH6z=5C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60553C10F29
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 08:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080E2205ED
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 08:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJq1q+4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgCQIUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:20:13 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:46894 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQIUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 04:20:13 -0400
Received: by mail-pl1-f170.google.com with SMTP id r3so1250156pls.13
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2020 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kAy3Q9Y39G+FuvpBioeYBonxIBzlHnVN0CWGNZ5LzA4=;
        b=uJq1q+4fHN57aH1IEzvuzn5Z/KMTIRrcrSwkAJ0R1XPKutBvYvnKFvl9l2Y048KqfQ
         u60/qOt3mAIXpO6tp/6xGCMBoF8CoS4XIkzdBQVpDdj4vHo0IjZsrWDU1B7eEMOfnjjV
         C58//hVTyl4NrCsIAV5ndpzx9bbkX/eQTzHsHwtnASQQP8Cn7I3SrFesLmcJm3VLTacq
         iAv3fyHbCxa8LdZ9LTW8nj5Xm/tj3I8XLu87vatxAHNw5BgLXwhOkZPdN6OB24Rx0i9U
         nkMnvzo1bS/ajrRHAi7s+4ZCfDC6RWTG0y8JoGMBnq3ThZ9mi5SKN247/m4WL1mcxLy7
         J3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kAy3Q9Y39G+FuvpBioeYBonxIBzlHnVN0CWGNZ5LzA4=;
        b=mbzSP1slnJPJrDL2MuUB2wP+tvnI5+mnnQ9O197onux7wQ/Hv44ZStHtElA4TfDYZZ
         zffMjo/78py3yuesDYv9KUOHAhTKrb4TEtzrzpaU9K5ugyCMx1Xmu3szzJ3eA7PkbLSi
         BB51po8wc4XrIzMizqIhLE4V9b77YdZbWU7ZTNtZbVm8+zX4WCwJaR/hUNlp6/n1hKqy
         8fvns+p6tPTiUUV3SMdfUOTt6ztUKzjfqtnXfbhsY3ct9pKM9By3l8QuPBLLbuZt0AuE
         si/syRZTvB83URIhE6j1dXTDQmUOc3r2R4gGO2HzFbYY+5x3UxH5u3MoJ9CpB2Tlvlig
         8FBA==
X-Gm-Message-State: ANhLgQ2PujLR5beTC3yvLoy/AjZXxt0tk4s4PX6TPLUtRQO3qLZHSUwI
        eOi5jZI8Twmp6nPH01bMquVbUwxiz2m2H8GV8GE=
X-Google-Smtp-Source: ADFU+vtgqfG4FF6mc0jKTN556TAzeaxdc9Yk0mjV6/i86BIoJ5VRFLVhhkWg4WxWaPTVBA4tJmivAUGZWBGlzJ4d4As=
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr3281931plp.217.1584433210972;
 Tue, 17 Mar 2020 01:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p> <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
 <20200313023156.GB27275@ming.t460p> <CAEK8JBCHKbBoXutE5rtxA+kUeoCZB2o=Lsjf9WbYZ+sLayNymA@mail.gmail.com>
 <CACVXFVPJcO41a-dinfEhLKnJ6P=6sMXyg7SZcXPtqHcyqRPUUA@mail.gmail.com>
In-Reply-To: <CACVXFVPJcO41a-dinfEhLKnJ6P=6sMXyg7SZcXPtqHcyqRPUUA@mail.gmail.com>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Tue, 17 Mar 2020 16:19:44 +0800
Message-ID: <CAEK8JBCKH8-tiUj1W6CB_wAx2xF4osDLXG3GNzuAySrgsqp=yQ@mail.gmail.com>
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks.
Sometimes when I observe multipage bvec on 5.3.7-301.fc31.x86_64.
This log is from Qemu virtio-blk.

=3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 2
      0: size: 229376 addr: 0x7fff6a7c8000
      1: size: 32768 addr: 0x7fff64c00000
=3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 2
      0: size: 229376 addr: 0x7fff6a7c8000
      1: size: 32768 addr: 0x7fff64c00000

I also tested on 5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64.
And observe 64 iovcnt.
=3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 64
      0: size: 4096 addr: 0x7fffb5ece000
      1: size: 4096 addr: 0x7fffb5ecd000
...
      63: size: 4096 addr: 0x7fff8baec000

So I think this is a common issue of the upstream kernel, from 5.3 to 5.6.

BTW, I have used your script on 5.3.7-301.fc31.x86_64, it works well.
However, when updating to kernel 5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x8=
6_64.
It complains:

root@192.168.19.239 16:57:23 ~ $ ./bvec_avg_pages.py
In file included from /virtual/main.c:2:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/u=
api/linux/ptrace.h:142:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/=
include/asm/ptrace.h:5:
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/=
include/asm/segment.h:266:2:
error: expected '(' after 'asm'
        alternative_io ("lsl %[seg],%[p]",
        ^
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/=
include/asm/alternative.h:240:2:
note: expanded from macro 'alternative_io'
        asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature)   \
        ^
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/l=
inux/compiler_types.h:210:24:
note: expanded from macro 'asm_inline'
#define asm_inline asm __inline
                       ^
In file included from /virtual/main.c:3:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/l=
inux/blkdev.h:5:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/l=
inux/sched.h:14:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/l=
inux/pid.h:5:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/l=
inux/rculist.h:11:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/l=
inux/rcupdate.h:27:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/l=
inux/preempt.h:78:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/=
include/asm/preempt.h:7:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/l=
inux/thread_info.h:38:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/=
include/asm/thread_info.h:12:
In file included from
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/=
include/asm/page.h:12:
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/=
include/asm/page_64.h:49:2:
error: expected '(' after 'asm'
        alternative_call_2(clear_page_orig,

Ming Lei <tom.leiming@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Mar 15, 2020 at 9:34 AM Feng Li <lifeng1519@gmail.com> wrote:
> >
> > Hi Ming,
> > This is my cmd to run qemu:
> > qemu-2.12.0/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -device
> > virtio-balloon -cpu host -smp 4 -m 2G -drive
> > file=3D/root/html/fedora-10g.img,format=3Draw,cache=3Dnone,aio=3Dnative=
,if=3Dnone,id=3Ddrive-virtio-disk1
> > -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk1,id=3Dvirti=
o-disk1,bootindex=3D1
> > -drive file=3D/dev/sdb,format=3Draw,cache=3Dnone,aio=3Dnative,if=3Dnone=
,id=3Ddrive-virtio-disk2
> > -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk2,id=3Dvirti=
o-disk2,bootindex=3D2
> > -device virtio-net,netdev=3Dnw1,mac=3D00:11:22:EE:EE:10 -netdev
> > tap,id=3Dnw1,script=3Dno,downscript=3Dno,ifname=3Dtap0 -serial mon:stdi=
o
> > -nographic -object
> > memory-backend-file,id=3Dmem0,size=3D2G,mem-path=3D/dev/hugepages,share=
=3Don
> > -numa node,memdev=3Dmem0 -vnc 0.0.0.0:100 -machine usb=3Don,nvdimm -dev=
ice
> > usb-tablet -monitor unix:///tmp/a.socket,server,nowait -qmp
> > tcp:0.0.0.0:2234,server,nowait
> >
> > OS image is Fedora 31. Kernel is 5.3.7-301.fc31.x86_64.
> >
> > The address from virio in qemu like this:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 64
> >       0: size: 4096 addr: 0x7fffc83f1000
> >       1: size: 4096 addr: 0x7fffc8037000
> >       2: size: 4096 addr: 0x7fffd3710000
> >       3: size: 4096 addr: 0x7fffd5624000
> >       4: size: 4096 addr: 0x7fffc766c000
> >       5: size: 4096 addr: 0x7fffc7c21000
> >       6: size: 4096 addr: 0x7fffc8d54000
> >       7: size: 4096 addr: 0x7fffc8fc6000
> >       8: size: 4096 addr: 0x7fffd5659000
> >       9: size: 4096 addr: 0x7fffc7f88000
> >       10: size: 4096 addr: 0x7fffc767b000
> >       11: size: 4096 addr: 0x7fffc8332000
> >       12: size: 4096 addr: 0x7fffb4297000
> >       13: size: 4096 addr: 0x7fffc8888000
> >       14: size: 4096 addr: 0x7fffc93d7000
> >       15: size: 4096 addr: 0x7fffc9f1f000
> >
> > They are not contiguous pages, so the pages in bvec are not continus
> > physical pages.
> >
> > I don't know how to dump the bvec address in bio without recompiling th=
e kernel.
>
> I just run similar test on 5.3.11-100.fc29.x86_64, and the observation
> is similar with
> yours.
>
> However, not observe similar problem in 5.6-rc kernel in VM, maybe kernel=
 config
> causes the difference.
>
> BTW, I usually use the attached bcc script to observe bvec pages, and you=
 may
> try that on upstream kernel.
>
> Thanks,
> Ming
