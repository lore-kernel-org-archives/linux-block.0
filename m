Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F4314A78
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182671; cv=none; b=VSCzsgMhPFvRQYGKCcaiWdYMf9UOBci35LYnDKeNNxpn+K7QcNoZD5Vt63hUAXRDBRRDVE/uf8aW7aS8kue4QAz38AEE+5EqzNqvKGYN9PfQM1q7RWIdOJ36QaCHJ1CgwPHum3uLmye62fWeKLs2/VQD51O1wDdmR+3yWoqfUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182671; c=relaxed/simple;
	bh=SLgrM5ObQMmpLGC8vcCxa09+wsi/kuI3pbTMDKR6QYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M3FPq0b95RrelhqlN1kjPuDUEQfdpUIbM91pPiWWEcQwXgpLeIczcVtGKMHDRJXHzs6Mq+V4RTHvM2SQjlkRU8e77I/fjJH5k1btcTCABxwn8OFfABsQ39SQdIt5P5xY6el2hWnUrFottNa1fG80irLE64sobLIGk8dhrOUJ8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jIpb5mWy; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jIpb5mWy"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-948284e6708so118583939f.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762182667; x=1762787467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/W4kVL5naEv4VI0BEK6o1WMukMJfU6huHYzRWN3Cf5E=;
        b=jIpb5mWy+UlyEvEPyKbl0Z1m6aJtpRpz1ooy6bRNelDDoKQHu/fvN1/cvtgBnFb3rx
         zCs1Mm/kkPrargo50yu7137CZ3bkGd7pl/76m0kDmlZJAdCucsYi/hS1il/tVWt9S6dh
         ZR5RhUMEvwKxKqbYU4pnlkZPzkYJ1iOvrvhG5ia1kB6l6xE6MRZ09xelajxr0k8uaf8F
         43tvXTc61T0Yjhd92VqyEQIzQ5q3z7veZV8SmImtbvD5GG3dzHRYT/K1N+BHocQFlKaU
         QZi/y0RgzRnEjum2g36bDV3m3Du2UJTlDPScUppZL7i5kR6SmSE7v9TmxCI5mkV4TmzW
         AqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182667; x=1762787467;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/W4kVL5naEv4VI0BEK6o1WMukMJfU6huHYzRWN3Cf5E=;
        b=ba2kIcXtQSqVrVsgPmRIIg0QyTj2Nlucfn3kF/8INwzXuGkl4FQKWqcUtK8EJV+Jgm
         H3JELtwTX1wL/7tn9HLMhBHPonLJW84kzAeAXImVBbZ8hyy7jnWpdqlcHKgQwxCHoZ+c
         BTLFVwHwyxIqUf9bsO0+njUf7JaGCUjCkPq2Q8SNmXMQEN7wfqspFgJ3FcEdSoWAGSjO
         dYbXj2Tm4O7jzIHc9csgZegaItYulbECKw+ZCuTQyTTYNXzlFbdht7R/3MfrXyPRdahR
         Jfk+N45YTF4onqgWDAhTHzdIkDIG+/dCNtnQlO+Y7KIjTD0nDSO0ooaBs2vKquHxiVbB
         TkMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/lVfRgl8PjvmKdX0yLMRkFq7cXxiYe8OL4+dIPSWwCdVdFUeQABjgHcUPEcO+8sn9ozdqew+7gJQ/bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2e818qbwBvwdHUVuN8Bk0gqX/1raRLELL66+QMdOqoaTehffz
	wJrwF4kbYb8Uc/mr5p/XCCfOR01XZZ7cLUD2k1IuLSeYZ7iRI0hxHScd+zaZKK1OPXrk+JhqLkc
	7SEim
X-Gm-Gg: ASbGncvtvNgi4wpzKTf0HR70sElaKLiG9VkDBMsYtqRBaWmqKc7tK/0eGuZkkPFaLKx
	YbB6AB6KkFfu4Uujhfu1Az9gX6s/IiO5fPGAFPw2EBENCg0FYHS4HfdryMP3VDeF5TTcClFwUJR
	e1XJsipNurTrOpaRlbfhe3h6XS3wVKs1giUaYS4bd3SKaM3IA3ngwujcwtP4eGDU+bUAv53cJFs
	C0cnEK0KnOQXYHlM/mmUplQAWqIiL+7Px9rd69MUKd6ryvDyFOLPuDhjAR/Fk3Dv7NaJJAKHf40
	BjZufmI3mYJSkh7vXK0b/sD7gT4HcAasxHaTABQbG0Ki+H3iFkTXJAf5cQJ/ul++LSK+ss8+K9s
	dyrQcZF5vbQkz2Vbga+J696sLZW8yzajL3Kr9z/TvllrKne3DWuG264r8yVQ6M7YKBV2uXeCL
X-Google-Smtp-Source: AGHT+IFYhrizsmQ1ipykP6xNR7Djv2en7+UHW7lqyQsZUIVlDKCsX7JRy6rHjH5PhEzAp4nppp4kWw==
X-Received: by 2002:a05:6602:740e:b0:948:1730:c30c with SMTP id ca18e2360f4ac-94822976519mr1884456939f.8.1762182666750;
        Mon, 03 Nov 2025 07:11:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94854f8cf4dsm21724039f.2.2025.11.03.07.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:11:05 -0800 (PST)
Message-ID: <b083caaa-5dec-41dc-8885-8ebb34cd1781@kernel.dk>
Date: Mon, 3 Nov 2025 08:11:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update io_uring and block tree git trees
To: John Garry <john.g.garry@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4d23b2b2-c723-461f-94a8-a90c60982bcc@kernel.dk>
 <ed992ce6-5224-4bf3-8bb3-91fb112c9287@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <ed992ce6-5224-4bf3-8bb3-91fb112c9287@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 4:12 AM, John Garry wrote:
> On 23/09/2025 12:20, Jens Axboe wrote:
>> Move to using the git.kernel.org trees as the canonical trees for both
>> the block and io_uring tree.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
> 
> Hi Jens,
> 
> Were you also supposed to update the tree for "BLOCK LAYER"? I think

Yep, as per subject, "update io_uring and block git trees"

> that previously it was
> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> (as that it what my .git/configs entries have), and now it seems to be
> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git

linux-block is somewhat of a relic, since io_uring was managed in the
same tree. That's why the block part was dropped, as both block and
io_uring have development and fixes branches in that same tree.

-- 
Jens Axboe
