Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19426225D9
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433199; cv=none; b=XyivtV+b4G0eQLUOGGkVBTeTxabXCKhNg2k03Xmdu6Nk0nA39Qe3WwlxAZwutqblxwOFv0q8aJv8YUNlsK4PCeADzysOV3AIbDwJMRDAG0eb82BYYgN7AxBuqTNgP3W/Rg7qKCVMO29oh8GM8zTdI9Y+r9ST9AxEM7WK+G5YxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433199; c=relaxed/simple;
	bh=5v9DMVfH0FYlVqUdkaNcGx17JaA1Ub4fkPg3u9n4mIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7lmxJnlGMTeN0Bl5CutyotcE5WWDwU9IKXaZb+uQaqJgNXv3VwEwmK1ebdyIYcZjFiM/3F8o+nRdhb2rsICTQras9oy1zoSvu3BPTIfqv1IOP/Ymnm8+hpmGx5uEHNG88d9LgVOh7Z5h8O99s/hD7vFlHJQXrx7x90fmNXaFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-345606e8ac0so81747f8f.0
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 02:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433196; x=1714037996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er8DX4GP/0zcFAH5hqRsOdPBNwI7p7EcYeTeMz68P6k=;
        b=lWwLFu6DttHCpnTl7w924rKCJmZixh3AxiLcMILBYQotGGxCL46fHnAAP2vQ1EsiYV
         JqMWDgJYo8+yObmkLMXngOeKiPe7V9JTJevq6lIVBGLLbm0+SC9ir+gAdhgdpCTtc8pf
         CMCp37gmwZaAm7NRa+W/43EQJWidn8qxKK1qnQ7uJ6G5CrEvgTREHv6icTOUQrK1gdsi
         9YVwnZarBHkzjKW5Cytthv4fE3/u8VGUOKXS5WHrWaGL1gpfmn4Z0ACxwVTr6S8JhOFb
         nG/3Py3VqlHQ+XF24TGV+8xQ23cGXdB1/3aBF5bth9g+iE86mVwaLf7J/wMsDeBzLsV8
         +7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCW5ipiMqo6lCiNJgAOof/FteuY3PTN9cx+LOKjqUwFH9Tmk/wVxOfC/i1GPZaEN7xLSUNOpu3Z316Qe6B0oqJRF9MdLago/RoOFsAg=
X-Gm-Message-State: AOJu0Yzp6m5GJNpyVHZlwdYx1FPMJhCRTesmDrRP1BwEreYIjnwABfWu
	t+tA0r/eaOl2dmegEyNQn3uqXFgQnoqI925H+6eKC8RVJCyBxr8ZipRS0mim
X-Google-Smtp-Source: AGHT+IExRCYVfQBev/WP5uthvMv97mFPpVQLciU76GEJOc65YeRzt2GNkaYiVeOeVs1IAm/cYJKisw==
X-Received: by 2002:a05:600c:1d16:b0:416:b5f7:7ceb with SMTP id l22-20020a05600c1d1600b00416b5f77cebmr1549260wms.0.1713433196291;
        Thu, 18 Apr 2024 02:39:56 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b00418a9961c47sm2057311wmq.47.2024.04.18.02.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:39:56 -0700 (PDT)
Message-ID: <35a9cba8-776b-4894-9dd4-122eccb68887@grimberg.me>
Date: Thu, 18 Apr 2024 12:39:54 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 05/11] nvme/rc: introduce NVMET_TRTYPES
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagern@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
 <20240416103207.2754778-6-shinichiro.kawasaki@wdc.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240416103207.2754778-6-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/04/2024 13:32, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group can be run under various nvme
> target transport types. The configuration parameter nvme_trtype
> specifies the transport to use. But this configuration method has two
> drawbacks. Firstly, the blktests check script needs to be invoked
> multiple times to cover multiple transport types. Secondly, the test
> cases irrelevant to the transport types are executed exactly same
> conditions in the multiple blktests runs.
>
> To avoid the drawbacks, introduce the new configuration parameter
> NVMET_TRTYPES. This parameter can take multiple transport types like:
>
>      NVMET_TRTYPES="loop tcp"
>
> Also introduce _nvmet_set_nvme_trtype() which can be called from the
> set_conditions() hook of the transport type dependent test cases.
> Blktests will repeat the test case as many as the number of elements in
> NVMET_TRTYPES, and set nvme_trtype for each test case run.

It would be nicer to keep the same name and just have it accept an array.
Not a must though.

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   Documentation/running-tests.md | 11 ++++++++---
>   tests/nvme/rc                  | 33 ++++++++++++++++++++++++++++++++-
>   2 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index ae80860..144acd1 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -102,8 +102,13 @@ RUN_ZONED_TESTS=1
>   
>   The NVMe tests can be additionally parameterized via environment variables.
>   
> +- NVMET_TRTYPES: 'loop' (default), 'tcp', 'rdma' and 'fc'
> +  Set up NVME target backends with the specified transport. Multiple transports
> +  can be listed with separating spaces, e.g., "loop tcp rdma". In this case, the
> +  tests are repeated to cover all of the transports specified.
>   - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
> -  Run the tests with the given transport.
> +  Run the tests with the given transport. This parameter is still usable but
> +  replaced with NVMET_TRTYPES. Use NVMET_TRTYPES instead.
>   - nvme_img_size: '1G' (default)
>     Run the tests with given image size in bytes. 'm', 'M', 'g'
>   	and 'G' postfix are supported.
> @@ -117,11 +122,11 @@ These tests will use the siw (soft-iWARP) driver by default. The rdma_rxe
>   
>   ```sh
>   To use the siw driver:
> -nvme_trtype=rdma ./check nvme/
> +NVMET_TRTYPES=rdma ./check nvme/
>   ./check srp/
>   
>   To use the rdma_rxe driver:
> -use_rxe=1 nvme_trtype=rdma ./check nvme/
> +use_rxe=1 NVMET_TRTYPES=rdma ./check nvme/
>   use_rxe=1 ./check srp/
>   ```
>   
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1f5ff44..34ecdde 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -18,10 +18,41 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>   def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>   export def_subsysnqn="blktests-subsystem-1"
>   export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> -nvme_trtype=${nvme_trtype:-"loop"}
>   nvme_img_size=${nvme_img_size:-"1G"}
>   nvme_num_iter=${nvme_num_iter:-"1000"}
>   
> +# Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
> +# If neither is configured, set the default value.
> +first_call=${first_call:-1}
> +if ((first_call)); then
> +	if [[ -n $nvme_trtype ]]; then
> +		if [[ -n $NVMET_TRTYPES ]]; then
> +			echo "Both nvme_trtype and NVMET_TRTYPES are specified"
> +			exit 1
> +		fi
> +		NVMET_TRTYPES="$nvme_trtype"
> +	elif [[ -z $NVMET_TRTYPES ]]; then
> +		nvme_trtype="loop"
> +		NVMET_TRTYPES="$nvme_trtype"
> +	fi
> +	first_call=0
> +fi

It would be nice to have the string check be done at first so you don't
get any typo-related error later during the execution.
