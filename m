Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99893EB64D8
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 14:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbjFMOmM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbjFMOmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 10:42:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E3E55
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 07:42:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5169f920a9dso11461515a12.0
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686667327; x=1689259327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byXEcpe9qk57x0KZ84Ts3U62dXdsbqGjNrweBoGIBfQ=;
        b=k9jzGiFe4aT7RrK4feB3hNVXNPwVt85JpKATd90lG95B53Rhc0eANCpvTsy8DL3qOo
         jM2Abf6o57h6EeWeiajsVb00oGxvxuK3nUmeoaISgABQh5aPXBfi9AOEhyOf6Odze6MC
         oweOPVuNMMlU+JVK0WmhUK11IT7C4F6Nter1xjxLzkcq5o/X7BwiKM/zVfbvILlBuFz4
         4YuR6YIxHHqcJtsMc/j+lx/3mvd37XeqFwhh6hyyxwBgMDrHUw6mEuz2LZGcZuR7HWei
         rEvFpOKepW+ihVw+SA/YCJ03MxT6wKqTZwt8Yd+PRDuuDT2T6MysKGJrp+RVi+dHxth5
         ZAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686667327; x=1689259327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byXEcpe9qk57x0KZ84Ts3U62dXdsbqGjNrweBoGIBfQ=;
        b=NkpxavY1TvHBley4pdb/sKAf3ybItxEaYAvir0hU+N4iExJ2vByflH+aMaMMAruJhk
         L+iz0lSOdK2QSUnDxg+HzTDZOvV9uGGb90ezpbr8fu7n+2Lz/03NB3wg0XGtKUPA3VIN
         wJb/OHGL7m+Tfd7Wn9RJdegpaxedF/cLbjX8LtRYLFd08hudzvYHDZxwusxsuVu2uiVb
         XbFK9hnZwzQ8AQa1RkqZgeJnImfHiU6EAOJghYr+ocQKdwqJSWainkokrz9TY+wruSh8
         k537nEBqlfgQyAkWgHBnqozvpP0hVIqPbwMYKKIpjg+Uzh8pb7ayT/MqV8vrvquvET3U
         Yo4Q==
X-Gm-Message-State: AC+VfDzf4FO6gff2G1mye5j8pFSBSfKagVI0YnQDEnJsxHMx0+4VUClP
        hRt0c45vgiHj3wxFGYSJvGQJAvaQEHqdJF1Zftg=
X-Google-Smtp-Source: ACHHUZ4Z2AtNXaEL/P03YEwjLE1ikhdgusRyDgmpAq7iNgqpyGZnELtN20/D7pdrixVii4ze+3R3SMELw0RI3m0RX3A=
X-Received: by 2002:a05:6402:27c9:b0:506:bbf8:5152 with SMTP id
 c9-20020a05640227c900b00506bbf85152mr9257411ede.9.1686667327239; Tue, 13 Jun
 2023 07:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusa7goyDs1HaMVYDvvXT7ePfB7cAQt3EewT+t=-kKNf5eg@mail.gmail.com>
 <BN9PR11MB535433DFB3A1CFAD097C13278353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusbqh97L-x2KhR3eWC9p6xQQevzmV4Fz-3OLMy8gG5-KWQ@mail.gmail.com> <BN9PR11MB53546C11605E8EAAE88A16FD8354A@BN9PR11MB5354.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB53546C11605E8EAAE88A16FD8354A@BN9PR11MB5354.namprd11.prod.outlook.com>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Tue, 13 Jun 2023 23:41:55 +0900
Message-ID: <CAFNWusYA0_yDDM0KDV6ShiMEw+KA_ZvRN2WCC9Tq-h1SA+aPkQ@mail.gmail.com>
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

On Tue, Jun 13, 2023 at 2:43=E2=80=AFAM Roberts, Martin
<martin.roberts@intel.com> wrote:
>
> I assume your find command should all be on the same line,
> i.e.
> find . -type f -exec grep -aH . {} \;
>
> -being a typical linux write-only style command, I have no idea what this=
 translates to...
>
> However, /sys/kernel/debug/block/vda (and /vdb ... /vdp) are all empty di=
rectories, and the find command returns nothing.
> What are you hoping to find in these paths? - created by who?
>

