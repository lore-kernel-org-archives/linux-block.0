Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059B1A0B15;
	Tue, 29 Sep 2026 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641760; cv=none; b=XlIpfBeztAN56joGHQ1KC/0bAdGKTUU8ZPw6vo9FveMzpMPmwn7w17JjDwxMFNP5SbQCDT5czf7t+3Gb4jVe6BHES5D/PUzu0k1IGST9gQ1czWCAPVhJBq4MZ9/h5bkzLePZ2JMufS8ac8kIRYdWSS7FDBDf9qBaHeIIKxA/LLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641760; c=relaxed/simple;
	bh=szoAaFfBzTh5QaebrDznk1BoUs0mjX3CQQFZgGrrflc=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=pwMhY8Vi6h9Eqr9RuroEoH79Vql7MmiCtUeBUOZmRby+Hm3zk8SB/pjvNBcPnUIMl6oL3qxFL8pRAfURq+pP/W0m/ALgbE6D0Ot2uIPcM+bHZ/H4Ohmiur0oHlCfq7PV+2rd60EAB0t9AiY5Xcs7uuMXMprOh3XK9dlcfx2FsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pmv32NhC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pmv32NhC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7FBC1400123;
	Mon, 28 Sep 2026 20:29:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 20:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790641758; x=
	1790728158; bh=NThFlK2rqq6IizG2OPZdjVK44ZtM9reAVhlYi9SKw4Q=; b=P
	mv32NhCkpi8sWYfTCbhq/9Pfr5WhraS23M2BOmO9gdLKeDg5N1YCRshKEcSJTmDk
	xGFfikz5AdwqmSnyvQ/gRQgJ7+ZMpMmDF6UCE7lOfPpghTiN/L40dzspoiojr04V
	INGGG1NEyzHjIpKgwDmPOaVBFO1fhYTCTWXau+Ipe2OtCsQ1zykWnI4qhYhQNpw/
	ksVyHGNNrnCK2+OwWjuN+9B6DT/eIbq4s7YAuiiNmZtHqfNwAwMVwTdN9sJwcgXi
	T4ki76v/xH5mRySFfSbzzC0xkAOZ7/cAlWO6ZRVZyiV85MEWnvZVaa9l/xM6WsaS
	xIqvxz6QDjXyQu+f1o98g==
X-ME-Sender: <xms:Xga7agSEow-WmdjSc7wTypLpKZ5GVJqr1sFxmB7IcbgVbHBQsPozkA>
    <xme:Xga7apzLop297flfJ8hl75Eo3_2M79C6OEmGzrrvcqY7JsK9tfGiOjyeymjGFRuai
    AM8exb6LNub2Wm0w6EKyBJdXXc07Pj5JcmgDkbePARxyWZ5ac0tDtHL>
X-ME-Received: <xmr:Xga7agAq0t_IgmCIKUO728NqXchu-vk4qek-L6K2FzKPOXIlyTpXV7ZujXdsmOf0CtgwHGYsdmE99wXcQA8CEYNFZPBoUAg7vr8>
X-ME-Proxy-Cause: dmFkZTFvVkWPdiE6nn+cl7P5xFBnKNzOXHNZ4eKj943n85xMEwwpwQBbZRt/UNf7hnM9sC
    uPVrP+UcbyvTpTEztDA8nAWIESxoAkKOJn2ZUxFSHZfDNcOaKpw6lXv6HRCZND1bjjgwdg
    Mh7qh5SeHPDlQIXJhO8R3txfGbQI4PC4ZB1pH8qfRIdGu7t4AnBmaOA3cwb7EPXDSJZH//
    2UbY+9RQfSl8M2+YPxgK2SBGR6qPQcEBVIJZQzobCDMnvCV15N3RS/fnKB+ImKobBaBcwr
    /KDXrG+CP3YzyTcVqEkrW2Zjxmph7hjAwlZ5ISpjHPjUSP+bSzaZssoh57/wWBy4TtPyb0
    E6Gtr2A0MIa1J3TL13qUq+zoe6JkAr31tjyMopwDNEv0HaIP+F3UkvFZqe7E4K/cX2PyQi
    +5MCo80HgBA8RrMuBeeZdfMC2/mFf3GemrCRyYvSyYaiCZ1hSMSDH6dlhLwWLqFbiv3yc1
    D/flkOqxPKDQqsxLZcnclm1g0SA3qf0srOiwZ2vEq7lzNouX8SFMJX/PgG/f/fachrYBxJ
    GMulnfDi8pZBMoXacB9xJuk7xLTQuO6g6VCOBsk5mCENCBLd0bPKAjbm08V8Z1HCHG/Evh
    7ovh0bsU6pAJuSz39Z9Lh3p4m4TJO7KVcHdvq+dh27RZ0QC15glzoQaInEQQ
X-ME-Proxy: <xmx:Xga7alHC6wiE1qxT-5ZLMS1ZhggIpQmz8NPe7F_i08-J7bxUdMa-qg>
    <xmx:Xga7anNXwIQKghtfFGouJI-WOQUmkfIt4qsjN-RxaAp9GRRLhvsukA>
    <xmx:Xga7am5DB7rlFGxEfNSswi0iS4c_rBev5ZkmsbaZXbVeqNwtbf6DEg>
    <xmx:Xga7aqi5lMrGuuebwzVX1hjvE4OnKBiUCfZ201p_4rX8alsxHJZ1Xw>
    <xmx:Xga7agiLYn8KZOorJtkB-hnlpYntVr6boXcuyH2DglKYdhdp5k50Slcv>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 20:29:15 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Stan Johnson <userm57@yahoo.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <f4cb43726ee6f1cf159a6208f77b4cceea670a3c.1790641175.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1790641175.git.fthain@linux-m68k.org>
References: <cover.1790641175.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 3/3] swim3: Fix FDEJECT ioctl for exclusive open
Date: Tue, 29 Sep 2026 10:19:35 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The eject command from the util-linux package does not work with the
swim3 driver: the drive doesn't eject anything and the command fails.
Apparently, ioctl(fd, FDEJECT) returns -EBUSY after fd was opened O_EXCL.
Fix this by checking ref_count for either 1 or -1. Either value means that
the caller is the sole user of the disk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Simplify by removing 'err' temporary variable.
---
 drivers/block/swim3.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 01f7aef3fcfb..b55cfe485beb 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -887,7 +887,6 @@ static int floppy_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 			unsigned int cmd, unsigned long param)
 {
 	struct floppy_state *fs = bdev->bd_disk->private_data;
-	int err;
 		
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -898,10 +897,9 @@ static int floppy_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch (cmd) {
 	case FDEJECT:
-		if (fs->ref_count != 1)
-			return -EBUSY;
-		err = fd_eject(fs);
-		return err;
+		if (fs->ref_count == -1 || fs->ref_count == 1)
+			return fd_eject(fs);
+		return -EBUSY;
 	case FDGETPRM:
 	        if (copy_to_user((void __user *) param, &floppy_type,
 				 sizeof(struct floppy_struct)))
