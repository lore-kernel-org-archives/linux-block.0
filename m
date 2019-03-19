Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6072CC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD902173C
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDo5Qep5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfCSOhD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:37:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33643 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSOhD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 10:37:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so5791236wrp.0
        for <linux-block@vger.kernel.org>; Tue, 19 Mar 2019 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXHXRGPXeHJwHDbPEkajJgyglTef9vh3EoeeoiI6WbI=;
        b=WDo5Qep5osut5rw60Pc4N9b6TlYMQGw3flP6ecBvZab4WqgyfFJeWo617nhGpGF/RS
         BfmOrgg4k7Lly7blbL+8oUD5qjh9t2HZ+UrzkhTALfBZfLZYmVCnEnNyEs1SqGammTA6
         rEEVOTdJyVUZcqJjxrYxBCi0X1862hG7BKgRVLJFx86LIpnkE526lHLXgDAzbbUBr6uS
         rJ1/jgDq2GUdvYkfT7x7ykCqlQoeYgfGtbEm8dg8Nz2iZwm+2RqlQ0nLWvui1cm8JwOu
         DPS4uSLLoVea0FhDGbS+j4qgqVE26OYiSBWA/LAy73X9AwtByDktsx32yUuMaourlFR4
         +qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXHXRGPXeHJwHDbPEkajJgyglTef9vh3EoeeoiI6WbI=;
        b=qJYKD86Hb3jJ4u8QEnyXlm4NNWLKb+v+EY2qNl8pv8ZZAWaE1Tfa8rRljtYphNE+Nz
         T+0kxHVeOxIbu9nYgcgy6yypukcmUf3NU4XKC7nHhKryGCHyhxS9dZmWv5+czvIt9gqB
         udiquOh1bILkJCsxVCGhmrrBvspGjtg6zl1s/SqjzfLf2KP5dVuDtQp+1JiPkpKfp34s
         E/L3H/LPSBmZknyH5//3Wdnj+cgTq0S5JjfJ1P33e4Wk9bz/SupS2Qd31YpkhshFITBo
         1a8u1iwo3kOMUBC2C/afYJYMJzuXTIGaa/Dl6Czv2ua3hvlntAUX6uVfP2uJ1bHOA9pm
         UWcQ==
X-Gm-Message-State: APjAAAV4ISxvbJdZ5zD9D5JUCS2zfPrp7P4GXW6wHmtrVr6SwDqUtTQg
        q1K6GSIsdoLivXbmEubCuWBCKbOgpCWwzOU11GHBNw==
X-Google-Smtp-Source: APXvYqxpOWjGacE5xnHX87A5De9Gv4iEWLPeYRCKsZ1srB7A2JIFzkpAnp3Yp/hV8OTHM9+7BySOSLI1vMTuEm69CtM=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr18207719wro.24.1553006221285;
 Tue, 19 Mar 2019 07:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ9A4Zc8Fc4bDyAsiduTw4kTpxR=dVZr7LUdqUkvQSu1CaGpg@mail.gmail.com>
 <20190318222133.GA24176@localhost.localdomain>
In-Reply-To: <20190318222133.GA24176@localhost.localdomain>
From:   Nikhil Sambhus <nikhilsambhus@gmail.com>
Date:   Tue, 19 Mar 2019 10:36:47 -0400
Message-ID: <CAFQ9A4YECyhaAyPzq+k4siPy9h-xQPjA9HUGu+4ZHHfe4zi0Zw@mail.gmail.com>
Subject: Re: Error while enabling io_poll for NVMe SSD
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks, it worked!

On Mon, Mar 18, 2019 at 6:20 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Mar 18, 2019 at 06:14:01PM -0400, Nikhil Sambhus wrote:
> > Hi,
> >
> > On a Linux Kernel 5.0.0+ machine (Ubuntu 16.04)  I am using the
> > following command as a root user to enable polling for a NVMe SSD
> > device.
> >
> > # echo 1 > /sys/block/nvme2n1/queue/io_poll
> >
> > I get the following error:
> >
> > bash: echo: write error: Invalid argument
> >
> > The current value of io_poll is 0.
>
> Be sure to turn on the polling queues in the nvme driver. There are none
> by default. The kernel parameter to that enable them is:
>
>   nvme.poll_queues=X
>
> Where 'X' is the number of polling queues. I'd recommend at least 1 per
> CPU socket, but more is better.



-- 
Regards,
Nikhil P Sambhus

"To bug is human, to debug is divine"