Can you rebuild kernel with kernel config change?
You can set kernel config at "make menuconfig" and enable below feature
You can find this feature at -> Enable the block layer (BLOCK [=3Dy])
 -> Block layer debugging information in debugfs (BLK_DEBUG_FS [=3Dy])

  =E2=94=82 Symbol: BLK_DEBUG_FS [=3Dy]
  =E2=94=82 Type  : bool
  =E2=94=82 Defined at block/Kconfig:168
  =E2=94=82   Prompt: Block layer debugging information in debugfs
  =E2=94=82   Depends on: BLOCK [=3Dy] && DEBUG_FS [=3Dy]
  =E2=94=82   Location:
  =E2=94=82     -> Enable the block layer (BLOCK [=3Dy])
  =E2=94=82 (2)   -> Block layer debugging information in debugfs (BLK_DEBU=
G_FS [=3Dy])

It can show IO hang information at block layer.
It will be very helpful if you share a result.

> I have no VMs running; the block devices are implemented in hardware, not=
 in QEMU, attached as PFs to the host.
> Host has 160 cores (dual socket with hyperthreads) - so 40 cores per CPU.=
 256GB RAM in total.
> fio is running on the host.
> fio threads/kblockd worker threads/irqs seem to get scattered across all =
cores, on both sockets! which doesn=E2=80=99t seem like a very efficient ap=
proach, but may not be a factor.
>

Yes, virtio block device can be implemented at HW
but maybe you are using VM.
virtio-blk driver should be run at VM.

>
> As previously indicated; I have added counts in the IRQ routine, which sh=
ow that all completions are accounted for inside the virtio-blk driver.
> However, the driver then passes back to the block stack (presumably via b=
lk_mq_add_to_batch()), which presumably then fails to process all the compl=
etions properly, leaving fio in the lurch. The virtio_mq_ops.complete callb=
ack in the virtio-blk driver (virtblk_request_done())  _never_ gets called.

virtblk_request_done() is not the function which processes request
completion at batch mode.
virtblk_complete_batch() is processing function of batch mode.
So you should track this function instead of virtblk_request_done().

virtblk_request_done() is called only when blk_mq_add_to_batch()
failed in virtblk_done().

blk_mq_add_to_batch() failure means it can not handle a request
in batch mode so pass it to virtblk_request_done() to process it
in not batch mode.

If batch completion works well, virtblk_request_done() never gets called.

Can you check if virtblk_complete_batch() is called properly?

And you said that you have added stat accounting codes to virtio-blk
([a]virtio_queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()),
it seems incomplete stat accounting because there is one more queuing
function (virtio_queue_rqs()) and virtblk_handle_req(),
virtblk_request_done() is not the only one which processes request completi=
on.

It is better to find other way to check irq and block stat.

And is there any other code changes you added to virto-blk and
block layer except accounting function?

> With the earlier code (5.15), this gets called for every packet.
> With, rq_affinity=3D2 (6.3.3), then it is called for most (~95%) packets =
but the system still hangs; albeit far less frequently - perhaps only on on=
e of those calls that doesn't trigger the .complete callback?
> i.e. it all points to a failure in the batching mechanism.
>
> Martin
>
>
> -----Original Message-----
> From: Suwan Kim <suwan.kim027@gmail.com>
> Sent: Monday, June 12, 2023 4:05 PM
> To: Roberts, Martin <martin.roberts@intel.com>
> Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundation=
.org>; linux-block@vger.kernel.org
> Subject: Re: virtio-blk: support completion batching for the IRQ path - f=
ailure
>
> Hi Martin,
>
> I'm trying to reproduce the issue but in my machine, IO hang doesn't happ=
en.
> I attached upto 16 disk images to vm and set various vCPU number and
> memory size (3~16 vCPU, 2~8GB RAM)
> Could you let me know your VM settings?
>
> And in order to know if the IO hang is triggered by driver,
> Could you please share a log when IO hang happens?
> You can get a log for each /dev/vd* with below command
>
> cd /sys/kernel/debug/block/[test_device] && find . -type f -exec grep
> -aH . {} \;
>
> Regards,
> Suwan Kim
>
>
> On Thu, Jun 8, 2023 at 7:16=E2=80=AFPM Roberts, Martin <martin.roberts@in=
tel.com> wrote:
> >
> > The rq_affinity change does not resolve the issue; just reduces its occ=
urrence rate; I am still seeing hangs with it set to 2.
> >
> > Martin
> >
> >
> >
> > From: Roberts, Martin
> > Sent: Wednesday, June 7, 2023 3:46 PM
> > To: Suwan Kim <suwan.kim027@gmail.com>
> > Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundati=
on.org>; linux-block@vger.kernel.org
> > Subject: RE: virtio-blk: support completion batching for the IRQ path -=
 failure
