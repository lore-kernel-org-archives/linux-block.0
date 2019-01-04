Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02750C43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 07:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC84D21871
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 07:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecpwhHWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfADHd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:33:59 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:44272 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfADHd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 02:33:59 -0500
Received: by mail-ua1-f54.google.com with SMTP id d19so11721851uaq.11;
        Thu, 03 Jan 2019 23:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoN7mnUDJXFg+XNU8hfN4dgzR17qUuCjUvFrl6KrO5M=;
        b=ecpwhHWFo4gwZRz3cRuYi0tz31Acw7JRwb79KCsna84iBkWva+Qz7ZUFei6pfYQBk7
         Gn7wxeRKDsyxhefDY9nwxeNU84pjgTqqbRIMAk/fb3x5/yakuQp79kz4ui5GaWPtMp8/
         D2a7jP1glGYP/s8IQhgp0z6JhKXFqC5Wml1ui5Ltx0KjEgYiJNmkyJFAjqNuLdArCEDC
         TEEcI+4aD5vJkAqwuWPr1P+NpFyvcrp7gZuk7MWPXlf6GKSCLCXCOj5fnQQavKhvasv7
         O/Ml1Daz7PPWZzYxdHVk5Ni1bdd6c20Ehj6YDw4Yi3U5DAFFH2IPN4CbqnGE8QidSXon
         jxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoN7mnUDJXFg+XNU8hfN4dgzR17qUuCjUvFrl6KrO5M=;
        b=sfaC1EZxAT/s8LgvfYvqZS6maiyhZUbxcolvQN7p1AL3yB4BZ/Xvy7617ZYtfRy+cp
         Xilv/3EeUjbJbX4oT9KPcp2UaLNSco0z2HB4lQ/jtTiXdkJNdctSq2/Vc0+fq0kpmKL1
         Jeir6Y6rBiuDBj2G89Z0ook4+JmefQH+Tmld8OOq0Ld9rPhWhES+EKAIds3KxN3dbrXu
         PP2CDff559GxZ6ZXlRYd05dIrN492TFqKj1x3MJ+Ec9VRfY5udKuDjIEEwxs5CnGabb6
         I6D5aCoTDk3MbyihpBX3DJWFRjd1JvJr3iouCpenvBbnhe9YNuL5BtxezI417ycudjQH
         5fGw==
X-Gm-Message-State: AJcUukeVF6oIoAugTE5AzoI+XuO26jSvwjuXSaMWcEy3tBm7V7mUf1+t
        SlqeohC2agawTPPFwS1825DD/+x5nFO1hwelg9k=
X-Google-Smtp-Source: ALg8bN4RWJLl/82NdF3JjDWJHWA0ndYc3naTH8nll2E+LB07/6O8YyPOG4Je1YXNf0Rz6TWes0wpMiepFmEx6JflD0s=
X-Received: by 2002:ab0:740a:: with SMTP id r10mr17481534uap.14.1546587237106;
 Thu, 03 Jan 2019 23:33:57 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
 <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
 <1546445424.29282.1.camel@redhat.com> <1546540117.24199.0.camel@redhat.com>
 <1546548458.24199.2.camel@redhat.com> <CALjAwxhOb_HLD1Adux-n0LUienLK_FhrOnyBw=UMLj49aN6_5A@mail.gmail.com>
 <1546555220.2666.1.camel@redhat.com>
In-Reply-To: <1546555220.2666.1.camel@redhat.com>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Fri, 4 Jan 2019 07:33:38 +0000
Message-ID: <CALjAwxgtCGLEJkV3xw4Amp4gdkuacgmTVkYn=w8ZHucJ6ffDew@mail.gmail.com>
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
To:     Laurence Oberman <loberman@redhat.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Blimey Laurence - you're really pushing the boat out on this one!

