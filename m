Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B13C43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 20:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783792184B
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfACUrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:47:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41100 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfACUrl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jan 2019 15:47:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so38280869qtf.8
        for <linux-block@vger.kernel.org>; Thu, 03 Jan 2019 12:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8VdEgY7zvf3tXCvEMJdGPvXoTWIfGWHPIu9ch0jg80=;
        b=mMDkRDaZehx4UPYmI47TE3YwHQxxstHyHowVXHz6+GRHPH6bIwGYJGSWUrA2zoSmVu
         O9Wd+eeS8Ck+wHeQXgw/axpTQi6ZYVVRT8BZTDqM38Mf6eGUQI5gEHwZAEfO0u93d1Av
         +x1TBxuGgNilQ5BhEOK99F89Z2VkUk+e9YrdNb++QEBZUhCoOwmaozGJWG2HILow6K3d
         TN+h1pvp3iKIEt4x3NRnasRXjGHiSGWStop8JrXnWIbgNZ7dizLo7WSUheNolfIId8rH
         SwUl4ZqSoLp3RVMm0LVcHtACfyx7CaNu/PXizVqbxyQeh/jUlFElRPZ8Wz3RzDopy718
         jY5Q==
X-Gm-Message-State: AA+aEWY6deVMK0oxkPZIFeMi3ruel3AKehmnH0jOd+oZVNdVvoSxohOH
        aXVYP4pck8BhJtA/deRf5hyh+g==
X-Google-Smtp-Source: AFSGD/WU/Wj0/xnCKzS2LHerA5xQiUMGERntCFZS/jDiN7GrFQrNGDYo/MhloPRsfCVNRfxGp1dwrQ==
X-Received: by 2002:ac8:7353:: with SMTP id q19mr46865383qtp.265.1546548459620;
        Thu, 03 Jan 2019 12:47:39 -0800 (PST)
Received: from 2600-6c64-4e80-00f1-56ee-75ff-fe93-2951.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-56ee-75ff-fe93-2951.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:56ee:75ff:fe93:2951])
        by smtp.gmail.com with ESMTPSA id o34sm24349387qte.4.2019.01.03.12.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 12:47:38 -0800 (PST)
Message-ID: <1546548458.24199.2.camel@redhat.com>
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
From:   Laurence Oberman <loberman@redhat.com>
To:     Sitsofe Wheeler <sitsofe@gmail.com>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Date:   Thu, 03 Jan 2019 15:47:38 -0500
In-Reply-To: <1546540117.24199.0.camel@redhat.com>
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
         <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
         <1546445424.29282.1.camel@redhat.com> <1546540117.24199.0.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-01-03 at 13:28 -0500, Laurence Oberman wrote:
