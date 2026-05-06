Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59936D51D
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051373; cv=none; b=fYIUHIWab+f99or5S5N5Nj4YRg1a82Lyhm7jR3HAmuX+lQNDBX3ka/rZLh8J7uP3wxdFz+9+/R0Yir+PYsaGbCRvHmv++VEpQjgXpvxgJSz9lILkLK6j5OzTojnleDxpCdbnW4zG38wXEg160yphPnxqsJQS0be4Yjl8VlP31WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051373; c=relaxed/simple;
	bh=vvariKpSLXBVCVyZYR/OEUF/P0GtuR2yTqRCxKpPd0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUR1dXeXu4XzyYebq2Rfi7cCFjvnK/HIvczr0c5nb5BKwaBJGj3lkrOJRvFPBX3SM1THl/kBWx3BmXt1e1Scztex+jNcBkVsXQmDyPy8GoYIVVaYIGAT7x9ZndBGK9ClSBar/Y6/0FYduVjUJDfzF8fBikRpwhDA6OUyIkc0hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=NRU2rSQs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="NRU2rSQs"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4847929f8f.2
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 00:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778051369; x=1778656169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/NNK31KWxsQZ1iecY4atieFZgPU2Vu2GTBkZCQW8vg=;
        b=NRU2rSQsD6eSP3AK8j6YyfJxjzeWmZEzDH9Q1Lz8vCqEy0feLZa47W7kdwc+ymPoq6
         KLnQ7tPK3eunSTtICKk+LoBtWCDoZdGF2FKf5KluduAXWzc8i7FFE/NK0gp+HR2Ijxc7
         WHlOYKLU4L8gG6sSMee4hj8pe+GSGf4kHpvQnc9PiEpW4aSGhEGFFwLQ+obYR8xbk/rT
         5BKsX4fi1t9500Q3tDbsK4I9CtXYPmUclWc3WzSCZdpH0lMhnF34nLH+zlcyfBvezwid
         TTXFKjA3nk23KrIhNZ2Anonuf/KhFB1m1d0CLr2N9oL5IPmadyLeTvXEifvXaTz+r5kV
         fG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051369; x=1778656169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/NNK31KWxsQZ1iecY4atieFZgPU2Vu2GTBkZCQW8vg=;
        b=b7vKVT4RmzUkPJoU40OL4VsYvrw4i0rFwiZUrMZD/iv/Q8Bpt+Ak66v0ORTqOmlngk
         287Z7AJwQ4bd27bdo5paX4U63RqTA3SwnN0+/6EVS2ilS9RscPzlmhYZFMtjzMfoA8pg
         xhp2Ub5cO4N74zKz2FQlgb1Y+aSU723rv8dCus9kUWLbGHQX/+qnArVkpsjDPexgOxKX
         9tjOn+I6jaCU5wxamFnsD+w8CxroHviUFGCAbRkFKqIX38ohYlS0y10VZDQQUdI9jEEs
         1cki6U/edJpnoIayrHpJbDLK2PhqsHcsKRkmExWkziyFoSG3yYgY/JiTVtFO1eGNARPw
         706A==
X-Gm-Message-State: AOJu0YzM/b5+wflKtnG/uex54RrFPUlg/ajPgrW9PF+tdVlTmPQ0asi2
	voVbgF2NgtooDS7WISe1Mm4sl9DLdmSGTMl7xyVlvemL8Q+FXEb25ao+iMbwQ7lln+M=
X-Gm-Gg: AeBDiesFsbubsOoS9U6Z86Q+NqGnJqw/5fWUyGRDnOQ7j49I7NLj8W9/SJWVXDLeFYT
	yzxdaanBY8P/VWoPIQNo6fZAexeqFTylM+rb/G+GMvpXuVyLDu5hEcxc/sYuCLCwE/lrMzWbnsI
	fcMAsBXhAIdp2O6W03eYPrYOriuQBvkveHmds6Yn7MyAWFnRVufQCSXpFNeiv4zm2OsNm+GVx/l
	I7E9A6znYkNqMvhad5TXOK33PGbK1qkh7SC+XdtwyWaS1PM20uSDHbXr70zlOYZH72PIlXPz88y
	XlR5TClGAi3lpDO2xNT18WfyjI1Q5pXUCKcwr5qTolhIkegm2JVOhHfHZ8pTqT5fHJy/OA+NWAm
	Lk/xZ0Cuzqz86McSUJXOkPJTsKCeHps7vaH/DZnZgA7p1tt4cyI4p/aaq+m3PiR1J+4CkVy0HUJ
	In+GWW2CK002w15rlgmPKJWbCw2cq63d6QkHuUzFhr/c48IXyYzPwruXcObzhrOBlBOCCt6dYQL
	pQyt6Iq1Bxi9Pd8CbdK3Q26sQNuEk0=
X-Received: by 2002:a5d:5d03:0:b0:43d:68dc:9ca6 with SMTP id ffacd0b85a97d-4515b5254b6mr3720321f8f.18.1778051369468;
        Wed, 06 May 2026 00:09:29 -0700 (PDT)
Received: from [10.211.9.173] ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f249bbsm9065327f8f.36.2026.05.06.00.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 00:09:28 -0700 (PDT)
Message-ID: <db3d516f-6ad2-469a-9bd8-1a9b61eb12a0@kernel.dk>
Date: Wed, 6 May 2026 01:09:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: bic maybe null pointer dereference
To: yanlonglong <yanlonglong@kylinos.cn>, yukuai@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506055655.32276-1-yanlonglong@kylinos.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260506055655.32276-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/26 11:56 PM, yanlonglong wrote:
> Signed-off-by: yanlonglong <yanlonglong@kylinos.cn>

Your subject line is incomplete, and your commit message is even more
incomplete.

> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 141c602d5e85..27ef736085b1 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -3035,9 +3035,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  {
>  	struct bfq_io_cq *bic = bfqq->bic;
> -	unsigned int a_idx = bfqq->actuator_idx;
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
> -
>  	/*
>  	 * If !bfqq->bic, the queue is already shared or its requests
>  	 * have already been redirected to a shared queue; both idle window
> @@ -3046,6 +3043,9 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  	if (!bic)
>  		return;
>  
> +	unsigned int a_idx = bfqq->actuator_idx;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
> +
>  	bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
>  	bfqq_data->saved_inject_limit =	bfqq->inject_limit;
>  	bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;

Ehm no, variable declarations go at the top.

Please try again, correcting the title/subject and ACTUALLY write a
commit message. See:

Documentation/process/submitting-patches.rst

-- 
Jens Axboe