On Thu, 3 Jan 2019 at 22:40, Laurence Oberman <loberman@redhat.com> wrote:
>
> On Thu, 2019-01-03 at 22:24 +0000, Sitsofe Wheeler wrote:
> > Hi,
> >
> > On Thu, 3 Jan 2019 at 20:47, Laurence Oberman <loberman@redhat.com>
> > wrote:
> > >
> > > Hello
> > >
> > > I put the 860 in an enclosure (MSA50) driven by a SAS HBA
> > > (megaraid)sas)
> > >
> > > The backplane is SAS or SATA
> > >
> > > /dev/sg2  0 0 49 0  0  /dev/sdb  ATA       Samsung SSD 860   1B6Q
> > >
> > > Running the same fio test of yours on latest RHEL7 and 4.20.0+-1 I
> > > am
> > > unable to reproduce this issue of yours after multiple test runs.
> > >
> > > Tests all run to completion with no errors on RHEL7 and upstream
> > > kernels.
> > >
> > > I have no way to test at the moment with a direct motherboard
> > > connection to a SATA port so if this is a host side issue with sata
> > > (ATA) I would not see it.
> > >
> > > What this likely means is that the drive itself seems to be well
> > > behaved here and the power or cable issue I alluded to earlier may
> > > be
> > > worth looking into for you or possibly the host ATA interface.
> > >
> > > RHEL7 kernel
> > > 3.10.0-862.11.1.el7.x86_64
> >
> > Thanks for going the extra mile on this Laurence - it does sound like
> > whatever issue I'm seeing with the 860 EVO is local to my box. It's
> > curious that others are seeing something similar (e.g.
> > https://github.com/zfsonlinux/zfs/issues/4873#issuecomment-449798356
> > )
> > but maybe they're in the same boat as me.
> >
> > > test: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W) 32.0KiB-
> > > 32.0KiB,
> > > (T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=32
> > > fio-3.3-38-gf5ec8
> > > Starting 1 process
> > > Jobs: 1 (f=1): [r(1)][100.0%][r=120MiB/s,w=0KiB/s][r=3839,w=0
> > > IOPS][eta
> > > 00m:00s]
> > > test: (groupid=0, jobs=1): err= 0: pid=3974: Thu Jan  3 15:14:10
> > > 2019
> > >    read: IOPS=3827, BW=120MiB/s (125MB/s)(70.1GiB/600009msec)
> > >     slat (usec): min=7, max=374, avg=23.78, stdev= 6.09
> > >     clat (usec): min=449, max=509311, avg=8330.29, stdev=2060.29
> > >      lat (usec): min=514, max=509331, avg=8355.00, stdev=2060.29
> > >     clat percentiles (usec):
> > >      |  1.00th=[ 5342],  5.00th=[ 7767], 10.00th=[ 8225], 20.00th=[
> > > 8291],
> > >      | 30.00th=[ 8291], 40.00th=[ 8291], 50.00th=[ 8291], 60.00th=[
> > > 8291],
> > >      | 70.00th=[ 8356], 80.00th=[ 8356], 90.00th=[ 8455], 95.00th=[
> > > 8848],
> > >      | 99.00th=[11600], 99.50th=[13042], 99.90th=[16581],
> > > 99.95th=[17695],
> > >      | 99.99th=[19006]
> > >    bw (  KiB/s): min=50560, max=124472, per=99.94%, avg=122409.89,
> > > stdev=2592.08, samples=1200
> > >    iops        : min= 1580, max= 3889, avg=3825.22, stdev=81.01,
> > > samples=1200
> > >   lat (usec)   : 500=0.01%, 750=0.03%, 1000=0.02%
> > >   lat (msec)   : 2=0.08%, 4=0.32%, 10=97.20%, 20=2.34%, 50=0.01%
> > >   lat (msec)   : 750=0.01%
> > >   cpu          : usr=4.76%, sys=12.81%, ctx=2113947, majf=0,
> > > minf=14437
> > >   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%,
> > > 32=100.0%,
> > > > =64=0.0%
> > >
> > >      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%,
> > > 64=0.0%,
> > > > =64=0.0%
> > >
> > >      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%,
> > > 64=0.0%,
> > > > =64=0.0%
> > >
> > >      issued rwts: total=2296574,0,0,0 short=0,0,0,0 dropped=0,0,0,0
> > >      latency   : target=0, window=0, percentile=100.00%, depth=32
> > >
> > > Run status group 0 (all jobs):
> > >    READ: bw=120MiB/s (125MB/s), 120MiB/s-120MiB/s (125MB/s-
> > > 125MB/s),
> > > io=70.1GiB (75.3GB), run=600009-600009msecmodinfo ata
> > >
> > > Disk stats (read/write):
> > >   sdb: ios=2295763/0, merge=0/0, ticks=18786069/0,
> > > in_queue=18784356,
> > > util=100.00%
> >
> > For what it's worth, the speeds I see with NCQ off on the Samsung 860
> > EVO are not far off what you're reporting (but are much lower than
> > those I see on the MX500 in the same machine). I suppose it could
> > just
> > be the MX500 is simply a better performing SSD for the specific
> > workload I have been testing...
> >
> > --
> > Sitsofe | http://sucs.org/~sits/
>
> Hello Sitsofe
>
> I am going to try tomorrow on a motherboard direct connection.
> My testing was with no flags to libata, but of course ATA is hidden
> host wise in my test as I am going via megaraid_sas to the MSA50 shelf.
>
> Are you using 32k blocks on the MX500 as well, is that 12gbit or 6gbit
> SAS (The MX500)
> Was it the same read tests via fio.