> On Wed, 2019-01-02 at 11:10 -0500, Laurence Oberman wrote:
> > On Wed, 2019-01-02 at 15:29 +0000, Sitsofe Wheeler wrote:
> > > (Also trying linux-ide list)
> > > 
> > > On Wed, 2 Jan 2019 at 15:25, Sitsofe Wheeler <sitsofe@gmail.com>
> > > wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I recently purchased a SATA Samsung 860 EVO SSD and put it in
> > > > an
> > > > old
> > > > HP microserver (which has an AMD N36L). By default, when the
> > > > disk
> > > > load
> > > > becomes a little heavy e.g. by running a job like
> > > > 
> > > > fio --name=test --readonly --rw=randread --filename /dev/sdb --
> > > > bs=32k \
> > > >     --ioengine=libaio --iodepth=32 --direct=1 --runtime=10m --
> > > > time_based=1
> > > > 
> > > > the kernel starts repeatedly producing error messages like:
> > > > 
> > > > [ 1177.729912] ata2.00: exception Emask 0x10 SAct 0x3c000 SErr
> > > > 0x0
> > > > action 0x6 frozen
> > > > [ 1177.729931] ata2.00: irq_stat 0x08000000, interface fatal
> > > > error
> > > > [ 1177.729943] ata2.00: failed command: WRITE FPDMA QUEUED
> > > > [ 1177.729962] ata2.00: cmd 61/80:70:80:50:e6/06:00:00:00:00/40
> > > > tag
> > > > 14
> > > > ncq dma 851968 out
> > > > [ 1177.729962]          res 40/00:80:00:5a:e6/00:00:00:00:00/40
> > > > Emask
> > > > 0x10 (ATA bus error)
> > > > [ 1177.729978] ata2.00: status: { DRDY }
> > > > [ 1177.729986] ata2.00: failed command: WRITE FPDMA QUEUED
> > > > [ 1177.730002] ata2.00: cmd 61/00:78:00:57:e6/03:00:00:00:00/40
> > > > tag
> > > > 15
> > > > ncq dma 393216 out
> > > > [ 1177.730002]          res 40/00:80:00:5a:e6/00:00:00:00:00/40
> > > > Emask
> > > > 0x10 (ATA bus error)
> > > > [ 1177.730017] ata2.00: status: { DRDY }
> > > > [ 1177.730024] ata2.00: failed command: WRITE FPDMA QUEUED
> > > > [ 1177.730039] ata2.00: cmd 61/00:80:00:5a:e6/05:00:00:00:00/40
> > > > tag
> > > > 16
> > > > ncq dma 655360 out
> > > > [ 1177.730039]          res 40/00:80:00:5a:e6/00:00:00:00:00/40
> > > > Emask
> > > > 0x10 (ATA bus error)
> > > > [ 1177.730053] ata2.00: status: { DRDY }
> > > > [ 1177.730060] ata2.00: failed command: WRITE FPDMA QUEUED
> > > > [ 1177.730078] ata2.00: cmd 61/00:88:00:5f:e6/01:00:00:00:00/40
> > > > tag
> > > > 17
> > > > ncq dma 131072 out
> > > > [ 1177.730078]          res 40/00:80:00:5a:e6/00:00:00:00:00/40
> > > > Emask
> > > > 0x10 (ATA bus error)
> > > > [ 1177.730096] ata2.00: status: { DRDY }
> > > > [ 1177.730108] ata2: hard resetting link
> > > > [ 1178.205831] ata2: SATA link up 3.0 Gbps (SStatus 123
> > > > SControl
> > > > 300)
> > > > [ 1178.206165] ata2.00: supports DRM functions and may not be
> > > > fully
> > > > accessible
> > > > [ 1178.209743] ata2.00: supports DRM functions and may not be
> > > > fully
> > > > accessible
> > > > [ 1178.212786] ata2.00: configured for UDMA/133
> > > > [ 1178.212826] ata2: EH complete
> > > > [ 1178.212988] ata2.00: Enabling discard_zeroes_data
> > > > 
> > > > I tried moving the SSD to another caddy and bay but the issue
> > > > persists. None of the regular hard disks (a Western Digital and
> > > > a
> > > > Seagate) nor the other SSD (a Crucial MX500) already in the
> > > > system
> > > > trigger the issue the Samsung 860 EVO does. Adding
> > > > 
> > > > libata.force=2.00:noncq
> > > > 
> > > > seems to make the issue go away but seemingly at some speed
> > > > cost
> > > > (at
> > > > least compared to what the MX500 achieves). The OS in use is
> > > > Ubuntu
> > > > 18.04 with a 4.15.0-43-generic kernel but even a 4.18.0-13-
> > > > generic
> > > > had
> > > > the same issue.
> > > > 
> > > > Is there anything software-wise that might need investigating
> > > > that
> > > > would allow NCQ to work and a better speed to be reached?
> > > 
> > > 
> > 
> > Hello 
> > 
> > I have seen issues reported due to low power delivery to the drive.
> > However investigating this, its starts with an exception Emask and
> > then
> > the link error code runs.
> > Reviewing online some folks are reporting cable issues can cause
> > this
> > or firmware.
> > I don't have one to test myself, and you are using an enclosure.
> > Are
> > you able to connect direct to the motherboard via another cable and
> > test again.
> > 
> > Regards
> > Laurence
> 
> I managed to find a 860 so going to test it and see if I see the same
> behavior and report back
> 
> Thanks
> Laurence

Hello

I put the 860 in an enclosure (MSA50) driven by a SAS HBA
(megaraid)sas)

The backplane is SAS or SATA

/dev/sg2  0 0 49 0  0  /dev/sdb  ATA       Samsung SSD 860   1B6Q

Running the same fio test of yours on latest RHEL7 and 4.20.0+-1 I am
unable to reproduce this issue of yours after multiple test runs.

Tests all run to completion with no errors on RHEL7 and upstream
kernels.

I have no way to test at the moment with a direct motherboard
connection to a SATA port so if this is a host side issue with sata
(ATA) I would not see it.

