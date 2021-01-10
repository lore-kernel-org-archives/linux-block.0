Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFECC433DB
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227B023B09
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAJJVI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbhAJJVG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:21:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F763C06179F
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:20:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t16so13236692wra.3
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gNGwDauNV6Xa0/z//tx3bUDvZhOjgqMBiBUEjPh1/NY=;
        b=pqK5NI8pBmokkYYJ7qmRH/FsR41EUifGmA9Q3cnsUOB3umK1ggHvGSoh+SM2W0NUZe
         9eMX8yWHyOWKSLsG4/FLlnIhJiFwtUnsUUugS7jRoVNHajSTjUyqFuQGKxHh1OWPVYDg
         47XtudZF/lRW7YgHIln6LJLjPT/uiTCp09rJY/dMomVKEQf2uRyXHeIUv6EAH+0Z2yyy
         wuo+LGgEtIeKYoAq/rb+rPno0DI1x0QBnwWdsORCy53vhSiwXfnBj9S5BtoAVvJPW5xR
         4AcsmdmQnzLu5aKsATJYkj9FUf7FZcz15pHjZ4u8+8YZKmc+R3YFm2s/spe/0qhYqyXD
         woIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gNGwDauNV6Xa0/z//tx3bUDvZhOjgqMBiBUEjPh1/NY=;
        b=T6fzdrOBFC9oqHp5Xr28Zl61KZ9eUPbqfssrYMcm3pAyollu0QJ55vLQHRwH59k17v
         hJFK4g6uHclv28Pkundr2l2RKX3F12imOk73GfKDmhSRoGZse7eJm1yYQp5ydOq9ISSa
         QQU04IlT25wJlZ8uanVkTM5kP1HU6XkHR6Tm4hsiHx3lDltA0DmApKV/NgTPlqVoeqhb
         ixU7uMkb9/5IYLgC9Mipk69j4cdu422xWEenUcIisskXhRsmC03q4NUM3uqp9DSD08nz
         Uvhm/vhl6mgkaRFPVoqUjOfZ75r8becIwAOIXXTNd77u22Bw6HSi7K3lf35xOtxQqo5c
         pjZA==
X-Gm-Message-State: AOAM530RgqRE+nUniPypUWqYXCdqplU/n0VphGa/tTbD5M3J8Scbke/0
        A2vqOUkQW+eH3qAiEpWIAhMN8w==
X-Google-Smtp-Source: ABdhPJz7Al2hWZI7Gadq3cZUMEvo65e9HOhYU6Wgt8Hak73oy1zzAEE2wN5T255l7yNozyJnEfqW9g==
X-Received: by 2002:adf:f891:: with SMTP id u17mr11562032wrp.253.1610270424209;
        Sun, 10 Jan 2021 01:20:24 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id f77sm17485617wmf.42.2021.01.10.01.20.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 01:20:23 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] bfq: Fix check detecting whether waker queue should
 be selected
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200409170915.30570-2-jack@suse.cz>
Date:   Sun, 10 Jan 2021 10:20:22 +0100
Cc:     linux-block@vger.kernel.org, Andreas Herrmann <aherrmann@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F338859F-DAD2-4D16-8E66-52387356E78D@linaro.org>
References: <20200409170915.30570-1-jack@suse.cz>
 <20200409170915.30570-2-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 9 apr 2020, alle ore 19:09, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> The check in bfq_select_queue() checking whether a waker queue should =
be
> selected has a bug and is checking bfqq->next_rq instead of
> bfqq->waker_bfqq->next_rq to verify whether the waker queue has a
> request to dispatch. This often results in the condition being false
> (most notably when the current queue is idling waiting for next =
request)
> and thus the waker queue logic is ineffective. Fix the condition.
>=20

Hi Jan,
my huge delay causes problems again, because a student of mine already
made this same fix a few months ago.  But I did not send it out yet,
for lack of time.  If ok for you, we could go for a common commit with
two authors (I seem to remember it is feasible).

Thanks.
Paolo

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 78ba57efd16b..18f85d474c9c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4498,7 +4498,7 @@ static struct bfq_queue *bfq_select_queue(struct =
bfq_data *bfqd)
> 			bfqq =3D bfqq->bic->bfqq[0];
> 		else if (bfq_bfqq_has_waker(bfqq) &&
> 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
> -			   bfqq->next_rq &&
> +			   bfqq->waker_bfqq->next_rq &&
> 			   bfq_serv_to_charge(bfqq->waker_bfqq->next_rq,
> 					      bfqq->waker_bfqq) <=3D
> 			   bfq_bfqq_budget_left(bfqq->waker_bfqq)
> --=20
> 2.16.4
>=20

