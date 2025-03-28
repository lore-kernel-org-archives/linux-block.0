Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB316FBF
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206319; cv=none; b=pMofOXhCm6f9XNczb3eD29myUZaT8h6DqWx3SZ4AuVYLRRHhDGKanEiE8FEyXpnoNyjk4k+BbttKPVDBobyiK1gHgvFLqUvVRWtUI5XmWXX/0n29+B0lGNqc+Jc8ngj3wOcvT+hEGwPrz1n3Ax8Pq/MyJdsFROPU6MU2tRgQa94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206319; c=relaxed/simple;
	bh=p6m/nvz/Q2Q0JIFlNq4Hw/EgwqnEbBRnzIoKtvBxnQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuY0tfZRT/1v8fpY3YlOltbdGlKQqnJG2RXbo3g1dG+D2UylUsJ+DHUMbRuuMvmSomGgyjtNtHnW91z3st+BSSU4imsYtYQtjjnsLlvt+LymCUiCj5e/m4WNxeZe5Ovqpjfnvz1vOlTKMcc5jKrZFako9v0pVgY245u5TxcutW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=awQLkTWs; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="awQLkTWs"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d434c84b7eso21024255ab.1
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743206316; x=1743811116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5JcEI/bdJeiO7FQkHMbOrLBwPR+IcOVIoR62S759ko=;
        b=awQLkTWs8C7VEnQn/v3pfJMmpb0HtW0XPb8TrQCBTNPVSk+y06amIUNHINHi0xv3M+
         xWzGmPaYBUiJXv9gkKzVUWLe+bO6pOwRTQbMena6R0ltMOX9jkjcYMa2Vc+afrFyxGwK
         27w1b+SsNdawssmcTVk9iG7nrfCdC2xKOo7Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206316; x=1743811116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5JcEI/bdJeiO7FQkHMbOrLBwPR+IcOVIoR62S759ko=;
        b=d1+pmUhnb/UetAQc+ZYY0mJJhe0hzyaFHObJtURre4uOesJiyAqa5pFmZUhLGSt05d
         Ea4tETFb4AlIuC2P3XKVy4IyKuKNA1dsuFE4zBfBvNOJh2NAPjT0ERN0bMC1YhN1pikh
         f2AWTqlQQZs/LJiWgYbWb9t43mv20NjkotPwOXDd6sCoV5Bc9Dwk7iKb0UqW9wnBn+yJ
         rzJeOmXqokwjAzKhvPk+kaFn54aNHWZYkkeaIhqXQtoBNfEIfy5xmJtFNr3X5AIhTkNU
         zX5UZXFaZqBdJEI7+LmgCSH5h3ekJL4VdCi/8yME5ZLxxR/yfuFkSJVB/JbrlcLQCcp1
         Z7zQ==
X-Gm-Message-State: AOJu0YwDQ8GfXk/5pys88qFRo8tbm4LczsAwJ7oq32yf2uo2uHM+FM09
	r+WFbskmCMu8b/Dl2S8DGiR4cOqq110NKTaWzS6ugFnTZ9u04ucMy7jFwCI07II=
X-Gm-Gg: ASbGncuvvAZQkU4QJxVOXH2T/agLaNmlRDM/lx1TCk6yURaNox0WKUup2vWLc9Vdf8H
	2FKeX1wc2pt5CW0dDvzS6xrhAdOGgmNcL5wL42Mn29JWO3+vawTw5PbJKnP4AALyUkIcIXdIkxr
	kObr9LUcbltdPsadgh5++1nokk92hr0PL1Mw2WTIAlOpI+q0UNiEJyZVCwSbal7YgkRMp/T40b+
	LM89tlED8vu5ZfuDELjIypGKcPFQWsJxj2LFTSTo2DmDbo+8QuxcEpPhC198QhRysepAUX/hZmI
	j2ncaQAQhJNNNXBtIZMZ72/RdfBhzMgVjNIjRO1Qk8PUEVTgnn3q/Escx1gz95kCGQ==
X-Google-Smtp-Source: AGHT+IFk3MJlvLeFpqX0/xXhiDnhkbsvv/gybLX1nzNP/m6Tx4Ep4JZoTJEVdakXyN/Hyebwsn24Cw==
X-Received: by 2002:a05:6e02:1aa5:b0:3d4:6e2f:b487 with SMTP id e9e14a558f8ab-3d5e07e88fbmr17198845ab.0.1743206315648;
        Fri, 28 Mar 2025 16:58:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5ae2591sm7073465ab.47.2025.03.28.16.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 16:58:35 -0700 (PDT)
Message-ID: <92cd8fdd-30eb-479e-9c06-31d6a467cb89@linuxfoundation.org>
Date: Fri, 28 Mar 2025 17:58:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250328194230.2726862-1-csander@purestorage.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/25 13:42, Caleb Sander Mateos wrote:
> io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
> char *. Indexing the array requires an explicit multiplication and cast.
> The compiler also can't check the pointer types.
> 
> Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
> indexed directly and the compiler can type-check the code.
> 
> Make the same change to the ublk selftests.
> 
> Caleb Sander Mateos (2):
>    ublk: specify io_cmd_buf pointer type
>    selftests: ublk: specify io_cmd_buf pointer type
> 
>   drivers/block/ublk_drv.c             | 8 ++++----
>   tools/testing/selftests/ublk/kublk.c | 2 +-
>   tools/testing/selftests/ublk/kublk.h | 4 ++--
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 

For selftests changes:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
