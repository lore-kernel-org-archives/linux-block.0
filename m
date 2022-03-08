Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E55C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 09:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbiCHJOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345192AbiCHJOA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 04:14:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B611A2982D
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 01:13:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o1so22490291edc.3
        for <linux-block@vger.kernel.org>; Tue, 08 Mar 2022 01:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4xwIW2FJYN5j+5RpBlcJYuBie5cHjb16/BXLSJiVNSY=;
        b=ypJzaTljTOo6hefJ35LpGKLHL3EV/E+qUm7RmOF7jFkbNwvnZ7NE7pj1pciq1eaGEx
         A9+HaBmn4ZwWdKhvzi4CxYEcga8QQKxMNXjQIL+PPRXQN8l4TjfuaBfxRf1oQWGvsv36
         pIxBpWfjRGX8AWwqWEKtMrRLWhVuRldd5fsXMySEv+e0RBX6aMBjjfHNdq4xqB87p2MX
         Pbx5+z+G9WrfaIyRL3RocGY17/KjWur1G4PQx2H4kUqYFv1T4y26wfq8zZKaZIk8C85Q
         zSuczI3jgq+AWeWFuJvqXZ88sWFey3H4gKdsoC9UWGCJCHmZv/FSUGeSmgY7a6Yo8qjo
         XBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4xwIW2FJYN5j+5RpBlcJYuBie5cHjb16/BXLSJiVNSY=;
        b=DA33qDmU/MyTQhx7EfSz7SF38q6Rmath3x6nkR9gJLkqEr6kBQEWZrEbiQS27kN1T6
         uFbiOVo1QpfiVG+4GpGpyBQWczrRZslvuJ0r/kiKJ5MSCRvOi4NJJdxjrTT94qoNPvGw
         wIBHEwLu9Ol8O6aP7IY+lZhz/807ORtj84mZXApuS01nP8URZJHFT2GOhPICBY6qGhCA
         1G2etf5+LFpOkXolcO1gfuDURpRvAMYPKBmTwea0+BvrkjiWeaNW76drb+jnrizlrz0a
         kUz9m+tYhKVlCxmAkhrNwZgBFSXDF8fyVmWTNin8htNTk5qThISOKm+pjm9R6JwtjxQ4
         4ATQ==
X-Gm-Message-State: AOAM530eD6ysTEv6C0oaXTiKENs90b49Wid7+faAek5hACKOV1v27TGz
        uWcjNH7DneOSPmnLxETsk/yHy7R8Izjr+g==
X-Google-Smtp-Source: ABdhPJwTlh4V/ELL3KLh8UL7xqheRe8zLtuSqQpxO+IwY6dI3zfokmYKYwTSL1sL/5eKrJcyK3Ix4w==
X-Received: by 2002:a50:e08c:0:b0:407:cdc6:809e with SMTP id f12-20020a50e08c000000b00407cdc6809emr14953408edl.162.1646730781303;
        Tue, 08 Mar 2022 01:13:01 -0800 (PST)
Received: from [192.168.0.15] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b006cf61dfb03esm5663090ejc.62.2022.03.08.01.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:13:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bfq: default slice_idle to 0 for SSD
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220308000253.645107-1-khazhy@google.com>
Date:   Tue, 8 Mar 2022 10:12:59 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <61B4B869-1B0B-4FE9-9AEE-712A3F50EDA6@linaro.org>
References: <20220308000253.645107-1-khazhy@google.com>
To:     Khazhismel Kumykov <khazhy@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 mar 2022, alle ore 01:02, Khazhismel Kumykov =
<khazhy@google.com> ha scritto:
>=20
> This improves performance on SSDs dramatically, and was default for =
CFQ
>=20

Ho,
unfortunately it is unacceptable, because it simply switches BFQ off =
with sync I/O.

Thanks,
Paolo

> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
> block/bfq-iosched.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 36a66e97e3c2..f3196036940c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7105,7 +7105,8 @@ static int bfq_init_queue(struct request_queue =
*q, struct elevator_type *e)
> 	bfqd->bfq_fifo_expire[1] =3D bfq_fifo_expire[1];
> 	bfqd->bfq_back_max =3D bfq_back_max;
> 	bfqd->bfq_back_penalty =3D bfq_back_penalty;
> -	bfqd->bfq_slice_idle =3D bfq_slice_idle;
> +	/* Default to no idling for SSDs */
> +	bfqd->bfq_slice_idle =3D blk_queue_nonrot(q) ? 0 : =
bfq_slice_idle;
> 	bfqd->bfq_timeout =3D bfq_timeout;
>=20
> 	bfqd->bfq_large_burst_thresh =3D 8;
> --=20
> 2.35.1.616.g0bdcbb4464-goog
>=20

