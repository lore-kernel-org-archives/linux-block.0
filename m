Received: from mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095743C7A8
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975856; cv=none; b=JCLpaKVzVVXxxXQKZFnTfer7mFOnTpmVv6T1FRmn0ICzfudtHsuIcshaC16eajmZOI4Y1t+uA25noZoXrg+SJDtBcJL7xtGRt70dkMywTcXZHIC9wgFMddL7Dp+4eQ9YVnOzI4MJFnyNCyFKMjz36F3SIWs521qkL2tXwfajxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975856; c=relaxed/simple;
	bh=WC6FwVcdTcvnbXOAaaKr7EIZTaS1+kvj6D3uYnj1BAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6zpfy4c8BNDCUFGh2EPAC8kFF45m1M5Y3IW4N9siyAOT8c/CrErj0NLWwx9vKnQJwXsMQ25XqtnR9UJM8oPPgR2NBDApVcf8dcYg/VkNPSL063JT3I7voKr2JZe1jhFMGDiT7WXecgNhrasHNwHB+CjKTmPyUW7o4v9p3YCMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HTSsQI6B; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HTSsQI6B"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WC6FwVcdTcvnbXOAaaKr7EIZTaS1+kvj6D3uYnj1BAQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786975852; v=1; x=1787580652;
 b=HTSsQI6BhGk1n2cZ4D8Fdn+HOIH7VTdhaHV2MJMLSMyCp6ksFFZ/xkhGh2cvJlgDp4tpwqRO
 +rwoFGkskABJfcKrr4OVX5uv3TspbR/KysS5ssNRPgwb/YWAkXRvn/jDcKl7WE9asiFsCXG7jYZ
 ijeO+uzB6vm0EptYSRPhfHQc=
X-Envelope-To: linux-block@vger.kernel.org
Received: from ctao-book.. (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 839f979253890219;
	Mon, 17 Aug 2026 14:10:42 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@lst.de,
	yukuai@kernel.org,
	linux-block@vger.kernel.org
Cc: nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	mchristi@redhat.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] nbd: clamp the timeout before converting it to jiffies
Date: Mon, 17 Aug 2026 22:10:27 +0800
Message-ID: <20260817141027.48423-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

nbd_set_cmd_timeout() stores timeout * HZ into tag_set.timeout, an
unsigned int, and passes the same product to blk_queue_rq_timeout()
without any range check.  A large timeout (2^32 seconds, say)
truncates to 0 instead of being a very long timeout.

Clamp the timeout to UINT_MAX / HZ seconds first.

Setting NBD_SET_TIMEOUT to 2^32 left the debugfs timeout at 0 before
this change and at 4294967000 after it.

Fixes: 55313e92bd17 ("nbd: add set cmd timeout helper")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/block/nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8f10762e90ef..1874c1a81d3a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1619,6 +1619,10 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
 
 static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
 {
+	/* clamp so that timeout * HZ fits in an unsigned int */
+	if (timeout > UINT_MAX / HZ)
+		timeout = UINT_MAX / HZ;
+
 	nbd->tag_set.timeout = timeout * HZ;
 	if (timeout)
 		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
-- 
2.43.0

