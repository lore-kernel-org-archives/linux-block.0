Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793415538;
	b=U9R1JAYKXnWf4Q4gONJW/wHeHbVwx7sYG4CLS3fn9mC+Ai6ztMMI8HUhviOnHls363QN
	 UKaTsgwSG3qL3NG292qo7J0KMnFA75ir5jbdA4EPdCtc+Uxy/LTm4bNTOb1eYNSAIQtRp
	 aPDkFNOlmySkhEF1SF08x5Yk2ByKQLcHwuNDvqLF75H8SI1E2ANfWzDc/ylg+LH4ODVPR
	 nb1rRcOE4Msnep8kI6Yk56g/4pMX9QTjzp0lqd2ipQ2+gpiGQuh4SgOmkUQ7Xr4p61IsH
	 /YDA0zIjC1yJbpWTsZBnZoyD+gbg3lXlLuhx1Mm1u4R7M9CmDRAGnTUzqvSYs3fZGhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JkfOBmmLSdrkWhRF5jU/G/pRdN9hDyVrLyqK8ebtGdc=;
	b=VqC/J+vmDWFcQco3MbK6ZkmjVieG43Nfk31nJYSuvUPbkV2joF4YdaLkm6FCqKePz2lo
	 LPxGcNAxN49q6SPSCRWRBAEnO6D0PxVHxQ0xYKPDQQeSiDXcR8F9mS8i1qrVTfP654hjB
	 ypFygSCb31cY8PDv1TicmTHAo7YVAKYdUr4+pO76hhks0k12jmOjqnueK8NrjKkF+mCKk
	 DmIx03u+1BO6Jbw9p8HlODnJ0ZdjGg5h+hXrHhhQCgzx7tf1SjdtYrwZiAHeWila2Oqb6
	 JVc7XL+RXeeXzBHxzatSX3ic0zW1XLUeDFfGIlICSVHkWz9eM2cvful7VqPe/FZfXgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxeGsHyt;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD981606A31A
	for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 02:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD981606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxeGsHyt
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso827518eec.0
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 19:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793415537; x=1794020337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JkfOBmmLSdrkWhRF5jU/G/pRdN9hDyVrLyqK8ebtGdc=;
        b=jxeGsHytW4yu/6DB/vxLQDJ6XTdzQ9NKtaGobF2RApLEBOkWjHOQt5/g8EHt4G1+dt
         HuBNuEO1zy1r0Se125GkCO4kMRCm4VPpJn+3xfmpchJRgHRNZZD5fnr+iZ5m2J0/GoPM
         69/JHz422gSJWQMY2eoLlmiuythx8B8J9Mpv06hBhalfMJPbxC/Qq3VCGasiCA42QX3C
         MEZw/86OUC+8Cyrcglu8b/tKz9f3aeaA5cf8umGvRpxP/1jXIwKWnI5vlvri5ngY7OOn
         tWi3fBnqhTmOgjUt3QyMwCjN0k6nU2Juzf7HmGfAjGhjPIE6KF2lV3lt7wRV1sr3qhZz
         87Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793415537; x=1794020337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JkfOBmmLSdrkWhRF5jU/G/pRdN9hDyVrLyqK8ebtGdc=;
        b=PfuSG0HuNSiTbA4o7SIr0kOeas9nhlPA23tLw+q/0i83N88gYWGIxu227XDfvTNlvS
         poxIfdbTEt/lhbnw0+jEH5ARKZzbpZDk84JywLJCg+Uq2dsoX1cCntfKwgikeTCps7SQ
         OLA7mylEB7fmqrqIHc5tJwfuMIgQrZ5BIJthr1oX/ywS9KNA3M2Hlyy2c5tI0HBHaU8w
         2BGrgV3dhQYzAFn94GVsGYKrFDgK5l6qUhZG96SyEJOMe9ZI+xq/JOPROL+4rZamlDLw
         ajp9UuB+2XDWEYspeav22Q/z7xdVn3qPDfWJTqpWOhZdK71ZkWejeSgHO01z0SdPRjkd
         7mRg==
