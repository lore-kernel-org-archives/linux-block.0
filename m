Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309219F13B
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732757; cv=none; b=UCPMjKYkJBjncBnSw3L9s71BYf2ifKvIduAHAQREsMCbd1JfhN/gRLGmnmdy4Trb599ZK1u/s9y3NQwhoBWQcvxMXWp7xi4Itoz34fVNLLov7fkyJeE5uVEr+XAHhd/dpDNzMBGVvJ8f2tS0hjYin6lSc730qCtIDcYWZ86AamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732757; c=relaxed/simple;
	bh=Bm7+K9nfbx8GrUNi/0vN+GliyYNoXH0V+uq8nvy68ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HkJH508B+jxizPm5km3pXn+ojVoHg/chX751vVN7XCpqcZRk4X+XgKeoq/0KI7On1D3zVA5xpP/DkSz+gNwRxit/gy3qQEOKZrspV7wx724dHBB9rJLuZlICWb+gkYU7RKd6U83PtzmezeMw3YKv2LyqlvnI94PFb7XXweAlpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iP1q6zOe; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iP1q6zOe"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d5ebc2b725so17886015ab.3
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744732753; x=1745337553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DvZ3lEk3LiFTQ514bUef/7CZabDImeQOBm5GUejr5dw=;
        b=iP1q6zOeGUWWgBb4GCgPSnytBfrLL+h6FbwZBYm/reND8MP/m5pXL9QYsBRA6GGUKI
         G1UIz8xTQsG14CpZrLHsz/Aj4LTCxxq+6dj4LbxAG5NJvsssovrf0Fy3FlhZDpcjJdXn
         M0UH41mYtgmE0t0AumfragL7Fh3gXILIgZTmcLr2AVztosmZaTfTkJ6JG9/ScMvMdxzE
         zooIj1lsvEHRGsj1CcG2PjRiCNjhIhtmGbKJcDAKyZvkRuoEvv3pszyLHaw64F/OKH1n
         4QVo4pEWsVU45NU5iPMLdoc+Ijk861gSP36QZQ4TmUqGaxWOVGdyPnDP3wusyIpMKuPW
         WeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744732753; x=1745337553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvZ3lEk3LiFTQ514bUef/7CZabDImeQOBm5GUejr5dw=;
        b=S8YJX4DIUY4AWnFBmIZbQrhh0EkbtjhH8mdwDtTxJY6GoSwkJJcIjGVPcBQhKCoCEQ
         ruwhZuzYjiEEublsG8nKRkwpp77rn+LBsy08K+xJzEs6dyw5ahQgeyVrKvFITi2u/OK8
         k4sZ0JugcL2FnKSYZ+E48DuNwN6W/yUnZI8IACwat4FJB8VM3sXbQ0G8O91A+XrA2/Lj
         lctkMx3DyPeADMcjHD1GkB2KApmJ7ZrAOZvn0b/gqJfj48TApD12S/zC74oHL3XVUFqu
         K0UHu0VmNu6tOk2vsDjZ901CSJ6kCO6JhPMY/NwO29hHcoJOAftl4WyYaTdmFRo1vve/
         K7gg==
X-Forwarded-Encrypted: i=1; AJvYcCXubjs3Kog/v/i4NpugK4n3M/Knz37IK/hQbmvKwUtc0xIheDt6O5SGiIZqIVjzUivZUkMhkEZE1qFQ+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvsnONeCabAGZaJdl8n47PgYcYqLiHyoU2t04YWu74EF1b+hsM
	DR9UC2RaLqKghWoNvCIphwk4LEP0tmaYbIQ3+zYpyV1ZybJLMjwVBNLQuD1js/E=
X-Gm-Gg: ASbGnctSs3b5roPBety5cIgZebj1m6+9JwhVnfmqd3TSa/L6Z/iUw6Za6cAC16nddCH
	NrcGdqRZwp4cIt96ZbQf4EtXgVsd5wLU07lpFok28B6otFJowBTiJScrehrkHWFLBoGFd9UBrz7
	PM1/zIpXqM0T7wTQLQEe9JDnFTR6K2UVdW0rXJdsxhb0zLC5w9MSd89k87p4KaLtH3PAt/xeH7E
	JxzcBf/EEiBLBxw3yW11OmgVJBzGDn9safL7cmsC/sdrgk0dt3A3yp6EcUlej1FKdHTT8CGI8De
	W27sP78lolLx9zAiEuhv+TzKJFxfkVEyEc/toouVRg5NN8Rv
X-Google-Smtp-Source: AGHT+IEkTkqUusJJOVmR/+yrncVb9sAmzMM30F2VLLNmLcld8OgoQox3K+fJUKohP3z4ynfXMfjyrg==
X-Received: by 2002:a05:6e02:2284:b0:3d3:d994:e92e with SMTP id e9e14a558f8ab-3d7ec265561mr153725035ab.17.1744732752707;
        Tue, 15 Apr 2025 08:59:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc592afcsm33601665ab.66.2025.04.15.08.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 08:59:12 -0700 (PDT)
Message-ID: <4b0eee16-a37b-4770-95f0-c5f02160e0da@kernel.dk>
Date: Tue, 15 Apr 2025 09:59:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: ensure that struct blk_mq_alloc_data is fully
 initialized
To: Bart Van Assche <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1720cf81-6170-4cac-abf3-e19a4493653b@kernel.dk>
 <a8074c72-e258-4b34-a629-c253997dfab9@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a8074c72-e258-4b34-a629-c253997dfab9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 9:50 AM, Bart Van Assche wrote:
> On 4/15/25 7:51 AM, Jens Axboe wrote:
>> On x86, rep stos will be emitted to clear the the blk_mq_alloc_data
>> struct, as not all members are being initialied.
> 
> "Partial initialization" never happens in the C language when
> initializing a data structure. If a data structure is initialized,
> members that have not been specified are initialized to zero (the
> compiler is not required to initialize padding bytes). In other words,
> the description of this patch needs to be improved.

How is the description inaccurate? As not all members are being
explicitly initialized, rep stos is emitted to do so.

-- 
Jens Axboe
