Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D89C433F5
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 10:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C1261207
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 10:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhKJK1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 05:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhKJK1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 05:27:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4DFC061764
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 02:24:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so4223985wme.0
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U0dTDAumU/CZgu/m2yDZYb0TCVcSZTKnFSnRL+2GVhY=;
        b=IDWWIKxwyg8x3j5FSIaDLmHtBc3yX8nv83YKgVOSgda5EifPi2f9+6zaZTMuzS2lhr
         42R/BqK/6KGck1tN0JK6mrdtXiRGcYHDv4Q71mjPDEqKiyTF5Gcg/XWYflzq7tvcH14w
         ByMKkp2rlyB/KLGdrxpHQrDiDDVvtYiFKSIYotETMJ4P38PD+VM9B3c0SjsqNRZ6pPZ3
         o7hrZ90YB68vguyejoUcVQxjNHneF9l6tbcTO6gNO2CTpUPekR21BFBe9eM5KCLjg3Wx
         48W8sbjsJKvNS2X+0TNQDNoDCTwYQ1j5nPxvyYapLiFmZM6WhsaYCWj1lacLde/f9pka
         KuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U0dTDAumU/CZgu/m2yDZYb0TCVcSZTKnFSnRL+2GVhY=;
        b=fztvl9EmSHZXe3uyNT1KtHGImXLlx9rP8vP71dC9Z2jgDTmlwI6Pawr2pXpNjji+xw
         kvpVPUv0sx67Y4MQY2PDa7SwfhwSAMKlHbm9tXdm3GmL/p+Kkoyis5lMQTiWQuiGJ11M
         /L6YLnpvydfRrZCpyH/9m0hkGqGsIGdWNTQh6KoJTw1hENB6TlH3cvAqQl6gU55o/PTy
         Ifl2LXya0PnwbGZzA9reQYPhbPQL67DJ/ifUWk+bytTwTYHF6EZlXB9AKwZ2tPaLYpl9
         JDXZkNcS4E95c5eymL0tDfgU9HDgF0D1AgVePAwmsXJ6AHsvphnbijoSHUALPMU7wf4A
         yU/w==
X-Gm-Message-State: AOAM533rKgbWXDpGTJTTV6gPzjfuZm3jrj+GSyd+fVDbVsGpx5pZZak0
        nkJro/fi2ZWACadFBAEAzs6Qdg==
X-Google-Smtp-Source: ABdhPJzXHTxaUP9KZtRcV8lxdrqxmoTpqoef97LKNBQLOg7tl1bW1MXYtEAlASQGBdPccb5qyzRAjQ==
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr14883235wmo.136.1636539893631;
        Wed, 10 Nov 2021 02:24:53 -0800 (PST)
Received: from [192.168.0.14] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id c5sm19463720wrd.13.2021.11.10.02.24.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:24:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/8 v3] bfq: Limit number of allocated scheduler tags per
 cgroup
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211025111447.GB12157@quack2.suse.cz>
Date:   Wed, 10 Nov 2021 11:24:51 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        237826@studenti.unimore.it, 224833@studenti.unimore.it,
        Giacomo Guiduzzi <224804@studenti.unimore.it>,
        238290@studenti.unimore.it,
        PAOLO CROTTI <204572@studenti.unimore.it>
Content-Transfer-Encoding: quoted-printable
Message-Id: <834E408E-3F06-4FA4-AF03-3579FFC1AA76@linaro.org>
References: <20211006164110.10817-1-jack@suse.cz>
 <D76F0193-9573-44B9-A401-97D2A0DB846B@linaro.org>
 <C7CBAECF-A7F3-4AA0-8F10-D7EC267AD4BE@linaro.org>
 <20211025111447.GB12157@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 25 ott 2021, alle ore 13:14, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Mon 25-10-21 09:58:11, Paolo Valente wrote:
>>> Il giorno 7 ott 2021, alle ore 18:33, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>> Il giorno 6 ott 2021, alle ore 19:31, Jan Kara <jack@suse.cz> ha =
scritto:
>>>>=20
>>>> Hello!
>>>>=20
>>>> Here is the third revision of my patches to fix how bfq weights =
apply on cgroup
>>>> throughput and on throughput of processes with different IO =
priorities. Since
>>>> v2 I've added some more patches so that now IO priorities also =
result in
>>>> service differentiation (previously they had no effect on service
>>>> differentiation on some workloads similarly to cgroup weights). The =
last patch
>>>> in the series still needs some work as in the current state it =
causes a
>>>> notable regression (~20-30%) with dbench benchmark for large =
numbers of
>>>> clients. I've verified that the last patch is indeed necessary for =
the service
>>>> differentiation with the workload described in its changelog. As we =
discussed
>>>> with Paolo, I have also found out that if I remove the "waker has =
enough
>>>> budget" condition from bfq_select_queue(), dbench performance is =
restored
>>>> and the service differentiation is still good. But we probably need =
some
>>>> justification or cleaner solution than just removing the condition =
so that
>>>> is still up to discussion. But first seven patches already =
noticeably improve
>>>> the situation for lots of workloads so IMO they stand on their own =
and
>>>> can be merged regardless of how we go about the last patch.
>>>>=20
>>>=20
>>> Hi Jan,
>>> I have just one more (easy-to-resolve) doubt: you seem to have =
tested
>>> these patches mostly on the throughput side.  Did you run a
>>> startup-latency test as well?  I can run some for you, if you prefer
>>> so. Just give me a few days.
>>>=20
>>=20
>> We are finally testing your patches a little bit right now, for
>> regressions with our typical benchmarks ...
>=20
> Hum, strange I didn't get your previous email about benchmarks. You're
> right I didn't run startup-latency AFAIR. Now that you've started =
them,
> probably there's no big point in me queuing them as well. So thanks =
for
> the benchmarking :)
>=20

Hi Jan,
we have executed a lot of benchmarking, on various hardware.  No
regression found!

So, thank you very much for this important contribution, and:

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

