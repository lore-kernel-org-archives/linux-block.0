Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D71FC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 23:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C702C2184C
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 23:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gf4jtzAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLRXfi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:35:38 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40532 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeLRXfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 18:35:37 -0500
Received: by mail-wm1-f43.google.com with SMTP id f188so3821953wmf.5
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 15:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Akuk/2UwnRVc4ivoj0d1MG9Y2gTYwtpUSc2Gb253rUM=;
        b=Gf4jtzAcQDXjz9zqCzOrqiC2GYvD1CJc/Glw3+gyTSNd9D2eefumSVGu3kqcEajR5n
         PQpEeugTXtPC7bCmKkS5eTe0wXhaHHpHTjoYp2uablP9FtgmeUDhqQNEaV3uZQcxCgzh
         TAwc9HNs6HP/QC5CMW2GfJ23roYyEY1b63YtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Akuk/2UwnRVc4ivoj0d1MG9Y2gTYwtpUSc2Gb253rUM=;
        b=g21m0EL69fD1XShSEWFOhbTnbn+j957ldzQfYZE2tyRiuf4jCiIGjAZmL3GS8KqOwY
         vEBubL2oQdf2OOu8wXHpJ5vveYIIHQA2IzXjRp9k1fbo472HrS3yg/mKJylWd7LaopWn
         z9foCcQI+EDXqDXrgknCcJtNxqWx4JjIXWfN6v6K0zXBCMGmKZ0ycg5esvQV+SVCWgXC
         8N94T/WhCtUQ5IMDK5gaUoD6NArkwkoLkdAoDgQCvEmfZZQ0LFQEOxSi4Klre6U48567
         tkaDY+8Y7aGEUPeNCqpqFcNArHDituFDknN+VLO24E3SxvEhPhzrpsYsdbLDqWVZYW+K
         +ntA==
X-Gm-Message-State: AA+aEWahphwjqEzFpnn1cppoCJpHdW6PFAxXdrbWUyV5dj3BJj9OqTo7
        oPhGS9+iMXv/6vV5lhdVXvcdeJMZ87Q=
X-Google-Smtp-Source: AFSGD/X5e/+JHelbP1Gkb4xhBFyuSGfE3SgaYYSaa8F4EAbFE6glXQ1h9mcTvfZua32O8sLtoL0QmQ==
X-Received: by 2002:a1c:4855:: with SMTP id v82mr4955883wma.15.1545176135202;
        Tue, 18 Dec 2018 15:35:35 -0800 (PST)
Received: from [192.168.0.100] ([84.33.70.123])
        by smtp.gmail.com with ESMTPSA id e19sm6369762wrc.25.2018.12.18.15.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 15:35:34 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: confusion about nr of pending I/O requests
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <4db2cb0f-e500-44da-e85d-ed417b74dae5@kernel.dk>
Date:   Wed, 19 Dec 2018 00:35:33 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92700F6D-AAF6-4F31-8775-CE6A7995C0CE@linaro.org>
References: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org>
 <4db2cb0f-e500-44da-e85d-ed417b74dae5@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 dic 2018, alle ore 19:50, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 12/18/18 5:45 AM, Paolo Valente wrote:
