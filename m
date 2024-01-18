Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F02D629
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604174; cv=none; b=G45BYw5tIKbEIVJ/zZNff8Qu0Gc098DFR9fW4a32sYuiqznKhOuwpzhD/g/iftdf6qr2OCni1ymC7Jcn5qkx3FQyHNLfgV30Frx0TOD3nQsfpbjLT1/cnvKRD3YatQ6e2jAaivM5hu77ywNsVfXZc60V4/XRWlLLQ8s3pr9eUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604174; c=relaxed/simple;
	bh=mGHcisxBHkO3/8FyZmo//V3Ik6pdV6NFeddlqZY6C+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M/krvpSaRqCAyFG1o7ROHguBsz1ZlM0+vT+8MD5QYsRGxAm4zkXZVdyx1s3VOAOrtz5j6vMKvi/xxti9y3L1/vXp14wT9mBVTmpYomCzEcFeXBOfTblrsvmGCAPEZw7xqdrtj4ogytNIsqD8OWHAjVYUvFSvRyvPeBLuEZVNa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YBXvn02D; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YBXvn02D"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so66489839f.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705604172; x=1706208972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xs8ZOh3O/xvMnS6lQsWYl9cRpf822755mVwZiWOr/jI=;
        b=YBXvn02DxxDTLfrQ/aPq+wRn0fVdTlHwp5JBJKOUhMeccFIbSipI7RUJ5aem/C7SaY
         VIfjoZ0mvOHzFZ0jnIzhf/9HcEfu+G7NdDulHbWh3r5RE4+8NiaBSBanN6nf6L3U1DEC
         +efrE1wRtCLYJCqJvWnV5rqkB3wRKXWj2D6G1MHaCfKTirwpS/oYfIXiWas8HGGHtVX4
         ZDtnDrmXFo++Ab1k+T/iZuNykqOKUxj8Vkzs/4BVRxRgMznFi6d7R05yvX8G7al9Lwgm
         wmIsXZWp7vqxXveiLFOV48y38hcR0xYiOULLbf4cg/o+skekVzX+4srOcqco3pbtmJcA
         Iy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705604172; x=1706208972;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs8ZOh3O/xvMnS6lQsWYl9cRpf822755mVwZiWOr/jI=;
        b=P35RZZ51AghqMFxln61Vdv/YpTjdkkkbsWQm8EhAWF0L73URU1EcpjnyGgCpzlwF1N
         qnjTZ2NcFjnCFEoraDg1yvWdqAbgy5yVM0ZKgPOqCFRW1V2xkWDKBgGzDWUX1vyZLf1M
         lpkypVvhJ4YLn93RSVkbTtERlOrq5Qp1lCYqIaUElzNJDTIhEuzyrLl9too2jd1HLF0y
         XdXhCZKQL/0E/EdW/1j7FrkLVIKdVJe4EbZ37hrbX81o5UmoGFPmVzto8EoqF0MDxXDT
         pBa86Xp33XW+hMQSJ4yjh2UXsabCzMwCzBlqYXF4WCXj/V2pZCMiEnGR4IPpr3u5Ac9a
         vhzg==
X-Gm-Message-State: AOJu0YxqKGE4dER7cTPN4VLibnuabGb2pcNcUedOixaW0QDzMfo4wCHx
	MaAqHtZHIFg8hmbb3mNrPXrt4YhVxQAhY/iNOCY7ZSozgstabAj8maygCXD2JXo=
X-Google-Smtp-Source: AGHT+IHFBUx+qZipH9c156ncD/nQ8zjHjKBpODmHdhGaenRTcB0HN2GVVoFcbU7AoCZ1BZs1Ykfn9A==
X-Received: by 2002:a6b:ea12:0:b0:7bf:60bc:7f1e with SMTP id m18-20020a6bea12000000b007bf60bc7f1emr323421ioc.1.1705604172095;
        Thu, 18 Jan 2024 10:56:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d980a000000b007bf45b1c049sm2243874iol.0.2024.01.18.10.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:56:11 -0800 (PST)
Message-ID: <248b7070-a7c6-456d-99be-c3fff6f94f5e@kernel.dk>
Date: Thu, 18 Jan 2024 11:56:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
 <0ca63d05-fc5b-4e6a-a828-52eb24305545@acm.org>
 <c9f1b580-2241-4415-aa48-e4b7e1bacdea@kernel.dk>
 <e4892064-cdf2-4cd9-8033-901d8db07cbf@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e4892064-cdf2-4cd9-8033-901d8db07cbf@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 11:53 AM, Bart Van Assche wrote:
> On 1/18/24 10:33, Jens Axboe wrote:
>> On 1/18/24 11:31 AM, Bart Van Assche wrote:
>>> On 1/18/24 10:04, Jens Axboe wrote:
>>>> If we attempt to insert a list of requests but someone else is already
>>>> running an insertion, then fallback to queueing it internally and let
>>>> the existing inserter finish the operation.
>>>
>>> Because this patch adds significant complexity: what are the use cases
>>> that benefit from this kind of optimization? Are these perhaps workloads
>>> on systems with many CPU cores and fast storage? If the storage is fast,
>>> why to use mq-deadline instead of "none" as I/O-scheduler?
>>
>> You and others complain that mq-deadline is slow and doesn't scale,
>> these two patches help improve that situation. Not sure why this is even
>> a question?
> 
> How much does this patch improve performance?

Do you need me to link the cover letter that you were CC'ed on?

-- 
Jens Axboe


