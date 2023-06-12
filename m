Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB96BC88CB4
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjFLPFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbjFLPFV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 11:05:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5CF1B3
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 08:05:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so4986184e87.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582308; x=1689174308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UID8H1ujoYRgO0p+bWdKckV7P3/rZg4rHUWf5ScJio=;
        b=eNFEpNewuhaMeXLFWje18KM3cm+S0IT4U5By9h+7E8rNkDy5HgdLbx6u2mJ3dochuF
         waL3XxOZG4sgO29tB7e/TN/dRWQ29kxeEZ2lThsQr952sv4AAR++dzeG6nKz3Dy9ruw5
         35GK/cQKNWzLrV59UtUj4eqBKXAwOaQEl3SHz9jKqISjX7hgE2B3ke8NZJVAUOcRQOXw
         kiERd7jzVenupOmmr3AWGloHxP1dZ1oRS6GG8YlHFhBClPjqrNlraO/QgXmyxze4b0sV
         8AiI/MwDAHmcCO6M1yr4gIp/FGPAgQa8Ncma/BoQqdkSXJdKyjgUT6R1xqJnOezI5tS/
         xSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582308; x=1689174308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UID8H1ujoYRgO0p+bWdKckV7P3/rZg4rHUWf5ScJio=;
        b=DKHdvCnGb/2re7aHB3DzBpuxf90UgnEBEAXd+F/IZAs2fnCY/8Eceqt6hXm5uHsgW6
         IMDhnJEoauNc9EdD7tiJc1ABVhPK220nwPx8oQ5jIQVIccxZy23xrMGf0ccoWZq24vGo
         xERHkyjTHbsNHfRwen2iQJ8VTOQpKQQl3y1VL6ta7so4N+IxNv643Qo1znqQlkL3gPB5
         xE6rNdBaHOSuYL4FIl8ELycW1gRfIAckFQwxP4wmyfRQGQodxfsVgUg4Dz+kY7ejgM/t
         lAaM5RP4q23xYGUVDmOuDidH9p04mOtx4gICiIPCl3qoj3dSrC/I1ms/6rc9EmsA4ziF
         ePEA==
X-Gm-Message-State: AC+VfDyXdPKmUhNPTtKiAK+SMLh8jLgy2HvOxVUUQQYTnl6fD7tdkNt2
        JsCqU2/pkh3eaTPIYXxWB++L9KAXYM3SAmqNdUX1iETI23U=
X-Google-Smtp-Source: ACHHUZ5rgb34SSnAnWspYm6/e0LAjmovQC6YjuTv1gVZbkU2O0OVezH4NrpAhKz3NrO6sUT4oYVYIrpXUpZOyduzXM0=
X-Received: by 2002:a2e:300f:0:b0:2a9:f114:f168 with SMTP id
 w15-20020a2e300f000000b002a9f114f168mr2882405ljw.46.1686582307627; Mon, 12
 Jun 2023 08:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusa7goyDs1HaMVYDvvXT7ePfB7cAQt3EewT+t=-kKNf5eg@mail.gmail.com>
 <BN9PR11MB535433DFB3A1CFAD097C13278353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Tue, 13 Jun 2023 00:04:56 +0900
Message-ID: <CAFNWusbqh97L-x2KhR3eWC9p6xQQevzmV4Fz-3OLMy8gG5-KWQ@mail.gmail.com>
Subject: Re: virtio-blk: support completion batching for the IRQ path - failure
To:     "Roberts, Martin" <martin.roberts@intel.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

I'm trying to reproduce the issue but in my machine, IO hang doesn't happen=
.
I attached upto 16 disk images to vm and set various vCPU number and
memory size (3~16 vCPU, 2~8GB RAM)
Could you let me know your VM settings?

And in order to know if the IO hang is triggered by driver,
Could you please share a log when IO hang happens?
You can get a log for each /dev/vd* with below command

cd /sys/kernel/debug/block/[test_device] && find . -type f -exec grep
-aH . {} \;

Regards,
Suwan Kim


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
>
> [RFC] blk-mq: Don't IPI requests on PREEMPT_RT - Patchwork (linaro.org)
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
