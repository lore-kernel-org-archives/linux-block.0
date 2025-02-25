Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29921ABAD
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494834; cv=none; b=RD7XczBBzUS2qi7Yc4Z1qC16r6nqLBNrnBrnUHfZ1Ir6av0g72O02hnrkV3RFtmMGcrwhmpFHZyQihwm4eCk5ZHo2Oh+9+b4CZ84yxEA/79F8qBJOWuUkJ0N3fvOOUypQQlrLL35GIcy+hhC3py81N9bYY37XK/tzMVFAe+UZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494834; c=relaxed/simple;
	bh=QwABXWy1fKbn1nAt5j/8CP3rTsH3O7QMG+bUCBwo5G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYQToPp2h7nIKsYcGUiPAuHNyuHQn5AoxlEtmbIuKr0NnMDpRn5A5r//VIOFV8ym9NwOZi2/CgPYn5Yd+aHTDutgVjHPRcmDVjC5zdrrBBQ+Po1VBu9IStF58MSGjbE7TqXC6g1zU5F3FvfRhopgi5+OhlYnAHilUgIBQTjgNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fHsqd/Kc; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fHsqd/Kc"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-855d6bdfe05so130347739f.2
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740494831; x=1741099631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcG1XxD6FnOBpx42YqnwfJDuehBu+OPJCV0NDRzKGho=;
        b=fHsqd/Kcx9LMy8KVqzeTwKApYnbQZ7kE3JGm/JAssA1+ATwbe//eXG7o4n8PXLWREV
         3Ap9Oi2q00z6/T8eTSwnNQlL+CknlAgnAjE8QPcpJq7ObOEkFlQPJmmBuR7NIlyZna60
         8tndmos4ct4CUUlbzhHQUK0hLOUU1/TMme6qW2iP0dn5gmObiSFpFT3gv+XNISn0MXoo
         wVSnY5EE6O3IuOpCnKJCiPBFjkE3uRKgptqnmzauhqWKSedCyQri9RT8PK+SYzpzwK3b
         qSdsL7kDbSsxzNKeCS5cvrf1THk5Jp/z1sHO7TeDvOKG1jVkC3O563vWpMeOH7GXjZqf
         6t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740494831; x=1741099631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcG1XxD6FnOBpx42YqnwfJDuehBu+OPJCV0NDRzKGho=;
        b=qWsr/icnomejIfGf7LOW3Wqai36Js/4ZyrjhJ5g9i5bSeA1sGOCU3qniIHFdVMUGqQ
         uJJISd56m413a0Er5JgSGvWkFmkCtAzCWd43iFyF11jKYTCoaufG+9cG5X32t9zRGMUo
         BEdzy2iz+iasCcnvNLOzwI2kf5LvqsZZ9t4e5fOez+J5MHNZqPqU6j0JOonq4Z/xEbde
         AGfJ2lXImDqH/Mq81YeceVyuia97uFioMmfYqqmsTy+Fo0QgG+xh6XTJmnmqWQ5f5oe8
         UJCasjGpweNCE509t6iZHYzJBmH8oXPZ49LMg67DY+DuLI1b9uPnYPgl3A9IpYHlmhnh
         ak2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNksvZ6Ht5ya1qdPFk9RQGCawtcNhhsndqPrkrBj53RaftNW0cRiJ3XiCldTWRIO8VtAp2XaDJO3B8zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Xbi6IIszJey/Y1igEMcgENQXmwBGn5iiZkzQoRwpXehrjJXI
	wrVVq0K59B/3KhOM99xv9ElbhnWK0LRAPuzJkKMUoNAQHUmVsGzIeXuYV9Cyb78=
X-Gm-Gg: ASbGnctoQiHaXbZBDSPrrPdNBFDmrxCBIXWKaoocSzuYqA+5bWQZ01lgJ3WfxdNv8V4
	a7ydz7/niLdypbFdg0GPr3uCkmkZ2plba0ruzPUdXidKeK/uMYN/gdnz+HsGLwr/WgDQIumistW
	N5vR3OXdgJdl6o3E49/hj462fU5TMU4u2r3bzwNHkNUX5MaoAHihEPRYvO+1w1bFBCEnoKODZvQ
	ZDV1hfWrCQv3wyUDqbIqyYEX4q3UMXPoMr0xRRp892pVpFXcKXAx7JstZ+goBEUoUueUcR/dhHH
	zt+z163a3fQ4LHXu7SYn1w==
X-Google-Smtp-Source: AGHT+IFVZ6yoKor7LCidCg3vshthrED33BTt9nHlIDKingFnGezqVjoW2ywwFd+pEsCuboPa/SxJrw==
X-Received: by 2002:a05:6e02:339b:b0:3d2:b0f1:f5bd with SMTP id e9e14a558f8ab-3d2fc0c3657mr39396875ab.3.1740494831293;
        Tue, 25 Feb 2025 06:47:11 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04744e8e9sm434255173.12.2025.02.25.06.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 06:47:10 -0800 (PST)
Message-ID: <bce558a2-269b-456e-bf28-d0ac529bf929@kernel.dk>
Date: Tue, 25 Feb 2025 07:47:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 00/11] ublk zero copy support
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch <kbusch@meta.com>,
 ming.lei@redhat.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 Keith Busch <kbusch@kernel.org>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <6354970e-bbd2-4435-945a-efd9e0f71eb4@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6354970e-bbd2-4435-945a-efd9e0f71eb4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 7:10 AM, Pavel Begunkov wrote:
> On 2/24/25 21:31, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Changes from v4:
> 
> Should we pick the first 3 patches so that you don't have to carry
> them around? Probably even [1-5] if we have the blessing from nvme
> and Keith.

Yep I think 1-5 are good to go, I'll run a bit of testing and queue
it up. Last bits look pretty close too, but indeed easier to manage
a shrinking series for a v6 posting that can hopefully wrap it up.

-- 
Jens Axboe

