Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ACBC433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 13:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E910206A1
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 13:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="cZQEjZuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403941AbgFYNQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404893AbgFYNQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 09:16:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DEBC08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 06:16:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so5895629ejc.8
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XcQYPjqyDWtMi0rENYvAazue/kPTvu18ESw09VtA/BQ=;
        b=cZQEjZuvR5f7FgpcWi3eJOhWn+RuQzWHhsuVP3jAlRNmG5phKcNwo+FK/x8Jqaaw9J
         P81xfWDy6iA5U1jyM3ltNNuutAeJTfgzYugb9G43XSAXpAFupO43KXGK0Og/zdJTCpfs
         J4oO6gulRPfCK4CTcyVo45pohzgNyzmfldqY3BYmajDEZm2DU3ZjdCRLiTInDl6C8Pma
         lj61JNC4LSdLVFteSKGShTRPNZViSuvYwGt0uDdwMLxXtj2IkxFuR7RIM5Fu28rkRRc0
         6v6CzMoBY3kxzlSWag4yEx/WlHnPAX1djfHJygxGPPkehlNy/ztQoGlNWoesCIoMjm5c
         7HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XcQYPjqyDWtMi0rENYvAazue/kPTvu18ESw09VtA/BQ=;
        b=aBS8Yg+09V2lIw/qWdtWiW6W9vWlXrEIjjqni3slxBfc6BdIGe3I2/t9ZzvSWwDbkb
         eyb+2/cb47MrA2VnK+zyTmekUjy8AeZ0PgfQOcILja/VSdoxK6pMLO5SOGcpplBuII9g
         Q73yGUuh1PXVYVh7VXXeUdwtZ974NKcQQ2Xx4Wl3STC+7WLSpiqMly9FQ58SN+rf1ZbJ
         tikGk8V61yJgY9CN2iFF5snrmNR09TtHHkMJ4d9tDSFcUwMMl59L302k/T81U0otDuLc
         oqdrp+Upb0857CBFH5wK0gvEflPEM5jjU1gSBfitObuwwQj1zJSrtOzkUs5Q58eTrAyg
         n8OQ==
X-Gm-Message-State: AOAM533oCsq+X0+AlTmCz/5yJwiyYEaxiyVaMhmFot4GOl4I76FQsf0d
        Bbd9t3mPkn1zFJgeLaX2RTUCaA==
X-Google-Smtp-Source: ABdhPJwIek7sLnxoju1+rcGjXPqwV/FQnxwJgYB9BILJ47lW0GF1ozwgl7ZsoLPjn8ycZZheLSOyVw==
X-Received: by 2002:a17:906:2c43:: with SMTP id f3mr5161913ejh.38.1593090974902;
        Thu, 25 Jun 2020 06:16:14 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id p9sm11849637ejd.50.2020.06.25.06.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:16:14 -0700 (PDT)
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0cd0ad57-ec21-3d20-d74d-7e454614f06f@lightnvm.io>
Date:   Thu, 25 Jun 2020 15:16:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625122152.17359-7-javier@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/06/2020 14.21, Javier González wrote:
> From: Javier González <javier.gonz@samsung.com>
>
> Since the number of zones is calculated through the reported device
> capacity and the ZNS specification allows to report the total number of
> zones in the device, add an extra check to guarantee consistency between
> the device and the kernel.
>
> Signed-off-by: Javier González <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   drivers/nvme/host/zns.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 7d8381fe7665..de806788a184 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>   		sector += ns->zsze * nz;
>   	}
>   
> +	if (nr_zones < 0 && zone_idx != ns->nr_zones) {
> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
> +				zone_idx, ns->nr_zones);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
>   	ret = zone_idx;
>   out_free:
>   	kvfree(report);

Sounds like a check for a broken implementation. For implementations in 
the wild that exhibits this behavior, a quirk can be added. This kind of 
check is generally not needed. This can easily be checked by having a 
test case in a validation suite. The kernel should not have to check for it.

