Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201AC7EE25
	for <linux-block@archiver.kernel.org>; Thu,  8 Jun 2023 14:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjFHOHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jun 2023 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbjFHOHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jun 2023 10:07:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEA31BE8
        for <linux-block@vger.kernel.org>; Thu,  8 Jun 2023 07:07:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977d6aa3758so127380466b.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jun 2023 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686233253; x=1688825253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw73xrFFp8nhGm2dQd3sOWmUYKkXMMFcamRQq6Kivpw=;
        b=bGrkf4fLwz0uW3gBSbEC5CSC7WNLR1J3KOEKkrk+mjeYv7Xd9ojPLpSzZNbcD7waHS
         oL6z13tLsRfeGVZNvpSRXTtx945igrZMrgKjlg8xFV34hm9pJyEdPQ1MAcOj+Stj1Pjp
         XRlvoju919CjZAsFCdtYoz4oo+9HnpdaN47VZDnj8fSQ5A3AcLWVadBx03sf6fNFt81p
         T0wlfK4OpcYTzpKbIuVBG5doJ6k2D3/erjiGxO/hS7IFqCts3dQGcrNlTQoD4A5PRtI2
         YVU2fR0GmSKfZE19im5GckWBs1B9VhArDmzX3axqPth623zukYIQVNw/WG2jfhgQUYEy
         rfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686233253; x=1688825253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw73xrFFp8nhGm2dQd3sOWmUYKkXMMFcamRQq6Kivpw=;
        b=N69+MvbITFxMvnUQqOxyxr+0nhrfX4222TQlLBOKoHENX2yoXY1f8iiNVHo9EOQ7fh
         GxwUyLqfByeMZTbQNI3kmn9pBZzu+ADqlqISznF1K/AftcUZ0K36dtcLgSUSMbFO6lgv
         rnfzx+6iHGL3VmXE8EpA+cDc77GXp8kwnyvuP2+2OV/7ZAI2VnpAqXP/7pBoLblY9F6u
         L2Ig8Wogm/vyb5Sq8PiG3NL4Bx+Gs+VXThhLeQ2t85WXZrjUzg/QIJ2jiJUV49tr0NpN
         toYx50IBQpw5k1OjVACH3/tg8kCbsTbB6r5nLqfVCVtPk1XaSbJelfVnig6HrD1DfZyt
         Zw3w==
X-Gm-Message-State: AC+VfDwhvVx/y80sTfvfRy/I/8Yg22zC0wNq4GVgn1lRMmYtgb8o9x9D
        pTTkKVkuIuqcODS2fPgafVnAIEFAG1Yx1oQxRkA=
X-Google-Smtp-Source: ACHHUZ56Zed9fR7jWQZTE2WoWnRgPa9L0kCBwhg7fNxLXy2FtGAk5S6G/SJ+2Q5WjPFVIKoQiTKXEzru1xtqxH/A93c=
X-Received: by 2002:a17:907:868f:b0:96a:5bdd:7557 with SMTP id
 qa15-20020a170907868f00b0096a5bdd7557mr9575746ejc.70.1686233252624; Thu, 08
 Jun 2023 07:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusa7goyDs1HaMVYDvvXT7ePfB7cAQt3EewT+t=-kKNf5eg@mail.gmail.com>
 <BN9PR11MB535433DFB3A1CFAD097C13278353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Thu, 8 Jun 2023 23:07:21 +0900
Message-ID: <CAFNWusbOKhZtVBRu88Ebo3=Cv9rdsX2aAf6_5hfnge=iryR3DQ@mail.gmail.com>
Subject: Re: virtio-blk: support completion batching for the IRQ path - failure
To:     "Roberts, Martin" <martin.roberts@intel.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 8, 2023 at 7:16=E2=80=AFPM Roberts, Martin <martin.roberts@inte=
l.com> wrote:
>
> The rq_affinity change does not resolve the issue; just reduces its occur=
rence rate; I am still seeing hangs with it set to 2.
>
> Martin
>
>
>
> From: Roberts, Martin
> Sent: Wednesday, June 7, 2023 3:46 PM
> To: Suwan Kim <suwan.kim027@gmail.com>
> Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundation=
.org>; linux-block@vger.kernel.org
> Subject: RE: virtio-blk: support completion batching for the IRQ path - f=
ailure
>
>
>
> It is the change indicated that breaks it - changing the IRQ handling to =
batching.
>
>
>
>
>
>
>
> From reports such as,
>
> [PATCH 1/1] blk-mq: added case for cpu offline during send_ipi in rq_comp=
lete (kernel.org)
https://lore.kernel.org/lkml/20220929033428.25948-1-mj0123.lee@samsung.com/=
T/
>
> [RFC] blk-mq: Don't IPI requests on PREEMPT_RT - Patchwork (linaro.org)
https://patches.linaro.org/project/linux-rt-users/patch/20201023110400.bx3u=
zsb7xy5jtsea@linutronix.de/
>
>
>
> I=E2=80=99m thinking the issue has something to do with which CPU the IRQ=
 is running on.
