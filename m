Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C224B2A
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523292; cv=none; b=VBccIoQV2ZvDcwAuTPvhBYpaqwAYHk3ToehherKLfke6OD5mAQEQY1/IZ73ZrP4TBElMoBmVPGvEnTuqAXAAtGiMHy1MYcted3ejkN/J/ttNG9mpsIFMM+xh5rfiWThGWTj6neFUDQxh3JJULI1yhdgOC+WfUOjWD91qvCq3pVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523292; c=relaxed/simple;
	bh=mq33gVRmpMbWeGOkSEeCOg8eVgxVV4WHrR3kxT2WELY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=tOM/9p2MjrSh7Jvn2zp10JYE8tqoOg0mpPOcWMgns/wQI9Gus5URMD11iBdPh57MAYczJHB2uJ63koQ7hHa6XVlvG3p7WSwPO02GCbDBGnSn/IO9pkMLWVUROW53x71kbprZI9WXdKWujIETW7QYqWMnnsBwt9ZNcw3aZtjAQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YYJb946a; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YYJb946a"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35d374bebe3so8819855ab.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705523289; x=1706128089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXFmXQPrtXqHHMbJR7oD+Bxy793qm+uj6e9nr3YrzPE=;
        b=YYJb946aH+EqaSOMkKt3g/yt2Bg6MbLFI/fslKvh5UpfW2tDz5Hj/6C5eowqJZtsaJ
         abdBzWk0KhzUOEG19UA10puPBdvgLLcEzNaP8ojK9AeoOqjEFo20BbaPCBd6GnpqvSWM
         Psu1wNh8M8mBn0lGfGzyzPbkCn2bQFp3zcIqJH+m/NVOMHMhL8UdBTeizpiPYI5cpdzr
         F6jDLfk1RGp1gce6SgyTmBzlsHFGJZSYGYvKyWHnvpYzEVZrvr2QKVH0+mPXpY3VHEiy
         d8ff5vFqxU2T620u/RMHuF1zf/VRAUs4Nxik8byVdd49xNjQnneOKJXYEh3s2GxipPGj
         EAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705523289; x=1706128089;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXFmXQPrtXqHHMbJR7oD+Bxy793qm+uj6e9nr3YrzPE=;
        b=HmKz3zS3kxkwk/KVMykXpBjhGvTPeWy5vyUcOinNdrt62peP34Vzh4/EMYb7cgKrqI
         oZkuk20owAVojLLu7/QCjIDrxnNWPbsqz9CT7EhhuTlKRV4ukBDAe24G1IwG55ZWaUkn
         mUwIQ5BZt/7oiiEbVHSx5C3ARxRHu0dklwEDLwmugiLGqCU/Y5C2ndMs53BGnt2B2NlZ
         GT40LkWLQimH85/T/CTDE2XJZSnkS067Px994lQug9meEz52dVMhEF9Fhi46ruu1s5RT
         tg3DpTxtQsLlE1J0dC6iZN62/0ASOWQRLjiVIld0aPDGi+BoNVybQ6Ue2/Dc0RGWapWf
         v1tw==
X-Gm-Message-State: AOJu0Ywf0OlOXZZ5Opw2/ac8uJzxTNbAuCxh3WjMDsoYFa+wKrygtTP3
	Ag1CJ0aIx2vwRUhcFr5S7dmpX9X5xbkmdvR8kUni3e1WvDKhmQ==
X-Google-Smtp-Source: AGHT+IHuS1KbWOcpJx7/TsH5LATPjYl2VITB7a2iPaMdsa41fp/N053d4cB6AxCEApJ7w/jxBQ9MRg==
X-Received: by 2002:a6b:6810:0:b0:7be:e376:fc44 with SMTP id d16-20020a6b6810000000b007bee376fc44mr15691431ioc.2.1705523289015;
        Wed, 17 Jan 2024 12:28:09 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t20-20020a028794000000b0046eb587003dsm16097jai.127.2024.01.17.12.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:28:08 -0800 (PST)
Message-ID: <3f676f69-690a-480c-850d-ff1d9e502e4f@kernel.dk>
Date: Wed, 17 Jan 2024 13:28:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race in block/blk-mq-sched.c blk_mq_sched_dispatch_requests
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Gabriel Ryan
 <gabe@cs.columbia.edu>, linux-block@vger.kernel.org
References: <CALbthteVP3BnZuQuGWfW-SviB64CwjACP2v1N5ayDVFpnjEOtw@mail.gmail.com>
 <e4347147-f88f-4a83-ac48-fde1af6a89e9@kernel.dk>
 <37b7836b-f231-4bf5-bee1-7571f889d6ff@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <37b7836b-f231-4bf5-bee1-7571f889d6ff@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/17/24 1:22 PM, Bart Van Assche wrote:
> On 1/17/24 12:17, Jens Axboe wrote:
>> On 1/17/24 1:16 PM, Gabriel Ryan wrote:
>>> We found a race in the block message queue for kernel v5.18-rc5 using
>>> a race testing tool we are developing. We are reporting this race
>>> because it appears to be potentially harmful. The race occurs in
>>>
>>> block/blk-mq-sched.c:333 blk_mq_sched_dispatch_requests
>>>
>>>      hctx->run++;
>>>
>>> where multiple threads can schedule dispatch requests and increment
>>> the request counter htctx->run simultaneously. This appears to lead to
>>> undefined behavior where multiple conflicting updates to the hctx->run
>>> value could result in it not matching the number of requests that
>>> have been scheduled with calls to blk_mq_sched_dispatch_requests.
>>
>> I suggest you take a closer look at how that variable is actually
>> used.
> 
> It's probably a good idea to explain this in a comment above the
> code that increments hctx->runs because others may also be wondering
> what the impact is of concurrent hctx->runs increments.

If you do a quick grep, you'll very quickly see that it's just used
for debugfs output. Being racy is not a problem. It should just get
removed, honestly, like I did with some of the other accounting some
time ago.

-- 
Jens Axboe


