Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23C275111
	for <linux-block@vger.kernel.org>; Wed,  1 Oct 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314387; cv=none; b=l9rjvmsHoMPClTi0DqyPBwEIrk/yHC3duWwvp4Y5S+2jPPYj9gtBwkGtdjhr5cksdKf53vAyl883ZjJ1V4t9P8gehGI8un1qtOYIKLIRflOwIEnnPLG/+xug+dJzksF2RR7hYTQ/FirNOpve8ti+AfgLq/y+wouutv8kuN778fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314387; c=relaxed/simple;
	bh=COvwm5jaQfs3tpP+sakmTLvUO/bpe6L/ZoDkK1VYm24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dU3bvCdl9DQEdok3KGoWrld9RfuZVrmVHqgwHkWoOKoGorbK0Of5jbMhyGZ7zDx8iBTJNtBA6OI7Z4CdG+QnPjgZgLzDlMnRtJzCJGD4jUvKwLjkVO59HfNRhjeRH50RYHOQq2dsUhnDQzoM7xN9k9KZ8QRYbMVLxwvlBrITPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Y3Kx4jJt; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Y3Kx4jJt"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1759314379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nfgEVOB3DZQ6/kGEtKzVJBDpgTIVIwUcLDFO2qRH4V4=;
	b=Y3Kx4jJtMijcjrfdGyIl1ZbwTNaaOMfm8177xkBDBVYvTOPoeujjuxwTlvo2lEj0ZQFn1F
	mNYctUeqTJuu4MZciKvB2Ai8YqECPNxjB2AX7CZ3iQimhxvuU6c0Olu8bKyWkq6Fzhf+Rt
	Fg0BMN5YVPCkUTrbO9+dTCTYT0yhzdU=
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [bug-report] NULL pointer dereference in __drbd_change_sync()
Date: Wed,  1 Oct 2025 13:26:14 +0300
Message-ID: <20251001102619.8912-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the Linux kernel, there's an unpatched bug in the DRBD code in the __drbd_change_sync() function,
a NULL pointer dereference.

The call stack that leads to this error looks like this:

drbd_request_endio
|-> __req_mod(req, what, NULL, &m);
    |-> case READ_COMPLETED_WITH_ERROR:
    |-> drbd_set_out_of_sync(NULL, ... )
    	|-> __drbd_change_sync(NULL, ... );
            |-> peer_device->device (NULL->device)

This bug has already been fixed here [1], but porting this commit to the kernel will be quite
difficult, since the DRBD code in the Linux kernel and on GitHub [2] differs significantly.

But ignoring it is also not a good idea.

The blamed kernel commit is 0d11f3cf279c ("drbd: Pass a peer device to the resync and online verify functions")
which came with series [3].

One possible solution is to reverse the patch series [3] because "it is mainly no-ops, pretty much just 
preparation for future upstreaming work" as its cover letter says.  

However, there seems to be no active drbd module development in mainline kernel since that series was posted in 2023.

[1]: https://github.com/LINBIT/drbd/commit/effc7281bf1a7922daa6393632fc6eeac1732bfa
[2]: https://github.com/LINBIT/drbd
[3]: https://lore.kernel.org/all/20230330102744.2128122-1-christoph.boehmwalder@linbit.com/

Found by Linux Verification Center (linuxtesting.org) with SVACE.

-- 
2.43.0