Yes I'm using 32k blocks on the MX500 as well:
# Samsung 860 EVO (with NCQ disabled)
# fio --readonly --name=test --rw=randread --filename \
 $(readlink -f /dev/disk/by-id/ata-Samsung_SSD_860_EVO_500GB_XXXXXXXXXXXXXXX) \
 --bs=32k --ioengine=libaio --iodepth=32 --direct=1 --runtime=60s \
 --time_based=1
test: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W) 32.0KiB-32.0KiB,
(T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=32
fio-3.1
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=107MiB/s,w=0KiB/s][r=3410,w=0 IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3671: Fri Jan  4 07:21:20 2019
   read: IOPS=3098, BW=96.8MiB/s (102MB/s)(5811MiB/60010msec)
    slat (usec): min=9, max=1398, avg=47.83, stdev=12.78
    clat (usec): min=384, max=69747, avg=10262.24, stdev=5722.72
     lat (usec): min=398, max=69798, avg=10311.27, stdev=5723.76
    clat percentiles (usec):
     |  1.00th=[  881],  5.00th=[ 1663], 10.00th=[ 2606], 20.00th=[ 4490],
     | 30.00th=[ 6390], 40.00th=[ 8225], 50.00th=[10159], 60.00th=[11994],
     | 70.00th=[13829], 80.00th=[15664], 90.00th=[17957], 95.00th=[19530],
     | 99.00th=[22152], 99.50th=[23200], 99.90th=[28967], 99.95th=[35390],
     | 99.99th=[58459]
   bw (  KiB/s): min=84032, max=111104, per=100.00%, avg=99154.29,
stdev=5994.62, samples=120
   iops        : min= 2626, max= 3472, avg=3098.57, stdev=187.33, samples=120
  lat (usec)   : 500=0.09%, 750=0.46%, 1000=0.95%
  lat (msec)   : 2=5.26%, 4=10.53%, 10=32.09%, 20=46.96%, 50=3.65%
  lat (msec)   : 100=0.02%
  cpu          : usr=9.95%, sys=26.29%, ctx=186005, majf=0, minf=266
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued rwt: total=185941,0,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: bw=96.8MiB/s (102MB/s), 96.8MiB/s-96.8MiB/s
(102MB/s-102MB/s), io=5811MiB (6093MB), run=60010-60010msec

Disk stats (read/write):
  sdb: ios=185497/86, merge=2/46, ticks=1893688/4600,
in_queue=1898360, util=99.92%

# Crucial MX500
# test: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W)
32.0KiB-32.0KiB, (T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=32
fio-3.1
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=249MiB/s,w=0KiB/s][r=7964,w=0 IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3684: Fri Jan  4 07:24:29 2019
   read: IOPS=7958, BW=249MiB/s (261MB/s)(14.6GiB/60004msec)
    slat (usec): min=8, max=781, avg=39.09, stdev=26.28
    clat (usec): min=351, max=11790, avg=3971.78, stdev=850.49
     lat (usec): min=418, max=11805, avg=4011.70, stdev=849.55
    clat percentiles (usec):
     |  1.00th=[ 2540],  5.00th=[ 2900], 10.00th=[ 3097], 20.00th=[ 3359],
     | 30.00th=[ 3556], 40.00th=[ 3720], 50.00th=[ 3884], 60.00th=[ 4015],
     | 70.00th=[ 4178], 80.00th=[ 4424], 90.00th=[ 4686], 95.00th=[ 5211],
     | 99.00th=[ 7177], 99.50th=[ 7308], 99.90th=[ 7701], 99.95th=[ 7832],
     | 99.99th=[ 8029]
   bw (  KiB/s): min=249856, max=255872, per=100.00%, avg=254709.22,
stdev=592.04, samples=120
   iops        : min= 7808, max= 7996, avg=7959.62, stdev=18.49, samples=120
  lat (usec)   : 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.07%, 4=58.38%, 10=41.54%, 20=0.01%
  cpu          : usr=13.17%, sys=45.78%, ctx=278702, majf=0, minf=265
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued rwt: total=477571,0,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: bw=249MiB/s (261MB/s), 249MiB/s-249MiB/s (261MB/s-261MB/s),
io=14.6GiB (15.6GB), run=60004-60004msec

Disk stats (read/write):
  sda: ios=476506/5, merge=0/1, ticks=1876020/136, in_queue=1875680, util=99.91%

I've yet to attach the disk directly to the mobo. It's a bit fiddly as
the most accessible port is meant for the DVD drive and I think it's
speed is slower than the others.

The speed of the ATA ports is lower than you might expect (this
machine is fairly old):

[    2.725849] ahci 0000:00:11.0: version 3.0
[    2.726434] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 3
Gbps 0xf impl SATA mode
[    2.726439] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led
clo pmp pio slum part
[    2.734592] scsi host0: ahci
[    2.741769] scsi host1: ahci
[    2.747197] scsi host2: ahci
[    2.752589] scsi host3: ahci
[    2.752731] ata1: SATA max UDMA/133 abar m1024@0xfe6ffc00 port
0xfe6ffd00 irq 25
[    2.752735] ata2: SATA max UDMA/133 abar m1024@0xfe6ffc00 port
0xfe6ffd80 irq 25
[    2.752739] ata3: SATA max UDMA/133 abar m1024@0xfe6ffc00 port
0xfe6ffe00 irq 25
[    2.752742] ata4: SATA max UDMA/133 abar m1024@0xfe6ffc00 port
0xfe6ffe80 irq 25
[...]
[    3.228107] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.228941] ata1.00: supports DRM functions and may not be fully accessible
[    3.228979] ata1.00: ATA-10: CT500MX500SSD1, M3CR023, max UDMA/133
[    3.228982] ata1.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    3.229920] ata1.00: supports DRM functions and may not be fully accessible
[    3.230705] ata1.00: configured for UDMA/133
[    3.231082] scsi 0:0:0:0: Direct-Access     ATA      CT500MX500SSD1
  023  PQ: 0 ANSI: 5
