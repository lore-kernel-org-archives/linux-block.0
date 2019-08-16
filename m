Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F1C3A59D
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 18:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1578B206C1
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 18:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQmKl6pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfHPSRX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:17:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36503 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfHPSRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 14:17:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so2392571wrt.3
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lxbKfa4ISoztLIjMd6DEgXa2A9ZSrMBVFcHAhR0c5ZY=;
        b=sQmKl6pFL/HMyjrb2LNeSTmjOtmdsAAVlPSq2ZJkeylDKNcMTzCVWJug5tEyHTqBHJ
         CRFAIo75L3ckfk0j+VyCc80njYk4+jFMVfAdJgGdoJujBvk3RoVwO2Pajwrafppa5eiB
         /4plsxkyF9sZx+BeiOalnJ79Hsk//lk39PjotJl7Jw/296ZXWykYN+AlfnjYLOX6RsEv
         XQJX/7f5ibKtOZ1nVlWSMbBAogUhXeRr4c4L+hUsFAuKfAMQ1YFqogalH4a/lV+Vt5B/
         qtNc1kibWxcr8x/4INb9Kn9dsxiaxlq5YQbZcUBvLM6mH5329ny0HFzmSIloXjPr4PdQ
         +hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lxbKfa4ISoztLIjMd6DEgXa2A9ZSrMBVFcHAhR0c5ZY=;
        b=UYZvwXfqrWtMrDvigNTvOzP/6tA+TmXUskAAEfc4+oIYDb+WFDc50hsj24Nks4L6Eu
         vzam3904cQ4Ioiq7k56pI2y6Fw/eTza+pXJuukEmXgpsH1ttDHHQKHFAzTdsZCQQtTAy
         ctpvoZGZtkkVqm08bmIkm6UEvSRVvI/f9Kkn4+8zdK4WZymH5FWiv19/s2NYie7DMtHx
         Pbhk596l4hxLwZHupKgsx15Vc3QnvEw37ZSsOlkr4DFrEuMdP9y7oVMsdGcFwoMHSXh6
         lw+XNkrW9YG/SLlcHS+7DpXAX362r99MfWUz5xNxW+Sb0z9yTK9G8UDZFEa3XX1GcjyJ
         A3Qw==
X-Gm-Message-State: APjAAAW+T8Z7Ztg+DSAmN6xmxg40gYUyXgBWH0wE+XAKRF+7rFcbA8q+
        HWSdsaVFIyQ9wfsxyU9XhyQaejufXo8=
X-Google-Smtp-Source: APXvYqzNL6M1ZKlYd1S2iAgw1E9UAQOWBgYwSckUmDm3//IQfQwuKYnQpHaY92B+TYzMI26Vb2E5jg==
X-Received: by 2002:adf:fc81:: with SMTP id g1mr12322678wrr.78.1565979440870;
        Fri, 16 Aug 2019 11:17:20 -0700 (PDT)
Received: from [192.168.0.101] (88-147-32-115.dyn.eolo.it. [88.147.32.115])
        by smtp.gmail.com with ESMTPSA id m23sm9354049wml.41.2019.08.16.11.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 11:17:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: io.latency controller apparently not working
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190816175931.cxpdko44cuyq7trj@MacBook-Pro-91.local>
Date:   Fri, 16 Aug 2019 20:17:19 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88488E82-E360-45B0-B010-209190D32892@linaro.org>
References: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
 <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
 <1842D618-3E31-47FE-8B9C-F26BF1F5349C@linaro.org>
 <20190816175931.cxpdko44cuyq7trj@MacBook-Pro-91.local>
To:     Josef Bacik <josef@toxicpanda.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 16 ago 2019, alle ore 19:59, Josef Bacik =
<josef@toxicpanda.com> ha scritto:
>=20
> On Fri, Aug 16, 2019 at 07:52:40PM +0200, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 16 ago 2019, alle ore 15:21, Josef Bacik =
<josef@toxicpanda.com> ha scritto:
>>>=20
>>> On Fri, Aug 16, 2019 at 12:57:41PM +0200, Paolo Valente wrote:
>>>> Hi,
>>>> I happened to test the io.latency controller, to make a comparison
>>>> between this controller and BFQ.  But io.latency seems not to work,
>>>> i.e., not to reduce latency compared with what happens with no I/O
>>>> control at all.  Here is a summary of the results for one of the
>>>> workloads I tested, on three different devices (latencies in ms):
>>>>=20
>>>>            no I/O control        io.latency         BFQ
>>>> NVMe SSD     1.9                   1.9                0.07
>>>> SATA SSD     39                    56                 0.7
>>>> HDD          4500                  4500               11
>>>>=20
>>>> I have put all details on hardware, OS, scenarios and results in =
the
>>>> attached pdf.  For your convenience, I'm pasting the source file =
too.
>>>>=20
>>>=20
>>> Do you have the fio jobs you use for this?
>>=20
>> The script mentioned in the draft (executed with the command line
>> reported in the draft), executes one fio instance for the target
>> process, and one fio instance for each interferer.  I couldn't do =
with
>> just one fio instance executing all jobs, because the weight =
parameter
>> doesn't work in fio jobfiles for some reason, and because the ioprio
>> class cannot be set for individual jobs.
>>=20
>> In particular, the script generates a job with the following
>> parameters for the target process:
>>=20
>> ioengine=3Dsync
>> loops=3D10000
>> direct=3D0
>> readwrite=3Drandread
>> fdatasync=3D0
>> bs=3D4k
>> thread=3D0
>> filename=3D/mnt/scsi_debug/largefile_interfered0
>> iodepth=3D1
>> numjobs=3D1
>> invalidate=3D1
>>=20
>> and a job with the following parameters for each of the interferers,
>> in case, e.g., of a workload made of reads:
>>=20
>> ioengine=3Dsync
>> direct=3D0
>> readwrite=3Dread
>> fdatasync=3D0
>> bs=3D4k
>> filename=3D/mnt/scsi_debug/largefileX
>> invalidate=3D1
>>=20
>> Should you fail to reproduce this issue by creating groups, setting
>> latencies and starting fio jobs manually, what if you try by just
>> executing my script?  Maybe this could help us spot the culprit more
>> quickly.
>=20
> Ah ok, you are doing it on a mountpoint.

Yep

>  Are you using btrfs?

ext4

>  Cause otherwise
> you are going to have a sad time.

Could you elaborate more on this?  I/O seems to be controllable on ext4.

>  The other thing is you are using buffered,

Actually, the problem is suffered by sync random reads, which always
hit the disk in this test.

> which may or may not hit the disk.  This is what I use to test =
io.latency
>=20
> https://patchwork.kernel.org/patch/10714425/
>=20
> I had to massage it since it didn't apply directly, but running this =
against the
> actual block device, with O_DIRECT so I'm sure to be measure the =
actual impact
> of the controller, it all works out fine.

I'm not getting why non-direct sync reads, or buffered writes, should
be uncontrollable.  As a trivial example, BFQ in this tests controls
I/O as expected, and keeps latency extremely low.

What am I missing?

Thanks,
Paolo

>  Thanks,
>=20
> Josef

