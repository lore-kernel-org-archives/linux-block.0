Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073478F59
	for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776818133; cv=none; b=cBGu/rmXixO9WwOCdwOvmu6cv9YE4C39OrBUkyXCqJB/BLMUXSNxRPK1/tOBMKX8iWHCdRdjoGvyJFaAU5awT3oKF6ntGKQiruJfOErPTS18FyUFEScHmUENXKVbc7ONeNAeMQ4oKsbw8VEjOo+RGvs33UMMauTLMJ7EA2pTebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776818133; c=relaxed/simple;
	bh=Z9ililjLGwtjtq0BjJzya7bvG160JiMRbUiNNtS4wb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyPAiwTz+vxGR+9caqNwsBJwdCqRMsDtiRkcSJ4iXdQf3lHxF+1YmvZ955eow/1XvoR3hFd5hWwWPnu2w8aWucHYwlDNJNJZvAGlsc6mkGGSziI86tBMylOPSmL/05bogDuJdwTzvoVWusDMz21z5RDRH/xGtDjgGMRGUFfqTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzZBygMz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzZBygMz"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-362ba069b13so215201a91.2
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776818131; x=1777422931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVYBYcbMKP9T66v2BVVHPkUpnYU8ZtQu2qMfVc8wIjw=;
        b=KzZBygMz6y+G3viPbrCWIEOlX4IKbn/LojmTTmdygL7GBjvQ2IaVUbvC7GxYHlls8M
         xEwQoOS/sMhs8Ol/kkhsKSlIslG1isOqORXlX22GjxtBBAjdPi/xdvjoznjZyPCvBg5f
         4NHs0UD3G0sX9Jjo/7lfkFnDqSRTnzDnTzxPtfnIRj6Lmn4GnaempHOCGWfP+lvLh0L9
         AyOpClkBXCj4q6W0rfZodqkk68ip8FPaPTRrAKfcsG6UtjvchMziuK/PQ+w7d6fuSODW
         vTfUJGeSS+mmie/RSrdeSt+spH87M1fcYpuD01CioLjRnFxZweYyjmAPsqIB0KMKsnOk
         YriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776818131; x=1777422931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVYBYcbMKP9T66v2BVVHPkUpnYU8ZtQu2qMfVc8wIjw=;
        b=M1VtvoO7PFyc/WtNVpGkiU3Wy6qbp5AtDMBJmCyXyZm9JUdC6KEmjoqjUmnw9eZD/6
         EcrxVH+dMzzvxeHdXbxAttxDJeS79/RVSg4OBK/j/Jd0QjdDtsS0MjXDf6x5z6PC+EFm
         t7VLXI3/l7EeZ3qIsPaab9UVDWVfysM3hHJYiwM4i44D7BYQbrLw15c/2NjdGgf4a3cB
         Z53CqDzwDMTakzw8xcGGCdAu8Ok/wCFwwsN7QkoLMGXvFBk5JxVEfbgsq53jhNq/q5ay
         vnZBV4JlfZIa+1LDaP/Ng1HBJuKXcjJ50M/829NDbprZ0mZ1sRqHaqeVZf1xUQ5YwSAk
         rXRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HOgilB1fkg6etlmxOGGDTHsWYUYb40WzbfX9jp/6JxxONHImu3WA8trRZGRr3w35Wh4rPhXH7LxmH2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeBZhMr4dt207++xQgNs7mxxU93+sWhiMh03VunVIAzdgZFIR
	PiMD65HzsRRWA54qY+eDkQ7JudfEyVYAuPyWuuk58FbmzWmwiUqS7K0a