>
>
>
> So, I set,
>
> # echo 2 > /sys/block/vda/queue/rq_affinity
>
> # echo 2 > /sys/block/vdb/queue/rq_affinity
>
> =E2=80=A6
>
> # echo 2 > /sys/block/vdp/queue/rq_affinity
>
>
>
>
>
> and the system (running 16 disks, 4 queues/disk) has not yet hung (runnin=
g OK for several hours)=E2=80=A6
>
>
>
> Martin
>

Hi Martin,

Both codes (original code and your simple path) execute
blk_mq_complete_send_ipi()
at blk_mq_complete_request_remote(). So maybe missing request completion
on other vCPU is not the cause...

The difference between the original code and your simple path is that
the original code calls blk_mq_end_request_batch() at virtblk_done()
to process request at block layer
and your code calls blk_mq_end_request() at virtblk_done() to do same thing=
.

The original code :
virtblk_handle_req() first collects all requests from virtqueue in while lo=
op
and pass it to blk_mq_end_request_batch() at once

Your simple path:
virtblk_handle_req() get single request from virtqueue and pass it to
blk_mq_end_request() and do it again in while loop until there in no reques=
t
in virtqueue


I think we need to focus on the difference between blk_mq_end_request()
and blk_mq_end_request_batch()

Regards,
Suwan Kim




