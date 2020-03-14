Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD61C1975A
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 01:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED4B2076A
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 01:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW2cooRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCOBdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:33:51 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42292 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCOBdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Mar 2020 21:33:51 -0400
Received: by mail-pf1-f174.google.com with SMTP id x2so7315958pfn.9
        for <linux-block@vger.kernel.org>; Sat, 14 Mar 2020 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JGXAXivUWhookJzvhdY3H9q1Gm3tmXD7ABYuLmVnXJo=;
        b=KW2cooRShutHVBMS2/HGQQsXxCEaJFWbK9PZ/2wfoXK27NHTZfhz4FqfrynEpw3dM6
         p/FoMruesgv7n3cNwtXWZmaWR3EW02jFZKk8OuDCt8jUwQfOCWc/wHqiQi42dfJfgy1H
         9EAUi/YncFPw/8miEWK22uXZ/2EXWAAr6iKFKrcCTLWisP8K5MFpuHjAe+rswjzOJ+c6
         Iq+T7LSBrRDO/jgwZkshDqa8Wqs//m2AGRPBk9JautiGPtTH4ZQBsMchZEF2oR07Lo8Z
         fElRPrYXibWdLDVM1QYDHXsqJr3AP/o5V4Xg3yEtDqIqQIrFFAuqQ8M7OI68Nq3W8Hp5
         uXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JGXAXivUWhookJzvhdY3H9q1Gm3tmXD7ABYuLmVnXJo=;
        b=IyrFMLFpAqqBnxxBhnc6O7Zx4Ma4Wh+x/tT5tK1O7XYvCNlLZ95V9NJ4M8a/lYxK81
         9oq8hVcF3ZMICO+DEBWUQ7ZvUiiVDakJGy/CK5B9dN2fTERmhX3+bNfIc7K+S8GA0dMZ
         4bBx9vaO22axULbeW6+Z7YaDF3+CWQk7mSXkmRz7A2RHC58uckKNFajYYy0ZufHRwb4b
         2mK58IDxQ16edEJQR6ApSjuYrEiB0K46CnsISjhBU21mjjNRhFoXsJ0tob1OLdtAnAQf
         1MJrWz3H6ZGqpBWQ9mMmCHrUI+XFEn6+EvetA/q7f99pX2wUpouh1V6rV4KSmuBrS/KC
         EwTQ==
X-Gm-Message-State: ANhLgQ1qry4ugD+rxfIGS+gr8ZGZ8vDY0uhLp4tk6Jgqo4EchNqSdJ+z
        odA4IzXKaFNow9ahsvHkQfkBJazIioCxO6nkvtGrso09iApfPg==
X-Google-Smtp-Source: ADFU+vvLUlPlBF85pvUtOeYaXjoTCZnlylPF2nB1gPyHPgvcb3MHRzxtJf1h5b6gfQ4sOB2vIM0nCGZgwqHL4C0x5Dk=
X-Received: by 2002:a65:64ca:: with SMTP id t10mr4120644pgv.190.1584207813366;
 Sat, 14 Mar 2020 10:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p> <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
 <20200313023156.GB27275@ming.t460p>
