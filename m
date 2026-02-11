Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43771E32D6
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770769478; cv=none; b=Ge0dtejRln12vDHiJuPvVP4nC9uIufuJv6xErgdJOxjkt2WYi4Lr9SbGklCuJ71k0ipfPLbxd9Aqmg1jYjbLkMpKJ3T+X0rP+d0lOHRb8/JuqDm/ip7fXICfThZNmw2H7zcOLIa6lo+YPgHXjvbKd/k3evwNCHPyXLrnK7pT2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770769478; c=relaxed/simple;
	bh=ju5P6MSCRAendyS2SYVIhbA3tQky8z9n3jLbBjeZ/zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvhBPfR8DKdditgb0/FID3IfdrcipTeFJvnlxQI96BwbgwMx1AG/Snjd+MFOJLVQGSNnHBv9mGl2P/N8jssvcidMf4jw+lySGCwEPUQ7e7mtWxjAHwwGODkK5fNz29AmRGg05ek3fLuXsW1UWhLH7Y+koeOJEqXlM1qyYZUjB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=swLTMrtT; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="swLTMrtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1770769473;
	bh=RW2u9FblXw/99dFsoyPShyFu+/Svaln1D1IAhqA6bAw=;
	h=From:Subject:Date:Message-ID;
	b=swLTMrtTnSNSszhy+Hbn3PyXmiYl36ZhmiKtjtjsVQYUPdVWpn0dgmwiIO2vme4QO
	 HiJjUynRUGWBSjR5cK773CACiDYXIrl9fjmfDtGnwTQdG6XakqGsGl/XPxGVTMz9qN
	 d7VCDoqdjFBprxWeliYt0UAf2rFgU7PgRFAFiPl4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 698BCAF50000053A; Wed, 11 Feb 2026 08:19:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9897336816036
X-SMAIL-UIID: 1BFCAC35E8DD46D0B5890F59211E6431-20260211-081903-1
From: Hillf Danton <hdanton@sina.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de
Subject: Re: [PATCH v2 0/1] block/blk-mq: fix RT kernel regression with dedicated quiesce_sync_lock
Date: Wed, 11 Feb 2026 08:18:49 +0800
Message-ID: <20260211001851.2821-1-hdanton@sina.com>
In-Reply-To: <20260210204943.21709-3-ionut.nechita@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Feb 2026 22:49:44 +0200 Ionut Nechita (Wind River) wrote:
> Hi Jens,
> 
> This is v2 of the fix for the RT kernel performance regression caused by
> commit 679b1874eba7 ("block: fix ordering between checking
> QUEUE_FLAG_QUIESCED request adding").
> 
> Changes since v1 (RESEND, Jan 9):
> - Rebased on top of axboe/for-7.0/block
> - No code changes
> 
> The problem: on PREEMPT_RT kernels, the spinlock_t queue_lock added in
> blk_mq_run_hw_queue() converts to a sleeping rt_mutex, causing all IRQ
> threads (one per MSI-X vector) to serialize. On megaraid_sas with 8
> MSI-X vectors, throughput drops from 640 MB/s to 153 MB/s.
> 
> The fix introduces a dedicated raw_spinlock_t quiesce_sync_lock that
> does not convert to rt_mutex on RT kernels. The critical section is
> provably short (only flag and counter checks), making raw_spinlock safe.
> 
> Test results on RT kernel (megaraid_sas with 8 MSI-X vectors):
> - Before: 153 MB/s, 6-8 IRQ threads in D-state
> - After:  640 MB/s, 0 IRQ threads blocked
>
Because the top waiter is allowed to spin on rtmutex owner, the D-state
irq threads are expected.
OTOH raw spinlock offers nothing for top waiter, which is the extra price
for resuming the throughput.
