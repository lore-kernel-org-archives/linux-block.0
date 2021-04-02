Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C65C433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 10:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E56D61057
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 10:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBKSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBKSi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 06:18:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9DDC0613E6
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 03:18:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u17so541660ejk.2
        for <linux-block@vger.kernel.org>; Fri, 02 Apr 2021 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wNu5K7GdfB3gh3v2/t6S38ywhzBMIuGf9bGwRtLuo6Q=;
        b=M9S/aGaterCn5KRNaEO2HTn3gyZ3r/iNSDmCixI1pMB1P/vUf7PXFCXeoKjMfc5JHO
         OC39vA9jhYPy6EcP3vDWEPbr+gtlX62cLZKbyWZtaJ+RW8X5oJZ6f6to5P+E4l8m7bBY
         53qurhdsfvvQAIziZLGqRaUunNrmJGkEWRltl8NEjKwj3CPKMrmvZvp5evZ7Zvrs+UUo
         GmpE/weR9yQhyG40I1TBBGkZUotltk+xS72zUb2b3GTRP7VfE8A8qX2nNzmM+r/W1IKs
         qfpSbhZYfizOMQVYddnnowXo89OfTX+Ez8GeN3MtdQZlhFy2T9puLW8314HltPkNjfw3
         C6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wNu5K7GdfB3gh3v2/t6S38ywhzBMIuGf9bGwRtLuo6Q=;
        b=fW8dw9NE+kVgyJEaZb2vRwOVxIX9uJpF0g5F+fFc243huMy3E40295zufCKV86pJY7
         HgZBP8otuw95LTDcEE4u9dkRNAqs/+SLs/sDMPh0/KpQRe/swu6+jcubDAzmAFylh2cQ
         vy4h5pAg0OUz8rlqZQv9iqxPQ/A48iKpHInu75e0U20Hb5aSdr1wqSuXfr4NRo7uO8vX
         mh0uInU9k8NytKScHQFUa9TO+1yZqRuF6Yp1p1kASH/P8N6may5Dahcd1hhYj/D8xHBb
         kYLjAa9SPhzVe4oaY/iKJ5F9ZN3sweVt+p0MO7cwqLWFWfZ3eAGmzKlzZrQIQBd23IF9
         GrGA==
X-Gm-Message-State: AOAM531dwYtPCO/0W5w2MaruIfc5d9tBauN0PSTiDRe7re/0p1E5jO8m
        uAVj2/dgvyVrUDz/eripplxrgBHtsxARz0id
X-Google-Smtp-Source: ABdhPJxH3TB1kFBHoCvTT6Cd6Bxc8aIlefFtVMv5lHP2yywmpMbTHr/tb3608pd52RPNDwAvAG+LmQ==
X-Received: by 2002:a17:906:4747:: with SMTP id j7mr13221783ejs.221.1617358716018;
        Fri, 02 Apr 2021 03:18:36 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id p19sm571197edx.44.2021.04.02.03.18.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 03:18:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] block,bfq: fix the timeout calculation in
 bfq_bfqq_charge_time
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210324023341.1545234-1-wu-yan@tcl.com>
Date:   Fri, 2 Apr 2021 12:18:41 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFDEA399-FCA3-4383-AEE0-91CD74E4D194@linaro.org>
References: <20210324023341.1545234-1-wu-yan@tcl.com>
To:     Rokudo Yan <wu-yan@tcl.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 24 mar 2021, alle ore 03:33, Rokudo Yan <wu-yan@tcl.com> ha =
scritto:
>=20
> in bfq_bfqq_charge_time, timeout_ms is calculated with global
> constant bfq_timeout(HZ/8), which is not correct. It should be
> bfqd->bfq_timeout here as per-device bfq_timeout can be modified
> through /sys/block/<disk/queue/iosched/timeout_sync.
>=20

Hi,
thanks for spotting this.

Reviewed-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
> ---
> block/bfq-wf2q.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 070e34a7feb1..48f540a5ee6a 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -872,7 +872,7 @@ void bfq_bfqq_charge_time(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
> 			  unsigned long time_ms)
> {
> 	struct bfq_entity *entity =3D &bfqq->entity;
> -	unsigned long timeout_ms =3D jiffies_to_msecs(bfq_timeout);
> +	unsigned long timeout_ms =3D =
jiffies_to_msecs(bfqd->bfq_timeout);
> 	unsigned long bounded_time_ms =3D min(time_ms, timeout_ms);
> 	int serv_to_charge_for_time =3D
> 		(bfqd->bfq_max_budget * bounded_time_ms) / timeout_ms;
> --=20
> 2.25.1
>=20

