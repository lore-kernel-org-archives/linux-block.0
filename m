Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DDD35B628
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902822; cv=none; b=JX/LNw3Nc8MPaQx5vOsM8waEQ5n3K6FRMuHP6OyXvCOiDaaO8LpyX6PNDO5Ua06cechtDFAyQgQ0v+BE8+sqHSeTVHQPd8jh/a2gcOlPRTG2D47m7mNrahhk9LgF0wEE/oXI5IzA5U6GNLZ8Lct5ypsMC/GzRmpEYunR6kes+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902822; c=relaxed/simple;
	bh=DDckpbX1Mf0vJIHpXEvtnuexbTx8CKJBYIaj4WrgeN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abqbMFxFdds/flMjoHc3H6AcLbAOPaAUEBteNTdknM6WW9Gs15EeCDb9lg4AWoUvQyL5ElzyzY5ODB2vQyLPXxUSj2K5+Rv4HcjtycerX214mw4roipKVq7HaHTv+UFf26fcHKgabvv94F30agkC1+Y1WRv/K3txbfXVDHf86OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=C8qMi9oH; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="C8qMi9oH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1770902818;
	bh=MFNqD27f/iIbabrusGiA5uEQ9ktT47oGuegporyJHW0=;
	h=From:Subject:Date:Message-ID;
	b=C8qMi9oHcwVuGf0gTObiOE7NM7vl6lUta4N94dYq2i2X/MQez97f6sHluLlORQtVz
	 gaJMkWu/V9DdSduzEkJ861AkwXBe95Yo4EVotQvsoVK8Du3c/2tNif+DCZVHbrdxt+
	 AAGVUOuc4Im6Qe57WBoDRGsDSveDXF1WjJrOW9bg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 698DD51D00007645; Thu, 12 Feb 2026 21:26:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8693756291925
X-SMAIL-UIID: 739880581B1348538D7438C2169D1226-20260212-212654-1
From: Hillf Danton <hdanton@sina.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: axboe@kernel.dk,
	torvalds@linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de
Subject: Re: [PATCH v3 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Thu, 12 Feb 2026 21:26:43 +0800
Message-ID: <20260212132644.2998-1-hdanton@sina.com>
In-Reply-To: <20260212071418.7622-1-ionut.nechita@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Feb 2026 09:14:18 +0200 Ionut Nechita (Wind River) wrote:
> 
> PREEMPT_RT has been merged into mainline since v6.12. There is no
> separate RT tree for this kind of fix anymore. The spinlock in question

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/

> converts to rt_mutex under PREEMPT_RT, which is now a mainline
> configuration option, so the contention issue is a mainline problem.
> 
CONFIG_PREEMPT_RT can not be found in your patch.

> Beyond the RT aspect, replacing the spinlock with atomic_t in the hot
> path is arguably a simplification that benefits all configurations -
> it removes locking overhead and eliminates the two-variable
> synchronization (quiesce_depth + QUEUE_FLAG_QUIESCED) in favor of a
> single atomic counter.
> 
Then it was not wise to add the spinlock, yes?
