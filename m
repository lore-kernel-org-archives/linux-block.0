Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBAC4320A
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 09:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE386108E
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 09:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbhHZJRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbhHZJRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 05:17:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7A7C0617AE
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 02:16:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h9so4778446ejs.4
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=90TIyffent6yuxV6QDlLnnHkqBnMdkJ8+S8MmEfNLOU=;
        b=xdP1R9EOVxkWxskVHUZ/6xAsVNeqvfrL6EWPaBrwt0zzv1x7+KpvYWzehCoPPZgqmv
         fis70gWGZZVTCglX8vYu45fR+FRrWqVn1xDuPSTkUie1I9xx/01IfCkzgxI1bO0nRhva
         OCjfC3+aOK+hJnZ+D0+hCwZCgnpseKwvRoexv/yToXVSTAZjtrXR5AF97Txz82oTDLI+
         Ch8YrZeU0oZOCfURGJhBOzyICWdt5Ax7/LFrUfsxIuLQp1D6CZs9OpXHIGjQmaVxmtjj
         S8nTPtniHdJdSzFGvuy4xK2V4y4Dxl0DHb7kXF7Tq7CcWIITQozNispEw75MHmPAMlF5
         ujCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=90TIyffent6yuxV6QDlLnnHkqBnMdkJ8+S8MmEfNLOU=;
        b=ulPxmsOVVKE2NUnBOzYkw983Dj+y3Hlbwmov4E+muCTnalynuaFO4FEjUuKUoAtDVb
         UaXis/OqCSqJ5rcsGv1IWKjlnRVqFPwp9kIY25QsayH9FjZqeeLLVkbQeyDe+nBWQQxA
         lpfO3IIumZ6oYWCZmzrCUZxXbhLvdAQl0mGr82Mk87mXfmdgadkbd3dtAbZ8hn9lTpCf
         ynz65+eHChOpydAaxDMCt1f3wEGNd/5ayW/yJlWvH84sdKQUay0nv0qahFFl+otCESdS
         1WXBGUiKRtsKfifAZF0/FaYcNFuAJgzegcwveKapIvId5DW0FJF+rE3VQmo/iUXN0fuy
         pciw==
X-Gm-Message-State: AOAM532fJB0jeNUDqWKEvMRnpd8404KAk7tLc1496xwf01GgPEYP2mZ9
        PxFfg23EPDh9MDayrQVchtnjiIwg2yuy5w==
X-Google-Smtp-Source: ABdhPJylWjVA4kpr0V8eWdrrFPQWt78ndRnXS0UO2Dwe8Y60vHYtCBMJCMP55/DytJUDSf5SO8vR1Q==
X-Received: by 2002:a17:906:b4d:: with SMTP id v13mr3242614ejg.468.1629969379325;
        Thu, 26 Aug 2021 02:16:19 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id ca4sm1058557ejb.1.2021.08.26.02.16.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 02:16:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: honor already-setup queue merges
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210802141352.74353-2-paolo.valente@linaro.org>
Date:   Thu, 26 Aug 2021 11:16:17 +0200
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidezini2@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BDD27BD-F49B-43B6-B41D-F7534B596A9A@linaro.org>
References: <20210802141352.74353-1-paolo.valente@linaro.org>
 <20210802141352.74353-2-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 2 ago 2021, alle ore 16:13, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> The function bfq_setup_merge prepares the merging between two
> bfq_queues, say bfqq and new_bfqq. To this goal, it assigns
> bfqq->new_bfqq =3D new_bfqq. Then, each time some I/O for bfqq =
arrives,
> the process that generated that I/O is disassociated from bfqq and
> associated with new_bfqq (merging is actually a redirection). In this
> respect, bfq_setup_merge increases new_bfqq->ref in advance, adding
> the number of processes that are expected to be associated with
> new_bfqq.
>=20
> Unfortunately, the stable-merging mechanism interferes with this
> setup. After bfqq->new_bfqq has been set by bfq_setup_merge, and
> before all the expected processes have been associated with
> bfqq->new_bfqq, bfqq may happen to be stably merged with a different
> queue than the current bfqq->new_bfqq. In this case, bfqq->new_bfqq
> gets changed. So, some of the processes that have been already
> accounted for in the ref counter of the previous new_bfqq will not be
> associated with that queue.  This creates an unbalance, because those
> references will never be decremented.
>=20
> This commit fixes this issue by reestablishing the previous, natural
> behaviour: once bfqq->new_bfqq has been set, it will not be changed
> until all expected redirections have occurred.
>=20

Hi Jens,
did you have time to look at this fix?

Thanks,
Paolo


> Signed-off-by: Davide Zini <davidezini2@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
> block/bfq-iosched.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 727955918563..08d9122dd4c0 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2659,6 +2659,15 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct =
bfq_queue *new_bfqq)
> 	 * are likely to increase the throughput.
> 	 */
> 	bfqq->new_bfqq =3D new_bfqq;
> +	/*
> +	 * The above assignment schedules the following redirections:
> +	 * each time some I/O for bfqq arrives, the process that
> +	 * generated that I/O is disassociated from bfqq and
> +	 * associated with new_bfqq. Here we increases new_bfqq->ref
> +	 * in advance, adding the number of processes that are
> +	 * expected to be associated with new_bfqq as they happen to
> +	 * issue I/O.
> +	 */
> 	new_bfqq->ref +=3D process_refs;
> 	return new_bfqq;
> }
> @@ -2721,6 +2730,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
> {
> 	struct bfq_queue *in_service_bfqq, *new_bfqq;
>=20
> +	/* if a merge has already been setup, then proceed with that =
first */
> +	if (bfqq->new_bfqq)
> +		return bfqq->new_bfqq;
> +
> 	/*
> 	 * Check delayed stable merge for rotational or non-queueing
> 	 * devs. For this branch to be executed, bfqq must not be
> @@ -2822,9 +2835,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
> 	if (bfq_too_late_for_merging(bfqq))
> 		return NULL;
>=20
> -	if (bfqq->new_bfqq)
> -		return bfqq->new_bfqq;
> -
> 	if (!io_struct || unlikely(bfqq =3D=3D &bfqd->oom_bfqq))
> 		return NULL;
>=20
> --=20
> 2.20.1
>=20

