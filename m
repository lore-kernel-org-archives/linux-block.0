Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F23B789
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3e2972f65so12279175ad.3
        for <linux-block@vger.kernel.org>; Tue, 09 Jan 2024 12:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831295; x=1705436095;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b54ofTwPiDuht93+XALRgXaF7fCgTFqFpCE6v73Tio0=;
        b=vY+UKTHXYwB3Z7w/04NgGvjOAW+dJMZqsIzCBFjz90aDyytHwZ0wNT1L/HeTD6qkWN
         +8qH8shV1bmJDBEgjvqzqJYjJaJrw/IVUDfqCSEdjarERxPBbGqT8GGqyQ7iWnS7Taqc
         luOwrNLI0p1sLdZ2BELFwcKUIAwwLMOSgaHWkfOPysUaivYMX3fmK9tRTsADFQpx6S86
         jqkXygA2ctsM0uOyu+L+RjS+w7rS5vJZfrwlUm4ieaR22S+Ftj/480SEZ0oVO76nSzq3
         mzW1qXJ5e10nQJhkf9pLYHKGGTlSwmnwewIj+sIeaw4Dfwfh6CUtD39mGhPHvHn4Mbxx
         sT2w==
X-Gm-Message-State: AOJu0YwYVm76GsXN7A61ZjOlfxCC29b2WRZbV/jegust0tupef5KE/Oy
	sEs/j4oFFI3Y52NO12d2V3s=
X-Google-Smtp-Source: AGHT+IGO1YfN7YI6nwPwzzZMw/s1shDHYELy2dp+DOXF2h9mH/VcAUMKOdHQDsSK3q25wmGBaunE2w==
X-Received: by 2002:a17:902:ea04:b0:1d4:2066:68c with SMTP id s4-20020a170902ea0400b001d42066068cmr4141505plg.130.1704831295175;
        Tue, 09 Jan 2024 12:14:55 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:b76f:b657:4602:d182? ([2620:0:1000:8411:b76f:b657:4602:d182])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902b21000b001d3aa7604c5sm2210087plr.0.2024.01.09.12.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 12:14:54 -0800 (PST)
Message-ID: <89abe7cd-298b-4bd4-9a08-e183ffa7af44@acm.org>
Date: Tue, 9 Jan 2024 12:14:53 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 1/2] common/null_blk: introduce
 _have_null_blk_feature
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
 <20240109104453.3764096-2-shinichiro.kawasaki@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240109104453.3764096-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 02:44, Shin'ichiro Kawasaki wrote:
> Introduce a helper function _have_null_blk_feature which checks
> /sys/kernel/config/features. It allows test cases to adapt to null_blk
> feature support status.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   common/null_blk | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/common/null_blk b/common/null_blk
> index 91b78d4..164125d 100644
> --- a/common/null_blk
> +++ b/common/null_blk
> @@ -10,6 +10,21 @@ _have_null_blk() {
>   	_have_driver null_blk
>   }
>   
> +_have_null_blk_feature() {
> +	# Ensure that null_blk driver is built-in or loaded
> +	if ! [[ -d /sys/module/null_blk ]]; then
> +		if ! modprobe -q null_blk; then
> +			return 1
> +		fi
> +		if [[ ! "${MODULES_TO_UNLOAD[*]}" =~ null_blk ]]; then
> +			MODULES_TO_UNLOAD+=(null_blk)
> +		fi
> +	fi
> +
> +	# Check that null_blk has the specified feature
> +	grep -qe "$1" /sys/kernel/config/nullb/features
> +}
> +
>   _remove_null_blk_devices() {
>   	if [[ -d /sys/kernel/config/nullb ]]; then
>   		find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 \

Shouldn't _have_null_blk_feature() unload the null_blk kernel module if it
loads that kernel module? That will allow to simplify the next patch in this
series.

Thanks,

Bart.