> >
> >
> >
> > It is the change indicated that breaks it - changing the IRQ handling t=
o batching.
> >
> >
> >
> >
> >
> >
> >
> > From reports such as,
> >
> > [PATCH 1/1] blk-mq: added case for cpu offline during send_ipi in rq_co=
mplete (kernel.org)
> >
> > [RFC] blk-mq: Don't IPI requests on PREEMPT_RT - Patchwork (linaro.org)
> >
> >
> >
> > I=E2=80=99m thinking the issue has something to do with which CPU the I=
RQ is running on.
> >
> >
> >
> > So, I set,
> >
> > # echo 2 > /sys/block/vda/queue/rq_affinity
> >
> > # echo 2 > /sys/block/vdb/queue/rq_affinity
> >
> > =E2=80=A6
> >
> > # echo 2 > /sys/block/vdp/queue/rq_affinity
> >
> >
> >
> >
> >
> > and the system (running 16 disks, 4 queues/disk) has not yet hung (runn=
ing OK for several hours)=E2=80=A6
> >
> >
> >
> > Martin
> >
> >
> >
> > -----Original Message-----
> > From: Suwan Kim <suwan.kim027@gmail.com>
> > Sent: Wednesday, June 7, 2023 3:21 PM
> > To: Roberts, Martin <martin.roberts@intel.com>
> > Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundati=
on.org>; linux-block@vger.kernel.org
> > Subject: Re: virtio-blk: support completion batching for the IRQ path -=
 failure
