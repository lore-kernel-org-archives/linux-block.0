Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0CBC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 06:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85396217D6
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 06:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClJT4MvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeLSGSB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:18:01 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44011 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeLSGSB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 01:18:01 -0500
Received: by mail-wr1-f49.google.com with SMTP id r10so18200861wrs.10
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 22:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AGUr2aHBnv61VkRdXW1wY77N3wG4IMTfjhBc7ZBITWA=;
        b=ClJT4MvEFHwCGqgptmrgqrc+ri54iSYJTTjmvqkIs5izYg4sTfIhc9omVbfbPDkjPu
         wk+/gksJlwfVYBHM23xMg6IkiTvjjGa1gNV/ShN057aD0W9TYHtuomhfNetpMFq/RkAF
         vQDSpFwdSFrzk1z/iCqOMPyRa+UZFeN1zwfcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AGUr2aHBnv61VkRdXW1wY77N3wG4IMTfjhBc7ZBITWA=;
        b=igbr0mE9dMrRSuldacOMpdfMIKPWL9J3Cj4UZwf1LTopMG2Y8U1H4weNrUlIoJRnUX
         P2IQOZGqKtEg4pYiNToeo+w7WpkN37GIAxPGsCrL8+aAFqXIUjRO+mxuqPOYvTGOodyI
         qbxYv/KpIAMrk6ETRZdRSg963Bp8SGHrCC7Ne5xZ1zTbGP3kXZGCX8ieh/ACY11kwkvn
         cOZ/ZbpNy6Kn1FlR/V09R8pOJpmgLuGH6V7AZd5d14bnc/i+QO77smhngtTodbumc3fk
         928+JMB8hvtnNYHrU1MykZDQN8v9GsKx+OSgrAR2jKWsow8SNuD/WsCfbaUeNsfSNt0h
         DwSg==
X-Gm-Message-State: AA+aEWYvV8sazxRhl4h3spMp4cPzfYSf9a5QzEOn7DX+ADL5YMkVxHDY
        6AeykWecm6mBuUfepsCk0FIw1g==
X-Google-Smtp-Source: AFSGD/X009D2iI4B+2T9kjnArS268bC3vOsSR4wP454jsgKkLbhPi8ug/oy6tliAZT+lXzbvJkFmyg==
X-Received: by 2002:adf:f149:: with SMTP id y9mr18612476wro.284.1545200279495;
        Tue, 18 Dec 2018 22:17:59 -0800 (PST)
Received: from [192.168.0.100] ([84.33.69.197])
        by smtp.gmail.com with ESMTPSA id l202sm7751155wma.33.2018.12.18.22.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 22:17:58 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: confusion about nr of pending I/O requests
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CACVXFVML3ZJ0ezsRBC6T_6zbJHqXRFXVQJxVhsK9spKEfgKipQ@mail.gmail.com>
Date:   Wed, 19 Dec 2018 07:17:57 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <80B060E9-48E9-45D3-9456-64E94947F048@linaro.org>
References: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org>
 <4db2cb0f-e500-44da-e85d-ed417b74dae5@kernel.dk>
 <CACVXFVML3ZJ0ezsRBC6T_6zbJHqXRFXVQJxVhsK9spKEfgKipQ@mail.gmail.com>
To:     Ming Lei <tom.leiming@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 19 dic 2018, alle ore 04:45, Ming Lei =
<tom.leiming@gmail.com> ha scritto:
>=20
> On Wed, Dec 19, 2018 at 2:52 AM Jens Axboe <axboe@kernel.dk> wrote:
>>=20
>> On 12/18/18 5:45 AM, Paolo Valente wrote:
>>> Hi Jens,
>>> sorry for the following silly question, but maybe you can solve very
>>> quickly a doubt for which I'd spend much more time investigating.
>>>=20
>>> While doing some tests with scsi_debug, I've just seen that (at =
least)
>>> with direct I/O, the maximum number of pending I/O requests (at =
least
>>> in the I/O schedulers) is equal, unexpectedly, to the queue depth of
>>> the drive and not to
>>> /sys/block/<dev>/queue/nr_requests
>>>=20
>>> For example, after:
>>>=20
>>> sudo modprobe scsi_debug max_queue=3D4
>>>=20
>>> and with fio executed as follows:
>>>=20
>>> job: (g=3D0): rw=3Dread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) =
4096B-4096B, ioengine=3Dlibaio, iodepth=3D20
>>>=20
>>> I get this periodic trace, where four insertions are followed by =
four
>>> completions, and so on, till the end of the I/O.  This trace is =
taken
>>> with none, but the result is the same with bfq.
>>>=20
>>>             fio-20275 [001] d...  7560.655213:   8,48   I   R 281088 =
+ 8 [fio]
>>>             fio-20275 [001] d...  7560.655288:   8,48   I   R 281096 =
+ 8 [fio]
>>>             fio-20275 [001] d...  7560.655311:   8,48   I   R 281104 =
+ 8 [fio]
>>>             fio-20275 [001] d...  7560.655331:   8,48   I   R 281112 =
+ 8 [fio]
>>>          <idle>-0     [001] d.h.  7560.749868:   8,48   C   R 281088 =
+ 8 [0]
>>>          <idle>-0     [001] dNh.  7560.749912:   8,48   C   R 281096 =
+ 8 [0]
>>>          <idle>-0     [001] dNh.  7560.749928:   8,48   C   R 281104 =
+ 8 [0]
>>>          <idle>-0     [001] dNh.  7560.749934:   8,48   C   R 281112 =
+ 8 [0]
>>>             fio-20275 [001] d...  7560.750023:   8,48   I   R 281120 =
+ 8 [fio]
>>>             fio-20275 [001] d...  7560.750196:   8,48   I   R 281128 =
+ 8 [fio]
>>>             fio-20275 [001] d...  7560.750229:   8,48   I   R 281136 =
+ 8 [fio]
>>>             fio-20275 [001] d...  7560.750250:   8,48   I   R 281144 =
+ 8 [fio]
>>>          <idle>-0     [001] d.h.  7560.842510:   8,48   C   R 281120 =
+ 8 [0]
>>>          <idle>-0     [001] dNh.  7560.842551:   8,48   C   R 281128 =
+ 8 [0]
>>>          <idle>-0     [001] dNh.  7560.842556:   8,48   C   R 281136 =
+ 8 [0]
>>>          <idle>-0     [001] dNh.  7560.842562:   8,48   C   R 281144 =
+ 8 [0]
>>>=20
>>> Shouldn't the total number of pending requests reach
>>> /sys/block/<dev>/queue/nr_requests ?
>>>=20
>>> The latter is of course equal to 8.
>>=20
>> With a scheduler, the depth is what the scheduler provides. You =
cannot
>> exceed the hardware queue depth in any situation. You just have 8
>> requests available for scheduling, with a max of 4 being inflight on
>> the device side.
>>=20
>> If both were 4, for instance, then you would have nothing to schedule
>> with, as all of them could reside on the hardware side. That's why
>> the scheduler defaults to twice the hardware queue depth.
>=20
> The default twice to hw queue depth might not be reasonable for multi =
LUN.
>=20
> Maybe it should be set twice of sdev->queue_depth for SCSI or
> hw queue depth/hctx->nr_active.  But either way may become complicated
> because both can be adjusted runtime.
>=20

Could you please explain why it is not working (if it is not working)
in my example, where there should be only one LUN?

Thanks,
Paolo

> Thanks,
> Ming Lei