X-Forwarded-Encrypted: i=1; AKwUvBxQFGymzeznkqB7mx/L3FrAnX82BJEQla96EB3ualFyfq+P/o2pbh0g/a2Ew1ODE9OCwOO1UXqWny6lPQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKtJDPfWlXb9eXpuVspKrpxEz6bupKuB1EognQlIqeNJTE1ODu0
	12/sOQnSdPaoBe+z50wiNGYsxSj/oksYOQ73EIybUvlhzRdSsnbUGxG7
X-Gm-Gg: AYBFou2Kn6XZ9OP785MGcRYK/oiOMVo+xqzzaP0zxkjYj2zN4tjbHLxdJBk1D3W3aA3
	6uxcO4D8nnTadlUbNoQSmxbpkC5ksBCjwMP9lJ3Yt7SLTwTghvpF1t761IGLiN//ujqBFMpWeF9
	SVcPbGuqClx1DhUFJYwhIX9LjE8lu9yfQnOjdYgqEwS/J8/sJtQv2/9rLTqfLEstcT2qtNNhQO9
	Q5VDmoxPdpBbXkJy5kYfw+RvL87zUDYuzRFOBLc527UQUQyolk9d1wkDyPThIuv8DvVUOjJn986
	Vi+WxG434w7zsnNbluvop2KDLkz+ozUIHmjggLItlZd7REiKLLmzoYG446djFt0jT7GIDFhnBpG
	bKjr4vVqCdgXnMrDhJC07S/hXtr+wYgel25E/RaTt3rmM0LRMvmSW3/Chhy4baW3uy4LdcuM+x5
	1ZGsgVuMUdhKk0b8y8vSXv7td6EsLs9lTx3+VRRa/gxHY2vg11VT8BW4bxv8X8IW2cZIF8xqVSh
	VqOThMfWi+VGei4Tu/OnWGIx8tymKSGiFZXVlfdLATUoQtS8KvXc21DwZjzgOz1Rg+WCpoGmhHh
	hjlyzLcN8dD9UzKCV59w2nK4jOWbih0qSmiaEncTk1KHflc=
X-Received: by 2002:a05:7022:1181:b0:154:e9d2:d741 with SMTP id a92af1059eb24-1ac5bbb4870mr5104907c88.8.1793415536649;
        Fri, 30 Oct 2026 19:58:56 -0700 (PDT)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b0a628bsm10940998c88.22.2026.10.30.19.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 19:58:56 -0700 (PDT)
From: zhangbo56 <zhangbo0325@gmail.com>
X-Google-Original-From: zhangbo56 <zhangbo56@xiaomi.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	bgeffon@google.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	richardycc@google.com,
	zhangbo0325@gmail.com,
	zhangbo56 <zhangbo56@xiaomi.com>
Subject: Re: [PATCH v7 00/15] zram: redesign zcomp and rework backends
Date: Sat, 31 Oct 2026 10:58:46 +0800
Message-Id: <20261031025846.3774596-1-zhangbo56@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I reported performance numbers earlier; this is a follow-up focused on
stability.

I ran an 8-hour stress test of this series using the following workload:
16 memcgs each looping a kernel build with tight memory limits to push
anon memory out to the zram swap (zstd), plus continuous CPU hotplug
(~113ms per cycle, 254k cycles). Repeated contained memcg OOM kills kept
the per-CPU streams constantly torn down and re-created under load.

Result: ran to completion, no issues.
  * dmesg clean - no BUG/Oops/stall/lockup/hung task/warning, no zram
    driver messages.
  * zram io_stat: failed_reads=0, failed_writes=0, invalid_io=0 across
    ~3.56 billion operations.
  * All CPUs back online cleanly.

A shorter lz4 (stateless) run was also clean.

Environment: 7.3.0-rc5-mmnew+, x86_64, PREEMPT, 28 CPUs, 8 GB RAM.

For the whole series:
Tested-by: zhangbo56 <zhangbo56@xiaomi.com>

Thanks,
Bo

