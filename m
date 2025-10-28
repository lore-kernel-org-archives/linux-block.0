Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC71239E7F
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659683; cv=none; b=XguYdULmOaC0hGl+8bt8MvnJ5KGTssKW56tlhg34Kr/MOvedXZ/hG3V1TEKY9F2H0iq46kvW+I7X2sC4hCftoCS4MqVB6l9hzIeJa93ZYDpzj/mNlVwQ9gK2s9FEg8MGe2eW8gNJgqS+wo+dDHrqfqx+wEMX3KUGrJA5ERRyyeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659683; c=relaxed/simple;
	bh=jSd4hcS7xop9ZuK0NsOQ84M/HWN04CoJ1NRFNJlY0hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/y7+RUTeWIXDa/6zKWE4ZndX0jePCv1jVbv6yon8yIB/5RKBBrVHI/Zd180z+Mv7+fc++9WnK3GLJwJfSrKjAzpRnWa4rfu0fsVgnb9YcCZ4IUsUPpsUZ6EW4sdAi+zp7SoBxYNgIFFVlbJUg/gHRMynMbwQzercVsQz2/gPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3cBvKpa9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3cBvKpa9"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430ccd45f19so63878775ab.1
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761659679; x=1762264479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vr99gX2aBwJu7kf6ztY22NIa238ykp6XTngN2e+Qruc=;
        b=3cBvKpa9JmgeLjstIEf+J/VUZ+v0sbh9Er8gI1w4+8Q95yZzgczN8xaEoY1ncvyGsK
         XUjrLualq1Dm5pPztchhu5EkbdRzfjp8QxMUOKAj38j1SO1efb/KJIEPYWErTMCQFKfA
         cinidTqquiqSeFnJaL6ktSVgHHGqFKMc/Zk385jllWtLi/z4vNJSFhTCcfosOyx3vlb/
         6U132VumGnwSDsj9jWKHsjBl7s+JmPoQkhXzJ2tshpMQ8YRPqKzM1lJzN8A7gy2jXaVI
         BA27vVLbCS8rnZ8CFbL7mWhwlojx5XOu/ufsOfv+kETNR9zNKOQr4PhVYUK9N3H4x1+A
         PRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659679; x=1762264479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr99gX2aBwJu7kf6ztY22NIa238ykp6XTngN2e+Qruc=;
        b=bKZbb2B7Rtiu9QiLPtcQ7guqvRh7YKjOLCAczIVVRSMoSQjMViCPPafxXpKEAhF8TY
         UBA8nBZ3j4im1/bVOeqofc8+9XLRRaZRXdCFyKoV3Emm2Dwngf9WUURvCjat1lcDDhuo
         L6ymbBMXvmI1rJWmedk3dXGue503AoS19dJ5xRQ+d4OoUtTrmXy8Z9MOP8H6wkd6GrH0
         A98u15poV8+i7svhwufeEtqhJw20axo9JTqiH+t4GSWX2co7Ru6aWjYeNQ8R5FPCZVxB
         hTVdlH2JFwYCbuA/XIuwci1ot60jeatWbaqkKQLsLGu1PnZr3wXeaEaFdEcgMf7VdgZ5
         UH7A==
X-Gm-Message-State: AOJu0YwEwPXh8ctgZvirAR5WjUe9fIFUQUBCaHeQ3CTKi2v7RDjyVk0T
	UvUJWAaJKR/nvl3VBLZZ4Rnf94O7N94Jj+Sbm7BLkCcbHMgyqRDAnUZl7tIEGm/k0MM=
X-Gm-Gg: ASbGncuy7rTrt3BkHN+fYKxT3yoMkbk+rfcUsn/W69vOjYZrJhtYtjW3bLav3HisMvr
	auflIbVCKnXLJAPm4bZ/61bQ/YweGTL8wp9wk/Tk2YkMPgz29FUdcqQo0DqV0rhs0nqCUUvpbsa
	VL0h0AbUwdKwPSedprePfEPkzuo+9cVBckFYI3+lXt/Gu8Q6kbFZ9ilHBVSbHcJkrwLSAXkxNjW
	GhOo3M+62eaKNxognn1aCnuAF1TzIBZZ7wvtvQW3lFE2hokPif5tXsk279N/uYXUUMwHQb4joy9
	rOloW5/VksIYzXIlbG8HSG1UGAFcIggKgQwbduCMi089PVkdv1Jm0b57kQI6RHc2JFxT3oZ/rff
	o7rMdrQTSZpBEXzNSQPupTuZzhsRvZksZf0bCzy/dQwwEoB+sRFCoihzUmEAa4Bikt6VM8nj8
X-Google-Smtp-Source: AGHT+IGCC24xLu0YPxPJqjvvOdQHxuwTrOmVY7UuZn98v9qWq2D9d2x55e3Zpz42GT5EFXIAara3Iw==
X-Received: by 2002:a05:6e02:330d:b0:430:a538:25e7 with SMTP id e9e14a558f8ab-4320f7af6cdmr54831985ab.29.1761659679547;
        Tue, 28 Oct 2025 06:54:39 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d420sm4405918173.43.2025.10.28.06.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 06:54:38 -0700 (PDT)
Message-ID: <ce30aa10-4138-4c25-857f-f1a2ea1c91f4@kernel.dk>
Date: Tue, 28 Oct 2025 07:54:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, Johannes.Thumshirn@wdc.com
Cc: linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, dlemoal@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org
References: <20251028043248.2873-1-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251028043248.2873-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 10:32 PM, Chaitanya Kulkarni wrote:
> Add informational messages during blktrace setup when version 1 tools
> are used on kernels with CONFIG_BLK_DEV_ZONED enabled. This alerts users
> that REQ_OP_ZONE_* events will be dropped and suggests upgrading to
> blktrace tools version 2 or later.
> 
> The warning is printed once during trace setup to inform users about
> the limitation without spamming the logs during tracing operations.
> Version 2 blktrace tools properly handle zone management operations
> (zone reset, zone open, zone close, zone finish, zone append) that
> were added for zoned block devices.
> 
> Example output:
> blktests (master) # ./check blktrace
> blktrace/001 (blktrace zone management command tracing)      [passed]
>     runtime  3.882s  ...  3.866s
> blktests (master) # dmesg -c
> [   95.874361] blktrace: nullb0:blktrace events for REQ_OP_ZONE_XXX will be dropped
> [   95.874372] blktrace: use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX
> blktests (master) # 
> 
> This helps users understand why zone operation traces may be missing
> when using older blktrace tool versions with modern kernels that
> support REQ_OP_ZONE_XXX in blktrace.
> 
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  kernel/trace/blktrace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 776ae4190f36..200d0deb6c90 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -690,6 +690,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
>  	 */
>  	strreplace(buts->name, '/', '_');
>  
> +	if (version == 1 && (IS_ENABLED(CONFIG_BLK_DEV_ZONED))) {

Redundant parens around IS_ENABLED() here.

> +		pr_info("%s:blktrace events for REQ_OP_ZONE_XXX will be dropped\n",
> +				name);

%s: blktrace events [...]? Seems weird not to have a space there.

-- 
Jens Axboe

