Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01448E92723
	for <linux-block@archiver.kernel.org>; Thu,  5 Oct 2023 18:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjJESCd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Oct 2023 14:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjJESC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2023 14:02:27 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE090
        for <linux-block@vger.kernel.org>; Thu,  5 Oct 2023 11:02:26 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-577fb90bb76so739655a12.2
        for <linux-block@vger.kernel.org>; Thu, 05 Oct 2023 11:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696528945; x=1697133745;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76a8YQ0hLV5bUIBYfne2+TIqNG1r6p78CzGnl00LQkI=;
        b=nAqDacVGDssoYoYwpUTRbLdwey9KO/8KUrQ85/IlPOBLCdOZ7SySO0n8TUUBfEbwN9
         EgKwESkUDzuczUTKtBqDdwv2UYFsQqX8c5fASqkTuoPnqPSzaOrsMeIJ48mkvomhh2W+
         2ZgrW/dbQJcKG987KmPi3RB+bVkhxClWmRc5j9WAZO+vRXdUJGBgJlN5aemgUbjzP1yP
         YJXaf/uJqmmaZaF55tbNNXqPtnlKRAjnCfooDHVxpRPuKEHU1TrBgzUrM2Fy4gaNsajY
         iTKBydOvIalpVpZx9UfAN5NmfDWLCsl31G0PLGwx7hVxbp1IJt9jpkougHeCgOUbfuGq
         QVYw==
X-Gm-Message-State: AOJu0YyM785Tnw+JVRl0giFMWqz2Njlj3zCwJzE/rVdRlig0Z9w3DJUw
        yuS45zNjOlgpboNGa4KJaZ4KN3db4wI=
X-Google-Smtp-Source: AGHT+IEtxhx8Df6oc23r6vTVfpi0GCljdCBIuAHJXI9tx/vfH9rfZ3EhYCygbBmPeUDVC2fu0Q7kog==
X-Received: by 2002:a17:90a:9d82:b0:269:621e:a673 with SMTP id k2-20020a17090a9d8200b00269621ea673mr5809723pjp.1.1696528945326;
        Thu, 05 Oct 2023 11:02:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ca3e:70ef:bad:2f? ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id mp3-20020a17090b190300b00267d9f4d340sm3897773pjb.44.2023.10.05.11.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:02:24 -0700 (PDT)
Message-ID: <6b267348-7548-4cb5-a62a-284c6750aeae@acm.org>
Date:   Thu, 5 Oct 2023 11:02:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/rc: fix rdma driver check
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20231005080242.292291-1-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231005080242.292291-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/23 01:02, Shin'ichiro Kawasaki wrote:
> Since the commit 4824ac3f5c4a ("Skip tests based on SKIP_REASON, not
> return value"), blktests no longer checks return values of _have_foo
> helpers. Instead, it checks if _have_foo helpers set SKIP_REASON, which
> was renamed to SKIP_REASONS later, to judge test case skip. If two
> _have_foo helpers are chained with ||, the skip check does not work as
> expected since one of the helper may set SKIP_REASONS even when the
> other does not set. Such chain with || is done in _nvme_requires() to
> check rdma drivers.
> 
> To fix the check, do not chain the helper functions with || operator.
> Instead, refer $use_rxe to call only the required function.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/nvme/rc | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1ec9eb6..bac2db7 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -44,7 +44,11 @@ _nvme_requires() {
>   		_have_driver nvmet-rdma
>   		_have_configfs
>   		_have_program rdma
> -		_have_driver rdma_rxe || _have_driver siw
> +		if [ -n "$use_rxe" ]; then
> +			_have_driver rdma_rxe
> +		else
> +			_have_driver siw
> +		fi
>   		;;
>   	fc)
>   		_have_driver nvme-fc

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
