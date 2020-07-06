Return-Path: <SRS0=7JbN=AR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1313C433E0
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0382074F
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 07:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zw5NNvo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgGFHQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgGFHQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jul 2020 03:16:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E8C061794
        for <linux-block@vger.kernel.org>; Mon,  6 Jul 2020 00:16:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so15021819wmc.1
        for <linux-block@vger.kernel.org>; Mon, 06 Jul 2020 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vLESYTwRgIEzacl15YJZpza+9kyceaKMoLaqX6m40MQ=;
        b=zw5NNvo0Eu8+IjaRXjHxdwT7ZCRIe6Hu5r+f7ZNg90MoD5ohiSJUqHDU9OIVb60+XQ
         9sUReu++a5Tt3Tss82ZcGbLj0IKCgXbaRcfjoI0tGvMB/VIBiYuw4OsJ01mSnZw7V7wk
         0O6c0nR4tqeQSRmhRfaEvPnxHCi63gP03Fa5QK7068l5Pdou723cpl/3IOY1GD89/jQc
         zmORq0LL3qzmOaTNZTjE0t+aU74ki50BSFYcihFvaYRHfAZ0ZAgzS8Be/k1OZIjS0j1W
         CCW/tW7hrDJKWK67ZG65n0D7oNmw9UNzRzIBLilvw+X5ufYy4KDirDG5Z5TqiusMo0E9
         mD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vLESYTwRgIEzacl15YJZpza+9kyceaKMoLaqX6m40MQ=;
        b=JPvFyDfDmmoxCd6kOEfq8/XE3AOqnCUwSzRJo27r3MDYB3OFMJCCFHOmif/MtmHzx1
         x6kz7aXW4/p4ihxKjIOKMx/LhgwARHw6wxIClL3HLRpz1WD5kLkPHzrZlJkQSBfjqcJj
         ElJtzV1NJ4NecwLlUpbbV+ij0k2qajeJTWvaYZtFld4mewNJJ2WScktP6CFz+Sv2Dae0
         xizQmCRx1c5wr50jjdOzktwITVs7SD68A0R5S6dZB+INzWR7FvaytGBpGeg+MHUR62ul
         QQQUuSnUc9O55DENluphQSP55IOdIoxownF3fsma0bd8x60SdWpDDDfNKBH5bzd1lBua
         B9Cg==
X-Gm-Message-State: AOAM530qmRZ+lzDHqoIJjwFensFa377NYPDpbsn8+zowmZrWrKZ+0YOh
        eKK+o/w+0KYg6m5FCUiXPKUvBA==
X-Google-Smtp-Source: ABdhPJxfyyFOAUjRwqmCoAeF7td/gWS8mcZ3rJISSVH2W0WCap4JqRbYzRLfeVuu43SB0/OV5bV9zw==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr45546915wmk.127.1594019811942;
        Mon, 06 Jul 2020 00:16:51 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id 22sm23456880wmb.11.2020.07.06.00.16.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 00:16:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] docs: block: update and fix tiny error for bfq
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200703061323.959519-1-yuyufen@huawei.com>
Date:   Mon, 6 Jul 2020 09:17:06 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <295D7F7E-2B17-469C-B758-9A9DAEC65E66@linaro.org>
References: <20200703061323.959519-1-yuyufen@huawei.com>
To:     Yufen Yu <yuyufen@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 3 lug 2020, alle ore 08:13, Yufen Yu <yuyufen@huawei.com> ha =
scritto:
>=20
> The max value of blkio.bfq.weight is 1000, rather than 10000.
> And 'weights' have been remove from /sys/block/XXX/queue/iosched.
>=20
Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks!
Paolo

> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
> Documentation/block/bfq-iosched.rst | 9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/Documentation/block/bfq-iosched.rst =
b/Documentation/block/bfq-iosched.rst
> index 0d237d402860..19d4d1570cee 100644
> --- a/Documentation/block/bfq-iosched.rst
> +++ b/Documentation/block/bfq-iosched.rst
> @@ -492,13 +492,6 @@ set max_budget to higher values than those to =
which BFQ would have set
> it with auto-tuning. An alternative way to achieve this goal is to
> just increase the value of timeout_sync, leaving max_budget equal to =
0.
>=20
> -weights
> --------
> -
> -Read-only parameter, used to show the weights of the currently active
> -BFQ queues.
> -
> -
> 4. Group scheduling with BFQ
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> @@ -566,7 +559,7 @@ Parameters to set
> For each group, there is only the following parameter to set.
>=20
> weight (namely blkio.bfq.weight or io.bfq-weight): the weight of the
> -group inside its parent. Available values: 1..10000 (default 100). =
The
> +group inside its parent. Available values: 1..1000 (default 100). The
> linear mapping between ioprio and weights, described at the beginning
> of the tunable section, is still valid, but all weights higher than
> IOPRIO_BE_NR*10 are mapped to ioprio 0.
> --=20
> 2.25.4
>=20

