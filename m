Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA243D574
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d40eec5e12so27417705ad.1
        for <linux-block@vger.kernel.org>; Tue, 09 Jan 2024 12:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831565; x=1705436365;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9kqU5X2TMS9hQrCMaHCADAVkV6CrsHjRbXVJ3WmO+I=;
        b=STkNRkP2a0dOw0zVZTRmmFEdt5AGh/ORX3oyjRR/JmSX6KMuUmolhVwTpRrdkzzVtD
         b4BQTge/6FeEj2Pv3eu5TBkMMq0NbJahtZZ26azhng5Ls0VR3KLFHL6Lhw1iiwFKKM9M
         Z1Ge81M5dq0ha7TOV02ukYNSyylk9350NMjypJFS8t45dIYqDNdRq8DUV0XnqdrKBw85
         YFX1BcYw2xlFpU9wEMsC+wMM02w14XZiFkMQJqlFTpNmSd9prP0B0xUlgzOImy4j6fiL
         rraVxQSKp6mVuc95Lije/S/eBDi13FmcDJP63pZBppt5mkeGD+d2ABSmWM+Hzx8JlwYg
         CeUQ==
X-Gm-Message-State: AOJu0YzLca7fsARoKzbap9mmO5m0CpdCaL8nfT4G/Hg6cu4bLwgo+Mmq
	NSV0XmoCyeEoq5ilwmlkdq+i178I+mg=
X-Google-Smtp-Source: AGHT+IHFnyfQQGd7bVxX5X0iEX3OseX9y50TftnzRl1oVKk6/LlD5MIShieMgUX/yAuPz1F+k4fYlQ==
X-Received: by 2002:a17:902:684f:b0:1d5:4dbf:6045 with SMTP id f15-20020a170902684f00b001d54dbf6045mr2148186pln.86.1704831564793;
        Tue, 09 Jan 2024 12:19:24 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:b76f:b657:4602:d182? ([2620:0:1000:8411:b76f:b657:4602:d182])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b001d53f81f894sm2181040ple.122.2024.01.09.12.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 12:19:24 -0800 (PST)
Message-ID: <4a6b2848-7792-4e11-9fc5-482b8e4e020b@acm.org>
Date: Tue, 9 Jan 2024 12:19:23 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 2/2] block/031: allow to run with built-in
 null_blk driver
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
 <20240109104453.3764096-3-shinichiro.kawasaki@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240109104453.3764096-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 02:44, Shin'ichiro Kawasaki wrote:
> The test case block/031 sets null_blk parameter shared_tag_bitmap=1 for
> testing.
> The parameter has been set as a module parameter then null_blk
> driver must be loadable.

It seems like the word "If" is missing from the start of the above sentence?

> -	if ! _init_null_blk nr_devices=0 shared_tag_bitmap=1; then
> -		echo "Loading null_blk failed"
> -		return 1
> +	if _have_null_blk_feature shared_tag_bitmap; then
> +		opts+=(shared_tag_bitmap=1)
> +	else
> +		# Old kernel requires shared_tag_bitmap as a module parameter
> +		# instead of configfs parameter.
> +		if ! _init_null_blk shared_tag_bitmap=1; then
> +			echo "Loading null_blk failed"
> +			return 1
> +		fi
>   	fi

_have_null_blk_feature loads the null_blk kernel module as a side effect. The
above code relies on that side effect. I think that _have_null_blk_feature either
should unload the null_blk kernel module or that a comment should be added above
the above if-statement that explains this side effect. Otherwise readers of this
code will wonder why there is an _init_null_blk call in one branch of the
if-statement and not in the other branch.

Thanks,

Bart.
