Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE0C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 11:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDE564E2F
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 11:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBJLR3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhBJLPW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 06:15:22 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA40C06121D
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 03:13:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g6so1977397wrs.11
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rlVxGUSSPCJtH0H34sD4Kgdi20pfZGhuTsAdOvhOScI=;
        b=hvReQJDXBsrRJfdRH2bscBqaQXtTTFgZaPB7ropsz3LUu1SVLvTMDuml8DsTeuuc2F
         NZMT+V7+TPavglEtqu2+hkrzX1iM8HspbHuYsjgdwJ8r9qNWjlSaYdhvRVBxQW70ruxl
         1Rdfw8kjAqi61NDWfyYolBZ91sPgmAhg9QUaGQZqRUp7FgwcfdOnDQ0937PZ8SO0S0ad
         5oUC9QCD+93OZHz2tRixnkU/iLLQKOJjUdkTbEbuqkMKZHzcM81amSzzVoQ5hN63Whma
         HO4VefHoCB2vFtYjAcINEXvh70rh93hfspDAT4ZvAXuuj+yYP6gpTVfvZy74twNhHYtd
         b+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rlVxGUSSPCJtH0H34sD4Kgdi20pfZGhuTsAdOvhOScI=;
        b=tnoADiGTEkDScJdxRiS2hw6jsWrEuZ1YmLQJiVV881Z9I5PImlP5p1bWJNSLQP7n+6
         DAS0FTyvm63AgVnxy57lPqaEOPm3fwfxaq7GydVGYnAAeHn/2shVZApQdUYPspF3GD/Q
         Mx9WVuIsba/I2m6rMNPSkR3X+brRenQH6/BSBlwX7q9dbCNv9ocbKqP8i+R/5te4IYsS
         q7Q/6n2WZUDUVpmricq/PYpF5kUecdkKRMcmIZz/e2ZLFsiaaPYxDjSvNcdUoYKahnmD
         48rGZTEawxjOlPkV25Pu79m5CrU7smEOECvh1YkbrGYOQjv6AH1ezzF3OF5LMz+w5PHs
         q/Iw==
X-Gm-Message-State: AOAM5305XoRudImiNSvei+RMVRGfAWSWPvqfJDMvvXGdFJwI/Lz9JZzt
        k4Mf2UBiC8E1kXm4c4k7t9eXyg==
X-Google-Smtp-Source: ABdhPJzifeUZriIOvo4cDKBY9VmccxjV3W7Obwczmt928UBOjqMcey5uOMdkRLCCerxXQx6AxaYKSA==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr2940604wrw.415.1612955630588;
        Wed, 10 Feb 2021 03:13:50 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t6sm1976264wmj.22.2021.02.10.03.13.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 03:13:49 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] bfq: amend the function name of
 bfq_may_expire_for_budg_timeout()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1611917485-584-2-git-send-email-brookxu@tencent.com>
Date:   Wed, 10 Feb 2021 12:13:59 +0100
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A676DC9-E730-460A-8C39-9E1851343339@linaro.org>
References: <1611917485-584-1-git-send-email-brookxu@tencent.com>
 <1611917485-584-2-git-send-email-brookxu@tencent.com>
To:     Chunguang Xu <brookxu.cn@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 29 gen 2021, alle ore 11:51, Chunguang Xu =
<brookxu.cn@gmail.com> ha scritto:
>=20
> From: Chunguang Xu <brookxu@tencent.com>
>=20
> The function name bfq_may_expire_for_budg_timeout() may be misspelled,
> try to fix it.
>=20

Ok for me to make this name longer.

Thanks,
Paolo

> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
> block/bfq-iosched.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9e4eb0f..4f40c61 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4061,7 +4061,7 @@ static bool bfq_bfqq_budget_timeout(struct =
bfq_queue *bfqq)
>  * condition does not hold, or if the queue is slow enough to deserve
>  * only to be kicked off for preserving a high throughput.
>  */
> -static bool bfq_may_expire_for_budg_timeout(struct bfq_queue *bfqq)
> +static bool bfq_may_expire_for_budget_timeout(struct bfq_queue *bfqq)
> {
> 	bfq_log_bfqq(bfqq->bfqd, bfqq,
> 		"may_budget_timeout: wait_request %d left %d timeout =
%d",
> @@ -4350,7 +4350,7 @@ static struct bfq_queue *bfq_select_queue(struct =
bfq_data *bfqd)
> 	 * on the case where bfq_bfqq_must_idle() returns true, in
> 	 * bfq_completed_request().
> 	 */
> -	if (bfq_may_expire_for_budg_timeout(bfqq) &&
> +	if (bfq_may_expire_for_budget_timeout(bfqq) &&
> 	    !bfq_bfqq_must_idle(bfqq))
> 		goto expire;
>=20
> @@ -5706,7 +5706,7 @@ static void bfq_completed_request(struct =
bfq_queue *bfqq, struct bfq_data *bfqd)
> 			 * of its reserved service guarantees.
> 			 */
> 			return;
> -		} else if (bfq_may_expire_for_budg_timeout(bfqq))
> +		} else if (bfq_may_expire_for_budget_timeout(bfqq))
> 			bfq_bfqq_expire(bfqd, bfqq, false,
> 					BFQQE_BUDGET_TIMEOUT);
> 		else if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
> --=20
> 1.8.3.1
>=20

