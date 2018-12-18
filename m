Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D49C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 12:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1352217D9
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 12:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FswItBlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeLRMtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:49:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34787 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRMtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 07:49:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so15807314wrw.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 04:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sZlAy0JMaMNZ4rIsBl3oRhTsHpWpr04NLqe/w21MnEQ=;
        b=FswItBlr8hAqwbHQ3ZUXqbqeK25adBsJBVAcKP0QEZWT08ZrqK/cxN2ebLHv6sPYEV
         KfS0LlKaQC7kWBZCi4wh1gzvIE0yDponmEIL7PcyUDgROUyJbzpHaCIS8cNlXCNQmmji
         CelnI5APZN8kS/ynR4wytCDxiwoHDbd9Rukts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sZlAy0JMaMNZ4rIsBl3oRhTsHpWpr04NLqe/w21MnEQ=;
        b=f5jekF0vEcR0p9oYtb9s/d8cVKkWk5Kw5BwCCvMIsqKl/FlZAxSU5exRCsut6gna73
         bqLu4Oyri+cmb/40jdnnGhaSepGcyqsXlguU0DOa8hiOhKc42BFPhoD9oj5YkJVfLJNp
         c+p6ugDfcePVkpJBZEWqMEy+MXBRoJ/r2MsODK4cqndS0r22LWPHx8wmPIsGy4IazQLq
         5pehMAFYdiR2kQfrBYcXq7qcNVy1pg7HT5rZYc7/GRv8pWic7iiHq0ctPTZExORnUNvU
         STA9UaJTNelJ4wR46pBE/0FmMVcLA25ucfVOfN4xsSMxDAl+6oWuPy+/QFBI7TkXmvul
         BOWw==
X-Gm-Message-State: AA+aEWaLqLNHsaUsura/umUi+Y+iEPkxQARJQUmM4ZxSHBh2jXxulW7Q
        +XLOPYT033GzqXFp5n2Vg/Nldw==
X-Google-Smtp-Source: AFSGD/VyUTso4L+XB0ZB9F0+axMqHXoDkRVINrlW5Cb+u8ZmrfE3yS2n0SP9VKnrOQPeB9rOe1LHBA==
X-Received: by 2002:adf:8506:: with SMTP id 6mr15239560wrh.128.1545137349476;
        Tue, 18 Dec 2018 04:49:09 -0800 (PST)
Received: from [192.168.0.100] ([84.33.66.6])
        by smtp.gmail.com with ESMTPSA id b7sm2482288wrs.47.2018.12.18.04.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 04:49:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: confusion about nr of pending I/O requests
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org>
Date:   Tue, 18 Dec 2018 13:49:07 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDC91F70-B65B-4D1F-95B0-E82478294CA1@linaro.org>
References: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 dic 2018, alle ore 13:45, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens,
> sorry for the following silly question, but maybe you can solve very
> quickly a doubt for which I'd spend much more time investigating.
>=20
> While doing some tests with scsi_debug, I've just seen that (at least)
> with direct I/O, the maximum number of pending I/O requests (at least
> in the I/O schedulers) is equal, unexpectedly, to the queue depth of
> the drive and not to
> /sys/block/<dev>/queue/nr_requests
>=20
> For example, after:
>=20
> sudo modprobe scsi_debug max_queue=3D4
>=20
> and with fio executed as follows:
>=20
> job: (g=3D0): rw=3Dread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) =
4096B-4096B, ioengine=3Dlibaio, iodepth=3D20
>=20
> I get this periodic trace, where four insertions are followed by four
> completions, and so on, till the end of the I/O.  This trace is taken
> with none, but the result is the same with bfq.
>=20
>             fio-20275 [001] d...  7560.655213:   8,48   I   R 281088 + =
8 [fio]
>             fio-20275 [001] d...  7560.655288:   8,48   I   R 281096 + =
8 [fio]
>             fio-20275 [001] d...  7560.655311:   8,48   I   R 281104 + =
8 [fio]
>             fio-20275 [001] d...  7560.655331:   8,48   I   R 281112 + =
8 [fio]
>          <idle>-0     [001] d.h.  7560.749868:   8,48   C   R 281088 + =
8 [0]
>          <idle>-0     [001] dNh.  7560.749912:   8,48   C   R 281096 + =
8 [0]
>          <idle>-0     [001] dNh.  7560.749928:   8,48   C   R 281104 + =
8 [0]
>          <idle>-0     [001] dNh.  7560.749934:   8,48   C   R 281112 + =
8 [0]
>             fio-20275 [001] d...  7560.750023:   8,48   I   R 281120 + =
8 [fio]
>             fio-20275 [001] d...  7560.750196:   8,48   I   R 281128 + =
8 [fio]
>             fio-20275 [001] d...  7560.750229:   8,48   I   R 281136 + =
8 [fio]
>             fio-20275 [001] d...  7560.750250:   8,48   I   R 281144 + =
8 [fio]
>          <idle>-0     [001] d.h.  7560.842510:   8,48   C   R 281120 + =
8 [0]
>          <idle>-0     [001] dNh.  7560.842551:   8,48   C   R 281128 + =
8 [0]
>          <idle>-0     [001] dNh.  7560.842556:   8,48   C   R 281136 + =
8 [0]
>          <idle>-0     [001] dNh.  7560.842562:   8,48   C   R 281144 + =
8 [0]
>=20
> Shouldn't the total number of pending requests reach
> /sys/block/<dev>/queue/nr_requests ?
>=20
> The latter is of course equal to 8.
>=20

I forgot: I did this with a 4.18.  Maybe this is something that has
been changed/fixed?

Thanks,
Paolo

> Thanks,
> Paolo
>=20

