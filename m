Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CE524B7
	for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714294701; cv=none; b=YU2zltsl2ZcDLAdGUqfn2kKmgxzF3SQomArPRHOCvHDkgcReHNx4E12mqkkHPR9YrHsMnhVLndVF3DR75oHq4DK4L30iuyS49SuNwZ33+yDhYnRDj3UsDitdpocRhvcZJoy22qPFF+exdMjen2SyZttB4ZGN4Zz107ciqH0d3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714294701; c=relaxed/simple;
	bh=rGJct+mJBUlnnhOzcT7UO9SqbXIOO1abL5jkj/vkxjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thb+L+WSj737kO2pVYfFpPd6OHIltHkq2Jt+1SWv9ko3NfK+1p/kRRF/88MpNJEWN0Bp4MwpaT+mod238aTYDwhpiYvsqRWBirX+1e1jXZ2Kvlx21pNVHb9IRF/0n4Q6X4TewoXhv16De+vJLHBmnspVgpPWSIozvcxwdX+E6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d9f829d398so8378841fa.0
        for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 01:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714294698; x=1714899498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96Om0+waDyQl6WbIl6bY94uj/oZp/fPxRE4KGqioeUs=;
        b=j1Yyz8prvTvsLt2V5V2iP9+YhaKC83OVnyJPf9Cz+TNOb73G8WLiNWV+j/bAXSYlfc
         31pXPy9k+sDStcH5Fcs3n+rIBsUQjifQfK/GUxmZuNNvU2VhD+MWLbWDJIcL5dqIpITu
         IYg7h+F5eaWtsJQ9vmNyzwTST3yDVoZCnve2gC6s404n6JXp18QN2dMLu460Uk6/5/NF
         qLRXETghMVwwTwIGJERN9r5v11/TbH/oqXuy7VOPr50C9wR8PQM2OLNRghSBNIe/DlMh
         0nF84VthEQIq2G6NpZpR0by5s9WkFO9406f/yVS73ayM38Eey/sZW1RrDfdJMb896HWf
         vKkA==
X-Forwarded-Encrypted: i=1; AJvYcCWZUty7STPPYRKiPkO9evY7H0fzw3fSnay+dOXl8Je9ijjqwgXzXTFQBslEX1umpAAFrH9AdZdXVWO+GAki9jGHE5InrWgVebUH9jU=
X-Gm-Message-State: AOJu0YwBohoSUYeE992tMtTtH8doBzIPXA4oeIJxDK26/SFgzxDp+gzr
	IafMAVZqs9E/ge3EoLJLTjG/Ryiic6flnxX9Ths8H4SNt/J/lYUn
X-Google-Smtp-Source: AGHT+IGb40SgdMG5/7RBbSJIB8Yrp8z8lxWupvlakG/K6+dOGI7hiPmGy6Zphzn9MYUWQx43W7fMyg==
X-Received: by 2002:a05:651c:2121:b0:2e0:243:dd61 with SMTP id a33-20020a05651c212100b002e00243dd61mr1333346ljq.4.1714294697907;
        Sun, 28 Apr 2024 01:58:17 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b00349d8717feasm26786004wrc.56.2024.04.28.01.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 01:58:17 -0700 (PDT)
Message-ID: <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
Date: Sun, 28 Apr 2024 11:58:16 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagern@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
> Enable repeated test runs for the listed test cases for
> NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
> _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
> so that the test cases are repeated for listed conditions in
> NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
>
> The default values of NVMET_BLKDEV_TYPES is (device file). With this
> default set up, each of the listed test cases are run twice. The second
> runs of the test cases for 'file' blkdev type do exact same test as
> other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/nvme/006 | 2 +-
>   tests/nvme/008 | 2 +-
>   tests/nvme/010 | 2 +-
>   tests/nvme/012 | 2 +-
>   tests/nvme/014 | 2 +-
>   tests/nvme/019 | 2 +-
>   tests/nvme/023 | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tests/nvme/006 b/tests/nvme/006
> index ff0a9eb..c543b40 100755
> --- a/tests/nvme/006
> +++ b/tests/nvme/006
> @@ -16,7 +16,7 @@ requires() {
>   }
>   
>   set_conditions() {
> -	_set_nvme_trtype "$@"
> +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"

Why not calling separate functions? having func do_a_and_b interface is 
not great.
