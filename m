Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C720BC433DB
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 09:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81335235E4
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 09:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbhAVJ56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbhAVJ5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 04:57:40 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C3C061786
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 01:56:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f1so5801606edr.12
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 01:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4IJ+nSeDZs+PTsuKQgs86D7D1ddxmo7h5PHArJlGH4w=;
        b=fxg4jJe35txF+f4y2ZZ31LbCXvkwGjhjsMnnECzPSVTwkI44sKC/580vlYOo2u6oEY
         uGsCGwiICbAHU2abpbudx5sHgGQUUL7IHmhKvnv/3hFqcPEB3FOIwccVZI7gPgw487B5
         blin9hHYWmhaT+ARqcHlEkFquIzY2qs+mjWXCwB/H5VbPOf40lzqTiczA/VOWDvgc5Mu
         C2WsJqp5LpRVZsDaPVtGJlOTvLdO7l2HcS7wL9k51rbFKpZiXh20exf00vmmtMiTzShY
         D1o3EVcGc0j7J5SDGmef63IbxJCk61Tv5Wyh+YAZIi8jFe/l56eitgAPHmr7URARidYP
         GYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4IJ+nSeDZs+PTsuKQgs86D7D1ddxmo7h5PHArJlGH4w=;
        b=J/uSSrNTQSh1JuAA4Br6DlNirEKwV92AHZDlhkzzo5R2PgumKaVqVCz1kKFvpSDmyS
         apTn4r0LidbqLZzyTZ4u9ozLlBkYBLv9e1KyZC8wdrE/iAkibXOpl74G4LRKHId6DB5s
         zsLa+hwaQXjuplqPxURSPyCxFkJdTYG97PbtipTjuni4/g+Fk8PNZjF9/OzRe/8Oy94y
         TRe7SegxmKLZxyfzLs0bOM5pwu9n3uE7GJGLPKJYI7Fb8S78jsw0/g+cqpq73omUthDZ
         I3hYky0yMzz/EQ9gCKPTi6LdBkkiGn4bFAqcLPLS+pJb76MFT2ENcuyWlsii9VKdiLjI
         53lw==
X-Gm-Message-State: AOAM532u5ZdQl0AozaWPnIR+8bAplGaCy1maLQm+YXXtA1BV9s77bHR/
        WA499RYqyJ5NOaH1jkHtZuY+3A==
X-Google-Smtp-Source: ABdhPJzDwLFvj3q+rfSW+Z0LN6FtPhpFzluKdhpyMy/8rsL9/OuQdnSbHvYFaJ3IRvhgYkr7xUeNBQ==
X-Received: by 2002:aa7:d511:: with SMTP id y17mr2631337edq.112.1611309416063;
        Fri, 22 Jan 2021 01:56:56 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id lv13sm4039513ejb.55.2021.01.22.01.56.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 01:56:55 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bfq: don't duplicate code for different paths
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20201225130016.20485-1-huhai@tj.kylinos.cn>
Date:   Fri, 22 Jan 2021 10:56:54 +0100
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B8B93BA-AAA5-4D11-8521-E26DD553034C@linaro.org>
References: <20201225130016.20485-1-huhai@tj.kylinos.cn>
To:     huhai <huhai@tj.kylinos.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 25 dic 2020, alle ore 14:00, huhai <huhai@tj.kylinos.cn> ha =
scritto:
>=20
> As we can see, returns parent_sched_may_change whether
> sd->next_in_service changes or not, so remove this judgment.
>=20

Thank you very much for spotting this mistake!

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: huhai <huhai@tj.kylinos.cn>
> ---
> block/bfq-wf2q.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 26776bdbdf36..070e34a7feb1 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -137,9 +137,6 @@ static bool bfq_update_next_in_service(struct =
bfq_sched_data *sd,
>=20
> 	sd->next_in_service =3D next_in_service;
>=20
> -	if (!next_in_service)
> -		return parent_sched_may_change;
> -
> 	return parent_sched_may_change;
> }
>=20
> --=20
> 2.20.1
>=20
>=20
>=20

