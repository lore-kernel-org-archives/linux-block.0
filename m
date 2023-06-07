Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A4FC7EE25
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 14:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjFGOU7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbjFGOU6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 10:20:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08D41BCA
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 07:20:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9788554a8c9so108582666b.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jun 2023 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686147655; x=1688739655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjnuyJE5MPCESC15VfWBkFspvFs6sDC35cz2+03PVNk=;
        b=rrHj2rz6T2jIgziFoHaiCJuN451HlDOO89oOgtV0hOmxMsy+bzBPgZVKSDzU1p7/6S
         ILrJnt56RG7uqmSYWIvsWfkCXGMQY0MVAdYqohsZkecFcTVOEkE68nAtE5nAQJ3Mqd9G
         sbdMNy49pjuzJD7rNE/IaK+LTHsXXgCEZNEhc5U3eESs/mGdWSpREZRrnSyRN3dzb28N
         xu7s9ybE1tDNXSIqDEAKnkf1sE+a6suX8f9Q2XTCCIUxRQFW+1q54/66WuIj3BPD6NKA
         QWNggpf9kvFYg9Ds/UufP/aWPzt5ktH1BZOailS7sr4buSLCwOUh3OEWsi3CNv2lV2S4
         0B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147655; x=1688739655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjnuyJE5MPCESC15VfWBkFspvFs6sDC35cz2+03PVNk=;
        b=gGT7K56ZW/SGly1qEY1xRrYndYNGePYi7XxCky2uBIrtH4rLPSr6Aej9EFI7P9DwS2
         ot2bSbP4lyFBy5XOm3e205nROPrV0fNzEanZep8JF/WwIYFkDXV1O2G7cbepnZ0v/sLv
         ms4j/azG5mZhGP+v+6fsV0enipTvAvRPCAubCNU0nLzZZJqJttIdtdWpVsDtGPQUttnT
         ccylvyxagWH7FCm1mEadd1tOVF9VfDug6rBkU0ahWntxLu6AXYf/LN2bM6gzLgFbiDZC
         4Klt1nZIsABVdQfR5mT5wV+06qrmZssjQMKd9uZM17Ds/0mnoAoDiZzD3HcwGacEIdpz
         7+wQ==
X-Gm-Message-State: AC+VfDwgA4/IjVNPb+dw2sRVKd0E6+JRfs2tBV8x+MCZQNCqW8umkVJK
        yNXgOi/mMJpRYMcMR2MeqBCaFW7cSC0L2pSAnlQ=
X-Google-Smtp-Source: ACHHUZ7EnBNjNqKKKXQB75Z3EtNvO1CN90RT/W9gem8aG5Qfqvf4PPaNN11JzfzaQ8AEyd4sK+E/zJAAFyRx8zs2pWU=
X-Received: by 2002:a17:907:6ea3:b0:966:2123:e0ca with SMTP id
 sh35-20020a1709076ea300b009662123e0camr7219002ejc.34.1686147654888; Wed, 07
 Jun 2023 07:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Wed, 7 Jun 2023 23:20:43 +0900
