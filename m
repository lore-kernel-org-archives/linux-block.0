Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93914612E1
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025533; cv=none; b=BgiZKbggneKWo2VDxl6DjZ+VTRvyQ83FmGUBH/prk6J9+Kk7dN+kMIhVu2vlNeTPTGKAp1GiHcCPMHW7ie96usVbkSWhzxiuP+3QSjWkcEgTJBCSo67LPKBTwXXUWuk3vOOr+1gRhVQ4qvd7zy5q9e+kFQKInh9h1srzY7OxB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025533; c=relaxed/simple;
	bh=9qIE2bfiFVPT+0QiWv+qdn9ncuMe3NLV+5xTbhnxIKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJbQVctvvgJG5dM/2Ov8roPIqYCZ9QXmufYHJZgbqgL3GXK30Yqpdkm/+kiVNsaWD5xkACaH+0bLg00xWljCr4qo+lV7Lj44sEMwdGnuZ/eUdZWKluBu/8ywtYe/e9DF114sAaW6nHLYuWbN/1aQlXElBjm/ly4MskTCBxEU9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FaYWSg82; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FaYWSg82"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so60141839f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706025530; x=1706630330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCq8nDnOxhz7egI8at/3y+/B1QQQ2aCDP0fX/KoZQek=;
        b=FaYWSg821j4LM6DJij6YqzWGB9kOsP4WC34zp1K83+kX3xxsGWc/G8nvx9B2MpL7rC
         k2I8yf1nzljxu6DqcDo05eFRbsfeG9VMR57KVw9Mfo331RGpCIvspJgPKKJMOXYiGkDz
         Uj9Lw0eeyttw1uA5kldQgMm2WsMYWfHTaib1rsTVJ/3JZRJ14EAFk46QFcE7J83idTCK
         UxfKJMJjEUnlNDlLpPk1l1aW9gVDmQAKUdH8T6crPmdcM9+xy0QXVCNRLMIVlNxM73ah
         P1evjD/xZgqCAev+zbWvt2mEIWrwYr/Fpci43AWC9bxerU2QFzDf1gORKKymzMmnBvu+
         IYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025530; x=1706630330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCq8nDnOxhz7egI8at/3y+/B1QQQ2aCDP0fX/KoZQek=;
        b=AnWALApvF4pLoFOwk+9xNCLo5hT5ZL3pruSrag1fUtD5dlkWcqGSS5qM7eUyeqgzjn
         J6V07z1wXdJnRmMQ4Q0wRbh9HwGbiJynUt49RgkQs7PFSAp4ZSmFqxfFbD1kqKKXZ+MU
         QQRQKsSxNjVObwaFD17d9ZDg+SBIQQpkiMYtXdp4yqLO442wAFn8MGoxZoxYPSSWdAiR
         UuDm7ZBJ8Gr+4EvRgQQ0SPzQbT5wRAEtbsY8K0cZGHeltZbfeyheX5ZsLOazDxqSVnj0
         7do7gb0BMVQ23t4jCUG83qI325zC75VXMxyVcZPME4usnAsjYcxMfJ3OH0q7LYh4F39l
         n4JQ==
X-Gm-Message-State: AOJu0YxYE8jReVhtPJOwV3iSK4F7fSkopD/K67VweGdaReFPwrkgYsEV
	ooITIgCOszT7BF5WmW7OslwSkbEBCdydp4Zh8QY9mDZmStuysmJt/H7BDVEqOuc=
X-Google-Smtp-Source: AGHT+IGv/p+Wyasu5GYuiW+vbacdlKgB4j1xLZF2CMvBqfQGEOpuuw1wBPaU685cUB7SCh6MHnE8/Q==
X-Received: by 2002:a05:6e02:1be8:b0:361:969c:5b4b with SMTP id y8-20020a056e021be800b00361969c5b4bmr10247052ilv.3.1706025530677;
        Tue, 23 Jan 2024 07:58:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e02110f00b003619fd1f271sm3695586ilk.69.2024.01.23.07.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:58:50 -0800 (PST)
Message-ID: <c85898de-0780-4690-adfa-99332eae0090@kernel.dk>
Date: Tue, 23 Jan 2024 08:58:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/blk-mq: Don't complete locally if capacities are
 different
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Wei Wang <wvw@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
References: <20240122224220.1206234-1-qyousef@layalina.io>
 <Za99LKnQE/M6pVfM@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Za99LKnQE/M6pVfM@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 1:47 AM, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 10:42:20PM +0000, Qais Yousef wrote:
>> The logic in blk_mq_complete_need_ipi() assumes SMP systems where all
>> CPUs have equal capacities
> 
> What is a capacity here?

It seems to be the chosen word to describe the performance potential of
the core in question, we use it elsewhere in the kernel. But yes, could
do with a bit more of an explanation.

>> +	return arch_scale_cpu_capacity(this_cpu) >= arch_scale_cpu_capacity(that_cpu);
> 
> oerly long line here.
> 
> Also pleas split patches for different subsystems.

Yes please, the sched/topology thing should be a separate prep patch.

-- 
Jens Axboe


