Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50A1A38CB
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520427; cv=none; b=sONL85QWOjRPe8LIZsB+0SwFyem4Hp5H4fQlvPH1XSl6dk1JyZUKV7a7oHVpdio+KO/Y5f4mUMqglbYOrtfaEU7wRK7FZ1AGIr2JIldn2Kgf2d7jhigiURDqeTVv+T4lDaOBwOiqTbDctp7hPwfoksWBFZQeMb73H+CljhG4dTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520427; c=relaxed/simple;
	bh=x4nCNFQVwr44iuG36GP8T1elKSwdqZxBj28qZs2HMeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zzv5hbPsAxiNfYfmvHUXHsToHEVQAYJw22UgQcF23dS62VUq+LAcKdaJrlMpHR8yNcCeZNZnw1WXQTHTLRzlHyXn4uT2InvIs9tqx76KGzCILf5zlccXfGvS5Pf1kWMIgFLDkZlXqIE6C8zeYwm2ibPMp42CBsXq/VkbLTSENyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ic5jhXty; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ic5jhXty"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cbf1751c8fso9816239f.0
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710520425; x=1711125225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7O7WCB2CJS7drVXMRwdZs06+iuCdTc/rL4uil+HyIo=;
        b=ic5jhXtyziIVQ3QekvfhiSyqNsWlAHnCZFtFoWXy0NAyuQYTcKrkYrVzvNZQQI4+e/
         cWz1SHHB9G7wrxDniAjS3MraSxHoL0MWt3ZjHHIY3pRAviX+S2AZDXzXTypdezw8Zu1A
         hIk/T75gAAh4fkMO1K69IYYMq0liJcmDYxNgqk15gZG+J/EjSBF4/NcKlGFf2JqCVjTo
         s7enlW27+IBMdWsEROcLhkQuXqYqzixKMuDtCqx2gmZHt34mfnIMhQimz5r+C8qxCWTA
         fhbIVPz/kkRPPYjNI0BQBxlz0k+kpD8nUOn6mmksAOXpuQW+oEhPDKMK7TZjvkfS6Czu
         4WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520425; x=1711125225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7O7WCB2CJS7drVXMRwdZs06+iuCdTc/rL4uil+HyIo=;
        b=B0Mc/7ZwrOfjtojPKH5BD4Y3tZyUDRcC5b333xNWzbKl5J7DSH+zB9gnzDAJS7SXvN
         vvu/FtCLffKr/zrSRW+eGHl5Yq+hS7sgXTeoGm/EmkLCqLxG4CaE/dKa1Vqxv2QVQz7U
         QN1/l3+GoHpei0MNazW+eEwOr43VIF9RTizCIniLeVbTu0IqlY557WGNo9coqUJdtiCp
         lUfeHY0qp93AYGcSIba2hPM939HkccrY+31mMLxIl1cWDPuIOdHO92Pln5CBZqsLKjeU
         XEYSUIiZx7J/VYx4kYWfzYu/cxcKIwN4ROwe0ZK/77ZSZWXgpcUvPOzoLbw7AYRVAV6A
         1vuw==
X-Gm-Message-State: AOJu0Yy2KGjr74lVeFXNRGZkdy9JaVtfSeDOAkhd7PitvY2z8Tnc8KSQ
	+8ct1mRp/UF0bEK4c1TBwcuiNd1mOeEEjbpi3fsb51ZfIIsFZ5Uc2B1IFxbd6rQ=
X-Google-Smtp-Source: AGHT+IHL4cYcOxxIzREL5AI79qW5dIzo4Vo+jixAeG8G3Zn8y6TEh51w48tt8FOtnf0ezuAvMuQUMA==
X-Received: by 2002:a6b:c505:0:b0:7cb:f18d:4fe6 with SMTP id v5-20020a6bc505000000b007cbf18d4fe6mr2600903iof.0.1710520424764;
        Fri, 15 Mar 2024 09:33:44 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id eq15-20020a0566384e2f00b004773a5341casm404951jab.177.2024.03.15.09.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:33:44 -0700 (PDT)
Message-ID: <bc6f1f3b-3a88-43bc-b3a9-992f4f6ce580@kernel.dk>
Date: Fri, 15 Mar 2024 10:33:43 -0600
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
 <70e18e4c-6722-475d-818b-dc739d67f7e7@kernel.dk>
 <62daf66f-39b9-4458-a233-2db2553c784f@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <62daf66f-39b9-4458-a233-2db2553c784f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 10:29 AM, Pavel Begunkov wrote:
> On 3/15/24 16:25, Jens Axboe wrote:
>> On 3/15/24 10:23 AM, Pavel Begunkov wrote:
>>> On 3/15/24 16:20, Jens Axboe wrote:
>>>> On 3/15/24 9:30 AM, Pavel Begunkov wrote:
>>>>> io_post_aux_cqe(), which is used for multishot requests, delays
>>>>> completions by putting CQEs into a temporary array for the purpose
>>>>> completion lock/flush batching.
>>>>>
>>>>> DEFER_TASKRUN doesn't need any locking, so for it we can put completions
>>>>> directly into the CQ and defer post completion handling with a flag.
>>>>> That leaves !DEFER_TASKRUN, which is not that interesting / hot for
>>>>> multishot requests, so have conditional locking with deferred flush
>>>>> for them.
>>>>
>>>> This breaks the read-mshot test case, looking into what is going on
>>>> there.
>>>
>>> I forgot to mention, yes it does, the test makes odd assumptions about
>>> overflows, IIRC it expects that the kernel allows one and only one aux
>>> CQE to be overflown. Let me double check
>>
>> Yeah this is very possible, the overflow checking could be broken in
>> there. I'll poke at it and report back.
> 
> test() {
>     if (!(cqe->flags & IORING_CQE_F_MORE)) {
>         /* we expect this on overflow */
>         if (overflow && (i - 1 == NR_OVERFLOW))
>             break;
>         fprintf(stderr, "no more cqes\n");
>         return 1;
>     }
>     ...
> }
> 
> It's this chunk. I think I silenced it with
> 
> s/i - 1 == NR_OVERFLOW/i == NR_OVERFLOW/
> 
> but it should probably be i >= NR_OVERFLOW or so

Yeah see other email, I did the latter. It's pushed out.

-- 
Jens Axboe

