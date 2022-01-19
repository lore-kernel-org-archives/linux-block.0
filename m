Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A154C433EF
	for <linux-block@archiver.kernel.org>; Wed, 19 Jan 2022 14:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355313AbiASO4k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jan 2022 09:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355317AbiASO4i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jan 2022 09:56:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA32C061401
        for <linux-block@vger.kernel.org>; Wed, 19 Jan 2022 06:56:38 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso7922693wmb.3
        for <linux-block@vger.kernel.org>; Wed, 19 Jan 2022 06:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ULZgaauuyoaJwI5e2y8JAvniLbu1yxiPn9oSjW3wkYQ=;
        b=I4/o+xwa7zVIvvpWHXpBn1Y0s+CrLNn10MAaN73Z0hQPF5OmurKlp4gbtSja9N1gqV
         iH2iEjju5V22FKR6HJ4EsLw9PEuUGVJLHYiH7czrbJLKabajkRnTApfR/A24XooDn3Ed
         YzPXoEDJoFl8wDLA/nPHsDujQg/4qc6BAQafIu3PdpKWWAJrdrZBQkEedW1wCVgbHdm8
         esrey8N7xU7BlCzU39WbI2xlKBgfntEW3gxkoge00UcGHZGbX6y9/6ZZU9sFmXTNFYuF
         Ffx9v92DCS7RncSqmXxbnNYbrshh+F3PNtjJNWJMIOq30fZ3fQNmtet43xUEzBuA48E/
         eCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ULZgaauuyoaJwI5e2y8JAvniLbu1yxiPn9oSjW3wkYQ=;
        b=cQl0+mT0fus45C0VS5rDXonNBib2GLIghjnQM+2sj3OqHEVEm+OSqdq+f95H3EF859
         /WlOq+kp98NC+CJSgmx4KVPLTVPG7h624UhwG2Vu5wiAY0RyzNCuXt0Dwv5WwaqtBBZB
         HbEYBCguvdeughUtjlWYEidi5DMxtReTQleDaWDJ2e1uWgbVO5cMoQyMkN+9iDd4JZ40
         XVIF/uKEdnCzD9qP7L6W/wm5ju7ihUeNXNBCqL75hu/Nmz6gPyGSnKDUgruoO35ihaf0
         2J0gMdyWlSlYh/S/ohPiPBa5TjVsrJmCA1qp0HQ11guZ9+awpp1XIVMCJoN3zcWbXpt8
         MQyw==
X-Gm-Message-State: AOAM531J+oEkVzxpwTZaIHpyC/Ry36F6VG7GaLwSAMF+tWWjceiane9W
        Pm0vT85ju5SYwtQQsnZh5ool0g==
X-Google-Smtp-Source: ABdhPJx0DmqZ6ESIEhpPSkiqt9eqbw1VEX2SoyWrOXnUV+yQ5XF70LJeYPYoh+94BY3urmvoW0RJxQ==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr1586097wru.415.1642604196518;
        Wed, 19 Jan 2022 06:56:36 -0800 (PST)
Received: from wifi-122-dhcprange-122-30.wifi.unimo.it (wifi-122-dhcprange-122-30.wifi.unimo.it. [155.185.122.30])
        by smtp.gmail.com with ESMTPSA id g17sm7618730wmq.9.2022.01.19.06.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 06:56:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] block/bfq_wf2q: correct weight to ioprio
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220107065859.25689-1-gaoyahu19@gmail.com>
Date:   Wed, 19 Jan 2022 15:56:33 +0100
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <27914345-9CBD-4F3C-AB55-243208521B35@linaro.org>
References: <20220107065859.25689-1-gaoyahu19@gmail.com>
To:     gaoyahu19@gmail.com
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 7 gen 2022, alle ore 07:58, gaoyahu19@gmail.com ha scritto:
> 
> From: Yahu Gao <gaoyahu19@gmail.com>
> 
> The return value is ioprio * BFQ_WEIGHT_CONVERSION_COEFF or 0.
> What we want is ioprio or 0.
> Correct this by changing the calculation.
> 
> Signed-off-by: Yahu Gao <gaoyahu19@gmail.com>
> 

Thanks for spotting this error!

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index b74cc0da118e..709b901de3ca 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -519,7 +519,7 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
> static unsigned short bfq_weight_to_ioprio(int weight)
> {
> 	return max_t(int, 0,
> -		     IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF - weight);
> +		     IOPRIO_NR_LEVELS - weight / BFQ_WEIGHT_CONVERSION_COEFF);
> }
> 
> static void bfq_get_entity(struct bfq_entity *entity)
> -- 
> 2.15.0
> 

