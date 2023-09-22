Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E3CD4844
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 16:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjIVQ2R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjIVQ2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 12:28:16 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095AA139
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 09:28:10 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79f96830e4dso18272239f.1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695400089; x=1696004889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jPU27f/QOTZZXxzNL9Wl0Fky7mqQXSIEn4SbYQwmjw=;
        b=GAUsFId3Iz/HhEEWKyGi5wIBlrhta2f3Mwf2EP70fDrFCZ3tL+A73IuVctILXQe2ul
         liosSrHbvIT/OqLJau/gfaWDMxo9LSNrwacF53I74fyzspH6aQXxpTFAIsTw6ALt3WRE
         4/jgipyK1o+HAH0igUyXHcEF+b8m+8wD0cHzSW+uYBEVVWktaZO358HJmPvnmFUEvfge
         q28JBY4f/hCHhVIwKDjmRGCfGc2E0JmVFUjylrhU5/P+m9XWCvfxtlL+TIKd1sjO2KT5
         bl7zzpKj1mhXLhy78Z47n+7UypfrDWXM+VemH6dotJNAQMu0tuhgDGmCrqYuCnlO7ocN
         udAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400089; x=1696004889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jPU27f/QOTZZXxzNL9Wl0Fky7mqQXSIEn4SbYQwmjw=;
        b=w0J9K+5ctLZxo7NFw++6wdgv6j1U19f/bnEDPiMg14QOecVQReCxMj58PuWZ4cjKzR
         zySXHvmSyR1gRct4wyaWXBhqItYBw4MPVwa0O14VmXTlsxa8JKMvrBv9P5xW1y2JruFQ
         yOU95NfytndYoIGhWXcDe1aRSt4WE/NvN5wmuZPPnJxJB5eg42Sucr/IH8s3kL5ttWyF
         V/WSbZEnSWExXa/0z6A752EExohr3XThJOUt7nK/m4ecRRM16gnHH4dztm9TDGrFvJ2W
         +pPi8btSFR/gyDTs3xLOMdTocDSM7cx68DEezFPCn2B0pjs4In9Qx8WXH7dSYmlfTxVt
         TSYQ==
X-Gm-Message-State: AOJu0Yz4zZoVivmfkgPlZOmImIc1deOE+4/Hhvm5MRL+H8Vxuv6798+6
        xkeEkjQ6LBlKys/YnmWE0kF+9A==
X-Google-Smtp-Source: AGHT+IGh7zQSr997B5ub842LyYZRMvYtZYNURY0DzOJ7kQB7BQcTYABXlU9nx4SaVN/TFCNBO0j5mQ==
X-Received: by 2002:a05:6602:3788:b0:792:7c78:55be with SMTP id be8-20020a056602378800b007927c7855bemr9268707iob.0.1695400089357;
        Fri, 22 Sep 2023 09:28:09 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n18-20020a056638121200b0042b0ce92dddsm1055745jas.161.2023.09.22.09.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:28:08 -0700 (PDT)
Message-ID: <c6f92395-fc15-4cd9-b685-1880c620d2b9@kernel.dk>
Date:   Fri, 22 Sep 2023 10:28:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] io_uring: cancelable uring_cmd
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>
References: <20230922160943.2793779-1-ming.lei@redhat.com>
 <20230922160943.2793779-3-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230922160943.2793779-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/23 10:09 AM, Ming Lei wrote:
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 783ed0fff71b..1e3de74c2ba3 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3256,6 +3256,39 @@ static __cold bool io_uring_try_cancel_iowq(struct io_ring_ctx *ctx)
>  	return ret;
>  }
>  
> +static bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
> +		struct task_struct *task, bool cancel_all)
> +	__acquires(ctx->uring_lock)
> +{

Minor nit - I don't think the static checker will be happy with this, as
we're now called with it held already. Might not be a bad idea to add a:

lockdep_assert_held(&ctx->uring_lock);

at the start of the body, both for safety but also to document this
requirement.

-- 
Jens Axboe

