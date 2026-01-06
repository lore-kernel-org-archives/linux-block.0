Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8FC332ED3
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699455; cv=none; b=MEOg9+bmBEG0qGdDbOqUk/UuLTtHlAeNOgh19Px9ntSjuGJLTl7B/q1a6QsQ8Ifr3G63YXJzYweU7e7CRc3OJBZRHpyWB32k1WkWOFfuiwJEvPRV+u1IM13R0H+XIkz5/lXVtAZJrU3I1W1lBOzdu7I5AdKjmQl56XvximjNIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699455; c=relaxed/simple;
	bh=v4YuHG1rupxsoSiOid32tx2tUkEKlM5xOQlZqfA5aZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EF281Ezo3SEDfKwKeFCgCozWZf6UT96CbO/Q4ol6Ni8EYQGTZfBCTGLa0uChVK+NGai0X5DffFhTJVL5KqsCl6a5yTZj++TLVxvdpYBlm5RhogtshHS1fGxvoy7Bw3Y3u+4cnu0JGDulxYTtLYXYFLPZ0s9EyqvsZTrgeeep5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH8clGh0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH8clGh0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so9128995e9.2
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699451; x=1768304251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6uW+A2P9pkdDCkg7XZPcaKU2E1i1mrVtntLiN6dJWY=;
        b=aH8clGh0aGB7eBc1MCM7+h6zNBiz4ABTMAJg9hhbrbFi4nOyCRr7Oat7A+tYBQBb+A
         u32LlHWneALAikJjmB2Yl0OvLjjBRNx1JiJXj1lRKFo/ZubXBcXx3S5xB6od0wQrBWsV
         RC32c19kxeBU1uzmp9KTRZLmW6n8E0I5sz3zNu7Qad/rhe2ZD2Zi7e1a16e0RXDtsfQB
         0G2t4RHKUxprxxuIzszkCpEWnI8yptSiK+LfO9Gl9OIi09NBDiEh2MiJkgBs1nuMIl4n
         oxJwyoFgvjuu4YrCbvup8BUVo9BN7cJUFXBg6TK0NcZ1c+OofZ9I+mz3pAiyUtIQMVj2
         03TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699451; x=1768304251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q6uW+A2P9pkdDCkg7XZPcaKU2E1i1mrVtntLiN6dJWY=;
        b=I8f9ROY76qoTjc2lz6nxO+KnzJGuEni1EjorusgzzkfYZkzLbKPURVpXxrymxuvJ9i
         oD9iNQ7Nqa/BBkVGp8/IvoE2P2Gret9cIa9LFzkHN/AEvUdqHohK/AOk3/Uv5WkdtcWK
         B13xDBNjn6yWJaiyqDWv7uJProK2Ank64lyPJq8Pd5wCQXjAWur31yPLJSnGk5Z0xyp5
         csGr3JY4EeygPTlcDc9qV6qhnzZfAuCkHyOdJEcPXhJoHKQZH4qOcfwtTyFp/sjWUr+v
         iOXiJWHSV6eDg+q6fYLXujvfCXUCVvU6EHN2ZSy4gF12tNEh3P3KKQOj2YaSxhnsqZ4F
         fM3w==
X-Forwarded-Encrypted: i=1; AJvYcCXXsRYZPQvRJUuRqUAFn/J4pF3AK3MudWQhl+geSyEAangC1RlLoaWwsAmhGEP0deo4v3aITVWNGHvCKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwvp+goNuhspCbJPXqEzzd+aJYv5sbCLLMGNlcoxUTLMNoOS4I
	ladTbt31kYcMjLZeLLo42fmcqfwCjLJ7DHOXgJqt797//9raMOnevI+e
