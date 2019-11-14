Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE93EC432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 09:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59C420718
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 09:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfewOOhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfKNJX3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:23:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39323 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfKNJX3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 04:23:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so5038851wmi.4
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 01:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BCms3BoxuxZj117QaSQEkXvp05ODrJPrbrWohMMueC4=;
        b=OfewOOhL+QAfF96fa0GKfmUbo0q4uh91B0zalam9bWDIf8f7hioWJJ+TQrEycpqJnJ
         vFbOE+LjWRY9hL0+FgnRlX8qYmb1DvBWaEet5HHxcrYaIOUcZShgzx1PNnUP8TQ7X923
         P3yHaQANLW4PeEaoIEYmAWABAhDKH2yngBSJSWAivhcNtsuUhlpibrnAFcO7eYjKF8b6
         23C4arl7O2Ahg08TUGK7qgiXcp7BKm+xAedIaavtfQni8Sf+n/Q/r1rJiz47uq9i9PfP
         ykKpVJTKcXN+DXwei7H2kXLbt5VlQWv0d0uq6urW3dij/UV6RXBjkQyGWmd02K3nMQYF
         KhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BCms3BoxuxZj117QaSQEkXvp05ODrJPrbrWohMMueC4=;
        b=TbAs/+T9Lf71meJqNKe7E2twain6QBhJ7R5WhE9ugPyC4IzODnVQxNN/KPGul1ii+c
         fGLlxB8+qZaCL1VouSQn+t7qJ4vttakRJSr3RThsD65oCjT28xEY/1HmrUzWYACgwcmg
         iaq2WAcXXpqrYNWidUkVFL6KXZdWTqspLjp8xt4A6hoBoe3LhSakONlcT7a+Bza4vV4D
         j4mbdO4OPqED0p/jl/LYFtD+3I7i3fHTEu+rqULpf1LYSYnEV3gXZpzailLVLxforbZS
         gpwSiXn4hdIuNV88M9CZiqs4RydtEZIUlxRUyy/IiTC85glDc0P9mgOtx6E7banYEapL
         uq+A==
X-Gm-Message-State: APjAAAUOufXNaKmXGIpUNnYj5i+LsIHlz/pNwT4FARImVyU9hYOOWKxQ
        T5V6tFjj+pSQdYDdIZEPcR4Siw==
X-Google-Smtp-Source: APXvYqyESXs3BB1OOtL7G36o3hJGQSngOs3IodW8l1oVTMn2lW+q2phaKMmi4kuokbdhSaLTF70XBw==
X-Received: by 2002:a05:600c:2307:: with SMTP id 7mr7293039wmo.154.1573723407147;
        Thu, 14 Nov 2019 01:23:27 -0800 (PST)
Received: from [192.168.100.210] (hipert-gw1.mat.unimo.it. [155.185.5.1])
        by smtp.gmail.com with ESMTPSA id t133sm10806453wmb.1.2019.11.14.01.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:23:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5b0b07fc8e50a1beac215230ca84d955@natalenko.name>
Date:   Thu, 14 Nov 2019 10:23:24 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C824EC38-887E-45DB-A629-A75E99ED7454@linaro.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
 <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
 <65fc0bffbcb2296d121b3d5a79108e76@natalenko.name>
 <5773ff54421ccf179ef57d96e19ef042@natalenko.name>
 <69B451DE-B04B-4E0E-9464-826C4A7619AD@linaro.org>
 <5b0b07fc8e50a1beac215230ca84d955@natalenko.name>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 14 nov 2019, alle ore 09:53, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hi.
>=20
> On 13.11.2019 18:42, Paolo Valente wrote:
>>> Il giorno 13 nov 2019, alle ore 16:01, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>> Ok, you may have given me enough information, thank you very much.
>> Could you please apply the attached (compressed) patch on top of my
>> offending patch?  For review purposes, here is the simple change:
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2728,7 +2728,8 @@ void bfq_release_process_ref(struct bfq_data
>> *bfqd, struct bfq_queue *bfqq)
>>         * freed when dequeued from service. But this is assumed to
>>         * never happen.
>>         */
>> -       if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list))
>> +       if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list) &&
>> +           bfqq !=3D bfqd->in_service_queue)
>>                bfq_del_bfqq_busy(bfqd, bfqq, false);
>>        bfq_put_queue(bfqq);
>=20
> The issue is not reproducible for me after applying this patch.
>=20

Great! I'm sending a V2 with your Tested-by.

Thank you,
Paolo

> Thank you.
>=20
> --=20
>  Oleksandr Natalenko (post-factum)

