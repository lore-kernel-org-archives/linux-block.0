Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F472755FD
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602179; cv=none; b=bFaF5hoqdSvd1Rg7+kkF7mjmwAWkmUf5q3tWLV/eWn/yS7iZMC/xHv2yB9uPlQHaQhAnYRZIRxwJ8ysDApxLr2UgoME3yhkf74klyI9f6nHJZp37kgfm7ulP+JJkGXvKifIlQCMyyhQiUnYo4JLNmatS/HfjokTHi/ffhQ7hPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602179; c=relaxed/simple;
	bh=VC3SAPTEl0i49ihRbrDdJsQYLdTwF6Wi5VeIuAFox50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRsskKxM8kupFokNA7zssn8D6XReLCg+AwWInrarvwx0AaIRsCmjhIu1hKhPNIMcHG/qXzkTxNg0NVULltzz+73iIhGLV5ai9Nu5SwAEkJRyaVHhVCCxAi2KVejgVZQeT5ZgrQ5A9ZzUvYfLTRWu+n/OBR/PuWB9pJjQ5OQ913g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OGC0f7lO; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OGC0f7lO"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-855d73856f3so14874239f.1
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740602176; x=1741206976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmzqUtuLFgT2c7u/W65oS618sUsNHDHfq220kvzNU6c=;
        b=OGC0f7lOayOhgQ/acv2MgoIggYZT2/PmQAxeu71GXIKDaGy0ueYZKv91gACs0/x59u
         NCFiQDz4gTdHNOoTEeIl7acP0HguFFND/nSR7lvZ/YFpVAyb3rHfwrTcy5WJcD9Hj9Bu
         hmNFFo4TuFw5zWTTGiekt+5J4qTRh2bSKBeM4BXFOTzA4W5K8ydm1F4LRwyCJnNBUrXM
         CdW2j2szmGOpLZYmx6WhmQreYVJjjhK0iUs8d3Utzh7g8igzbDN2yn32vMlBZp343Iyi
         Rt6TxXyHelHgY0zSdvEgqCqoIDnylW8h/xrZEqgUr3b9U7cjzgYFm7nSDax1ie2e8gnj
         Yzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740602176; x=1741206976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmzqUtuLFgT2c7u/W65oS618sUsNHDHfq220kvzNU6c=;
        b=sTLKEIHkcKDXvMShWhSvm7LU5PwMHhgLu0liAgetsvZ0v1xL98kVs+50Qv1/LBzBei
         Zt030N+N3b1yjZlteZ/70DbP/SNPxTPXZq9+jwOxWqyYxotGhIEZq1IBr36GdTSvX27W
         yo8MMI/PHTpCujvk1DNuUJyYEiG1rphAM8a7J9Xl4mR72nTDEL83c3KYWoh6RjJijsgw
         baMclZNuGKc1YVL+uoDVGs8D5ml9mY5/PVMdERsLhmnEBJS/npOcmrpqOGXz4QS6xzqO
         TxgAP+X0lBsb7n2/vVFGcxqHjsbOTejR28Q5LiNvIdx4KHrt/qRvKQkiLIOLdOcy7pJW
         MQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxv2WRiCE5ssWDu5LVOhv4myd3/1XN4JqX5NHQBrpDuBKPpwmkLXnbkwkE/TBEIYjnp4MGMsRmTC7oyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPam8i/6pLSSD7ZTVy1jwIHp3Tba2Prd0VaynJ9QyEgpm8gJk
	/X/c8c44c5+ADRTVndjmFFlEw99tjz9TCMlD4RYQZLi6W+5HDpAW7P1BRN+rt4U=
X-Gm-Gg: ASbGnct0RERGetqIckPRfFWxCA/aFquFuiAY2d3sYXNxFq2hlWUgTq3716jgfb0LWCm
	Kqt4k7JECRzUudySZasje1TTEEvb/Elt6KyloOM0atYHffL0ymoSq1eYPGbu7xMRyxKLq3f1uY5
	sRLIKNLUGjTTZ0cnZH3IJh6HED+YLDaHRjFjNOOoBAhlx47Y4A2nVpgppTqru3TKu8OdMc62SM7
	3rW68lxQ33mj8ql9NtXfson/raxVQgy8QjeXIv0PKIkrBKOvgnFHUE/a6e63oItXkZmqS4lX+lH
	Ivd3mDW/eWqDy90xqYvq8w==
X-Google-Smtp-Source: AGHT+IFZhUDa0aBEcOlvPZddOMoMuQxC93b3SQFzlP0FnLZWxjGnGimX11rNVAbPFw+yMxcl4BKkvQ==
X-Received: by 2002:a05:6e02:1906:b0:3d3:d4a2:94a0 with SMTP id e9e14a558f8ab-3d3d4a29640mr41989075ab.8.1740602175816;
        Wed, 26 Feb 2025 12:36:15 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061fa8750sm12443173.136.2025.02.26.12.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 12:36:15 -0800 (PST)
Message-ID: <e7e3d82d-d983-4073-8cfa-91f2a3f2ea62@kernel.dk>
Date: Wed, 26 Feb 2025 13:36:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/6] io_uring: add support for kernel registered bvecs
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-3-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:20 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide an interface for the kernel to leverage the existing
> pre-registered buffers that io_uring provides. User space can reference
> these later to achieve zero-copy IO.
> 
> User space must register an empty fixed buffer table with io_uring in
> order for the kernel to make use of it.

Just a suggestion, but might make sense to not use ->release() as
a gating whether this is a kernel buffer or not, there's room in the
struct anyway with the 'u8 perm' having holes anyway. And if we did
that, then we could just have a default release that does the unpin
and put rather than needing to check and have branches for the two
types of release. Yes the indirect function call isn't free either,
like the branches aren't, but I don't think it matters on the release
side. At least not enough to care, and it'd help streamline the code
a bit and not overload ->release() with meaning "oh this is a kernel
buffer".

-- 
Jens Axboe

