Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E26C43613
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 20:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9830E206B7
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 20:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjIfbBIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFVUmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Jun 2019 16:42:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVUmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Jun 2019 16:42:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so9237773wms.2
        for <linux-block@vger.kernel.org>; Sat, 22 Jun 2019 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2aKQSSh/xkZ2zv+siRas+9STNbes79rOsAYZGCl58YY=;
        b=jjIfbBIjn3gI/kyrUDR/T+KGW7LWo9P/jaziL3FOc5/CDUrdipqpAjCSzBJAHIPCgb
         v8H7mLNN9qyZfG1UQuxER+iVVh2+VHo98GFzWaEYSDaXWqm6CUPc3bgFXYOj7Af1iVZ6
         jBh/ZrVD59OZWYT0MZ449o/dB7FswYccVcXKH2H7YSEBnvmF3EFbNILGckxw4FUSWMut
         P2nKWQ1dzPpVqOs89YFocIqX57BX/HGXj5i3IC5ZPpkAW7qKJXDq7nruAvu6K/YIAfk+
         i2YkZwGv7Z89zLoMewHmveq8t3WEh1SQ2g0lOh96QTfstprSoXdjhqTRtAvegvn8cBgZ
         Dy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2aKQSSh/xkZ2zv+siRas+9STNbes79rOsAYZGCl58YY=;
        b=QShIPebviYgDk+WGYfeS6lueXtZmfuExubZMXLp3alZLPwj8sbfjoQFEaPp3h2cUwX
         WFXujsnTBVV8yKeJgLfCUyaIJuDoHdz+OEcZ7LfD9BKyiusN7kTZxDjc+8Vap/CWupDI
         UcrNb1e0bkEbdwjOr2X3E2OKAoQfPHsBgZoHXtSscU5sWyfyXkPoOo5zBSlLlsoIjeBo
         qnRxA11ti2bQDJCH88PsNpyB9OWgjTRSFI8gih9gVDnP4EowW7Mr+ceJ2GcFUVznvV3j
         KmtRMsODx1EwDt8xOnmz1yOsp39I7iuyvJrcMN5GNFTQ53CJqzgyJ2HWAyJ5QCgjUxZy
         oq2A==
X-Gm-Message-State: APjAAAXWxIYHbamCRDXSEi8LQiRrSzdH1KWilIHOB5ihqhde+q8UZVNk
        Qhy3jbrX/ZlcXKW9pudJuqxK6MRTECI=
X-Google-Smtp-Source: APXvYqzCh1SjQa2BvSWFnOnaUWuI9BKC7ymRavXMimSXNbzTfKUJCHDAPsf874W7HRfybFpyBIKzcw==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr8965647wme.102.1561236170736;
        Sat, 22 Jun 2019 13:42:50 -0700 (PDT)
Received: from [192.168.0.100] (88-147-39-13.dyn.eolo.it. [88.147.39.13])
        by smtp.gmail.com with ESMTPSA id l17sm6768975wrq.37.2019.06.22.13.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 13:42:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: fix operator in BFQQ_TOTALLY_SEEKY
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190622193803.33044-2-paolo.valente@linaro.org>
Date:   Sat, 22 Jun 2019 22:42:48 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FA0E6F1-CE62-43C7-80C7-6474AB9BBEA6@linaro.org>
References: <20190622193803.33044-1-paolo.valente@linaro.org>
 <20190622193803.33044-2-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry, I forgot to mention the fixed commit. Making a V2 ...

> Il giorno 22 giu 2019, alle ore 21:38, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> By mistake, there is a '&' instead of a '=3D=3D' in the definition of =
the
> macro BFQQ_TOTALLY_SEEKY. This commit replaces the wrong operator with
> the correct one.
>=20
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
> block/bfq-iosched.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index f8d430f88d25..f9269ae6da9c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -240,7 +240,7 @@ static struct kmem_cache *bfq_pool;
>  * containing only random (seeky) I/O are prevented from being tagged
>  * as soft real-time.
>  */
> -#define BFQQ_TOTALLY_SEEKY(bfqq)	(bfqq->seek_history & -1)
> +#define BFQQ_TOTALLY_SEEKY(bfqq)	(bfqq->seek_history =3D=3D -1)
>=20
> /* Min number of samples required to perform peak-rate update */
> #define BFQ_RATE_MIN_SAMPLES	32
> --=20
> 2.20.1
>=20

