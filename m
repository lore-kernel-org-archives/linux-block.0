Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82517258CCB
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333152; cv=none; b=biOIjtBywPRplvgQ8tN2jKdv7aJVoaPK3u2xPOHsUyWE+s1RRqOL/0Ao7zYICPkjxvAzz4Qffe8Le4HFWYf8x3mwHz67zRoTseLKuExfVm7OB43UQMtoxOUsFAmq/bfZDak8+Qd37J3L/Zv3v/qe/xcTSc3KcruGXFE0E1P6TNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333152; c=relaxed/simple;
	bh=rThOUHpQpOulaBM/pPEtW/Ij9btfVNHXGPGNuxYSj0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6f4pF0ZV3GrTPSbsR45BrrYQAmlDwZyPkijMjqBx5saCnBgjbEVbphIPHJi2FtOYu7CtbWlGQVn5zqHxevn8w78DKDBLA34znFbojTTOMM+7PJTrMEaIjIkrIktcyhJ+kGuwArzuceC8Z64iy9jftPt/ATOf05aETIVuC625Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FHOUN5qZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FHOUN5qZ"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da6fb115a6so8459395ab.1
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747333149; x=1747937949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1ihuHhphZY4t6ks48DSj/n7XCufCoO8j5uJD2DmT3E=;
        b=FHOUN5qZLpVvNnmL7RBOJyK6hv+S8QuH1+UEMl+fcVbqM6aVGG4rTxzRdP9I6ZTq/H
         IP88HMwpXKzuKppmXt1LHWnAUd9ZRh9ocZLeiLf7lB/vZwDzCgXPi1E8loc2JWYcdjKx
         jKvyrZhbBWhNuYmgwZAopMafO1IJmTOlD8VTNAUnuGk236lLhRib3Ee/M0T85STCEx1l
         76uIxgQFPJO0PfUwd0ZE9NYtBWEY8Shbc2JIyGWKHI6JtENEt3uYRVOgGbOoA+5hOoRE
         kFxRM3liePpEkKQ8KsYpFMY/h/4m4nGJ/EHpwmb+IN9YnfZkzzeh+Zu0OArFshDUzqY0
         hzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333149; x=1747937949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1ihuHhphZY4t6ks48DSj/n7XCufCoO8j5uJD2DmT3E=;
        b=KpIperrdE3dEUMiImVWbxr7A1kwAavd9Sxr5jb+4GjygI9Fy6X3ZjfNQbKbffV8eSC
         AJGEL2+SnRVvcmTeb5UZ8/Jf8QFvV6gMmXGCXKxAu+NW8C86WhRB8CuyiySEQtOGbU7M
         /FedUnllqjTrc5tFw7JelZzOFSzzAp1GY4C6J8YtpsnvziAB4M5auJ12KeN9O9zmw7pc
         bRYXyh/PPRGUqkAYseu92aND+OWaTnmDB3+kBqvMf9dpG95IJK8ZLfFDxnnP1yZu3aDx
         mIaoPUyQT538MpLXgUKD+xF9C2Y8qISa4H2X18u/bwEZWSfisls0+oVXV+uvwKaQ1HfC
         5qJg==
X-Forwarded-Encrypted: i=1; AJvYcCUOMwMCAHS8B/u7OSCcFkaJVCDXRAVAMuH+Ze6K3+i2q+8aOVbYHoaPiW8aDuPg3kO3h+486OfS5kfxxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyvFBCaNKZ6FSgvLriXaN+MtH+G+e7IZ9qdvlI2yqx+Ayy7lz3
	yYCA3pBoe8NzxlNEM1EOXQob4evvY+UfgYmIykfkBXgRzIWP6TZsldB3TKlZoalXOGdatRMC7qR
	/HXw/
X-Gm-Gg: ASbGncsefGRSAoSiAOMUDeY3W7kpzb+Zfmf/h0oENQHaUtsG207wt8ACZ5hxL0qW/eS
	HRWqDlBuNsZ1JjT83l7MKO9r7XnZPRSt6jsofyIVyhe5uV0C7pF3k8+da5+YA3W3lFmIpqXkcj1
	vZhgSUH3L3pqgXd/GzP1Q1k/QzMnYPMbQbSlPLcP89AN5rDoyhgh/LswN2YUyGdc/J/nMCiQLhP
	oIp5Mc3BegNxerATna1dcuRIoKwG1Tc8qvH9qt5id9eoEdwaNaAQyNJTqS1JjnAxUcI2vZ16Zb8
	+3W1e+WNgTBWbHDBJuQqVtj0yveDW6VLTHZmDwP2gdVqMZk=
