Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4312E52
	for <linux-block@vger.kernel.org>; Sat, 13 Jan 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o289cWW8"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-680b1956ca4so45174516d6.3
        for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 23:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705129519; x=1705734319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqUVJ8s7EGwnf8VW2qN30KaMR9GjPb0OJdm4xU8DVmE=;
        b=o289cWW8aNxAKsdsbqumdVPwhE2vleIrcKu9YwaWzWJTXxR2BN30pi9gTTCPhvpw0E
         QPp2eM+ppILjGs/huoeth7SKWJvGO+rNJstbSaFtqhzBrW916WDAFoLClStwpqw9C9l5
         53/StuPRbHuIMoByk9mG+TG0B7MtTqo+BKqmQOoclDR1xdKmgoqXt2FMUcbl0cSqOWNf
         iCi0XQbC8MU+MnTs+fKthnb5qkliqVMQJNDoVIXH4VHSETxIeszsYKZz1uQFY9IYGM4K
         etJ3XFDvTPP1F+r1UPVjsUyBrhp2WUxj7NKMrUHJN53xpCKLmu119KZPtJWRAOuCGX10
         n4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705129519; x=1705734319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqUVJ8s7EGwnf8VW2qN30KaMR9GjPb0OJdm4xU8DVmE=;
        b=MmJi37XGewb1SeAtPFFgFmlS0AXivmDMA82zVPySluTX3VbdXTcirRjM0WMtG/idyZ
         Ic8Ro+1Bt51Sl+lIls/+BD/25Etb2qr9GUQnRiXbWCREDmZw7WYzp52AcPyl+2ptLJA6
         MN2gwkY4oM3Hf1EuPBvuxFCPAiawmhbiuXJrF9Vded2Xz6nmSNWTPTkPPjH07LCZqmZ+
         +nlz0lHb2dtYZ7SCM7xLOXBwiUFRJ6ONo3JniQfA4BYOBG1DgEwryihUjv3jNs359Bi3
         BCLGPsAPiT7KF4RYRoy8qEssg53Hp19mq7GFv+FE8GgfT+28lXY0n7YH/94G2Ul3puc+
         7ZUQ==
X-Gm-Message-State: AOJu0YwdIjjcg8RUnjBKy2x7johGmEesETCatUy2amGc3ZhU9DDttkeA
	lDaQp3WRBonTsySFF+o6PqB5XU6twB3pQ6hutYYVj+UX7bhAVA==
X-Google-Smtp-Source: AGHT+IFc0y2uSmt7xB6X4CM/6iYzv7XLzqDXm1OMDLNeYk0eIgGxUlMEo1QaTfdT2BHiqR6aEvzb2Y8BVfmQGNWecLs=
X-Received: by 2002:ad4:5be2:0:b0:681:3b95:cedd with SMTP id
 k2-20020ad45be2000000b006813b95ceddmr2122750qvc.59.1705129519531; Fri, 12 Jan
 2024 23:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYu1hB2OMf0EFrt_86OE=0Ug3y6nQd3=OZeEeM1jp3P92g@mail.gmail.com>
 <11a31e09-2e11-43a4-8995-ae70c5bef8bf@kernel.org>
In-Reply-To: <11a31e09-2e11-43a4-8995-ae70c5bef8bf@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 13 Jan 2024 12:35:08 +0530
Message-ID: <CA+G9fYthC3qsH8ey=j3RvCr4-0zp1S3Ysr5QvY6SptorHpju1g@mail.gmail.com>
Subject: Re: scsi: block: ioprio: Clean up interface definition -
 ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	open list <linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Niklas Cassel <niklas.cassel@wdc.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 10:49, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 1/12/24 14:15, Naresh Kamboju wrote:
> > The LTP test 'iopri_set03' fails on all the devices.
> > It fails on linux kernel >= v6.5. ( on Debian rootfs ).
> > Test fail confirmed on LTP release 20230929 and 20230516.
> >
> > Test failed log:
> > ------------
> > tst_test.c:1690: TINFO: LTP version: 20230929
> > tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
> > ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
> > ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
> > ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL (22)
> >
> > Investigation:
> > ----------
> > Bisecting this test between kernel v6.4 and v6.5 shows patch
> > eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
> > as the first faulty commit.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> This is fixed in LTP. Please update your LTP setup to avoid this issue.

Please point me to the fixed commit id.

I have the latest LTP release test results as ioprio_set03 has failed.

ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
LTP Version: 20230929-258-gec0a8f18b
on Debian rootfs.

Links:
 - https://qa-reports.linaro.org/lkft/ltp-master/build/v6.6.10_20230929-258-gec0a8f18b/testrun/22035919/suite/ltp-syscalls/test/ioprio_set03/history/
 - https://qa-reports.linaro.org/lkft/ltp-master/build/v6.6.10_20230929-258-gec0a8f18b/testrun/22035919/suite/ltp-syscalls/test/ioprio_set03/details/

- Naresh