Message-ID: <CAFNWusa7goyDs1HaMVYDvvXT7ePfB7cAQt3EewT+t=-kKNf5eg@mail.gmail.com>
Subject: Re: virtio-blk: support completion batching for the IRQ path - failure
To:     "Roberts, Martin" <martin.roberts@intel.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 7, 2023 at 6:14=E2=80=AFPM Roberts, Martin <martin.roberts@inte=
l.com> wrote:
>
> Re: virtio-blk: support completion batching for the IRQ path =C2=B7 torva=
lds/linux@07b679f =C2=B7 GitHub
>
> Signed-off-by: Suwan Kim suwan.kim027@gmail.com
>
> Signed-off-by: Michael S. Tsirkin mst@redhat.com
>
>
>
>
>
> This change appears to have broken things=E2=80=A6
>
> We now see applications hanging during disk accesses.
>
> e.g.
>
> multi-port virtio-blk device running in h/w (FPGA)
>
> Host running a simple =E2=80=98fio=E2=80=98 test.
>
> [global]
>
> thread=3D1
>
> direct=3D1
>
> ioengine=3Dlibaio
>
> norandommap=3D1
>
> group_reporting=3D1
>
> bs=3D4K
>
> rw=3Dread
>
> iodepth=3D128
>
> runtime=3D1
>
> numjobs=3D4
>
> time_based
>
> [job0]
>
> filename=3D/dev/vda
>
> [job1]
>
> filename=3D/dev/vdb
>
> [job2]
>
> filename=3D/dev/vdc
>
> ...
>
> [job15]
>
> filename=3D/dev/vdp
>
>
>
> i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
>
> This is repeatedly run in a loop.
>
>
>
> After a few, normally <10 seconds, fio hangs.
>
> With 64 queues (16 disks), failure occurs within a few seconds; with 8 qu=
eues (2 disks) it may take ~hour before hanging.
>
> Last message:
>
> fio-3.19
>
> Starting 8 threads
>
> Jobs: 1 (f=3D1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
>
> I think this means at the end of the run 1 queue was left incomplete.
>
>
>
> =E2=80=98diskstats=E2=80=99 (run while fio is hung) shows no outstanding =
transactions.
>
> e.g.
>
> $ cat /proc/diskstats
>
> ...
>
> 252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 7125=
68645 0 0 0 0 0 0
>
> 252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 7049=
05623 0 0 0 0 0 0
>
> ...
>
>
>
> Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_qu=
eue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, an=
d show every request had a completion, and that virtblk_request_done() neve=
r gets called.
>
> e.g.
>
> PF=3D 0                         vq=3D0           1           2           =
3
>
> [a]request_count     -   839416590   813148916   105586179    84988123
>
> [b]completion1_count -   839416590   813148916   105586179    84988123
>
> [c]completion2_count -           0           0           0           0
>
>
>
> PF=3D 1                         vq=3D0           1           2           =
3
>
> [a]request_count     -   823335887   812516140   104582672    75856549
>
> [b]completion1_count -   823335887   812516140   104582672    75856549
>
> [c]completion2_count -           0           0           0           0
>
>
>
> i.e. the issue is after the virtio-blk driver.
>
>
>
>
>
> This change was introduced in kernel 6.3.0.
>
> I am seeing this using 6.3.3.
>
> If I run with an earlier kernel (5.15), it does not occur.
>
> If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_=
mq_add_to_batch()call, it does not fail.
>
> e.g.
>
> kernel 5.15 =E2=80=93 this is OK
>
> virtio_blk.c,virtblk_done() [irq handler]
>
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>
>                           blk_mq_complete_request(req);
>
>                  }
>
>
>
> kernel 6.3.3 =E2=80=93 this fails
>
> virtio_blk.c,virtblk_handle_req() [irq handler]
>
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>
>                           if (!blk_mq_complete_request_remote(req)) {
>
>                                   if (!blk_mq_add_to_batch(req, iob, virt=
blk_vbr_status(vbr), virtblk_complete_batch)) {
>
>                                            virtblk_request_done(req);    =
//this never gets called... so blk_mq_add_to_batch() must always succeed
>
>                                    }
>
>                           }
>
>                  }
>
>
>
> If I do, kernel 6.3.3 =E2=80=93 this is OK
>
> virtio_blk.c,virtblk_handle_req() [irq handler]
>
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>
>                           if (!blk_mq_complete_request_remote(req)) {
>
>                                    virtblk_request_done(req); //force thi=
s here...
>
>                                   if (!blk_mq_add_to_batch(req, iob, virt=
blk_vbr_status(vbr), virtblk_complete_batch)) {
>
>                                            virtblk_request_done(req);    =
//this never gets called... so blk_mq_add_to_batch() must always succeed
>
>                                    }
>
>                           }
>
>                  }
>
>
>
>
>
> Perhaps you might like to fix/test/revert this change=E2=80=A6
>
> Martin
>
>

Hi Martin,

There are many changes between 6.3.0 and 6.3.3.
Could you try to find a commit which triggers the io hang?
Is it ok with 6.3.0 kernel or with reverting
"virtio-blk: support completion batching for the IRQ path" commit?

We need to confirm which commit is causing the error.

Regards,
Suwan Kim
