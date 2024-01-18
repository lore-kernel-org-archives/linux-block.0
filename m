Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69FE2DF9C
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603538; cv=none; b=WbAWp3Fx3bXb1GImoU212qZGZ6okMm4/9gCC3Nw00l4xt24GkA6+h6aV1CRbOuChBUU9+4s68NyB/KD1ts2ySTOBG29dRQ49EmMPoa+oD+hUXqCLetZzqRm3h1Gd+jN/TU9Cv/u1PDEhk0NflIfyte4QhjBPI7y/KqsV8FhG0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603538; c=relaxed/simple;
	bh=kQy8npT8uJT0RaEVhbvo3KUpiVzVkwvADinaueH7JCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AEPqAt7Cs4u5quC1EiaeXfO8I+Mfvs9d4UlVtNkLBqcFEVUkXgB9CyfCRtUECqo+nGBNiuR8M2yUykv+v9H4rM9/9XXBO37jNRgNSqVTb0KmIK5/QswC4w0Gli+8SuYCI0pLZhTym9OHOSetjR91Cet27U+7sOLsNlYyn5FKKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rrb0bNML; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rrb0bNML"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so66360739f.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705603535; x=1706208335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aavTE5PqE11UzsVFo1kxJMhxEJL0LBk1aQG8TogVo1s=;
        b=rrb0bNMLitQfvYZ7l96dkU2j2LHlX/3okQVXGe/E9LgATv6ynzV511gVe6sYLD96tf
         mbjT4efDHt2wFyBohxb62bhu8TfTFu78eKd/MUU2vNX9U8Lw286J5tdXm6GRehhSuZjf
         C0dU8iJxosAEqMo8QGTdWcQt22vmkcVViwB96KNSXTOHe+GSDHgVlQCZr5xcXtUSHSa6
         kAp56gPL7wucbKZME6kGl+eMhQp1VvNXWZ15EE2nAnYAitmQ3KI1cHrkAdkcuTGSDqiV
         k5MASJ/WZtUAryE40B+UHrTKdp5F2XL0MMc5kprgq+dsyY3rF8OLo9bJC3BCjOAC7WXW
         kkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603535; x=1706208335;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aavTE5PqE11UzsVFo1kxJMhxEJL0LBk1aQG8TogVo1s=;
        b=CpnhlECAH2qivhjDhOVRgZ6toHPrm+gmENSoyViwzQxJMEd8nPH2nRxBw6RSMZ2cKH
         OL4WdrIKiLxooMTMD2tvXiv6p9oChvNWaRVhbsBhhsPmrO7EluqrGTEVouMeczM/E5Jh
         c2uSefPn7XV44naFRflg12HaiOD/X01qHqiH+TaXweguseyEGSyAIo9//IXEl4eEF4y9
         +/wy5xVYnMfo7mVd6MlK7VbVZ9IiB5uPiDr8ta8/8H6JlTt8JDSJm8G9NW0woWUP0xz4
         zQkjinvjjFC4tCvIjZZUflJFhON30TF5HM6+k66dT2ZPbQIEKNXtbtueEQhhaiWvuE61
         ccKQ==
X-Gm-Message-State: AOJu0Yy/ZBXzJtEOAPto89Xzw8mhUcymVL3syQ64vDlJFAlAhKTygmg2
	UY9dJoTAJi2/GQJ3RUiprGEGMD+fls3HQu1GmHN6oZ6a+9P885hLHX4RSumfgqRVj7P9Wuvh2f7
	NMBM=
X-Google-Smtp-Source: AGHT+IEFd2A2mNpPyBsYNV6NYuBybaHjlh9X+ng1HtszyEGeoXR0+Atf4tAqayy1/p25dkU1V7S9ow==
X-Received: by 2002:a6b:4110:0:b0:7bf:4758:2a12 with SMTP id n16-20020a6b4110000000b007bf47582a12mr307414ioa.0.1705603534842;
        Thu, 18 Jan 2024 10:45:34 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c23-20020a6bfd17000000b007bf56383e74sm1612278ioi.18.2024.01.18.10.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:45:34 -0800 (PST)
Message-ID: <3910157f-dbb7-4048-ac52-a2b354048be6@kernel.dk>
Date: Thu, 18 Jan 2024 11:45:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-2-axboe@kernel.dk>
 <d8485e78-5cf5-47c1-89d4-89f52ba7149f@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d8485e78-5cf5-47c1-89d4-89f52ba7149f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 11:24 AM, Bart Van Assche wrote:
> On 1/18/24 10:04, Jens Axboe wrote:
>> If we're entering request dispatch but someone else is already
>> dispatching, then just skip this dispatch. We know IO is inflight and
>> this will trigger another dispatch event for any completion. This will
>> potentially cause slightly lower queue depth for contended cases, but
>> those are slowed down anyway and this should not cause an issue.
> 
> Shouldn't a performance optimization patch include numbers that show by
> how much that patch improves the performance of different workloads?

The commit messages may want some editing, but all of that is in the
cover letter that I'm sure you saw. This is just a POC/RFC posting.

>>   struct deadline_data {
>>       /*
>>        * run time data
>>        */
>> +    struct {
>> +        spinlock_t lock;
>> +        spinlock_t zone_lock;
>> +    } ____cacheline_aligned_in_smp;
> 
> Is ____cacheline_aligned_in_smp useful here? struct deadline_data
> is not embedded in any other data structure but is allocated with kzalloc_node().

It's not for alignment of deadline_data, it's for alignment within
deadline_data so that grabbing/releasing these locks don't share a
cacheline with other bits. We could ensure that deadline_data itself
is aligned as well, that might be a good idea.

>> +    /*
>> +     * If someone else is already dispatching, skip this one. This will
>> +     * defer the next dispatch event to when something completes, and could
>> +     * potentially lower the queue depth for contended cases.
>> +     */
>> +    if (test_bit(DD_DISPATCHING, &dd->run_state) ||
>> +        test_and_set_bit(DD_DISPATCHING, &dd->run_state))
>> +        return NULL;
>> +
> 
> The above code behaves similar to spin_trylock(). Has it been
> considered to use spin_trylock() instead?

Do you read the replies to the emails, from the other thread? First of
all, you'd need another lock for this. And secondly, this avoids a RMW
if it's already set. So no, I think this is cleaner than a separate
lock, and you'd still have cacheline bouncing on that for ALL calls if
you did it that way.

-- 
Jens Axboe

