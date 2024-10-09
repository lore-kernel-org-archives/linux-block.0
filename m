Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1241C6A;
	Wed,  9 Oct 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471664; cv=none; b=BxVN84V4co5RdapAL12sYwe21KrfxrD93V7ZWlmiF73abrRtFd2TNJZmoXSEc6YqQjbt9c/VuHTiySJCgKzDtB5sqcdXa3OcL2i7gnsyKomaWmuzMrkU1Sp18Bjt0OMPka7Ul+qQYk21xCjyq9w2qW0oXNoOTWryWYPMIdbKHVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471664; c=relaxed/simple;
	bh=JKxhyQ9BOgWSYDC5gllA6FYyekxp6zW4aJDHnbf0qRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4f50UhgRMb0bZyRQ8/HeeKpo2lPKNMiPJlpF4X4EcDDP3RvOdSzBSKLNNIcgnGusOTa+r44+uL9m/xftKqnx7UT7pCEE+e8qqFvmLnC9Q8SvGM5ow70Z68OnF88MX+1zRpyJqD5zUP9elsFXZ2gjStei+E4GQkHaVlN8NtqrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9aCpzmZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9aCpzmZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bb610be6aso73182735ad.1;
        Wed, 09 Oct 2024 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728471662; x=1729076462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OiY6CpBEzHsjraTshq69qQz+AGO9HWUOSPdHLM5wrI=;
        b=j9aCpzmZyoyq7YC9qp8z6eQ+PhsImBLFO0raAzP6eYIHhCZ4cY+HOQIDW3xgXaH2O4
         +aa9nNC6Z5O0o1vkkeWl6IslfJ5QLUSUgew/p887siFdsPCsNHnKIxV241wlwsJCtpeq
         +dSaVmWj15Qo/UxPTkAvzxlM9EwRTe4kCOtfHrjAwsPGRx8Y+STX0OQ/qrtqEPAxWyiW
         XGzIwsEej7TEbGq159K4yxUCcNiecAEYw2te1spVFzeuTuONGzqV1UHkUa8GIXB5I6v8
         DxCpTU3L12FrLnJiIMPqmCGLjUSbonMiMSn/mbezKmFVW5qkEJzTSMQTagb7yRJs6Hmd
         8FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471662; x=1729076462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OiY6CpBEzHsjraTshq69qQz+AGO9HWUOSPdHLM5wrI=;
        b=inMunfkVIPFbeVrRnzWnwuw8e2pJ/M+pt8gm1+2V8XeNbXi/cOHBqcWrWX7aG6POGh
         pspNUjlXPr9qjtc2YK38zGterNZLSX8PqQg2OggJsapmQm9e9bxjbQykXCx6xh/ofPwG
         5igZ5FbBonQaoN01F3ywfX7WdCIa5wNbDYRBNqbGPCs67XwkhvPAzWUlBqQq+RI3BuV1
         tEmNLLMCopOxQL+VuJkIp0Elb7EBUs+JBC8aJNLRfAK9XDH9wrUun46CNd5fvzhoWijI
         9p2fAVTSBXKIBkR+7YNLlTS9texgXoqzpVpVqCfnistbe4Rc8hPEai0bQ19y5pVn1s5X
         Us5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlVY+gMQ23URgv/0ZuMQGzlTZ/WaZTlL16TQlaE9xkoZubYP7cLwgmyz9Kk/VZi42m3SKbRoKMd3ePzpor@vger.kernel.org, AJvYcCXlQ+1pG4C/64zCHtZol/+UB4px3nmI/1YKC/8351s9pobKS4ZKUr0bECwONCA2j1YPIjiFcw/DZpnA2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4Zz8mYtmWN9S8Gm+N3fl8JGvST7esIQmCOS/3p0DN4Z12HGL
	AaszXsjHSuLdKHYwCNpWrGsB7+PpEhD51degQj8EECdFuUO8fw8DvxF8hA==
X-Google-Smtp-Source: AGHT+IF07LOXv7qo1PT0ouEnajyTQ5JOdx3xpv5X/Ep9k2ZNrxULBFiCmymWI7fNe5z6CLixrrnzSQ==
X-Received: by 2002:a17:903:2302:b0:20c:6098:473d with SMTP id d9443c01a7336-20c637a4411mr24401435ad.60.1728471662264;
        Wed, 09 Oct 2024 04:01:02 -0700 (PDT)
Received: from ?IPV6:2409:40c0:1048:4b3c:cd38:b59:a263:1c9a? ([2409:40c0:1048:4b3c:cd38:b59:a263:1c9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cff51sm69020185ad.87.2024.10.09.04.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 04:01:01 -0700 (PDT)
Message-ID: <6e290cc3-0be1-4ee9-8e13-351f8cd9f658@gmail.com>
Date: Wed, 9 Oct 2024 16:30:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
 <ZwYxA1sfQdaj0Hy3@infradead.org>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <ZwYxA1sfQdaj0Hy3@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/24 13:00, Christoph Hellwig wrote:
> The patch itself looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> On Tue, Oct 08, 2024 at 11:22:15PM +0530, SurajSonawane2415 wrote:
>> Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
>> to resolve the following error:
>> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.
> 
> To make this more readable I'd usually keep and empty line before
> the actual error message.  But more importantly it would be useful
> to explain what tool generated said error message, and maybe also add
> a summary of the discussion why this function was in many ways
> pretty horrible code.
> 
Thank you for the review and suggestions.

Should I submit a new version with the added empty line and explanation 
about the tool and function issues?

Best regards,
Suraj Sonawane
