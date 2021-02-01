Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11256C433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 19:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4ECF64DDF
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 19:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhBATD2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhBATDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 14:03:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAD4C061573
        for <linux-block@vger.kernel.org>; Mon,  1 Feb 2021 11:02:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c12so17820699wrc.7
        for <linux-block@vger.kernel.org>; Mon, 01 Feb 2021 11:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sdvevv2gz1bUVsF+XnLUZlDENOwhzGgg1vb+hP5H9SM=;
        b=SXwoKqJcDSFwN6H9J2EbTQFjgMR7jo88Lha3QlrBR9WMaZUac5bINT+Gi0x5dV7sV5
         iAyrAt/vszuiy38xr2GbBw+K4qjT7M72wou0RY5SYnWA4RcXnfm/lkUgzxAVM7CqLvNO
         59QWfoAGSJGqwJ7EN4zwR2EvZm9PT0gYgTMTh/WtgOqiHqPmF9uV2yfy8veyuAegS0JI
         fKx0dYTesJ9vyv3ca9vMe17krrIlZPJcMdHz+pgOR0p5iKoEuGiX9PXL6oipdBmavDJ3
         3FJGHA0qDmJuog2WKc/UHEA3fgUgUdqsjXeY5CROSdZvS35sPVMcr5Z4VpgCmFTqW+5a
         o0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sdvevv2gz1bUVsF+XnLUZlDENOwhzGgg1vb+hP5H9SM=;
        b=OGUwq0x1ULhKWYwofhNM4L3HtS4V5ayf5J13L2bPtJQ/3C96MpdcsKa4Ggz23P8EsL
         r5nJRPxY1TCGDbDWdaEAkca6X5azDEr+LPdmfFmBXMBrtLX3Eus78ZBdy52odyMsYp3R
         MIgxH5o9O3gKMcxOCSzIjqYF31Ah6gmxPgSR7SHoSFg5U8gAnibn1F7DxMbHBP0QWsf/
         t7gDzuOzv8BYVHYR9YZI//DFbAqz4Hq+dWD3kok+8FO/QZw3Onu7//oVnm1fMtttzlBM
         dyThzt4IE86bQ+jvdCKI73qR2YOxyIJaJbk9Uuotq7HN+q7RnuGXYUqHFSAB8Hv0cG8s
         Vf/w==
X-Gm-Message-State: AOAM530t+QqHS9se1rirTgUQNW98qBVL8jxAuFHUlgwujgP0xYZ7CZT4
        parosoZhl3CNyhXm3p+8fQ6J3w==
X-Google-Smtp-Source: ABdhPJyKrgQb1DoN8nwasmPcDxn3ePHguKIqWaqfaL4t3L+IJwm6/ZFCZ2KOihhlKSKBbYBqE2zi5Q==
X-Received: by 2002:a5d:654f:: with SMTP id z15mr19838499wrv.46.1612206163677;
        Mon, 01 Feb 2021 11:02:43 -0800 (PST)
Received: from [192.168.159.233] ([37.162.183.28])
        by smtp.gmail.com with ESMTPSA id z15sm25944615wrt.8.2021.02.01.11.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:02:43 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Revert "bfq: Fix computation of shallow depth"
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210129111808.45796-1-linf@wangsu.com>
Date:   Mon, 1 Feb 2021 20:02:41 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9EA9F1F4-F294-48DA-B456-D903E4299509@linaro.org>
References: <20210129111808.45796-1-linf@wangsu.com>
To:     Lin Feng <linf@wangsu.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 29 gen 2021, alle ore 12:18, Lin Feng <linf@wangsu.com> ha =
scritto:
>=20
> This reverts commit 6d4d273588378c65915acaf7b2ee74e9dd9c130a.
>=20
> bfq.limit_depth passes word_depths[] as shallow_depth down to sbitmap =
core
> sbitmap_get_shallow, which uses just the number to limit the scan =
depth of
> each bitmap word, formula:
> scan_percentage_for_each_word =3D shallow_depth / (1 << sbimap->shift) =
* 100%
>=20
> That means the comments's percentiles 50%, 75%, 18%, 37% of bfq are =
correct.
> But after commit patch 'bfq: Fix computation of shallow depth', we use
> sbitmap.depth instead, as a example in following case:
>=20
> sbitmap.depth =3D 256, map_nr =3D 4, shift =3D 6; sbitmap_word.depth =3D=
 64.
> The resulsts of computed bfqd->word_depths[] are {128, 192, 48, 96}, =
and
> three of the numbers exceed core dirver's 'sbitmap_word.depth=3D64' =
limit
> nothing. Do we really don't want limit depth for such workloads, or we
> just want to bump up the percentiles to 100%?
>=20

Bumping to 100% would be a mistake.

Thanks,
Paolo

> Please correct me if I miss something, thanks.
>=20
> Signed-off-by: Lin Feng <linf@wangsu.com>
> ---
> block/bfq-iosched.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9e4eb0fc1c16..9e81d1052091 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6332,13 +6332,13 @@ static unsigned int bfq_update_depths(struct =
bfq_data *bfqd,
> 	 * limit 'something'.
> 	 */
> 	/* no more than 50% of tags for async I/O */
> -	bfqd->word_depths[0][0] =3D max(bt->sb.depth >> 1, 1U);
> +	bfqd->word_depths[0][0] =3D max((1U << bt->sb.shift) >> 1, 1U);
> 	/*
> 	 * no more than 75% of tags for sync writes (25% extra tags
> 	 * w.r.t. async I/O, to prevent async I/O from starving sync
> 	 * writes)
> 	 */
> -	bfqd->word_depths[0][1] =3D max((bt->sb.depth * 3) >> 2, 1U);
> +	bfqd->word_depths[0][1] =3D max(((1U << bt->sb.shift) * 3) >> 2, =
1U);
>=20
> 	/*
> 	 * In-word depths in case some bfq_queue is being weight-
> @@ -6348,9 +6348,9 @@ static unsigned int bfq_update_depths(struct =
bfq_data *bfqd,
> 	 * shortage.
> 	 */
> 	/* no more than ~18% of tags for async I/O */
> -	bfqd->word_depths[1][0] =3D max((bt->sb.depth * 3) >> 4, 1U);
> +	bfqd->word_depths[1][0] =3D max(((1U << bt->sb.shift) * 3) >> 4, =
1U);
> 	/* no more than ~37% of tags for sync writes (~20% extra tags) =
*/
> -	bfqd->word_depths[1][1] =3D max((bt->sb.depth * 6) >> 4, 1U);
> +	bfqd->word_depths[1][1] =3D max(((1U << bt->sb.shift) * 6) >> 4, =
1U);
>=20
> 	for (i =3D 0; i < 2; i++)
> 		for (j =3D 0; j < 2; j++)
> --=20
> 2.25.4
>=20

