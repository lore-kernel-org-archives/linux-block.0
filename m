Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61207C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 12:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0A2186A
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 12:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cs4NzT1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeLRMpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:45:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34466 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeLRMpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 07:45:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so15796539wrw.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=pgtVurqkouqqjNQrhDqXABTTgXAaGn3VbzP1F86YCdg=;
        b=Cs4NzT1cj/WUyJFkXGdzR0fv4uQisQMmYYBuq/dEGaYjV4g93MY+s1egiUTPMgUks+
         64LNBFRwehSY6tOyAHQdJQgh4Qwga3Vu7FF6MZ1hrNL6I86nj52AgnWB/R+Gje473aYt
         PIm5fN5FIgQR3OQS5e57kTsIz436iye1sXIuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=pgtVurqkouqqjNQrhDqXABTTgXAaGn3VbzP1F86YCdg=;
        b=EQHkUX5vCdPc2HyLnHsKtta3ZADs5tm+Y0nGYzO0tkzV1nk7+PFdz9DxiHKdrPNZ5U
         HQRVpeZs9KdkfgsSuTCsc2bOzVpkg7B31MsBhyAG54BYHolYUmJOtko1B1VqKwX2N43H
         aSTp1X83e+4VJJsmQEjOexlJzq9Gr8mGturtjjRcemaTm6E7vWN5EcvOyEbnX9FltGK4
         eGJolwr+81hNtRT41VKDEFpXUKICHs5gsaROo46Tz/Z2rtM5NRCHGJrfHsjoaVeyjw44
         k7hWGPACmUN7aDqk9DsTOgEpf3Md7GqNO0JVApwQiQvmkliDkAcL5psbxhyikU9MGhXi
         PjJQ==
X-Gm-Message-State: AA+aEWa+LCyr9DbA0f7xL5ryzoPh9ZeN0WnFbpoB/YEq52h/51kcpchN
        F//z+YrVngT19XSOB6AUU6lzyg==
X-Google-Smtp-Source: AFSGD/UEPMqSS0F5D1alfytOM1bcQggz+llrhpenfBCtzu+TEBzwwkMp79IE/R7Pm7Uubqp2kFxywA==
X-Received: by 2002:adf:9467:: with SMTP id 94mr14313016wrq.305.1545137131895;
        Tue, 18 Dec 2018 04:45:31 -0800 (PST)
Received: from [192.168.0.100] ([84.33.66.6])
        by smtp.gmail.com with ESMTPSA id t4sm4047254wrm.6.2018.12.18.04.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 04:45:31 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: confusion about nr of pending I/O requests
Message-Id: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org>
Date:   Tue, 18 Dec 2018 13:45:29 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
sorry for the following silly question, but maybe you can solve very
quickly a doubt for which I'd spend much more time investigating.

While doing some tests with scsi_debug, I've just seen that (at least)
with direct I/O, the maximum number of pending I/O requests (at least
in the I/O schedulers) is equal, unexpectedly, to the queue depth of
the drive and not to
/sys/block/<dev>/queue/nr_requests

For example, after:

sudo modprobe scsi_debug max_queue=3D4

and with fio executed as follows:

job: (g=3D0): rw=3Dread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) =
4096B-4096B, ioengine=3Dlibaio, iodepth=3D20

I get this periodic trace, where four insertions are followed by four
completions, and so on, till the end of the I/O.  This trace is taken
with none, but the result is the same with bfq.

             fio-20275 [001] d...  7560.655213:   8,48   I   R 281088 + =
8 [fio]
             fio-20275 [001] d...  7560.655288:   8,48   I   R 281096 + =
8 [fio]
             fio-20275 [001] d...  7560.655311:   8,48   I   R 281104 + =
8 [fio]
             fio-20275 [001] d...  7560.655331:   8,48   I   R 281112 + =
8 [fio]
          <idle>-0     [001] d.h.  7560.749868:   8,48   C   R 281088 + =
8 [0]
          <idle>-0     [001] dNh.  7560.749912:   8,48   C   R 281096 + =
8 [0]
          <idle>-0     [001] dNh.  7560.749928:   8,48   C   R 281104 + =
8 [0]
          <idle>-0     [001] dNh.  7560.749934:   8,48   C   R 281112 + =
8 [0]
             fio-20275 [001] d...  7560.750023:   8,48   I   R 281120 + =
8 [fio]
             fio-20275 [001] d...  7560.750196:   8,48   I   R 281128 + =
8 [fio]
             fio-20275 [001] d...  7560.750229:   8,48   I   R 281136 + =
8 [fio]
             fio-20275 [001] d...  7560.750250:   8,48   I   R 281144 + =
8 [fio]
          <idle>-0     [001] d.h.  7560.842510:   8,48   C   R 281120 + =
8 [0]
          <idle>-0     [001] dNh.  7560.842551:   8,48   C   R 281128 + =
8 [0]
          <idle>-0     [001] dNh.  7560.842556:   8,48   C   R 281136 + =
8 [0]
          <idle>-0     [001] dNh.  7560.842562:   8,48   C   R 281144 + =
8 [0]

Shouldn't the total number of pending requests reach
/sys/block/<dev>/queue/nr_requests ?

The latter is of course equal to 8.

Thanks,
Paolo

