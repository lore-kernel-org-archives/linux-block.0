Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273E5C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 09:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbiCHKA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbiCHKAW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 05:00:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A99237ABC
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 01:59:26 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qt6so37933407ejb.11
        for <linux-block@vger.kernel.org>; Tue, 08 Mar 2022 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pRG1TWdNLz8GiMsY5y8KT4bp2xB9Bcl6XVP9DPz6GnQ=;
        b=GTOBbkSDA2VWRcV26QmnqTixaxeUSvrkCGNjxamcQbWZA32Jod2BFrLB9fnhL9wSOt
         xT4kRXQCLNbNq7zAtDDds0/h7cbVDfV7eoSQfs2jzOxjmsdf7cmRd1jvMc2trEdYhPYZ
         Xpub9/k25spnAPcfhJ8+/BlDP6tCFmUT1UNerCkK8X0V3+ckHyUpRIYneMdY4vMA7KwX
         EBWuIfHkTCXPwv5S7MFv+vBBFqLgJ4HSv8H4hbxZGP2UzFYUpZ9ANkBq8YIviUwePmw2
         t0fDg6j7T5xsifZGl3XC9QVLxOK9sngbQMvaMndBmcsg4xau8T936KQser/vR8/xfwAP
         zVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pRG1TWdNLz8GiMsY5y8KT4bp2xB9Bcl6XVP9DPz6GnQ=;
        b=iMkDCGlge/zAORNOl9LNbnxRNj2qBw+A5Yab67XeDgSSofyszr+KBH4hc1Kcod8b04
         L8HQ9Mmm8oVg2OX6QYWmhzEM9Lwan0b7+zs3/NWNfhLlSIBJYx7ovh7/B2fDr7huIWDZ
         xgSGn1fyeFffWsMrmP4Dt+JAMJpH5vSxbmq1ckPmsmnpY6+xUdz6spd4kjdXI9K/WEmX
         4hRA01wu8vJ5zC8G+F9ZmUWx6jNOTcieNapkiH+Qrypmr/TxTGx9nVxPkmvyjVhTJVL+
         Gti2z5QunVindlUEF9l5Jlv2sUWGZi4fLjj1cr5lYdkpaNVnLuzhSxuIB8xesCsTtUSV
         EMVQ==
X-Gm-Message-State: AOAM5339y3A1HGljhfPZYabO3Nllkh69gH25MpJY/DKIOWxhNLB460DD
        rB+q+oBa55Ee9X9Tn/5CcfTCQA==
X-Google-Smtp-Source: ABdhPJx2L7y3iv3G/AQ2fBSScXKbPLZTYEpTt0Q9W2H/z5Onoh9Ovh8QWiTzC2ZboBeS4iPXpEufOQ==
X-Received: by 2002:a17:906:3a4f:b0:6cf:86e0:586c with SMTP id a15-20020a1709063a4f00b006cf86e0586cmr12480862ejf.626.1646733564618;
        Tue, 08 Mar 2022 01:59:24 -0800 (PST)
Received: from [192.168.0.15] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906961500b006daac87ddb0sm4882842ejx.140.2022.03.08.01.59.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:59:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Revert "Revert "block, bfq: honor already-setup queue
 merges""
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211125181510.15004-1-paolo.valente@linaro.org>
Date:   Tue, 8 Mar 2022 10:59:22 +0100
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <82461016-858C-487B-B3B2-ED0008BB2501@linaro.org>
References: <20211125181510.15004-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 25 nov 2021, alle ore 19:15, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> A crash [1] happened to be triggered in conjunction with commit
> 2d52c58b9c9b ("block, bfq: honor already-setup queue merges"). The
> latter was then reverted by commit ebc69e897e17 ("Revert "block, bfq:
> honor already-setup queue merges""). Yet, the reverted commit was not
> the one introducing the bug. In fact, it actually triggered a UAF
> introduced by a different commit, and now fixed by commit d29bd41428cf
> ("block, bfq: reset last_bfqq_created on group change").
>=20
> So, there is no point in keeping commit 2d52c58b9c9b ("block, bfq:
> honor already-setup queue merges") out. This commit restores it.
>=20

Hi,
this patch does not seem to have been applied yet (or at least
commented if there are still problems).

Thanks,
Paolo

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D214503
>=20
> Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
> block/bfq-iosched.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index fec18118dc30..7cde7a11c42b 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2662,6 +2662,15 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct =
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
> @@ -2724,6 +2733,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
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
> @@ -2825,9 +2838,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
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

