Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2A45035
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519656; cv=none; b=d+XkwjTVQGoAATdx92iRJxsH5PKjiIwvZWtROtu3Gx7nrjSIDz+BfxQtE6b+zvZECL7yEzo/0xkwVkY0c7YyAu8d1yLUnS6XBzsgAK+Y3XC+C1GrpR+YmcxvsmKgR0SJYsq/cBn/B2e36BhjLCV4IqU87nhHrLN0976zc8JjFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519656; c=relaxed/simple;
	bh=Z6EFxoutHZVK6zJ9o4cvquk4gB0jrtuY/AXOAoUtGC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o29nUdGzjCObhvfyEheEo1bifZS/8++KChILBJg3842hP2Q8Hk2+wVgddJ1MAxGoPDRKvTvPz/0t05+AXUfp26+ftnpcPFhWBq24WiPRN9b3lC2XaTXBuQJsYn51JZi7Q+a8DMwq8TddGOjgSzax9pkZJiwuAlqzl1k1IPsas2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BP81AGz2; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BP81AGz2"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7cbf1751c8fso9529739f.0
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710519653; x=1711124453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1p0Lq0m2EZg986149GaGwg2Ju9h7+VpqiFNMJ2p+kOs=;
        b=BP81AGz2N/awkQF52BodZPZ3t48E/C8lFVQ965BnL1L8id8WAIZ3zk05/1b/3s3rAU
         AImY87/NcOocMTOAADW1YYLI9h0lzrTMjsa0iV9KR5SvmgY9gHEiQWA0fOHV4OUtgJnX
         SYYkrQe0buGuivi/ZonAkTPfVvePXgImOHKDk6sexqLpkzupsE8PrMkDcHa2k2aw1ctG
         2mqaQBG5q0Ec6jjpVBvbLOvVnx3LEdgMN1EinujZPBXroqQOhOsmgsiFf/fbwKDm3qcB
         ELgifA1RLtV63+XuYVwaUPGSG2Ob29ezqBIZKcEYtu/uKKCrUG+0PZr7VLUUT04ZbF6a
         xdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710519653; x=1711124453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p0Lq0m2EZg986149GaGwg2Ju9h7+VpqiFNMJ2p+kOs=;
        b=BbCYdLgb/rsx7hUt9EQu5YlraJrKAcccUizp5vYtAzDTzxzAeblYE3YJOTVGuabg70
         5YY+M7p7Q9km92hIgd+bJviejg8LJIf8cgxmU0flGLLPY2Bdah5OOwHpg8MQTQ7YIhr0
         CRWW09QYqfC/uxFGlXPcrxKzBsIiMqFvWyZqOp8n1UDGY7Z6+lr8P2ZG0gBWNB372byb
         rhkz8qn//0kr829Jt1AUOwB/gwkMK6GjAYD4SI0S8pJrLO7Bz3SacDYr294chBjOdIjw
         3KJayq5tQh9K8i865o3tLcndF8AgxXPw8ov8x0GTX61wHZA6ihv93D5Rl8+f4h7BBtC8
         9S+Q==
X-Gm-Message-State: AOJu0Yz3e2/uXT11o8XDFamdZo76/6lY7CQiOeEk4OnaKTvzbyELXaR3
	GOUfnBQJ2cg4sdeCl1EiNjfhRQ8NPxnQqNynhGBgg2q1ZNgBrXpJ0xOHEYrveTA=
X-Google-Smtp-Source: AGHT+IHI4jokg11GVbWUclXTVDHBAutZIy6pCJFXre+RShmfjMMsqdBHT8OE/IHjMszpADrR9ErLOw==
X-Received: by 2002:a5d:9253:0:b0:7c8:bd77:b321 with SMTP id e19-20020a5d9253000000b007c8bd77b321mr5728782iol.2.1710519653256;
        Fri, 15 Mar 2024 09:20:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x12-20020a02970c000000b0047469899515sm812052jai.154.2024.03.15.09.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:20:52 -0700 (PDT)
Message-ID: <6e5d55a8-1860-468f-97f4-0bd355be369a@kernel.dk>
Date: Fri, 15 Mar 2024 10:20:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] io_uring: get rid of intermediate aux cqe caches
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
 Ming Lei <ming.lei@redhat.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
 <0eb3f55722540a11b036d3c90771220eb082d65e.1710514702.git.asml.silence@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0eb3f55722540a11b036d3c90771220eb082d65e.1710514702.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 9:30 AM, Pavel Begunkov wrote:
> io_post_aux_cqe(), which is used for multishot requests, delays
> completions by putting CQEs into a temporary array for the purpose
> completion lock/flush batching.
> 
> DEFER_TASKRUN doesn't need any locking, so for it we can put completions
> directly into the CQ and defer post completion handling with a flag.
> That leaves !DEFER_TASKRUN, which is not that interesting / hot for
> multishot requests, so have conditional locking with deferred flush
> for them.

This breaks the read-mshot test case, looking into what is going on
there.

-- 
Jens Axboe

