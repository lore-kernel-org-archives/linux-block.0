Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34309 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 08:19:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so10986546ljk.1
        for <linux-block@vger.kernel.org>; Mon, 20 Aug 2018 02:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
 <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com> <20180820083032.GA24522@ming.t460p>
In-Reply-To: <20180820083032.GA24522@ming.t460p>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 20 Aug 2018 11:04:08 +0200
Message-ID: <CAPybu_3QT_qTojTUXFhJFQKVsbhnWUmvyQ0zb5MwDJ5hsECf=A@mail.gmail.com>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
To: ming.lei@redhat.com
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Ming
On Mon, Aug 20, 2018 at 10:30 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Aug 20, 2018 at 09:39:45AM +0200, Ricardo Ribalda Delgado wrote:
> > Some measurements:
> >
> > Please note that even when iostat shows 0.0 the LED on the device was
> > blinking as if there was some activity going on.
> >
> > Thanks!
> >
> > KERNEL:
> > Linux neopili 4.17.0-1-amd64 #1 SMP Debian 4.17.8-1 (2018-07-20)
> > x86_64 GNU/Linux
> >
> > DISK:
> > [247530.712686] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
> > [247530.738906] usb 2-2: New USB device found, idVendor=174c,
> > idProduct=5136, bcdDevice= 1.00
> > [247530.738913] usb 2-2: New USB device strings: Mfr=2, Product=3,
> > SerialNumber=1
> > [247530.738918] usb 2-2: Product: 91686
> > [247530.738921] usb 2-2: Manufacturer: Delock
> > [247530.738925] usb 2-2: SerialNumber: 300000003B45
> > [247530.750709] scsi host6: uas
> > [247530.751377] scsi 6:0:0:0: Direct-Access     ASMT     2105
> >    0    PQ: 0 ANSI: 6
> > [247530.752174] sd 6:0:0:0: Attached scsi generic sg2 type 0
> > [247530.752616] sd 6:0:0:0: [sdb] 31277232 512-byte logical blocks:
> > (16.0 GB/14.9 GiB)
> > [247530.752740] sd 6:0:0:0: [sdb] Write Protect is off
> > [247530.752742] sd 6:0:0:0: [sdb] Mode Sense: 43 00 00 00
> > [247530.752905] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
> > enabled, doesn't support DPO or FUA
> > [247530.755912]  sdb: sdb1 sdb2
> > [247530.756832] sd 6:0:0:0: [sdb] Attached SCSI disk
> >
> >
> > TL/DR:
> > CFQ: 21.7
> > NOOP: 21.7
> > DEADLINE: 21.7
> > MQ-DEADLINE: 175.2
> > NONE: 236.4
> > KYBER: 174.9
>
> Thanks for your test!
>
> One problem found from your iostat log is that looks there is ~30sec
> idle period between IO activities when blk-mq is enabled.

During all the test the LED on the device was blinking.

But a closer look to dmesg reveals a lot of this messages:

[  196.929811] sd 6:0:0:0: [sdb] tag#3 data cmplt err -71 uas-tag 1
inflight: CMD
[  196.929822] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
68 00 04 00 00
[  227.764379] sd 6:0:0:0: [sdb] tag#4 uas_eh_abort_handler 0 uas-tag
2 inflight: CMD OUT
[  227.764389] sd 6:0:0:0: [sdb] tag#4 CDB: Write(10) 2a 00 00 04 04
68 00 04 00 00
[  227.766555] sd 6:0:0:0: [sdb] tag#3 uas_eh_abort_handler 0 uas-tag
1 inflight: CMD
[  227.766562] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
68 00 04 00 00
[  227.784312] scsi host6: uas_eh_device_reset_handler start
[  227.913672] usb 2-2: reset SuperSpeed USB device number 3 using xhci_hcd
[  227.944842] scsi host6: uas_eh_device_reset_handler success
[  231.416133] sd 6:0:0:0: [sdb] tag#1 data cmplt err -71 uas-tag 10
inflight: CMD
[  231.416147] sd 6:0:0:0: [sdb] tag#1 CDB: Write(10) 2a 00 00 06 d5
e8 00 04 00 00

And they take around 30 secons (227-196)


Maybe this is a hw issue? I will bring the reader home tonight and see
if I can replicate the bug with my notebook

>
> Maybe it is related with timeout, given we had big change in v4.17 timeout code,
> and we also fixed one scsi_mq timeout related issue recently, and the patch[1] has
> been merged to v4.18 release already.

I tried with v4.18-rc4 (latest one packaged in debian experimental)
and after 3 runs, 2 were fine (27 sec), but the last one was over a
minute.



Thanks!



>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d5ba0e2de24ec87636244a01d4e78d095cc1b20
>
> So could you test v4.18 and see if there is such issue?
>
> BTW, I have run the same test on usb-storage, and can't reproduce it.
> However you are using UAS, and I don't have it at hand, so can't
> reproduce it completely.
>
> Thanks,
> Ming



--
Ricardo Ribalda