X-Google-Smtp-Source: AGHT+IEjbOAcSkq+LL7MyZVqkUw2Qy2cJyeGbpl9GT88sFbWtYw2OKtGcO5G6lWBN2TWHlHIfCx+2A==
X-Received: by 2002:a05:6e02:1a6c:b0:3d9:398f:b836 with SMTP id e9e14a558f8ab-3db84321988mr10719295ab.17.1747333149510;
        Thu, 15 May 2025 11:19:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db8443ae8dsm710395ab.49.2025.05.15.11.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:19:08 -0700 (PDT)
Message-ID: <d5032331-7fbc-4c7b-9d1e-845121664872@kernel.dk>
Date: Thu, 15 May 2025 12:19:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics
 function
To: Jason Xing <kerneljasonxing@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
 Yushan Zhou <katrinzhou@tencent.com>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-3-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250515061643.31472-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 12:16 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In this version, only support dumping the counter for buffer full and
> implement the framework of how it works.
> 
> Users can pass certain flag to fetch what field/statistics they expect
> to know. Each time it only returns one result. So do not pass multiple
> flags.
> 
> Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> 1. refactor relay_dump() and make it only return a pure size_t result
> of the value that users specifies.
> 2. revise the commit log.
> ---
>  include/linux/relay.h |  7 +++++++
>  kernel/relay.c        | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/relay.h b/include/linux/relay.h
> index ce7a1b396872..3fb285716e34 100644
> --- a/include/linux/relay.h
> +++ b/include/linux/relay.h
> @@ -31,6 +31,12 @@
>  /*
>   * Relay buffer statistics dump
>   */
> +enum {
> +	RELAY_DUMP_BUF_FULL = (1 << 0),
> +
> +	RELAY_DUMP_LAST = RELAY_DUMP_BUF_FULL,
> +};
> +
>  struct rchan_buf_stats
>  {
>  	unsigned int full_count;	/* counter for buffer full */
> @@ -167,6 +173,7 @@ struct rchan *relay_open(const char *base_filename,
>  			 void *private_data);
>  extern void relay_close(struct rchan *chan);
>  extern void relay_flush(struct rchan *chan);
> +extern size_t relay_dump(struct rchan *chan, int flags);
>  extern void relay_subbufs_consumed(struct rchan *chan,
>  				   unsigned int cpu,
>  				   size_t consumed);
> diff --git a/kernel/relay.c b/kernel/relay.c
> index eb3f630f3896..f47fc750e559 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -701,6 +701,37 @@ void relay_flush(struct rchan *chan)
>  }
>  EXPORT_SYMBOL_GPL(relay_flush);
>  
> +/**
> + *	relay_dump - dump channel buffer statistics
> + *	@chan: the channel
> + *	@flags: select particular information to dump
> + *
> + *	Returns the count of certain field that caller specifies.
> + */
> +size_t relay_dump(struct rchan *chan, int flags)
> +{
> +	unsigned int i, count = 0;
> +	struct rchan_buf *rbuf;
> +
> +	if (!chan || flags > RELAY_DUMP_LAST)
> +		return 0;
> +
> +	if (chan->is_global) {
> +		rbuf = *per_cpu_ptr(chan->buf, 0);
> +		if (flags & RELAY_DUMP_BUF_FULL)
> +			count = rbuf->stats.full_count;
> +	} else {
> +		for_each_online_cpu(i) {
> +			if ((rbuf = *per_cpu_ptr(chan->buf, i)))
> +				if (flags & RELAY_DUMP_BUF_FULL)
> +					count += rbuf->stats.full_count;

Kernel tends to avoid the rolled-into-one assignment and check, it's
easy to misread. This:

	rbuf = *per_cpu_ptr(chan->buf, i);
	if (rbuf && flags & RELAY_DUMP_BUF_FULL)
		count += rbuf->stats.full_count;

reads much easier. IMHO.

-- 
Jens Axboe
