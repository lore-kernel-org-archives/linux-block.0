Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31010C3A59D
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 17:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09145206C1
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 17:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ued4AmBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfHPRws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:52:48 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51094 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfHPRwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 13:52:44 -0400
Received: by mail-wm1-f48.google.com with SMTP id v15so4688583wml.0
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k+xusRflpFP0QFvrEvHkmFM6lrPCmbIUxPJWx8KxgCk=;
        b=Ued4AmBDCouf3VdaxlwBFg/PIZRnFcpYnyY1bfhJvN5WGInd6hoi0GPTazl2MaRUCJ
         xsDP//6xOfG4NGmdUhC2z8TR5Rr3pMS5p3JMaVo0ed8Pr4eB9Nvw1c6L2VcbQIQWO4tH
         Z4qezU/ygkmeGIsq81ZAauw5lMGrDT/rXxpjBl40gepR42Qf+lElNzc8FNrPiVeT9QX/
         YsSSz+aAMZkAuB6EPiVeRuiJ+p71MI6vgRepnNw2SYUOSUS880q+mkYYGeN7m3x1EpIQ
         XkE5nYE/FAEp/SE4x7jPhuCnm21r9PvwKcAvAEwsO+3DKPkxQW3hDghikRDx2HTwNz9p
         UA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k+xusRflpFP0QFvrEvHkmFM6lrPCmbIUxPJWx8KxgCk=;
        b=chQuneod/RIaz7dl4DAOYbx36P6WvwxzvRFG+BMq+RlMGw1nCkJ/7/3Sl4EblV0TeL
         mJfBXWBCD94Qnks4tK6M8ghVavGO6aC/+GEdWT6YBOudKEIpNm/KWwp91Wy5NUNeTw4w
         aW9QS1ArFC/snUNgIobR9wrPOinNncR5569ISpYgVxMoOJ7dMn8HelE+o9aj9ht59K6k
         8j9MTnnKaninjjwMuJu6PbggmSUe0Kp4xXCby8zVV0/QGnRA+LB9ITSvIVSnUStysIwm
         DnM2a2BgdhU2NqetLL5TiVCrmly+sI+2coHIgTlDjs7WgHy3cJ0QnDljh0Y6UrhfjXeJ
         DgxA==
X-Gm-Message-State: APjAAAVyTz7VnX7bTk7tDIpYi4s8fJRdlROlZ5JTPpqaF7cjs4RmsOn5
        uvW60uqZ+wYPjlp6gIKKG7DU7g==
X-Google-Smtp-Source: APXvYqxQJgAArOlNcboXKAbS4+sOWkkZnADm2KthRsNyunmnj0lkmenB7nqdclIHJstotG/zGp6IZw==
X-Received: by 2002:a05:600c:1087:: with SMTP id e7mr8593857wmd.19.1565977962239;
        Fri, 16 Aug 2019 10:52:42 -0700 (PDT)
Received: from [192.168.0.101] (88-147-32-115.dyn.eolo.it. [88.147.32.115])
        by smtp.gmail.com with ESMTPSA id f70sm9044482wme.22.2019.08.16.10.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 10:52:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: io.latency controller apparently not working
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
Date:   Fri, 16 Aug 2019 19:52:40 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1842D618-3E31-47FE-8B9C-F26BF1F5349C@linaro.org>
References: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
 <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
To:     Josef Bacik <josef@toxicpanda.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 16 ago 2019, alle ore 15:21, Josef Bacik =
<josef@toxicpanda.com> ha scritto:
>=20
> On Fri, Aug 16, 2019 at 12:57:41PM +0200, Paolo Valente wrote:
>> Hi,
>> I happened to test the io.latency controller, to make a comparison
>> between this controller and BFQ.  But io.latency seems not to work,
>> i.e., not to reduce latency compared with what happens with no I/O
>> control at all.  Here is a summary of the results for one of the
>> workloads I tested, on three different devices (latencies in ms):
>>=20
>>             no I/O control        io.latency         BFQ
>> NVMe SSD     1.9                   1.9                0.07
>> SATA SSD     39                    56                 0.7
>> HDD          4500                  4500               11
>>=20
>> I have put all details on hardware, OS, scenarios and results in the
>> attached pdf.  For your convenience, I'm pasting the source file too.
>>=20
>=20
> Do you have the fio jobs you use for this?

The script mentioned in the draft (executed with the command line
reported in the draft), executes one fio instance for the target
process, and one fio instance for each interferer.  I couldn't do with
just one fio instance executing all jobs, because the weight parameter
doesn't work in fio jobfiles for some reason, and because the ioprio
class cannot be set for individual jobs.

In particular, the script generates a job with the following
parameters for the target process:

 ioengine=3Dsync
 loops=3D10000
 direct=3D0
 readwrite=3Drandread
 fdatasync=3D0
 bs=3D4k
 thread=3D0
 filename=3D/mnt/scsi_debug/largefile_interfered0
 iodepth=3D1
 numjobs=3D1
 invalidate=3D1

and a job with the following parameters for each of the interferers,
in case, e.g., of a workload made of reads:

 ioengine=3Dsync
 direct=3D0
 readwrite=3Dread
 fdatasync=3D0
 bs=3D4k
 filename=3D/mnt/scsi_debug/largefileX
 invalidate=3D1

Should you fail to reproduce this issue by creating groups, setting
latencies and starting fio jobs manually, what if you try by just
executing my script?  Maybe this could help us spot the culprit more
quickly.

>  I just tested on Jens's most recent
> tree and io.latency appears to be doing what its supposed to be doing. =
 We've
> also started testing 5.2 in production and it's still working in =
production as
> well.

I tested 5.2 too, same negative outcome.

Thanks,
Paolo

>  The only thing I've touched recently was around wakeups and shouldn't
> have broken everything.  I'm not sure why it's not working for you, =
but a fio
> script will help me narrow down what's going on.  Thanks,
>=20
> Josef

