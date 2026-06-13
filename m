Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9C3A2572
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345706; cv=none; b=RaJ1sGhl22X3iw8xK3W1exoCZCUibF0B/jq7AvsLLEXbGOtZjzWUfbegSZLOxk2fxYy2oukuVMscJPW5lQbcUBU4+NSdKBu2WZXGsgxPOh6eu/YgSjLNGJKRsM50IvEGDqcH3e/kyljKs1dZDMNqKoDNQUucTvumbRfLP70KVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345706; c=relaxed/simple;
	bh=v912xpOvs0q/yr0iMenSrteIUL8UFC9cqr/6/oziSX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7BwqxVGLOjaqTgbHwrChAU4sQTKKOvI0LDGrtmEPQtzw7+nUHs9bi/MeyHbmhVN3Zap30Rl9jCAPxqu3Ll1JvMxB3y3CZNM+K9rn3RanP3b0CCCI+ZKWz9QBtUieJ1cRJ1/XBmHphB4mv1NGchhCYfnyEMJotrB1Dv7aZ5Iie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=VzMrSe/Z; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="VzMrSe/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1781345700;
	bh=o+4ANMBUOQ9kcRY4jwP0XwLbZ4OBI1MMyqHEK1GAvEo=;
	h=From:Subject:Date:Message-ID;
	b=VzMrSe/ZaxmzIMS+XvTZqouvWYp1ItKP5ozdqq3LGR6XldasyC6uMIARZi+XHYCCA
	 CasZGNKsBIr1m3RjlWFiidzOIInqT3s/VDZprN5OhNypL+1MWCt3zOKJBPZPmhsITQ
	 Yx+pEOCNJyRs/GWti91QMI41NqxEcRZxipXBjL9Y=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A2D2D0700000894; Sat, 13 Jun 2026 18:12:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5034706816304
X-SMAIL-UIID: 9BB9CB8B0A304A6598BC31B0012ACB21-20260613-181225-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: Reclassify sockets to avoid lockdep circular dependency
Date: Sat, 13 Jun 2026 18:12:13 +0800
Message-ID: <20260613101214.1771-1-hdanton@sina.com>
In-Reply-To: <20260613042619.1108126-1-edumazet@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Jun 2026 04:26:19 +0000 Eric Dumazet wrote:
> syzbot reported a possible circular locking dependency in udp_sendmsg()
> where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
> can eventually depend on another sk_lock (e.g., if NBD is used for swap
> or writeback and NBD uses TLS/TCP which acquires sk_lock).
> 
> Since the UDP socket and the NBD TCP/TLS socket are different, this is a
> false positive. Fix this by reclassifying NBD sockets to a separate lock
> class when they are added to the NBD device.
> 
> This is similar to what nvme-tcp and other network block devices do.
> 
> Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")

Given the Fixes tag, can you specify anything wrong that commit added?

> Reported-by: syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a2cdafe.428ffe26.258b27.0161.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