X-Gm-Gg: AY/fxX7aZzCKy+kOJZPHChCuKgnrqli7aLLvoHhxLHF1pqg1bRJ7K31EbopHKvDwWNx
	LDq448Q8zFsU+y/vXLGw50LpOfDekoJ3P3VPPgNbMNSTb+axVsYEwzUAWvbZCRlCzrhxFw2yzoj
	VMsbe30LWlT1H3NnQFYXvcdijZqhSm0ya9QshQ1aIVn2oAY3+TEK2QbAE3ul90zcQu/trGCsb6d
	cNBMAV0FYyxUNQ2KxtVcHvcaGpwCvqqi7V5DPsRHtPl/jPBx71vaBvnvjSMjC1YggASnuljrmLR
	/jV4rFRuNtPVHcj83kDxIggsGZ7h3ZkZn6U28md/Fivs9HKXA8f8HKaJS9sG7z0jx3ny4lugyCV
	E8x39WeMauM1QPPZaREX1qjmmo4ID/V09XzFggm8fcPBpfhcvBWdCzY8OjE1BLonx+JSJo8nFVH
	4cpCWSUEerTA/GO+HCW23PRBmwxqqrd0dg4h7HJLmf8yI0
X-Google-Smtp-Source: AGHT+IFZ91WQ+XxVidfhxQyJyWI8jqmAirmsj1rp2dJE8QgUjcxhZbOX7ZjT1XaFm0hj6+FAliB85A==
X-Received: by 2002:a05:600c:4e86:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-47d7f066195mr30148295e9.3.1767699451299;
        Tue, 06 Jan 2026 03:37:31 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:ca09:7000:33fc:5cce:3767:6b22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c6csm40282735e9.1.2026.01.06.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:37:30 -0800 (PST)
From: djiony2011@gmail.com
X-Google-Original-From: ionut.nechita@windriver.com
To: muchun.song@linux.dev
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.lei@redhat.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] block/blk-mq: fix RT kernel regression with queue_lock in hot path
Date: Tue,  6 Jan 2026 13:36:27 +0200
Message-ID: <20260106113626.7319-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <73000e7f-14a7-40be-a137-060e5c2c49dc@linux.dev>
References: <73000e7f-14a7-40be-a137-060e5c2c49dc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Muchun,

Thank you for the detailed review. Your questions about the memory barriers are
absolutely correct and highlight fundamental issues with my approach.

> Memory barriers must be used in pairs. So how to synchronize?

> Why we need another barrier? What order does this barrier guarantee?

You're right to ask these questions. After careful consideration and discussion
with Ming Lei, I've concluded that the memory barrier approach in this patch is
flawed and insufficient.

The fundamental problem is:
1. Memory barriers need proper pairing on both read and write sides
2. The write-side barriers would need to be inserted at MULTIPLE call sites
   throughout the block layer - everywhere work is added before calling
   blk_mq_run_hw_queue()
3. This is exactly why the original commit 679b1874eba7 chose the lock-based
   approach, noting that "memory barrier is not easy to be maintained"

My patch attempted to add barriers only in blk_mq_run_hw_queue(), but didn't
address the pairing barriers needed at all the call sites that add work to
dispatch lists/sw queues. This makes the synchronization incomplete.

## New approach: dedicated raw_spinlock

I'm abandoning the memory barrier approach and preparing a new patch that uses
a dedicated raw_spinlock_t (quiesce_sync_lock) instead of the general-purpose
queue_lock.

The key differences from the current problematic code:
- Current: Uses queue_lock (spinlock_t) which becomes rt_mutex in RT kernel
- New: Uses quiesce_sync_lock (raw_spinlock_t) which stays a real spinlock

Why raw_spinlock is safe:
- Critical section is provably short (only flag and counter checks)
- No sleeping operations under the lock
- Specific to quiesce synchronization, not general queue operations

This approach:
- Maintains the correct synchronization from 679b1874eba7
- Avoids sleeping in RT kernel's IRQ thread context
- Simpler and more maintainable than memory barrier pairing across many call sites

I'll send the new patch shortly. Thank you for catching these issues before
they made it into the kernel.

Best regards,
Ionut