[    3.231546] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.231767] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    3.231770] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    3.231790] sd 0:0:0:0: [sda] Write Protect is off
[    3.231793] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.231826] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    3.232091] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.233529]  sda: sda1 sda2 sda3
[    3.236030] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.236057] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.236617] ata4.00: ATA-9: WDC WD20EZRX-00D8PB0, 80.00A80, max UDMA/133
[    3.236620] ata4.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    3.236843] ata3.00: ATA-9: ST2000DM001-1CH164, CC29, max UDMA/133
[    3.236846] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    3.237178] ata4.00: configured for UDMA/133
[    3.237669] ata3.00: configured for UDMA/133
[    3.240132] sd 0:0:0:0: [sda] supports TCG Opal
[    3.240136] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.242623] ata2.00: FORCE: horkage modified (noncq)
[    3.242683] ata2.00: supports DRM functions and may not be fully accessible
[    3.242686] ata2.00: ATA-11: Samsung SSD 860 EVO 500GB, RVT01B6Q,
max UDMA/133
[    3.242689] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (not used)
[    3.245518] ata2.00: supports DRM functions and may not be fully accessible
[    3.247611] ata2.00: configured for UDMA/133
[    3.247915] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD
860  1B6Q PQ: 0 ANSI: 5
[    3.248390] ata2.00: Enabling discard_zeroes_data
[    3.248493] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    3.248514] sd 1:0:0:0: [sdb] Write Protect is off
[    3.248517] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    3.248551] sd 1:0:0:0: [sdb] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    3.248777] ata2.00: Enabling discard_zeroes_data
[    3.249093] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    3.249398] scsi 2:0:0:0: Direct-Access     ATA
ST2000DM001-1CH1 CC29 PQ: 0 ANSI: 5
[    3.249649] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    3.250007] scsi 3:0:0:0: Direct-Access     ATA      WDC
WD20EZRX-00D 0A80 PQ: 0 ANSI: 5
[    3.250266] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    3.250477] sd 2:0:0:0: [sdc] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    3.250480] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[    3.250512] sd 2:0:0:0: [sdc] Write Protect is off
[    3.250514] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    3.250586] sd 2:0:0:0: [sdc] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    3.250619] sd 3:0:0:0: [sdd] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    3.250622] sd 3:0:0:0: [sdd] 4096-byte physical blocks
[    3.250739] sd 3:0:0:0: [sdd] Write Protect is off
[    3.250741] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    3.250811] sd 3:0:0:0: [sdd] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    3.254586]  sdb: sdb1 sdb2 sdb3 sdb4
[    3.255158] ata2.00: Enabling discard_zeroes_data
[    3.257058] sd 1:0:0:0: [sdb] supports TCG Opal
[    3.257063] sd 1:0:0:0: [sdb] Attached SCSI disk
[    3.274972]  sdd: sdd1
[    3.275532] sd 3:0:0:0: [sdd] Attached SCSI disk
[    3.276090]  sdc: sdc1
[    3.276548] sd 2:0:0:0: [sdc] Attached SCSI disk

--
Sitsofe | http://sucs.org/~sits/
