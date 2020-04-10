Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED0AC2BB1D
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 12:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460AC2078E
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 12:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TqW0DwOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJMUV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:20:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40384 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDJMUV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 08:20:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id z15so1879837qki.7
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2020 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j0xq3XxrlNu4Qc4ztwGcIn5i4ud0A4XU61qD7ZOx5Ag=;
        b=TqW0DwOwY4ZE4ujuXB+j46RD9fAxlH6saUZWhwloMR+92dlljvV53EXaZSVkYQRkKt
         RXMfV9++lq3AGwz7gkpUfax15VQm/u2byD4ddmdfGRByv/J9bgLbyPODdRvITXymQ5z0
         j9caCAIeja1c4XlXw2n43Us7FncnisZKjmQv4SwxgKd2vlqTGbSmoMy9V9UV88U2OYRJ
         RXe0qhBOU/m3U2QVvlwNj+mFMnZ8ZYIfQ0VckcTsWfeJC4FANa3/k95pdYOQuobUKIyw
         E9guFRZg4UF9wxfnmAEKgSpJSB4Oh5qJmDYnYAhs4FECpA1QBiX735CyjjLFRyjq51Q3
         lQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j0xq3XxrlNu4Qc4ztwGcIn5i4ud0A4XU61qD7ZOx5Ag=;
        b=Eul5+XoMEgxz04mIRm15bGIKAWsoe6PX9LIC675hg9cqVuvPtNIlx9Lh44ZI7jyqWb
         dz2V6kvUPigpLcndyR4v+HNsTs8JC6N9OG3CLOEXTv/mq/oMws7Vz279pBJbIVlmDzH6
         yVMjWEQVJZ/ZGscOXPtP4N/BLbs6ezsN5pHSS+9wYdhRq73cwUrgW9zVVEFWF4F/rAXP
         O6qTnfDL7rh89as3FrTGKdqgSLR/c7AgIPAc0ESdzq7Z5DmtsWvmvTP9Y0//tIaIzlp5
         dQusx6Fjt/4ud/DKxBbXzTyjRz+SI6n6WDOdes7T+E/rNbIDmre0J02pRa6h+lUw/jnI
         7YXw==
X-Gm-Message-State: AGi0PualRVsUcUGj0SJ07H29gFK/Vw0tC0fCxkjC/PQTckPvT9q1l+5s
        BDBJck8vm+U4Vxfxgk021p8frw==
X-Google-Smtp-Source: APiQypJFXmrYehKyrmHS6x/fCnBdKOhdEzQUjMHenMUEYSOOd7PHRRzV9grmABzvA/R5mqzhwY+Bsg==
X-Received: by 2002:a05:620a:782:: with SMTP id 2mr562538qka.444.1586521219343;
        Fri, 10 Apr 2020 05:20:19 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u13sm1425748qku.92.2020.04.10.05.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 05:20:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: s390 boot woe due to "block: fix busy device checking in
 blk_drop_partitions"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200410054544.GA17923@lst.de>
Date:   Fri, 10 Apr 2020 08:20:17 -0400
Cc:     Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CC1C981-47F1-4C4D-A4D7-B6411D716A2F@lca.pw>
References: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw>
 <20200410054544.GA17923@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Apr 10, 2020, at 1:45 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Please try this patch:

It works fine.

>=20
> ---
> =46rom f42fb98cc627f9b960fd5b9a3a229da5c5dcf54a Mon Sep 17 00:00:00 =
2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 10 Apr 2020 07:14:13 +0200
> Subject: block: fix busy device checking in blk_drop_partitions again
>=20
> The previous fix had an off by one in the bd_openers checking, =
counting
> the callers blkdev_get.
>=20
> Fixes: d3ef5536274f ("block: fix busy device checking in =
blk_drop_partitions")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/partitions/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 1a0a829d8416..bc1ded1331b1 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, =
struct block_device *bdev)
>=20
> 	if (!disk_part_scan_enabled(disk))
> 		return 0;
> -	if (bdev->bd_part_count || bdev->bd_openers)
> +	if (bdev->bd_part_count || bdev->bd_openers > 1)
> 		return -EBUSY;
> 	res =3D invalidate_partition(disk, 0);
> 	if (res)
> --=20
> 2.25.1
>=20

