Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A2DDAA
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784487; cv=none; b=dHiokf9TVe67Ya0PR/dnirhf9AOnzp80y3Lx8CeLIcsSoFZ9cw0Tg4HM+FwjfYa6FQrDqLBFFf03Q9fZf8JNuuRIFybGX95GsAArAQ/y4WeH2951ajENli7CwUeO240WK1e1dagvIoyIjPX3gQPZTnhcXE8chgmM0QWdI+BlT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784487; c=relaxed/simple;
	bh=nbLAzDN/pTxbliYc/lzPC7HJNvElZsPPqy6KUQPua10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyw3nCcXmLSWWhDKjSBDKNDNaRtw0nLlr2+LLfTp5PC74EVRqWRdrxUtdziHj9iHXb58P4Yo/bWPbdnjhCT62udK7yHImZGf4E9w/niUWy5LboR+PvjzLvHm9GoexTYFcI1TQB8LPSzfV/AmyT363wL1bbvGXDTW/N+X4tzwQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUs6dbOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUs6dbOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAE8C2BBFC;
	Mon, 27 May 2024 04:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716784487;
	bh=nbLAzDN/pTxbliYc/lzPC7HJNvElZsPPqy6KUQPua10=;
	h=From:To:Cc:Subject:Date:From;
	b=LUs6dbOdmzsvUlx6QoqoWU4C+CHv5ttOvpS4D8mGjtYdtDWPRiktp7EIY+6AV8Jtj
	 gXYzsnW1640FvSZSlI4D9MWADhNyHc+cnpw7b0fBDyK178yya+AWlnSOM9EKeX4I5D
	 UfpB9W40T7eFYkepe32Qr1RJ39SzxY5xXuVW8qWFbLAmDHXTTSFi3z8tPcXX7SXa51
	 XtI74aWov+wBdi0861FTTo1xu9gvf7BK8Bk8IOUNe6fJT+I/zDQaGPiZxd6Lg3I1+r
	 0kEc01fyVHb820a1z+MMowc+yy5lTz7U1dULZUPF+U/u6DtKLQOybYImc2LD3XDN5M
	 m0iR+59zTCEpA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH] null_blk: Fix return value of nullb_device_power_store()
Date: Mon, 27 May 2024 13:34:45 +0900
Message-ID: <20240527043445.235267-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When powering on a null_blk device that is not already on, the return
value ret that is initialized to be count is reused to check the return
value of null_add_dev(), leading to nullb_device_power_store() to return
null_add_dev() return value (0 on success) instead of "count".
So make sure to set ret to be equal to count when there are no errors.

Fixes: a2db328b0839 ("null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eb023d267369..631dca2e4e84 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -494,6 +494,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 		dev->power = newp;
+		ret = count;
 	} else if (dev->power && !newp) {
 		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
 			dev->power = newp;
-- 
2.45.1