>
>
> -----Original Message-----
> From: Suwan Kim <suwan.kim027@gmail.com>
> Sent: Wednesday, June 7, 2023 3:21 PM
> To: Roberts, Martin <martin.roberts@intel.com>
> Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundation=
.org>; linux-block@vger.kernel.org
> Subject: Re: virtio-blk: support completion batching for the IRQ path - f=
ailure
>
>
>
> On Wed, Jun 7, 2023 at 6:14=E2=80=AFPM Roberts, Martin <martin.roberts@in=
tel.com> wrote:
>
> >
>
> > Re: virtio-blk: support completion batching for the IRQ path =C2=B7 tor=
valds/linux@07b679f =C2=B7 GitHub
>
> >
>
> > Signed-off-by: Suwan Kim suwan.kim027@gmail.com
>
> >
>
> > Signed-off-by: Michael S. Tsirkin mst@redhat.com
>
> >
>
> >
>
> >
>
> >
>
> >
>
> > This change appears to have broken things=E2=80=A6
>
> >
>
> > We now see applications hanging during disk accesses.
>
> >
>
> > e.g.
>
> >
>
> > multi-port virtio-blk device running in h/w (FPGA)
>
> >
>
> > Host running a simple =E2=80=98fio=E2=80=98 test.
>
> >
>
> > [global]
>
> >
>
> > thread=3D1
>
> >
>
> > direct=3D1
>
> >
>
> > ioengine=3Dlibaio
>
> >
>
> > norandommap=3D1
>
> >
>
> > group_reporting=3D1
>
> >
>
> > bs=3D4K
>
> >
>
> > rw=3Dread
>
> >
>
> > iodepth=3D128
>
> >
>
> > runtime=3D1
>
> >
>
> > numjobs=3D4
>
> >
>
> > time_based
>
> >
>
> > [job0]
>
> >
>
> > filename=3D/dev/vda
>
> >
>
> > [job1]
>
> >
>
> > filename=3D/dev/vdb
>
> >
>
> > [job2]
>
> >
>
> > filename=3D/dev/vdc
>
> >
>
> > ...
>
> >
>
> > [job15]
>
> >
>
> > filename=3D/dev/vdp
>
> >
>
> >
>
> >
>
> > i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
>
> >
>
> > This is repeatedly run in a loop.
>
> >
>
> >
>
> >
>
> > After a few, normally <10 seconds, fio hangs.
>
> >
>
> > With 64 queues (16 disks), failure occurs within a few seconds; with 8 =
queues (2 disks) it may take ~hour before hanging.
>
> >
>
> > Last message:
>
> >
>
> > fio-3.19
>
> >
>
> > Starting 8 threads
>
> >
>
> > Jobs: 1 (f=3D1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
>
> >
>
> > I think this means at the end of the run 1 queue was left incomplete.
>
> >
>
> >
>
> >
>
> > =E2=80=98diskstats=E2=80=99 (run while fio is hung) shows no outstandin=
g transactions.
>
> >
>
> > e.g.
>
> >
>
> > $ cat /proc/diskstats
>
> >
>
> > ...
>
> >
>
> > 252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 71=
2568645 0 0 0 0 0 0
>
> >
>
> > 252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 70=
4905623 0 0 0 0 0 0
>
> >
>
> > ...
>
> >
>
> >
>
> >
>
> > Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_=
queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, =
and show every request had a completion, and that virtblk_request_done() ne=
ver gets called.
>
> >
>
> > e.g.
>
> >
>
> > PF=3D 0                         vq=3D0           1           2         =
  3
>
> >
>
> > [a]request_count     -   839416590   813148916   105586179    84988123
>
> >
>
> > [b]completion1_count -   839416590   813148916   105586179    84988123
>
> >
>
> > [c]completion2_count -           0           0           0           0
>
> >
>
> >
>
> >
>
> > PF=3D 1                         vq=3D0           1           2         =
  3
>
> >
>
> > [a]request_count     -   823335887   812516140   104582672    75856549
>
> >
>
> > [b]completion1_count -   823335887   812516140   104582672    75856549
>
> >
>
> > [c]completion2_count -           0           0           0           0
>
> >
>
> >
>
> >
>
> > i.e. the issue is after the virtio-blk driver.
>
> >
>
> >
>
> >
>
> >
>
> >
>
> > This change was introduced in kernel 6.3.0.
>
> >
>
> > I am seeing this using 6.3.3.
>
> >
>
> > If I run with an earlier kernel (5.15), it does not occur.
>
> >
>
> > If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the bl=
k_mq_add_to_batch()call, it does not fail.
>
> >
>
> > e.g.
>
> >
>
> > kernel 5.15 =E2=80=93 this is OK
>
> >
>
> > virtio_blk.c,virtblk_done() [irq handler]
>
> >
>
> >                  if (likely(!blk_should_fake_timeout(req->q))) {
>
> >
>
> >                           blk_mq_complete_request(req);
>
> >
>
> >                  }
>
> >
>
> >
>
> >
>
> > kernel 6.3.3 =E2=80=93 this fails
>
> >
>
> > virtio_blk.c,virtblk_handle_req() [irq handler]
>
> >
>
> >                  if (likely(!blk_should_fake_timeout(req->q))) {
>
> >
>
> >                           if (!blk_mq_complete_request_remote(req)) {
>
> >
>
> >                                   if (!blk_mq_add_to_batch(req, iob, vi=
rtblk_vbr_status(vbr), virtblk_complete_batch)) {
>
> >
>
> >                                            virtblk_request_done(req);  =
  //this never gets called... so blk_mq_add_to_batch() must always succeed
>
> >
>
> >                                    }
>
> >
>
> >                           }
>
> >
>
> >                  }
>
> >
>
> >
>
> >
>
> > If I do, kernel 6.3.3 =E2=80=93 this is OK
>
> >
>
> > virtio_blk.c,virtblk_handle_req() [irq handler]
>
> >
>
> >                  if (likely(!blk_should_fake_timeout(req->q))) {
>
> >
>
> >                           if (!blk_mq_complete_request_remote(req)) {
>
> >
>
> >                                    virtblk_request_done(req); //force t=
his here...
>
> >
>
> >                                   if (!blk_mq_add_to_batch(req, iob, vi=
rtblk_vbr_status(vbr), virtblk_complete_batch)) {
>
> >
>
> >                                            virtblk_request_done(req);  =
  //this never gets called... so blk_mq_add_to_batch() must always succeed
>
> >
>
> >                                    }
>
> >
>
> >                           }
>
> >
>
> >                  }
>
> >
>
> >
>
> >
>
> >
>
> >
>
> > Perhaps you might like to fix/test/revert this change=E2=80=A6
>
> >
>
> > Martin
>
> >
>
> >
>
>
>
> Hi Martin,
>
>
>
> There are many changes between 6.3.0 and 6.3.3.
>
> Could you try to find a commit which triggers the io hang?
>
> Is it ok with 6.3.0 kernel or with reverting
>
> "virtio-blk: support completion batching for the IRQ path" commit?
>
>
>
> We need to confirm which commit is causing the error.
>
>
>
> Regards,
>
> Suwan Kim
