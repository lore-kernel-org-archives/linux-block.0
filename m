Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D52C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 06:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21E420883
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 06:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEzRKJBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfAIGIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:08:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35016 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfAIGIL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 01:08:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so6844771wmt.0
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 22:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gqukryv+mBDUA/6t1Jgl7DfoIiIhQffw5pjQXTeSGRg=;
        b=NEzRKJBrGnluBDhtURZI0WRtVfRQE52NdD2UmNY9SZWMGquMY+b5QRIKbO3w2BPxIE
         DGZiTTZnJUHIuv8I1LZX2ftC49R0NJSkyV3du3GKy+1fV6cRE/mXi+f8cU3C3yd9/lbx
         fiNp9nuCXxpdu84Zi4B3AS5vJtCGALm3uQS40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gqukryv+mBDUA/6t1Jgl7DfoIiIhQffw5pjQXTeSGRg=;
        b=H0dsV8Q/21H8CdRr/efRyF1FcxBRSUOZa8SVn6SUsimYq2QuQ/XnHlbzMh55g/Kb0U
         WGXeHAPPfCpfBM+mTaneWzDqN+ShBDq5vH9KP8UL/aBYj1UZfQGKdL1R+t79D7yVTw3m
         L0kgCMqE/4iwsdzqXto9qCagF3t3gsgUJBHwr59Zy4V84K5cjNh66xjV15nCLXulvVW2
         uIM9FCzxFcmTY01GWXDs3xi7Ncz5ibf/D/3D6w82sR9lVLMmTj1/tPgKEqFzeRzmLe67
         EACbzVcpWaKNzrk5sBSTM2jAo1thX6NKnT/F1I8xg0Kh/mwZFaziBhb8s4+bMrdoXVOm
         66+w==
X-Gm-Message-State: AJcUukfpadVmS4pPAOHkb2JuDzDGZI7e+hBEzgW2qBSejZQfoiVQSEE0
        +cB/rYR9D/jWEbJlorFNqKpCwA==
X-Google-Smtp-Source: ALg8bN4gy1OIxU5PxpKyGzW6U5DarEhMVYkOLLDxhu4Y1sZwlRdi7dmQZ94aKUyk9QVmBU+toqKHlA==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr4045031wmc.50.1547014088599;
        Tue, 08 Jan 2019 22:08:08 -0800 (PST)
Received: from [192.168.0.101] (146-241-115-31.dyn.eolo.it. [146.241.115.31])
        by smtp.gmail.com with ESMTPSA id u204sm14837706wmu.30.2019.01.08.22.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 22:08:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] block: doc: add slice_idle_us to bfq documentation
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190108215613.15277-1-jpittman@redhat.com>
Date:   Wed, 9 Jan 2019 07:08:06 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        linux-block <linux-block@vger.kernel.org>,
        linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A42F583-7641-4B58-AEC7-B1AE943A6DFB@linaro.org>
References: <20190108215613.15277-1-jpittman@redhat.com>
To:     John Pittman <jpittman@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 gen 2019, alle ore 22:56, John Pittman =
<jpittman@redhat.com> ha scritto:
>=20
> Of the tunables available for the bfq I/O scheduler,
> the only one missing from the documentation in
> 'Documentation/block/bfq-iosched.txt' is slice_idle_us.
> Add this tunable to the documentation and a short
> explanation of its purpose.
>=20
> Signed-off-by: John Pittman <jpittman@redhat.com>

Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thank you for adding this missing piece,
Paolo

> ---
> Documentation/block/bfq-iosched.txt | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/block/bfq-iosched.txt =
b/Documentation/block/bfq-iosched.txt
> index 8d8d8f06cab2..98a8dd5ee385 100644
> --- a/Documentation/block/bfq-iosched.txt
> +++ b/Documentation/block/bfq-iosched.txt
> @@ -357,6 +357,13 @@ video playing/streaming, a very low drop rate may =
be more important
> than maximum throughput. In these cases, consider setting the
> strict_guarantees parameter.
>=20
> +slice_idle_us
> +-------------
> +
> +Controls the same tuning parameter as slice_idle, but in =
microseconds.
> +Either tunable can be used to set idling behavior.  Afterwards, the
> +other tunable will reflect the newly set value in sysfs.
> +
> strict_guarantees
> -----------------
>=20
> --=20
> 2.17.2
>=20

