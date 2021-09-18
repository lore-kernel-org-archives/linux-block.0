Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B18CC433F5
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E543660F9C
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 10:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhIRLAD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Sep 2021 07:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhIRLAC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Sep 2021 07:00:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF8FC061574
        for <linux-block@vger.kernel.org>; Sat, 18 Sep 2021 03:58:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b21-20020a1c8015000000b003049690d882so11831356wmd.5
        for <linux-block@vger.kernel.org>; Sat, 18 Sep 2021 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vWd1P9CRMg4Pz32pKAdM/AeB1mjDQwEtw2WgM5SSPF4=;
        b=GxP0VJpMjSAQnSHcRpp4VCpSN/uRrPem/sJhQjSmYVjX2Nw2C/yttldCuXQ+f0ykbE
         NKHX8rRdL1nNWUItN04YdRX+rBg7bQNJqbz2LXKRwRkSlhJuK8K7J4/52ih6tcghqYMF
         y0UzTsV/V9sDOmjJatw0QpHA4Xgw6wU4n2G13STe9cLpCXX+ayk9Ezy7UovFQ+brSvfq
         gNdOpz1gt1CTpmSBiFNNk9P4V2BihgMyJbQ1K3JW0tSyz3A4iCc64KI5kNUpkqzIYjwb
         sAvDdTV6uk9Q583QFv5d6GR/RQd2ePJ+leMWJeZk648w+jS6YeV1v5+CIm51V7lPanpA
         AQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vWd1P9CRMg4Pz32pKAdM/AeB1mjDQwEtw2WgM5SSPF4=;
        b=IB6lff4MwvJBVQ6VlN/GKf+x91fLDvoKu0lRZWqIgMsoe4ArWMostGea9hfHHMZyPp
         T9NC5oiFiDdyMs5dQXvxH8g7y4O5adHX9dsl+k0lA183qbfvte5Z7UGi4pWK9x5mdL5P
         kh8Ag7YxajNL9JM7MXsKSDGL1gVeF3dx5r35zNrpGAfJOsdKav0P99/6TxAyjhztW2DX
         AIxX/Zvl/HLQaHSOGivqpUe/hwXtt2Cu9rUkozVZcFG6gw0M4oMJ4Bx4dCAsUn9WuNge
         wvFI/mGcB/wDAfJp3KyzU9TR1s/zTZdC9rvn2b/vYn6LSd2z/XKXr0nDcYX8kXAIHz/Z
         7pWg==
X-Gm-Message-State: AOAM533bxceZeqy2WV5AcEuii4kjUma7gSVAyNHLxkoWhsvvuK2it9Lw
        Rh1YDC99ri17wRjBBRGEMUUnbxrPSxAu8Sbv
X-Google-Smtp-Source: ABdhPJxSyiFNq68PRmyizGNSlpPnsbg5rU+WBrY04XMiZa5i2IpyjvwRgxGTN6xkeBABfE2iUk2CWw==
X-Received: by 2002:a05:600c:4a16:: with SMTP id c22mr10044589wmp.72.1631962717572;
        Sat, 18 Sep 2021 03:58:37 -0700 (PDT)
Received: from [192.168.136.233] ([37.160.169.152])
        by smtp.gmail.com with ESMTPSA id v10sm9858370wri.29.2021.09.18.03.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 03:58:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3 v2] bfq: Limit number of allocated scheduler tags per
 cgroup
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210915131512.GB6166@quack2.suse.cz>
Date:   Sat, 18 Sep 2021 12:58:34 +0200
Cc:     =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF7AAF20-7D9E-4305-901A-86A3717A9CFB@linaro.org>
References: <20210715132047.20874-1-jack@suse.cz>
 <751F4AB5-1FDF-45B0-88E1-0C76ED1AAAD6@linaro.org>
 <20210831095930.GB17119@blackbody.suse.cz>
 <20210915131512.GB6166@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 15 set 2021, alle ore 15:15, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Tue 31-08-21 11:59:30, Michal Koutn=C3=BD wrote:
>> Hello Paolo.
>>=20
>> On Fri, Aug 27, 2021 at 12:07:20PM +0200, Paolo Valente =
<paolo.valente@linaro.org> wrote:
>>> Before discussing your patches in detail, I need a little help on =
this
>>> point.  You state that the number of scheduler tags must be larger
>>> than the number of device tags.  So, I expected some of your patches
>>> to address somehow this issue, e.g., by increasing the number of
>>> scheduler tags.  Yet I have not found such a change.  Did I miss
>>> something?
>>=20
>> I believe Jan's conclusions so far are based on "manual" =
modifications
>> of available scheduler tags by /sys/block/$dev/queue/nr_requests.
>> Finding a good default value may be an additional change.
>=20
> Exactly. So far I was manually increasing nr_requests. I agree that
> improving the default nr_requests value selection would be desirable =
as
> well so that manual tuning is not needed. But for now I've left that =
aside.
>=20

Ok. So, IIUC, to recover control on bandwidth you need to
(1) increase nr_requests manually
and
(2) apply your patch

If you don't do (1), then (2) is not sufficient, and viceversa. Correct?

Thanks,
Paolo

> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

