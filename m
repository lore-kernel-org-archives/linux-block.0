Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD23C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EA32073C
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 15:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="vQ09+5D6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLCPeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:34:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33958 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCPeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 10:34:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so3351971lfc.1
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ja8qjlrHWabWQbZYSZoFBCf6oV9iEsZAzm4UxlPbLn0=;
        b=vQ09+5D6qPUyixhPclo72lWAfJO3aKRjhdFHlkej+3301HZRmDl4PrCgi80aYE1rev
         p1zrOW76MAMC3c9heOPWczqqezohf4zNBmhM6aGMgvD14IFd+YdnjcQMZltWU0SbDKA6
         3ZXbpI0cQXp73R4Q9mEf9b9m8JOWudlenivyJ7Ns5BEGb6WXL+0IPUD9s2o5Gs3/DI6O
         uP1cl45QItASdQBGvwTxlD5Ge4OG7uTABPJiN3zBJrKh5k+oeCq7aOJuU5wtXj97x8Y0
         WWGp8U498ROsfurCEioM5mGOK735CuYm+XwmzOvNESbMVFJXcnoAFbzzSOBwKYDZcBOw
         HsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ja8qjlrHWabWQbZYSZoFBCf6oV9iEsZAzm4UxlPbLn0=;
        b=ZYkRJA0S+E8zadfSyO/B6rxBW0oj9tqFN0cfUKZK7wfdSkv8kl0mP/DCctHpYg5MiR
         yNO2r5N5wIvyay+xhmSC84wo95Ue4sknvjNCIcCSawg/bmD+u6ucw5UZ+CFciJwFuMIu
         SX91T7zPRcn80gjU2isTk4mpbGzx2iYnDAyER4Qvu4vP6pJiCCy4GgcGk//Eyjnb+Q8Y
         zyBT+vKnA8x5v/bAm2SdMYeWoR5QM6jDs4opZNZwXIUJoRyfBP+ZR+mxbRgGtRLidqnm
         OnI44kkbiiGMacld4PnPXHf5NQ1jVLynyYSvBnvIRPPWIvk3lvuPDHQsrvLscyT4wVOb
         eInA==
X-Gm-Message-State: APjAAAUlGV24nntm4P5ZE2aHQ354QL6e+msfLsN3l9ru38HmhYDbtEp+
        g1yM7mBcOLMz7s+9npOgLni4kObQc6izCA==
X-Google-Smtp-Source: APXvYqycXKCbjEAdwgG051su41hhdnIkyrf8DrvkqXHeNZ1/4ubsYNPA5QtfiyA9dBpcS2F1Jwoi7A==
X-Received: by 2002:a19:e343:: with SMTP id c3mr2992380lfk.192.1575387249824;
        Tue, 03 Dec 2019 07:34:09 -0800 (PST)
Received: from [10.55.132.17] ([185.245.84.227])
        by smtp.gmail.com with ESMTPSA id x87sm1581178ljb.103.2019.12.03.07.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 07:34:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 8/8] block: set the zone size in blk_revalidate_disk_zones atomically
Date:   Tue, 3 Dec 2019 16:34:08 +0100
Message-Id: <8FC173FA-576A-4425-AAE4-EE2A27C5F6BE@javigon.com>
References: <20191203151808.GA558@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
In-Reply-To: <20191203151808.GA558@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On 3 Dec 2019, at 16.18, Christoph Hellwig <hch@lst.de> wrote:
>=20
> =EF=BB=BFOn Tue, Dec 03, 2019 at 03:00:09PM +0100, Javier Gonz=C3=A1lez wr=
ote:
>>> This change also allows to check for a power of two zone size in generic=

>>> code.
>>=20
>> I think however that this checks should remain at the driver level, or
>> at least depend on a flag that signals that the zoned device is actually
>> a power of two.
>=20
> The block layer requires a power of two zone size / chunk size,
> including having a BUG_ON for that requirement blk_queue_chunk_sectors.
> I'd much rather have a proper check in the zone code with proper
> diagnostics than triggering a BUG_ON..

Agree on the BUG_ON part.  But since you=E2=80=99re looking into this part n=
ow, would it make sense to do the check in the block layer only if the drive=
r imposes a power of two? We can also do it down the road, but seems like do=
uble work.=
