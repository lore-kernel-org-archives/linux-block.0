Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE41E89C
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669562; cv=none; b=Jcs3U8iyGtxJWGZY7Kdz3Sg5bacVcn6azz8zAjrEkH2avvhyeit8Oc+QYq2dwGCtGVeFojzWCEDWfkBxNPHfLvwhO+HnP0fHBC/TKeDOv/ffL+nONhh6dfR5CwzPU6HabbtCpZ4vvevpuKmzO91CWMckNZxuT1FF5gFnTaRo4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669562; c=relaxed/simple;
	bh=0ATt7Pmh971sGk2uvb6JDMe6ycDXGDu2Qvf3yLklJTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfqbJVCdWZU6oy+HQ/X2l+03ZVYwanq27fId8izX3gBNbLHaL7y9rrW9Ay8nTAB0i+lCR2Ykn7HIuDThKo6D5SDVx2S2yM8MZX/BNM00D0nCXNkEeC27BPhAM8MxLdSxWVc8ZiUoFX9BMWZvy/oRGQwaJ9jiQAEaW+78GEn6K5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LiNNY/7M; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LiNNY/7M"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d9ef422859so62740339f.0
        for <linux-block@vger.kernel.org>; Thu, 02 May 2024 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714669558; x=1715274358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f36Ah0ouDXNgYfSYjsUT8q/cVW+LwxmuqKq7JxYZFsE=;
        b=LiNNY/7MewKlqEf5dWN68Fxd33FLB7mAe6oxubHyErjLjb/XpC7IDkfI8p6flxkJUB
         54kTpNgs/e2pnvjYA6jrbNi0vGLqFt8ZknwV/AMkdITce0wDWcOiJryEqyNqQFYjI3Fx
         kpZbxuSDlWMSvLmDfZGaLlHb6dTZYVS5alAr4F1zay5BE3X6bYu+9T5V1jJNZpIHagmb
         bj0/qcUapZLJMxcTlcz3TyIpYVR+feZCrz6bKNutFN6UsdsfBo193XeO0l/nREJhF6EY
         pBkkJvualJeThVZTonv5/hdPDcL+3y3JC8pozo5Ik+Zx8V8xAUewQ+JvQObGjyu4F/Lt
         sUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714669558; x=1715274358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f36Ah0ouDXNgYfSYjsUT8q/cVW+LwxmuqKq7JxYZFsE=;
        b=EsfGM0P3nBnAFlQZccwJfMGZDqHFFd592Lo4bI7FThEnh55jnz5KM+FupjW2ohl36/
         c8z8A4adl6e/BfWBnHcg6q7d+AQLHz03nc9UnDoqfSrMzEYUW9+DAhovBwTHQTZ4v2Xa
         3B9n/ATg4qWcOXvA9sogj/lu+UaQSRP/SPBzwtVfUCR5w8wVFkVKqGizsd6qJDeMbO+t
         I7BSyIH1vEcgeVBkkOz702KXAK4RKF9dmXVMUiG01MfFxYdSXcLMntrCfOQHPp1EYp8P
         n7pkY8b6a2kNjM9haXY51hmAMlQ7cdRl6lSmYvVTPwojYFiv6u/KJoxjd6SRcR36dt/o
         MxmA==
X-Forwarded-Encrypted: i=1; AJvYcCUD8RCKgiBkRtm9yWrYM9jWCD3Z35MsBdrX2aqTUeV5fWD54H4G9BwUOoV/QZJrETMJam3yCr+Ktlha4wJV/tVcHvV7cvnKQubptkg=
X-Gm-Message-State: AOJu0YwY0z6LJboJv5FSIcWy8CxEvn9cBpcx4dbXI3f1wdQyezJSShWl
	qu08VJNii7cPfIK/AW8W85TDKb3g4FqwCEcRy1f+3NXbDpJP2ERlt+TUMCU9UaDIz+4qIhXv/3O
	4
X-Google-Smtp-Source: AGHT+IGtMJj55hfnDilmqrEkdqB+ez2WlFsq8ttr3/P31DXzakmpbQ3pP1Qj4Q6KXReuzesYCbKVbg==
X-Received: by 2002:a05:6602:2557:b0:7dd:88df:b673 with SMTP id cg23-20020a056602255700b007dd88dfb673mr335202iob.0.1714669556392;
        Thu, 02 May 2024 10:05:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id iz7-20020a056638880700b00484b1f904c0sm308877jab.142.2024.05.02.10.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 10:05:55 -0700 (PDT)
Message-ID: <6e70dd3f-381c-4435-a523-588ce2fafb39@kernel.dk>
Date: Thu, 2 May 2024 11:05:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: add a partscan sysfs attribute for disks
To: Christoph Hellwig <hch@lst.de>
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-block@vger.kernel.org
References: <20240502130033.1958492-1-hch@lst.de>
 <20240502130033.1958492-3-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240502130033.1958492-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 7:00 AM, Christoph Hellwig wrote:
> This attribute reports if partition scanning is enabled for a given disk.

This should, at least, have a reference to Lennart's posting, and
honestly a much better commit message as well. There's no reasoning
given here at all.

Maybe even a fixes tag and stable notation?

-- 
Jens Axboe

