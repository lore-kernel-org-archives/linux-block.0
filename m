Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067B28E0
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838511; cv=none; b=K2TJ1Zm54f2z435vShQFlcBmc0kDgR/8PvdrMkLyTZEwbTiQ7QC4ncP9pLplZxDvETAJbfSZhlcQcpJTzOSIgGlapcbbU3m3vGI/Q53Frw9NCW6Mv5FXJF4hUXN5K9qT5MNr/tqimvqc99Enc8ZMoL3I+IcwTVC7wbV9RN9j1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838511; c=relaxed/simple;
	bh=feTf3gDPxpTJ7EucbapPKXU/Ow8t1YDYYEeMpkX4irY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WK+U0JowNDxIsieSpMJ+m5Ra6RgSE4t4boXavPnIpNsyFGBJV+RcX3b47p8Wb+JhH6NYWs3YJxzsyE9lfBotlTpw+fFURmvzMJkbDpNLBy5BcVjCpkPlSUSp9wmXU8txSuw7xFnVX/hHSJEV499kCbLuvlyTPX+AxllJaEmDpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=lNRBRjVT; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="lNRBRjVT"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so1497847b6e.0
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838508; x=1787443308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOy7gSHvO9zPI/lOB2xKGNQPh6roFIkY+cj7vJXmC3Y=;
        b=lNRBRjVTwvIpZWZHn/A+hdaQ59Prizm9I5XVh+j+QiSg0q+ShXz9sJe8+FcZqm6sm7
         IwtxNivqlZGItXmAZgOVOUS7uQ5rsY+we4dzmuLZXGncojerh/hGmXXMuFOuZN//joAB
         8GU/6W4dSC5KtCHldV/aVE6zLygs63wmhXVoPZL0D6nOTuZfeAk51UwcG6HO/sKVY/56
         hmCVcJAwq0Il3hGuhBpUDkoeEBFzM1gFWs42ZRRYX8CJTYpwzAPGJ39kS1WZvZNqL865
         /7L8AJ9s46x6cYt3VFpZ8GpcCjui0XiTOcb29eIST5sPrhezMZ4mI0aaQ21GG/E6pGxX
         vzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838508; x=1787443308;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOy7gSHvO9zPI/lOB2xKGNQPh6roFIkY+cj7vJXmC3Y=;
        b=qGcLAXb5KvmRvbKJ/gBy9hgZ63ZeIyr07Lrypw5jIPw3cR1Cpo/LWOXaCI/GHBKaVn
         Zt0J4/tgoXaLG6jBwcHTZd+cX7ywsMkl8X5/BfECZMJROII0A+gu/EZozAo1d4NiPeqx
         4lkXpvhltpWbIGxlIh1zAT5MFbSfnQCAge4fVHyZKG8tZr6ZG1WRe81biAfz9pUm6Fk/
         lTzVzX0wGbhA1WCn1K27g1gTyG3JShtI6U/dVntggaHDSDaGiruEUuqgkeCipeg5gMW2
         BAzQALKj+ONXq+LP80FiXKaZnXlyCwroDNPtG+AIBv3Oh207tuxERl9E9/KXbT3wo3CX
         w5rg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq1CJkjtbjSzE9RR/NPWX95qk9Tq9wvT8r9Vj45V5WY5dl94IeE64mzzjolQlDchBcbOCqjxrFHAsWOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iLq2ErHXOqMTWOZoXchV60O9pkFdHxOlUlNzDlmI1ZHJw83o
	+zf19MJwTeSLHZLkWOr9u6fjW45sMzlqjp2IKB20TbgCNgT2n4YK0mjmT6knsGeQmLM=
X-Gm-Gg: AR+sD11QoIbWGLaiPx2eG/4r8nQl3qJ9V37THSqgQckh450JUpH9qisLLo979o60ogN
	otRYgq1gmthNeWATPOGketPZ5bj3UUcZPtEpvP3AABGJt5VycndfEFzJuH8yXe6ZgoXpH+rbdcn
	OKeTCLNVkYeWPNKHXDL29/a09hia1a7oUhVvaCHa0B/s/1Y4KpEySMlf5xfzO/AlW7kZF1QecLZ
	tLbmcNOV4/VwGIZqt21KefW7IrttTWBmZpJGETiqeOUqZkyaupW7W1+/J/olnpESwfAkZdfhwGN
	NHA4OSPPUnJWYFzytXyE4SQYSr6WmZDvtsn4mXMHhLKeG3eLV+vCLmqLb2zvCGrsY69TnBWcXUi
	XMyfjPtlPUZVf2tkuhkyBKHpuvk6SoDfFMA78npikqDwqPmKZFwUCp24RY0wa1fMvL/P6pVLZyh
	T23l4/LZxAgEqLvk8l+0dYEJ2Ij00rep0HNskBGQ+AUCs6x9tzFXfJuaguhFTNEf6b4828lvVms
	YwqC4CXJZOdwfP3Anl/gbjaLZ14Gf4eDRlYdnDTPmroD3sC5okCkQ==
X-Received: by 2002:a05:6808:c3f2:b0:497:8f1:df07 with SMTP id 5614622812f47-4b241995a69mr13578476b6e.7.1786838508515;
        Sat, 15 Aug 2026 17:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, cgroups@vger.kernel.org, josef@toxicpanda.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Usama Arif <usama.arif@linux.dev>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com, 
 kernel-team@meta.com
In-Reply-To: <20260814165712.510132-1-usama.arif@linux.dev>
References: <20260814165712.510132-1-usama.arif@linux.dev>
Subject: Re: [PATCH v2 0/3] block: skip the blkcg walk in
 blk_cgroup_congested() when nothing is throttled
Message-Id: <178683850494.1984298.9181884544120135376.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 14 Aug 2026 09:56:36 -0700, Usama Arif wrote:
> blk_cgroup_congested() walks the current task's blkcg ancestor chain on every
> readahead decision and, once swap is in use, on every anonymous and shmem
> folio allocation.  The answer is almost always "no", but finding that out
> costs two loads per level on two cold cache lines, plus an out-of-line
> kthread_blkcg() and an RCU read-side pair.  On a fleet profile of hosts
> running containers with 5-10 level hierarchies it costs about as much as all
> of mutex_lock(), 99.4% of it under __folio_throttle_swaprate().
> 
> [...]

Applied, thanks!

[1/3] blk-iolatency: clear delay state when freeing policy data
      commit: 8935bf22c0a0db517a7f72f7097300e05dd852f5
[2/3] blk-iocost: clear delay state when freeing policy data
      commit: 97cb95d2148835ae86ff916b145aef332d40439d
[3/3] block: skip blkcg walk in blk_cgroup_congested() when nothing throttled
      commit: 4febfe7d98948bf6693f5c6a0a7e198e8fb4e584

Best regards,
-- 
Jens Axboe



