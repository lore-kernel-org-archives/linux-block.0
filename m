Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E5C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 17:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605AE20637
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 17:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="qCntB/vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLCRRd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:17:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35614 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLCRRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 12:17:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so4748765lja.2
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=rgsa2I3JNZqKxBw44xS16Ap0SigVs8FPG9nt9ZVQaAQ=;
        b=qCntB/vRTzWH0OKSbiBsMS8sUHx6KQtYZfnrcADsK5gyD/rOpgoaljnNGCBmsqzuWr
         /dVA/7gZ9h/3bwX77A9LBajn6DFHHSZCqwja2Hd9EbkVgk0ZnNFh4Wt92qZcD2hVF3z5
         RQ6D+xSvmFMKhkqMLFWjoQCZNDkl3h0Kmx9CrbSK0u3uKgUFefWxTfOSrLPyok3pL3kn
         A4GqwYUZN7CjSi1wFmsfeMA8UQ4TEhQY07ZqVgoo5aXw78+2IRiolVazbrLHYB/f0n8c
         EbJXA+JP2Nl9YK9zrHPyDILBc0LrGY+4xPGygupA+Tzupl7V62y4DBmuLkyqbFfg5Oe/
         UkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rgsa2I3JNZqKxBw44xS16Ap0SigVs8FPG9nt9ZVQaAQ=;
        b=JcdDHvgs6d1UvWSclSpK3yUrDgR5BNWWYM18aFDAvSOM4gWICNYHflORlLM43GZ6Y4
         Xsjt5PzTGoIUEQurlok8R0oZYjqr7oBXkZ822kC6Kd3u/qvaZdzw38ikh0SVIwWjfoxu
         4Cj4Ycfsaszb9FZS6q34j1ToG1DlX6psozlakpv5vdO43qkqK8M8MYDfkrY0U864VEyw
         3wCWJ73UlflISXWq5JcakK4JEu0FIRjZrTbfuCKiKru7+Gdxj7JqAvuUCyK75DnHogSp
         aAQrfRNPXyhi/EscGLKmhF9npXL5p9djhL+bZOiyTrj9IRvMp16bdKHPheRAYbH1lR3t
         +msA==
X-Gm-Message-State: APjAAAXPhELDzUFupC13nYcMbZ5ucAN8UpXXi6vFe0afZqAtz9DfGzvd
        CBrMSIJJQbhokRazcnLx7jDTeQ==
X-Google-Smtp-Source: APXvYqz3pXG7V1x38757go/1jKccFq3y2phsUB9Pr6eOwmdF4w0YDwKYE80129F+oGby1Bfx9gjCbg==
X-Received: by 2002:a2e:b5da:: with SMTP id g26mr3212252ljn.107.1575393451526;
        Tue, 03 Dec 2019 09:17:31 -0800 (PST)
Received: from [10.55.132.17] ([185.245.84.227])
        by smtp.gmail.com with ESMTPSA id m26sm2002662lfc.90.2019.12.03.09.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 09:17:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 8/8] block: set the zone size in blk_revalidate_disk_zones atomically
Date:   Tue, 3 Dec 2019 18:17:29 +0100
Message-Id: <F0EAD4B8-1051-41FE-90A7-91207EA70790@javigon.com>
References: <20191203154251.GA928@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
In-Reply-To: <20191203154251.GA928@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 3 Dec 2019, at 16.42, Christoph Hellwig <hch@lst.de> wrote:
>=20
> =EF=BB=BFOn Tue, Dec 03, 2019 at 04:34:08PM +0100, Javier Gonz=C3=A1lez wr=
ote:
>> Agree on the BUG_ON part.  But since you=E2=80=99re looking into this par=
t now, would it make sense to do the check in the block layer only if the dr=
iver imposes a power of two? We can also do it down the road, but seems like=
 double work.
>=20
> The whole block layer chunk / zone handling has always assumed power
> of two zone sizes.  Changing that would introduce expensive divisions
> in the fast path.  This patch just moves the check to where it belongs.

Ok. Let=E2=80=99s do the refactor now. Though, we will need to support this f=
or zoned devices that are not powers of two, but we can add this path when t=
ime comes.=20

You can add my reviewed-by=20

Thanks Christoph!
Javier=
