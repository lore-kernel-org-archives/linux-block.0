Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FF18C011
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305211; cv=none; b=X0n6uGmTt0yUYzAlf1r09M7+xDbE0U8zs1L7nTdcuQ6IkRg/+TRpApGgvnfvmpR9yzazAKUO0UkGxDN/FSandHg2xdCObGz9cH9ABbVLZFDh/FRLrO61OPubA6fAOHiu1Akpp/NwMrwMQv4I3uanfdipCLq2Ta1lO9z7FRU1qZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305211; c=relaxed/simple;
	bh=sldAhQQpmLk8JfPQ/X/+f6FvtcyWfPIoIRD3vqVION0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh+hQCTMF+pnrGPLoJE21AYyRkRg9kowmzvfd8dxtU1iMLHyOjlsvQ1CzmHxjT/YKq4ZW3GU1QSk2gAfOgBps0o3Hnv/NP7azYki7dHyEBKu3hQvuxy3cv7tVq0gSoHeGlScmx90nigkjb49HZ1p/m0NQPF2Rd44ahdzE2YTFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EqmoFEq4; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EqmoFEq4"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88432efaf45so88129839f.3
        for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756305208; x=1756910008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuXTvGJMiWGFlmLyQyXukPdAfvRayni7TOXCI1oEsiI=;
        b=EqmoFEq41KGQNhGdLYTS0SQP41vUPjT42sofrhJQjgGRicuyrAqkPEap+DyoFF19pw
         1c9PyODXgCiZMBQmPd3zYMyNTuqLYdPqhfN2NysBZ910QNr+Z6HrawSj4SDITlWHjxhh
         3YcEMjbPtEQu40l73qiIl0r0fmG46LxoohVOMPxeaUppaQbj8C5VH5plK4dwY0EfT3wl
         QJwpBTTH+rY3b9BNvoms7WzmDj0r+IoHU8L4lLBDoc9GctiyZ+wVTeHVtfth28kG5Jef
         rMyEPivKoxFWTbhMn3NyyZp3Ges/1TKkyKCL51N06VCEp8i4ZSuTMzTTbcr541Sz8gpZ
         OZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305208; x=1756910008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuXTvGJMiWGFlmLyQyXukPdAfvRayni7TOXCI1oEsiI=;
        b=na1C8vIn/4xHAg49megqbzWq2dRgguLXEJbnLsC0gywQore0MOe992KOBvTUJ/ZBCM
         yQbh1jVmrAcZLFPqzg5qT1Rit+fc1DyOA8Qodua6IxJZgj0WfnlUy8QDriUYOWS5Mcgx
         NqihxZ1SwYfe1pvrKt0SxjVl/HDqHfUmUAkiWJbLB/cBUMLZod76MwOmuGHQUjFk4bwN
         CbNAvOkCK0YnsZ1u05LtdfKNQWxAC4BNspYqrSKfamDaa2bf0idtePrd5vaTchvhwiup
         SDN41JefT4fJXLKCSNighYvFLQjLBLe9+CTmzm2rBkOOHxXHGcpYGxtPuIPBHECv61nx
         EyOA==
X-Forwarded-Encrypted: i=1; AJvYcCXAY9q2vfcY43Q5tc8X/e89dHJ9SU1a9/dSPUeP/Roy+u4s2ZgCjTSdqAi+ZY5BG6ZZeuf97f7Vw6r3XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyScpvJ/YWsPDZ2fMeI7BX3nCcdivCyLJ6J6nFKnGy3C4ut5o1A
	eJi8EyidJJs8uD+2fgpxfHNaivE6Te4PfppaZNaLFXJQR8zJQ3WUci3Ia7155HYrG14=
X-Gm-Gg: ASbGnctOpP4uKSas/OXrpFqvMYC0Ny4Kj51u80V4RS6RyxZpGEc5TILv9lScVK44NOd
	lDha943F981gA763d6lJt5DCbeqobmCc0OO6Nx3EBRw4aJRt6e3GDgmGmrwEa+fVGHy6cbgtVyY
	eOvCAx+n3Ko31Fr51oBH2jMLcH85ao5R23ddFOlbOnZ8RONxg4SMoBDaS9B0bz7wNw+838emR4Y
	xHxPMxH5EQy1B0jB97c5xiGxj91BeL1NvWtVfXI1aiL/JM47nYsPEi4wlqvF3rsyGLbt2y76XCe
	KCa6ATIwxfT+lxA7A2kTcYjjpnLnBL1Y86TNPZ6dJOUqG/tkUeAO1I5/wPWOzm/K6wyE1kL8/oS
	k2TApabi81xsvV0nOPq+ZVKp6KGZ9NFRg/uB+mwnI
X-Google-Smtp-Source: AGHT+IFhCDX+vznxC1PeElLem/u1bc5IXLzc0em6nOpMfx2mbDcc4ih3vaywDiYCZarP1Vk6NBlZyA==
X-Received: by 2002:a05:6602:6215:b0:886:f821:a575 with SMTP id ca18e2360f4ac-886f821a5cdmr567026339f.1.1756305207920;
        Wed, 27 Aug 2025 07:33:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8f0c68asm849331339f.11.2025.08.27.07.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 07:33:27 -0700 (PDT)
Message-ID: <a7006be1-fcb0-4132-88c1-0b23bc6d642b@kernel.dk>
Date: Wed, 27 Aug 2025 08:33:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] loop: use vfs_getattr_nosec for accurate file size
To: Theodore Ts'o <tytso@mit.edu>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Rajeev Mishra <rajeevm@hpe.com>, linux-block@vger.kernel.org,
 Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250827025939.GA2209224@mit.edu>
 <274c312c-d0e5-10af-0ef0-bab92e71eb64@huaweicloud.com>
 <20250827143136.GA2462272@mit.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250827143136.GA2462272@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 8:31 AM, Theodore Ts'o wrote:
> On Wed, Aug 27, 2025 at 11:13:13AM +0800, Yu Kuai wrote:
>> This is fixed by:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-6.17&id=d14469ed7c00314fe8957b2841bda329e4eaf4ab
> 
> Great, thanks!  Looking forward to this landing in linux-next (since
> it showed up in my automated linux-next testing laght night).

Sorry about that, the patch was queued for linux-next on my end on Monday.
Surprised it isn't there already - in any case, it will be soon.

-- 
Jens Axboe
