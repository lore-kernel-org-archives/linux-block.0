Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2961DFEA
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065077; cv=none; b=A0f/aAGZsIVhWjfoqZpjfpPJ59LHCXPWDauT+px3cGrZx89ANJhHMEZ26AjVYCRfd5HdXHmDFSR+nIu3oafVeKFDHqBI/xpNHGrzDJJlUblks5qsek0vtWySsD7Z76+Gw1UsBzu+8icTfYzXIhoxjLWRBjNYrrqzWgcpNpYLKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065077; c=relaxed/simple;
	bh=gVXjZthSSGv9rLbXwjrMxc8J5EcDJkdCRHYp864ZbKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=so0WhFxpAcMagfF1C3cNgS0wFVttdy5JWeRBGtm/QQ69/eUxIkaQ+ojqGt0tpg5CBs/HO0Ib4DDVTttLFIlq6rEvJTNUNUHBib4jRRFNnF5JTcXOBjTM1hlQFE2gKXdx8qcbFYkT9E5JTxzSTFsjBpNhzef6yGUtS994/kXxxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IhLo2EcP; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IhLo2EcP"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7da9db319e2so9608639f.0
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714065073; x=1714669873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/5OrelQ4oKZ7zz3g/Pdac51XtcPfMDbS5v1Bxhgtu0=;
        b=IhLo2EcPQvUg/PH9h3VieQxXTL1YojoBBPZY+WVh3WN8GePLCpY/M/Dc5nfJGBsun+
         2epQGyW4Z/8f0qQ+YynRbFGO5iYhrs4lk+lV7OwXh9d9KBz5fhAbweL/V6YlZL5bsNYn
         D8XNUCAqGSWjIlmh80uF7xPOkzXzVDCkrO8COiWc2MqXWESCzZ1uCMUuvorjKbja0fPs
         sRGeLeKW0QN0iMx48R4ckwywMEO8nukvnJ6lNioNrqY/S3EuK39w+b148PBuXhZG/YlT
         GhvrhQzZJD0jO9xClhSfE480bJB8iwR1uPgqhsST5CiOGh7+/hTeQIXVzI35HH0YJ8Q/
         5tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065073; x=1714669873;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/5OrelQ4oKZ7zz3g/Pdac51XtcPfMDbS5v1Bxhgtu0=;
        b=tvkNU8wtHNQSriR10UFrDkr+RRizJ56ktRdul0cJ60t5m4uhCpg+ACaD0bVplD1ST/
         AAX1JNNJIaC1k7fuLLOn+mmVTb8l7I3aKpDWY+cT1RhTrh5/wy18eoCo3HL6992SnAdG
         VxEhp2iH6h4sQRXzBqaQwWuv15PFd3zIxBt3IG/DluxPmnY/I4ArJSQU91aACdiOykNH
         voozY30ttktoia7i/d27Twaio4GwHmo7kacZFUUvTj1tp2TE5/0hkisvjtmkBapy30BH
         10pIKHJc53uWhW8smw60AfeihAO1eNQgKgty7rITC/Frq1kgEvk2MrsR/lF3jFXik39S
         lCaA==
X-Forwarded-Encrypted: i=1; AJvYcCWw2Cd6dRXGv+PLt1XfETYF/xkV2Fp5f2dTeH11IPox4AlXkMWbt7qGXCeekLVs2sQ2TdwglV+1ZcEL1eX7IPlre8at1/c1DQMqRN8=
X-Gm-Message-State: AOJu0YwGzEBsSoWguNw6zj06yj2IRM0rGoV9lOOQkOrycNbnWsY89tNS
	JiOU0aZ1TaiXw71wo2XV0TcOl4KxfA2DP2sFwksvTGpnvuHnFCJ+rlufILAw9lc=
X-Google-Smtp-Source: AGHT+IG+Hp6JmEzfc5nRubmxDn5AdajOYtarLDX2ZKJ2a0V/UTeX5bZZq17RQgefTLuP2ZVATIR8Fg==
X-Received: by 2002:a5e:c603:0:b0:7d6:9d75:6de2 with SMTP id f3-20020a5ec603000000b007d69d756de2mr346973iok.2.1714065073340;
        Thu, 25 Apr 2024 10:11:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w17-20020a0566022c1100b007dea5e4e80asm158911iov.37.2024.04.25.10.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 10:11:12 -0700 (PDT)
Message-ID: <e69bea72-1454-46ea-82f6-c1d091ba8a58@kernel.dk>
Date: Thu, 25 Apr 2024 11:11:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] null_blk: Fix the problem "mutex_destroy missing"
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, dlemoal@kernel.org,
 linux-block@vger.kernel.org
References: <20240425170127.4926-1-yanjun.zhu@linux.dev>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240425170127.4926-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/24 11:01 AM, Zhu Yanjun wrote:
> When a mutex lock is not used any more, the function mutex_destroy
> should be called to mark the mutex lock uninitialized.

You didn't fix the title...

-- 
Jens Axboe


