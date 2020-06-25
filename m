Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F7C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBC620789
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="I11KMzCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406116AbgFYTpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406069AbgFYTpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 15:45:04 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF54C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:45:03 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g20so4938566edm.4
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LEsN02TD2NfJjwSK4xJpn95bFrWqOr+Dp2f+nTtJnEs=;
        b=I11KMzCm1c4uwoEwh/vfPrmhuZZTPf7zJk9bn/oTzsPOdH5m7SS6LvOZNNeoxdCKnb
         20CjRJAqln/dfB2pAvmDhcu1CpwHtM295EVG9DyCJ/XKaqYeXSZ7PmYALZ/bzJOsyZX+
         dMjF018DOrSzNOnV9HrproyBVbOQqNZN/TH9keym/JaVJjOPdZJbQ/0D2pYKMMcf5QOK
         Kk0QfHai+vxhWtzt3t8RjzUK2qAcVIXjacRaoIiSckvjuACedYpza2Z4rWX6CTl3FBEg
         ePAWS4w1+CYHuMACwb5QRlGyK9Q4O/UmcJQeXLHeI9ExrKX2a4fI2o+Jw347yp4xUz3J
         2Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LEsN02TD2NfJjwSK4xJpn95bFrWqOr+Dp2f+nTtJnEs=;
        b=km08/J7h768SljrLOKpHTNeCUKnjKRx4Z466ehpFTewM19hlkWb95Xm0/6pkRMb1/C
         6EoLN6MKCdlcxGnjpuwthWILIB71acxfA8zIuu6bPEPbgZ9PCuwgQ9+6MgyOk4ws+3WG
         O8bVTdp1hSi7emPTh9q/hn0tOrLA4uFBDhdDUslRb1pUNewpWgMzsloTlJqZfAVyIEOU
         DjIedTT6+hs5ZtTjaXN9PkCLtfI+Jx+UxQ6m2pXA80zWzpCJBVaUVNxnHNO+mWE1ZqSp
         876jtGUHFwg7asP00EuOKdsGPT1oqVDQ45eQsK8InFlMpB2Cye8mu1gw0js+6CHYo1PK
         Eufw==
X-Gm-Message-State: AOAM531VxemnH83x+R5jsB0Hgbp10AJAb3isldgVzyKlTiE62VEwRIXp
        xxmEnaHCRh37w48XICGmc7RX9A==
X-Google-Smtp-Source: ABdhPJxn9WE1PPEUFRlBfDmfNh4vCP5hZ/o/wTfpHcjCsucpxN9RqQvmaNHqWKvEiLfe3YwgfnJkXw==
X-Received: by 2002:a05:6402:2064:: with SMTP id bd4mr8375875edb.180.1593114302411;
        Thu, 25 Jun 2020 12:45:02 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id f17sm5394548ejr.71.2020.06.25.12.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:45:01 -0700 (PDT)
Date:   Thu, 25 Jun 2020 21:45:00 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200625194500.io3e6fbju6l6fkms@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <0cd0ad57-ec21-3d20-d74d-7e454614f06f@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cd0ad57-ec21-3d20-d74d-7e454614f06f@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.06.2020 15:16, Matias Bjørling wrote:
>On 25/06/2020 14.21, Javier González wrote:
>>From: Javier González <javier.gonz@samsung.com>
>>
>>Since the number of zones is calculated through the reported device
>>capacity and the ZNS specification allows to report the total number of
>>zones in the device, add an extra check to guarantee consistency between
>>the device and the kernel.
>>
>>Signed-off-by: Javier González <javier.gonz@samsung.com>
>>Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>---
>>  drivers/nvme/host/zns.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>>diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>index 7d8381fe7665..de806788a184 100644
>>--- a/drivers/nvme/host/zns.c
>>+++ b/drivers/nvme/host/zns.c
>>@@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>  		sector += ns->zsze * nz;
>>  	}
>>+	if (nr_zones < 0 && zone_idx != ns->nr_zones) {
>>+		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
>>+				zone_idx, ns->nr_zones);
>>+		ret = -EINVAL;
>>+		goto out_free;
>>+	}
>>+
>>  	ret = zone_idx;
>>  out_free:
>>  	kvfree(report);
>
>Sounds like a check for a broken implementation. For implementations 
>in the wild that exhibits this behavior, a quirk can be added. This 
>kind of check is generally not needed. This can easily be checked by 
>having a test case in a validation suite. The kernel should not have 
>to check for it.
>

I don't believe it hurts to validate as ZNS provides a method to
retrieve the actual number of zones. It can help people detecting an
issue that can hide for some time.

If the general opinion is that this belongs to a test suite, we can add
it to blktests (already have it there internally). We can also have it
in both places.

Javier