>> Hi Jens,
>> sorry for the following silly question, but maybe you can solve very
>> quickly a doubt for which I'd spend much more time investigating.
>>=20
>> While doing some tests with scsi_debug, I've just seen that (at =
least)
>> with direct I/O, the maximum number of pending I/O requests (at least
>> in the I/O schedulers) is equal, unexpectedly, to the queue depth of
>> the drive and not to
>> /sys/block/<dev>/queue/nr_requests
>>=20
>> For example, after:
>>=20
>> sudo modprobe scsi_debug max_queue=3D4
>>=20
>> and with fio executed as follows:
>>=20
>> job: (g=3D0): rw=3Dread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) =
4096B-4096B, ioengine=3Dlibaio, iodepth=3D20
>>=20
>> I get this periodic trace, where four insertions are followed by four
>> completions, and so on, till the end of the I/O.  This trace is taken
>> with none, but the result is the same with bfq.
>>=20
>>             fio-20275 [001] d...  7560.655213:   8,48   I   R 281088 =
+ 8 [fio]
>>             fio-20275 [001] d...  7560.655288:   8,48   I   R 281096 =
+ 8 [fio]
>>             fio-20275 [001] d...  7560.655311:   8,48   I   R 281104 =
+ 8 [fio]
>>             fio-20275 [001] d...  7560.655331:   8,48   I   R 281112 =
+ 8 [fio]
>>          <idle>-0     [001] d.h.  7560.749868:   8,48   C   R 281088 =
+ 8 [0]
>>          <idle>-0     [001] dNh.  7560.749912:   8,48   C   R 281096 =
+ 8 [0]
>>          <idle>-0     [001] dNh.  7560.749928:   8,48   C   R 281104 =
+ 8 [0]
>>          <idle>-0     [001] dNh.  7560.749934:   8,48   C   R 281112 =
+ 8 [0]
>>             fio-20275 [001] d...  7560.750023:   8,48   I   R 281120 =
+ 8 [fio]
>>             fio-20275 [001] d...  7560.750196:   8,48   I   R 281128 =
+ 8 [fio]
>>             fio-20275 [001] d...  7560.750229:   8,48   I   R 281136 =
+ 8 [fio]
>>             fio-20275 [001] d...  7560.750250:   8,48   I   R 281144 =
+ 8 [fio]
>>          <idle>-0     [001] d.h.  7560.842510:   8,48   C   R 281120 =
+ 8 [0]
>>          <idle>-0     [001] dNh.  7560.842551:   8,48   C   R 281128 =
+ 8 [0]
>>          <idle>-0     [001] dNh.  7560.842556:   8,48   C   R 281136 =
+ 8 [0]
>>          <idle>-0     [001] dNh.  7560.842562:   8,48   C   R 281144 =
+ 8 [0]
>>=20
>> Shouldn't the total number of pending requests reach
>> /sys/block/<dev>/queue/nr_requests ?
>>=20
>> The latter is of course equal to 8.
>=20
> With a scheduler, the depth is what the scheduler provides. You cannot
> exceed the hardware queue depth in any situation. You just have 8
> requests available for scheduling, with a max of 4 being inflight on
> the device side.
>=20
> If both were 4, for instance, then you would have nothing to schedule
> with, as all of them could reside on the hardware side. That's why
> the scheduler defaults to twice the hardware queue depth.
>=20

That's exactly what I expected, thanks.  But not what happened.  Let
me add also dispatch lines to my filtered-trace snippet.  The
repetitive pattern becomes:

             fio-5180  [001] d...   786.931956:   8,48   I  WS 333824 + =
1024 [fio]
             fio-5180  [001] d...   786.932010:   8,48   D  WS 333824 + =
1024 [fio]
             fio-5180  [001] d...   786.932137:   8,48   I  WS 334848 + =
1024 [fio]
             fio-5180  [001] d...   786.932160:   8,48   D  WS 334848 + =
1024 [fio]
             fio-5180  [001] d...   786.932318:   8,48   I  WS 335872 + =
1024 [fio]
             fio-5180  [001] d...   786.932354:   8,48   D  WS 335872 + =
1024 [fio]
             fio-5180  [001] d...   786.932467:   8,48   I  WS 336896 + =
1024 [fio]
             fio-5180  [001] d...   786.932489:   8,48   D  WS 336896 + =
1024 [fio]
          <idle>-0     [001] d.h.   787.023945:   8,48   C  WS 333824 + =
1024 [0]
          <idle>-0     [001] d.h.   787.023978:   8,48   C  WS 334848 + =
1024 [0]
          <idle>-0     [001] d.h.   787.024080:   8,48   C  WS 335872 + =
1024 [0]
          <idle>-0     [001] d.h.   787.024237:   8,48   C  WS 336896 + =
1024 [0]

So, after the four dispatches, there are 0 requests in the scheduler,
and 4 requests inflight.  But *no* new request is inserted into the
scheduler before *all* four inflight requests are completed.

So the total number of requests available seems 4 and not 8.

Am I missing something?

Thanks,
Paolo

> --=20
> Jens Axboe

