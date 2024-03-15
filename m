Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B51773D
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519910; cv=none; b=N8aeDXnqDAk3EpI8eNsUH3XuVrgrQABpmrwqsMOayzG2ehocfTZIuHTvC45CSWPG3yqqkPC0k4OaorPSAHbQybcIdMJ6gOXYE/uG+4qnIfGsmLTfA7dBPQ/quC3Xd3ZqHPBXKtrDQigTnjg5PKtTFbPUOE8durAiKMAkx7byz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519910; c=relaxed/simple;
	bh=Z2WmmJpkOrKzU/uviURlN49V26+WjaBbh4kaNh7sv0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erE9UX0PN9v5JEHRSnN1eH1JRPOI1pjtPEFss0WSDNcfYiN7uLx95Yk3Tgb7SN3xX377n6oayPUx/2vnQzVAX4mIOlLPLlVFngCpNO5bSgRWEXcOFsFAo8kP4Fgxb5kdiAFCS5Na0WqDHIkyuaayJO1SrLyuztcCHybTPFgWdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=InWcY6tg; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="InWcY6tg"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-366326c6c0cso3340035ab.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710519908; x=1711124708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBFPEL56yLusV1rxCKLsq8eWVbb+S7a7fAkKDb5lVIU=;
        b=InWcY6tg7ycsapx6SEROpIZqZsbINt8YncF5ZsNEcTSzs98lpezPjzctd0jhToNc8q
         BjxUxw9CnOI0QwcEs1RExKqNoiaiJGztbG3oLzpIM1i4R3r8iT7bZjmtcXd23rfhXw0Q
         EKXwFRpjosbl25SELM4Qq2QFT3k6HKj7k62kHFACACZvtvG4B2H+XrvfCJUu1VS/ObA5
         Xi3nex1vL/n1x/PyOeBP+hxLFgmwS1tD+jclbWKrrIQIvyaTOFfVJJgqru+jVCWGyzPN
         vq7aVfsWrwdCNiQww63K5rOE3IrYmkaUSFnrVEW8+UGwUK3WJ+d3lo1SwrTZqiNwubNK
         s7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710519908; x=1711124708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBFPEL56yLusV1rxCKLsq8eWVbb+S7a7fAkKDb5lVIU=;
        b=EYjduWEgrkpNpI/7YB8UIedetcTu7WIRmXF53zqi75jdN8yJEhNlaRYQv3hEBxnRUd
         iBBDcPd0h2NRLMo7rm7fKpgHurbOCBfXMufw8Ht7JT+J8I/30CF4ANcVbtQBD/WwPPvg
         AAfiLZw0KFoA2SbWhZDcHXlNS4TbbYzbQHpFcjBY+iR05BnzIXoDcIVOCJwEPFxTetmw
         xq7qcJwf8e4RJmvnOkOFHC5/U2VwChzuOf8dtVnljZhzytjHg4rHJekr60LaYyfvAHvT
         0NZBtqwrZif7fpTDL1jDZhnx3lR7upsp68f9nVUAHYgR/rV2ngxkJ50pcZs3CDKU0Uxs
         TVGg==
X-Gm-Message-State: AOJu0YwTOqRLSLNUG5YaL1z2wvO+Kd/lZVL4824y/qfGWae3LL99T1SX
	oVGgszjUp1gf6gtCkdEhPSSpjyhGDiOtgWCmjBiLIDgh+RzVrXm3AsFp4IWS/ts=
X-Google-Smtp-Source: AGHT+IFxW4thXl0s+zIUyL81HkO/iXRin3b7okEZ7wncVbqVpq+zXZeQ9YTnUbtAlpViMGECSx21nQ==
X-Received: by 2002:a05:6e02:20ec:b0:366:3766:6c48 with SMTP id q12-20020a056e0220ec00b0036637666c48mr6521756ilv.1.1710519907697;
        Fri, 15 Mar 2024 09:25:07 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d5-20020a056e021c4500b0036677f5d5c2sm812763ilg.64.2024.03.15.09.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:25:07 -0700 (PDT)
Message-ID: <70e18e4c-6722-475d-818b-dc739d67f7e7@kernel.dk>
Date: Fri, 15 Mar 2024 10:25:06 -0600
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
 <6e5d55a8-1860-468f-97f4-0bd355be369a@kernel.dk>
 <7a6b4d7f-8bbd-4259-b1f1-e026b5183350@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7a6b4d7f-8bbd-4259-b1f1-e026b5183350@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 10:23 AM, Pavel Begunkov wrote:
> On 3/15/24 16:20, Jens Axboe wrote:
>> On 3/15/24 9:30 AM, Pavel Begunkov wrote:
>>> io_post_aux_cqe(), which is used for multishot requests, delays
>>> completions by putting CQEs into a temporary array for the purpose
>>> completion lock/flush batching.
>>>
>>> DEFER_TASKRUN doesn't need any locking, so for it we can put completions
>>> directly into the CQ and defer post completion handling with a flag.
>>> That leaves !DEFER_TASKRUN, which is not that interesting / hot for
>>> multishot requests, so have conditional locking with deferred flush
>>> for them.
>>
>> This breaks the read-mshot test case, looking into what is going on
>> there.
> 
> I forgot to mention, yes it does, the test makes odd assumptions about
> overflows, IIRC it expects that the kernel allows one and only one aux
> CQE to be overflown. Let me double check

Yeah this is very possible, the overflow checking could be broken in
there. I'll poke at it and report back.

-- 
Jens Axboe