In-Reply-To: <20200313023156.GB27275@ming.t460p>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Sun, 15 Mar 2020 01:43:06 +0800
Message-ID: <CAEK8JBCHKbBoXutE5rtxA+kUeoCZB2o=Lsjf9WbYZ+sLayNymA@mail.gmail.com>
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,
This is my cmd to run qemu:
qemu-2.12.0/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -device
virtio-balloon -cpu host -smp 4 -m 2G -drive
file=3D/root/html/fedora-10g.img,format=3Draw,cache=3Dnone,aio=3Dnative,if=
=3Dnone,id=3Ddrive-virtio-disk1
-device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk1,id=3Dvirtio-di=
sk1,bootindex=3D1
-drive file=3D/dev/sdb,format=3Draw,cache=3Dnone,aio=3Dnative,if=3Dnone,id=
=3Ddrive-virtio-disk2
-device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk2,id=3Dvirtio-di=
sk2,bootindex=3D2
-device virtio-net,netdev=3Dnw1,mac=3D00:11:22:EE:EE:10 -netdev
tap,id=3Dnw1,script=3Dno,downscript=3Dno,ifname=3Dtap0 -serial mon:stdio
-nographic -object
memory-backend-file,id=3Dmem0,size=3D2G,mem-path=3D/dev/hugepages,share=3Do=
n
-numa node,memdev=3Dmem0 -vnc 0.0.0.0:100 -machine usb=3Don,nvdimm -device
usb-tablet -monitor unix:///tmp/a.socket,server,nowait -qmp
tcp:0.0.0.0:2234,server,nowait

OS image is Fedora 31. Kernel is 5.3.7-301.fc31.x86_64.

The address from virio in qemu like this:
=3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 64
      0: size: 4096 addr: 0x7fffc83f1000
      1: size: 4096 addr: 0x7fffc8037000
      2: size: 4096 addr: 0x7fffd3710000
      3: size: 4096 addr: 0x7fffd5624000
      4: size: 4096 addr: 0x7fffc766c000
      5: size: 4096 addr: 0x7fffc7c21000
      6: size: 4096 addr: 0x7fffc8d54000
      7: size: 4096 addr: 0x7fffc8fc6000
      8: size: 4096 addr: 0x7fffd5659000
      9: size: 4096 addr: 0x7fffc7f88000
      10: size: 4096 addr: 0x7fffc767b000
      11: size: 4096 addr: 0x7fffc8332000
      12: size: 4096 addr: 0x7fffb4297000
      13: size: 4096 addr: 0x7fffc8888000
      14: size: 4096 addr: 0x7fffc93d7000
      15: size: 4096 addr: 0x7fffc9f1f000

They are not contiguous pages, so the pages in bvec are not continus
physical pages.

I don't know how to dump the bvec address in bio without recompiling the ke=
rnel.

IO Pattern in guest is :
root@192.168.19.239 02:39:29 ~ $ cat 256k-randread.fio
[global]
ioengine=3Dlibaio
invalidate=3D1
ramp_time=3D5
iodepth=3D1
runtime=3D120000
time_based
direct=3D1

[randread-vdb-256k-para]
bs=3D256k
stonewall
filename=3D/dev/vdb
rw=3Drandread

Thanks.


Ming Lei <ming.lei@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8810:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Mar 12, 2020 at 09:21:11PM +0800, Feng Li wrote:
> > Hi Ming,
> > Thanks.
> > I have tested kernel '5.4.0-rc6+', which includes 07173c3ec276.
> > But the virtio is still be filled with single page by page.
>
> Hello,
>
> Could you share your test script?
>
> BTW, it depends if fs layer passes contiguous pages to block layer.
>
> You can dump each bvec of the bio, and see if they are contiguous
> physically.
>
> Thanks,
> Ming
>
> >
> > Ming Lei <ming.lei@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8812=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:34=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Mar 12, 2020 at 07:13:28PM +0800, Feng Li wrote:
> > > > Hi experts,
> > > >
> > > > May I ask a question about block layer?
> > > > When running fio in guest os, I find a 256k IO is split into the pa=
ge
> > > > by page in bio, saved in bvecs.
> > > > And virtio-blk just put the bio_vec one by one in the available
> > > > descriptor table.
> > > >
> > > > So if my backend device does not support iovector
> > > > opertion(preadv/pwritev), then IO is issued to a low layer page by
> > > > page.
> > > > My question is: why doesn't the bio save multi-pages in one bio_vec=
?
> > >
> > > We start multipage bvec since v5.1, especially since 07173c3ec276
> > > ("block: enable multipage bvecs").
> > >
> > > Thanks,
> > > Ming
> > >
> >
>
> --
> Ming
>
