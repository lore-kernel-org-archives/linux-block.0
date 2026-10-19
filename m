Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D4490BFC
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399382; cv=none; b=ieMP3B7ZHI1VUqCRFVcaq41Rp9kiaCXLNO9FIXrO7t3OUdRIxSvDM+hKgTLviFucpwPd/qDG1moIbjZ2AWjKDfnmT3ksaQurSnMJTHxkcHvfzOkVZd9gUTnISBfUW0YaJHAZf4/uz+lvkRcnhQ8Ob9JzeOeQwUrka9E9Qlsntsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399382; c=relaxed/simple;
	bh=/eSaq17ziiJZlDcmi2BZUV2YyIProXsI46Any0K0g9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUc6DCsJs3yeO6uD70fdie2qGNtptWlzQrobxVjNLNU7AEZlk8e7GvtTZGBKAmr+KqgNS3DVjgfiV2YDsbNab3oa3jGG7IIoBQtVEYIquKM7+9gRzbqwFvZJ+uD03BsHiCkvB2pXguRjJDlFn7DQeDr6lAqOmngoiiw/ohz6U8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=szZDz116; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="szZDz116"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/eSaq17ziiJZlDcmi2BZUV2YyIProXsI46Any0K0g9E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792399378; v=1; x=1793004178;
 b=szZDz116kLIW5PTeUPsGrzT/XwzBlonRY2FK0BD7jn2gJXzmuMC8NNnfRcacnUYvFucyNlsL
 FfYKVdwHKWiGii2t8X4SWR/beNl5AYQ5O63Fls8EUk9jIRz0VRIUEtYPxwK40d4oaJXbd1icTov
 5ve1euF3fr1q3BEv9YjhjSbw=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fd0ba17bda9f288f;
	Mon, 19 Oct 2026 08:42:58 +0000
X-Mizu-Trace-ID: fd0ba17bda9f288f
X-Migadu-Flow: FLOW_OUT
From: Jackie Liu <liu.yun@linux.dev>
To: josef@toxicpanda.com
Cc: axboe@kernel.dk,
	shuah@kernel.org,
	tom.leiming@gmail.com,
	yukuai@fygo.io,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/4] nbd: recheck multi-connection support on startup
Date: Mon, 19 Oct 2026 16:42:26 +0800
Message-ID: <17ecfc5a704d73de68cbe09c4f287157170bdbaa.1792399225.git.liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792399225.git.liuyun01@kylinos.cn>
References: <cover.1792399225.git.liuyun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackie Liu <liuyun01@kylinos.cn>

nbd_start_device() checks NBD_FLAG_CAN_MULTI_CONN before dropping
config_lock to update the hardware queue count. A concurrent
NBD_SET_SOCK can add a connection during that window, and NBD_SET_FLAGS
can clear the flag without changing the connection count.

The queue-count retry only notices changes to num_connections and does
not repeat the flag check. Startup can therefore create multiple receive
workers even though the server no longer advertises multi-connection
support.

Recheck the current connection count and flags after reacquiring
config_lock, before retrying the queue update or starting the device.
Return -EINVAL if multiple connections are no longer supported.

Fixes: 8b428f42f3ed ("nbd: fix lockdep deadlock warning")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/block/nbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e8e8517fb6c7..9987c56758ec 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1533,6 +1533,9 @@ static int nbd_start_device(struct nbd_device *nbd)
 	/* The device may have been started or reconfigured while unlocked. */
 	if (nbd->pid)
 		return -EBUSY;
+	if (config->num_connections > 1 &&
+	    !(config->flags & NBD_FLAG_CAN_MULTI_CONN))
+		return -EINVAL;
 
 	/* if another code path updated nr_hw_queues, retry until succeed */
 	if (num_connections != config->num_connections) {