X-Gm-Gg: AeBDies5phwpL/cCeQJLZ7I+FL0dWA6FiJlKbw4C0Uqm6WvPEfaw1ALoxZojMR+tAeH
	8xe5f+GNOMQy5PrCXRvfVPUVs5kxY27Kf2Sftl+7u9y6QOeCi86PswSBlqmXjBvTIKHs4xF3x3U
	IsHXwmgLPcQn1wCpSat3crEYYLd9i6VeK+Nq1Gyq+xSpC0N5DzSI5rBfjZaWM45MGYyYKDmnl1l
	s4QESMEuPUm3INQtmfGXH+mmTBI1vyztg+mjA7r4KSM6jNl1CD5GIwzRawQllrdrZxkl233QOMf
	VpTLX3lhtNKQODGj7DRjBnCap9X+x9+CktUPhHnjaPU64ZnV+2BAKaJjsj6CgrMMVj66YwHH2Rw
	oB9Lc9ow0locM48uQDQfeiCm8JBtduxcrZ10oYFPdO0AzIhPvE/ItQpPIxdz7nXiCE8/qwYPQ+Z
	NUASnfLnkt+1d0NW6RbX3cCvmtH4HRklzCMSloaEO6QdiQFKhtkKmey90msGIwyl/lKsy1LCZDX
	dtnpN2bm7Djv8zwrujQVw==
X-Received: by 2002:a05:6a21:62cc:b0:39b:91d1:6c10 with SMTP id adf61e73a8af0-3a08d916aa1mr11415454637.4.1776818130499;
        Tue, 21 Apr 2026 17:35:30 -0700 (PDT)
Received: from fedora ([188.253.4.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79770512afsm11597247a12.31.2026.04.21.17.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:35:30 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: nphamcs@gmail.com
Cc: ryncsn@gmail.com,
	haowenchao22@gmail.com,
	akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	axboe@kernel.dk,
	hannes@cmpxchg.org,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	yosry@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com,
	haowenchao@xiaomi.com
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap release path
Date: Wed, 22 Apr 2026 08:34:12 +0800
Message-ID: <20260422003412.11678-1-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKEwX=P6L=CeJCXkC+cKbZKYk_ORho3pLy476c8=BbDianx=vg@mail.gmail.com>
References: <CAKEwX=P6L=CeJCXkC+cKbZKYk_ORho3pLy476c8=BbDianx=vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Apr 21, 2026 at 11:25:17AM -0700, Nhat Pham wrote:

[...]

>Hmm, free_zspage() and kmem_cache_free().
>
>* kmem_cache_free() is just handle freeing. Bulk-freeing?
>
>* free_zspage() looks like just ordinary teardown work :( Seems like
>we're not spinning any lock here - we just try lock the backing pages,
>and the rest is normal work. Not sure how to optimize this - perhaps
>deferring is the only way.
>
>

Hi Nhat,

Currently, free_zspage() is called while holding the class->lock. 
However, free_zspage() eventually invokes folio_put(), which may acquire
the zone->lock.

This creates a nested lock dependency. If multiple CPUs contend for the
same class->lock and the current holder is stalled waiting for the
zone->lock, it significantly extends the hold time of the class->lock.
This causes other CPUs to wait much longer.

Here is the ftrace data showing the severe contention on class->lock.
Under contention, the time spent in queued_spin_lock_slowpath() jumps 
from ~1.3us to over 30us, significantly increasing the total latency
of zs_free().

  7)               |  zs_free() {
  7)   0.220 us    |    _raw_read_lock();
  7)               |    _raw_spin_lock() {
  7)   1.320 us    |      queued_spin_lock_slowpath();
  7)   1.820 us    |    }
  7)   0.170 us    |    _raw_read_unlock();
  7)   0.170 us    |    obj_free();
  7)   0.190 us    |    fix_fullness_group();
  7)   0.150 us    |    _raw_spin_unlock();
  7)   0.170 us    |    kmem_cache_free();
  7)   4.610 us    |  }

---------------------------------------------------------

  7)               |  zs_free() {
  7)   0.230 us    |    _raw_read_lock();
  7)               |    _raw_spin_lock() {
  7) + 30.100 us   |      queued_spin_lock_slowpath();
  7) + 30.600 us   |    }
  7)   0.200 us    |    _raw_read_unlock();
  7)   0.170 us    |    obj_free();
  7)   0.170 us    |    fix_fullness_group();
  7)   0.170 us    |    _raw_spin_unlock();
  7)   0.210 us    |    kmem_cache_free();
  7) + 33.850 us   |  }

Best regards,
Xueyuan