What this likely means is that the drive itself seems to be well
behaved here and the power or cable issue I alluded to earlier may be
worth looking into for you or possibly the host ATA interface.

RHEL7 kernel
3.10.0-862.11.1.el7.x86_64

test: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W) 32.0KiB-32.0KiB,
(T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=32
fio-3.3-38-gf5ec8
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=120MiB/s,w=0KiB/s][r=3839,w=0 IOPS][eta
00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3974: Thu Jan  3 15:14:10 2019
   read: IOPS=3827, BW=120MiB/s (125MB/s)(70.1GiB/600009msec)
    slat (usec): min=7, max=374, avg=23.78, stdev= 6.09
    clat (usec): min=449, max=509311, avg=8330.29, stdev=2060.29
     lat (usec): min=514, max=509331, avg=8355.00, stdev=2060.29
    clat percentiles (usec):
     |  1.00th=[ 5342],  5.00th=[ 7767], 10.00th=[ 8225], 20.00th=[
8291],
     | 30.00th=[ 8291], 40.00th=[ 8291], 50.00th=[ 8291], 60.00th=[
8291],
     | 70.00th=[ 8356], 80.00th=[ 8356], 90.00th=[ 8455], 95.00th=[
8848],
     | 99.00th=[11600], 99.50th=[13042], 99.90th=[16581],
99.95th=[17695],
     | 99.99th=[19006]
   bw (  KiB/s): min=50560, max=124472, per=99.94%, avg=122409.89,
stdev=2592.08, samples=1200
   iops        : min= 1580, max= 3889, avg=3825.22, stdev=81.01,
samples=1200
  lat (usec)   : 500=0.01%, 750=0.03%, 1000=0.02%
  lat (msec)   : 2=0.08%, 4=0.32%, 10=97.20%, 20=2.34%, 50=0.01%
  lat (msec)   : 750=0.01%
  cpu          : usr=4.76%, sys=12.81%, ctx=2113947, majf=0, minf=14437
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%,
>=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%,
>=64=0.0%
     issued rwts: total=2296574,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: bw=120MiB/s (125MB/s), 120MiB/s-120MiB/s (125MB/s-125MB/s),
io=70.1GiB (75.3GB), run=600009-600009msecmodinfo ata

Disk stats (read/write):
  sdb: ios=2295763/0, merge=0/0, ticks=18786069/0, in_queue=18784356,
util=100.00%

Upstream Kernel
4.20.0+-1.x86_64

[root@localhost ~]# ./test_ssd.sh 
test: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W) 32.0KiB-32.0KiB,
(T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=32
fio-3.3-38-gf5ec8
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=120MiB/s,w=0KiB/s][r=3835,w=0 IOPS][eta
00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=2895: Thu Jan  3 15:47:21 2019
   read: IOPS=3826, BW=120MiB/s (125MB/s)(70.1GiB/600009msec)
    slat (usec): min=5, max=410, avg=26.92, stdev= 3.81
    clat (usec): min=760, max=1287.1k, avg=8327.27, stdev=4756.19
     lat (usec): min=787, max=1287.1k, avg=8355.50, stdev=4756.18
    clat percentiles (usec):
     |  1.00th=[ 8225],  5.00th=[ 8291], 10.00th=[ 8291], 20.00th=[
8291],
     | 30.00th=[ 8291], 40.00th=[ 8291], 50.00th=[ 8291], 60.00th=[
8291],
     | 70.00th=[ 8356], 80.00th=[ 8356], 90.00th=[ 8356], 95.00th=[
8356],
     | 99.00th=[ 8455], 99.50th=[ 8455], 99.90th=[ 8455], 99.95th=[
8455],
     | 99.99th=[ 9765]
   bw (  KiB/s): min=25152, max=124559, per=100.00%, avg=122589.35,
stdev=3879.77, samples=1199
   iops        : min=  786, max= 3892, avg=3830.88, stdev=121.24,
samples=1199
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=99.99%, 20=0.01%
  cpu          : usr=4.19%, sys=18.68%, ctx=2295902, majf=0, minf=278
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%,
>=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%,
>=64=0.0%
     issued rwts: total=2296041,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: bw=120MiB/s (125MB/s), 120MiB/s-120MiB/s (125MB/s-125MB/s),
io=70.1GiB (75.2GB), run=600009-600009msec

Disk stats (read/write):
  sdb: ios=2296022/0, merge=0/0, ticks=19111730/0, in_queue=18408961,
util=99.87%