> >
> >
> >
> > On Wed, Jun 7, 2023 at 6:14=E2=80=AFPM Roberts, Martin <martin.roberts@=
intel.com> wrote:
> >
> > >
> >
> > > Re: virtio-blk: support completion batching for the IRQ path =C2=B7 t=
orvalds/linux@07b679f =C2=B7 GitHub
> >
> > >
> >
> > > Signed-off-by: Suwan Kim suwan.kim027@gmail.com
> >
> > >
> >
> > > Signed-off-by: Michael S. Tsirkin mst@redhat.com
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > > This change appears to have broken things=E2=80=A6
> >
> > >
> >
> > > We now see applications hanging during disk accesses.
> >
> > >
> >
> > > e.g.
> >
> > >
> >
> > > multi-port virtio-blk device running in h/w (FPGA)
> >
> > >
> >
> > > Host running a simple =E2=80=98fio=E2=80=98 test.
> >
> > >
> >
> > > [global]
> >
> > >
> >
> > > thread=3D1
> >
> > >
> >
> > > direct=3D1
> >
> > >
> >
> > > ioengine=3Dlibaio
> >
> > >
> >
> > > norandommap=3D1
> >
> > >
> >
> > > group_reporting=3D1
> >
> > >
> >
> > > bs=3D4K
> >
> > >
> >
> > > rw=3Dread
> >
> > >
> >
> > > iodepth=3D128
> >
> > >
> >
> > > runtime=3D1
> >
> > >
> >
> > > numjobs=3D4
> >
> > >
> >
> > > time_based
> >
> > >
> >
> > > [job0]
> >
> > >
> >
> > > filename=3D/dev/vda
> >
> > >
> >
> > > [job1]
> >
> > >
> >
> > > filename=3D/dev/vdb
> >
> > >
> >
> > > [job2]
> >
> > >
> >
> > > filename=3D/dev/vdc
> >
> > >
> >
> > > ...
> >
> > >
> >
> > > [job15]
> >
> > >
> >
> > > filename=3D/dev/vdp
> >
> > >
> >
> > >
> >
> > >
> >
> > > i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
> >
> > >
> >
> > > This is repeatedly run in a loop.
> >
> > >
> >
> > >
> >
> > >
> >
> > > After a few, normally <10 seconds, fio hangs.
> >
> > >
> >
> > > With 64 queues (16 disks), failure occurs within a few seconds; with =
8 queues (2 disks) it may take ~hour before hanging.
> >
> > >
> >
> > > Last message:
> >
> > >
> >
> > > fio-3.19
> >
> > >
> >
> > > Starting 8 threads
> >
> > >
> >
> > > Jobs: 1 (f=3D1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
> >
> > >
> >
> > > I think this means at the end of the run 1 queue was left incomplete.
> >
> > >
> >
> > >
> >
> > >
> >
> > > =E2=80=98diskstats=E2=80=99 (run while fio is hung) shows no outstand=
ing transactions.
> >
> > >
> >
> > > e.g.
> >
> > >
> >
> > > $ cat /proc/diskstats
> >
> > >
> >
> > > ...
> >
> > >
> >
> > > 252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 =
712568645 0 0 0 0 0 0
> >
> > >
> >
> > > 252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 =
704905623 0 0 0 0 0 0
> >
> > >
> >
> > > ...
> >
> > >
> >
> > >
> >
> > >
> >
> > > Other stats (in the h/w, and added to the virtio-blk driver ([a]virti=
o_queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree=
, and show every request had a completion, and that virtblk_request_done() =
never gets called.
> >
> > >
> >
> > > e.g.
> >
> > >
> >
> > > PF=3D 0                         vq=3D0           1           2       =
    3
> >
> > >
> >
> > > [a]request_count     -   839416590   813148916   105586179    8498812=
3
> >
> > >
> >
> > > [b]completion1_count -   839416590   813148916   105586179    8498812=
3
> >
> > >
> >
> > > [c]completion2_count -           0           0           0           =
0
> >
> > >
> >
> > >
> >
> > >
> >
> > > PF=3D 1                         vq=3D0           1           2       =
    3
> >
> > >
> >
> > > [a]request_count     -   823335887   812516140   104582672    7585654=
9
> >
> > >
> >
> > > [b]completion1_count -   823335887   812516140   104582672    7585654=
9
> >
> > >
> >
> > > [c]completion2_count -           0           0           0           =
0
> >
> > >
> >
> > >
> >
> > >
> >
> > > i.e. the issue is after the virtio-blk driver.
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > > This change was introduced in kernel 6.3.0.
> >
> > >
> >
> > > I am seeing this using 6.3.3.
> >
> > >
> >
> > > If I run with an earlier kernel (5.15), it does not occur.
> >
> > >
> >
> > > If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the =
blk_mq_add_to_batch()call, it does not fail.
> >
> > >
> >
> > > e.g.
> >
> > >
> >
> > > kernel 5.15 =E2=80=93 this is OK
> >
> > >
> >
> > > virtio_blk.c,virtblk_done() [irq handler]
> >
> > >
> >
> > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> >
> > >
> >
> > >                           blk_mq_complete_request(req);
> >
> > >
> >
> > >                  }
> >
> > >
> >
> > >
> >
> > >
> >
> > > kernel 6.3.3 =E2=80=93 this fails
> >
> > >
> >
> > > virtio_blk.c,virtblk_handle_req() [irq handler]
> >
> > >
> >
> > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> >
> > >
> >
> > >                           if (!blk_mq_complete_request_remote(req)) {
> >
> > >
> >
> > >                                   if (!blk_mq_add_to_batch(req, iob, =
virtblk_vbr_status(vbr), virtblk_complete_batch)) {
> >
> > >
> >
> > >                                            virtblk_request_done(req);=
    //this never gets called... so blk_mq_add_to_batch() must always succee=
d
> >
> > >
> >
> > >                                    }
> >
> > >
> >
> > >                           }
> >
> > >
> >
> > >                  }
> >
> > >
> >
> > >
> >
> > >
> >
> > > If I do, kernel 6.3.3 =E2=80=93 this is OK
> >
> > >
> >
> > > virtio_blk.c,virtblk_handle_req() [irq handler]
> >
> > >
> >
> > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> >
> > >
> >
> > >                           if (!blk_mq_complete_request_remote(req)) {
> >
> > >
> >
> > >                                    virtblk_request_done(req); //force=
 this here...
> >
> > >
> >
> > >                                   if (!blk_mq_add_to_batch(req, iob, =
virtblk_vbr_status(vbr), virtblk_complete_batch)) {
> >
> > >
> >
> > >                                            virtblk_request_done(req);=
    //this never gets called... so blk_mq_add_to_batch() must always succee=
d
> >
> > >
> >
> > >                                    }
> >
> > >
> >
> > >                           }
> >
> > >
> >
> > >                  }
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > > Perhaps you might like to fix/test/revert this change=E2=80=A6
> >
> > >
> >
> > > Martin
> >
> > >
> >
> > >
> >
> >
> >
> > Hi Martin,
> >
> >
> >
> > There are many changes between 6.3.0 and 6.3.3.
> >
> > Could you try to find a commit which triggers the io hang?
> >
> > Is it ok with 6.3.0 kernel or with reverting
> >
> > "virtio-blk: support completion batching for the IRQ path" commit?
> >
> >
> >
> > We need to confirm which commit is causing the error.
> >
> >
> >
> > Regards,
> >
> > Suwan Kim
