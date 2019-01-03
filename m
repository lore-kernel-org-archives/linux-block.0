Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FBAC43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 22:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17972184B
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 22:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0HgUNLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfACWYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:24:38 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43983 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfACWYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jan 2019 17:24:37 -0500
Received: by mail-vk1-f196.google.com with SMTP id o130so7579759vke.10;
        Thu, 03 Jan 2019 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TXz+/MvxM6jMozS9yJxzfLeryC5HqYgXFr/QNnpg8M=;
        b=m0HgUNLF7Jm7OAlqOzGo6JblR6eSjGSwRBpFk7kt9dcXVYsC6IOVfHZ7w+X//wWvd8
         qFnkEvCxiRRC/eTB20f3o7TJkGqhSipH7e4ExjRlwcKpyrKZU5P1YXAnbYMJJpHOCCjP
         HvNhHjB2122Qf2gxdkVJSZ2VXlyUzxRA8B3AOaIYRtRWyG8n2mZtPWkYSc6ohkPjy4t1
         8zvjxAhxJbKPR01MOMjOvWTgU2i3/GMye7DnPMV2fd+VS2fuGTexbwxh+++2N30s44SK
         W9Vs+21nXgh4hjJ406uFT6F51YGImfDAnCncJ2z6MDDA67tjUl3VUwPYN/NzUMo84Gif
         GHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TXz+/MvxM6jMozS9yJxzfLeryC5HqYgXFr/QNnpg8M=;
        b=qyVT+mJtBJzCLog9CGSD0ZCj3musAO5mmS4g6EQKb2DBwuma6bvHOBeEjveMbolUyx
         iherweBvmF4aPbT3YIbAJceaTwYG1QPXaPUtjUpEBwLAsa3s1UEEPDlhYE3iX6HRwVNd
         dC1AW/mRKuYHi+Wvd2DW3NbEAv7WgXoiSKH5ScDSJzpHpdun8gDmmrJafv4gcg34tvwQ
         QhxnLDwnAl6oyp37Wo26W/APYAxPvANpLaJE/N3cbE8o4jLK88lrvn/DFXknbqIrIz3q
         qDaehFWbsklOaYzOE4TO1oRYUqJYTemCHYrWJQ6PEFWPzTeAelQZEiai2WpeR9+z/1XV
         GP2w==
X-Gm-Message-State: AJcUukfg2RVd23Mtt+Q/K09fTNJCFcMJyls0vkQs5bvZSvuKWRmXxnt6
        2YS1cj4y1WDlALQPYe5VLIXZelqa+YTJvi8Mgml+48G8
X-Google-Smtp-Source: ALg8bN7uZ+sSVZTF3f+s2l0GvyFQXEN3BP3nptQzY8IF/2b8ImFZ6rykyiJhlBTM9RkTYZyHGLlvFPbsPTKynheDftc=
X-Received: by 2002:a1f:80d3:: with SMTP id b202mr17359336vkd.23.1546554276064;
 Thu, 03 Jan 2019 14:24:36 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
 <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
 <1546445424.29282.1.camel@redhat.com> <1546540117.24199.0.camel@redhat.com> <1546548458.24199.2.camel@redhat.com>
In-Reply-To: <1546548458.24199.2.camel@redhat.com>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Thu, 3 Jan 2019 22:24:15 +0000
Message-ID: <CALjAwxhOb_HLD1Adux-n0LUienLK_FhrOnyBw=UMLj49aN6_5A@mail.gmail.com>
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
To:     Laurence Oberman <loberman@redhat.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Thu, 3 Jan 2019 at 20:47, Laurence Oberman <loberman@redhat.com> wrote:
>
> Hello
>
> I put the 860 in an enclosure (MSA50) driven by a SAS HBA
> (megaraid)sas)
>
> The backplane is SAS or SATA
>
> /dev/sg2  0 0 49 0  0  /dev/sdb  ATA       Samsung SSD 860   1B6Q
>
> Running the same fio test of yours on latest RHEL7 and 4.20.0+-1 I am
> unable to reproduce this issue of yours after multiple test runs.
>
> Tests all run to completion with no errors on RHEL7 and upstream
> kernels.
>
> I have no way to test at the moment with a direct motherboard
> connection to a SATA port so if this is a host side issue with sata
> (ATA) I would not see it.
>
> What this likely means is that the drive itself seems to be well
> behaved here and the power or cable issue I alluded to earlier may be
> worth looking into for you or possibly the host ATA interface.
>
> RHEL7 kernel
> 3.10.0-862.11.1.el7.x86_64

Thanks for going the extra mile on this Laurence - it does sound like
whatever issue I'm seeing with the 860 EVO is local to my box. It's
curious that others are seeing something similar (e.g.
https://github.com/zfsonlinux/zfs/issues/4873#issuecomment-449798356 )
but maybe they're in the same boat as me.

> test: (g=0): rw=randread, bs=(R) 32.0KiB-32.0KiB, (W) 32.0KiB-32.0KiB,
> (T) 32.0KiB-32.0KiB, ioengine=libaio, iodepth=32
> fio-3.3-38-gf5ec8
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=120MiB/s,w=0KiB/s][r=3839,w=0 IOPS][eta
> 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=3974: Thu Jan  3 15:14:10 2019
>    read: IOPS=3827, BW=120MiB/s (125MB/s)(70.1GiB/600009msec)
>     slat (usec): min=7, max=374, avg=23.78, stdev= 6.09
>     clat (usec): min=449, max=509311, avg=8330.29, stdev=2060.29
>      lat (usec): min=514, max=509331, avg=8355.00, stdev=2060.29
>     clat percentiles (usec):
>      |  1.00th=[ 5342],  5.00th=[ 7767], 10.00th=[ 8225], 20.00th=[
> 8291],
>      | 30.00th=[ 8291], 40.00th=[ 8291], 50.00th=[ 8291], 60.00th=[
> 8291],
>      | 70.00th=[ 8356], 80.00th=[ 8356], 90.00th=[ 8455], 95.00th=[
> 8848],
>      | 99.00th=[11600], 99.50th=[13042], 99.90th=[16581],
> 99.95th=[17695],
>      | 99.99th=[19006]
>    bw (  KiB/s): min=50560, max=124472, per=99.94%, avg=122409.89,
> stdev=2592.08, samples=1200
>    iops        : min= 1580, max= 3889, avg=3825.22, stdev=81.01,
> samples=1200
>   lat (usec)   : 500=0.01%, 750=0.03%, 1000=0.02%
>   lat (msec)   : 2=0.08%, 4=0.32%, 10=97.20%, 20=2.34%, 50=0.01%
>   lat (msec)   : 750=0.01%
>   cpu          : usr=4.76%, sys=12.81%, ctx=2113947, majf=0, minf=14437
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%,
> >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%,
> >=64=0.0%
>      issued rwts: total=2296574,0,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=32
>
> Run status group 0 (all jobs):
>    READ: bw=120MiB/s (125MB/s), 120MiB/s-120MiB/s (125MB/s-125MB/s),
> io=70.1GiB (75.3GB), run=600009-600009msecmodinfo ata
>
> Disk stats (read/write):
>   sdb: ios=2295763/0, merge=0/0, ticks=18786069/0, in_queue=18784356,
> util=100.00%

For what it's worth, the speeds I see with NCQ off on the Samsung 860
EVO are not far off what you're reporting (but are much lower than
those I see on the MX500 in the same machine). I suppose it could just
be the MX500 is simply a better performing SSD for the specific
workload I have been testing...

--
Sitsofe | http://sucs.org/~sits/
