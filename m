Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EDFC433EF
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 05:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DB721A49
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 05:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnFVSsjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfIIF56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 01:57:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35073 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfIIF56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 01:57:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id n10so13088419wmj.0
        for <linux-block@vger.kernel.org>; Sun, 08 Sep 2019 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=00uQqKGc3ntry1sUHA28NuC7W2YW52OB0uzh/6SRnk4=;
        b=dnFVSsjoxqSQxLiFpd7+EBfRtZDxKWV8t82KXqAehO1Vsl2O22PFD7pPt3gzFtlblQ
         5FA9tNp5HySNWlDNCLPb7WPNYH1XzJH6mtgjEske8i+sUegf0BUZkw9A+9OSJczNf8al
         dhDX6UvKUJihuhitVElv3mGro33zvxV69SxtHBYFJ2HM1hWtOk+LrhidapysjUR0cd9M
         YmH6nlM2Wdsa0ALFBH2n753qXT5rddEiAyg5Ji4XcUSd/nJcotRIXyiLuCkJOHq+8UGP
         LC0hqVg+J2fq4kA8cJYMtD92Jz0Rodd/4o4Bf7qmvnKhnamI2KcLMP9IN6HPjuwbYb4H
         zd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=00uQqKGc3ntry1sUHA28NuC7W2YW52OB0uzh/6SRnk4=;
        b=rSTVifqhOCg7HkwzbVE4vATyRsnZlAU9uYy69dAWdQW+dCKR+RjrDOFP3zGFbKmnKF
         9AEDvH5izlnmzGj7qwVX2kQXXDD6XW8gk3BexaKHcaiIOsmIq0NpHfnJsyaJDR3mefIr
         c0p/TlmgVxHr8adYi2zehRKahmqBOIo5Hgvv9qFa0QI71riLYaqEX1CuJbrVLbXkkdH6
         5PiqWnzOis2KRYtVzJVm2zutw8XX16ADvteb2dnVMEiXtihmVYj1+S7XzwikSWZ+zbY8
         9g7En49WQgjzmBeIkqypMhtEigQ9jfhQFl5ywJpUakMVgF2GUoMqVM2ornbYCePUDqnM
         eacg==
X-Gm-Message-State: APjAAAUei93g60VZqY56hPwSTD6xkClTkmZrNgTvOk9TgBcQJVOkIpGT
        ov2oJ7MVtgtHqrk4q5NdSjBc/A==
X-Google-Smtp-Source: APXvYqyTuOYWiPrJQegHYIEdG0b8fajJCGI0sjBqLXu6MTa5++KDoPx8Kxrq8U2i/YY6IhYKXCtKjQ==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr17169399wmc.68.1568008676005;
        Sun, 08 Sep 2019 22:57:56 -0700 (PDT)
Received: from [192.168.0.102] (146-241-7-242.dyn.eolo.it. [146.241.7.242])
        by smtp.gmail.com with ESMTPSA id r18sm14513325wrx.36.2019.09.08.22.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 22:57:55 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/4] block, bfq: series of improvements and small fixes of
 the injection mechanism
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
Date:   Mon, 9 Sep 2019 07:57:55 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7AE7BB9-667F-4732-87D4-F28C2D864645@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
have you looked into this?

Thanks,
Paolo

> Il giorno 22 ago 2019, alle ore 17:20, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens,
> this patch series makes the injection mechanism better at preserving
> control on I/O.
>=20
> Thanks,
> Paolo
>=20
> Paolo Valente (4):
>  block, bfq: update inject limit only after injection occurred
>  block, bfq: reduce upper bound for inject limit to max_rq_in_driver+1
>  block, bfq: increase update frequency of inject limit
>  block, bfq: push up injection only after setting service time
>=20
> block/bfq-iosched.c | 35 ++++++++++++++++++++++++++---------
> 1 file changed, 26 insertions(+), 9 deletions(-)
>=20
> --
> 2.20.1

