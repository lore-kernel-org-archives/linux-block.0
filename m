Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A891DA608
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458105; cv=none; b=gNbTlbmE4oMaVLs5ueBsWBvGeXEjmDX+S7ewU4+yG3Zbjj4RDT9oTRiPB174ozGg0yT/xEoQgRdzHV0jfdCdDW2w684NAfKipQNqW78lSS6O4ZwZSsuy3lq8kFcv/o+q9boUzaW03cEbytN9t/q+JkNIpqFBeCuh7o3A6cfAyqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458105; c=relaxed/simple;
	bh=G9TWLJ5Qcqe5/+6+DCHM88NkcdYLAIpLajkqunioBH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPFHH6mM6YgOSNiaxpmRxYCiSsK8e4p7j/k+uAqkOu2W256F8Ku96Yq0UroWxG/7wM1DpGXwLvSEkz5IqJOQCg2LGd8+jpxPZgw4RdBj3n90Wsc+MbWxd52ctm2MMn3AthRtXLkJLonBDKniQUJybUmiGrikiik4oljS7J7wih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AfVP21Ef; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AfVP21Ef"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so24063305ab.1
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725458103; x=1726062903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oF5PiVstO1bSVn0uGppYTW7lTYTwkYc95VjzklZhkF4=;
        b=AfVP21EfCIFzF2+MqebsBlbguMO84/+jrsaAQUfJ9/LXcqG9rf418ORU6711RPQHDS
         knCveCZTKuJCaueIFO1XzzY9OWNZvGD6eXiAs0DF0Ye9DmatQO8+H71JA31vCUKQuh25
         L39jpTUr257HfCyb6S5w67CLCYRJwvL0kpCx7q9yTm5ejuE0Fe2FucDSDs79k+ImBx2u
         992U5rjqW2EKskgcBLxA3ICShhPVSR9QIkGsteoi8qZXJiHhxOETErJ0OVkS8C3YNI5k
         OyFo0Rjq7BNKsV6G450dbOf+dMaUyJD7mnbphNMfulj5Q5tSGZtLLFxLWVtAwmfYN6k8
         X2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458103; x=1726062903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oF5PiVstO1bSVn0uGppYTW7lTYTwkYc95VjzklZhkF4=;
        b=gs3tpWwxR06HRZEOKxddGBaqqFlhigEPFnxLxaTv8d111gcbXSChey2eTRT6TqjRym
         hmETYGDnM/LLfpjV6XXpXmdzFs7mXqgO5hoW3es5odWXDi+kxG8MHYm5e61B/SDh0GGG
         w5RCZVdAAuDrVIJTIhNtmT/S1YSjuknMZbyhwNp4XElW/W5wBfxG+bf03+0oa7G/x2gT
         BO0XFXgoOrwtT7ad5oCMTXA5PnOLV3eZYks0/BW0OTCi4Fv1p9eN1AyxJZlMsekI4SdL
         y1g25etG3SSqi5Ek2+erDaMnPRDRKemsiHbUJfzpkx3fd2Bxd1eO8rDpn5gK0p304dSR
         a7NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkGgDwcn8iO0+iC/hGt8W6kCsZuJkhnNwWEsZ1EdIR1UEeBOJZWhGMl5o9AVHCrhYCyM8quxnXZTiv9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpE3x+DqSMCAH9ezHZpeXYNdkv6riXzRwGHp14rPHdGp54b6YA
	eqXOkF3fOYR06CQJ2LMG6vVg6rZYfLHpprJqS7DbiF/UT9piNQMg7FS7+n12vEh8sckMolsSEUN
	j
X-Google-Smtp-Source: AGHT+IEh4dvLQ3fPzZIYoRvC2kmG6Tqk81n0JWgsiNRAqvk43xqMT4zgjhYnO9n1kzwMTRb76YKEbQ==
X-Received: by 2002:a05:6e02:1569:b0:3a0:1828:31d9 with SMTP id e9e14a558f8ab-3a018283360mr15675225ab.24.1725458103506;
        Wed, 04 Sep 2024 06:55:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3af97220sm36719625ab.11.2024.09.04.06.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:55:02 -0700 (PDT)
Message-ID: <edfe3c80-c359-44a0-889c-1a879532175a@kernel.dk>
Date: Wed, 4 Sep 2024 07:55:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Yu Kuai <yukuai1@huaweicloud.com>, Bart Van Assche <bvanassche@acm.org>,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, paolo.valente@unimore.it,
 mauro.andreolini@unimore.it, avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
 <b5b0e655-fb17-4967-9104-4386710ee8db@acm.org>
 <80732d0d-e1a6-8b5e-791d-7c8a8091159a@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <80732d0d-e1a6-8b5e-791d-7c8a8091159a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 8:45 PM, Yu Kuai wrote:
> Hi,
> 
> ? 2024/09/04 10:28, Bart Van Assche ??:
>> On 9/3/24 6:32 PM, Yu Kuai wrote:
>>> We do have customers are using bfq in downstream kernels, and we are
>>> still running lots of test for bfq.
>>
>> It may take less time to add any missing functionality to another I/O
>> scheduler rather than to keep maintaining BFQ.
>>
>> If Android device vendors would stop using BFQ, my job would become
>> easier.
> 
> I'm confused now, I think keep maintaining BFQ won't stop you from
> adding new functionality to another scheduler, right? Is this something
> that all scheduler have to support?

With fear of putting words into Bart's mouth, perhaps he's saying that
the BFQ is a bit of a mess and it'd be nice if we had a cleaner version
of some of the features it brings. But having someone actually maintain
it and perhaps clean it up a bit and reduce the complexity would be a
good thing. Really it's the authors choice on where to best spend his or
her time.

-- 
Jens Axboe

