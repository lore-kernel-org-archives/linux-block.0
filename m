Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F17083C
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817178; cv=none; b=az1TH9XsXfkDZ2m7pfUKR97WA+3w1UnWErZxZY1kv7E1tHm3/Ypj+5c2KEHDPj0Mu3mRZ2dzij2A96RzXWCfSDbhx1AHVLzUw1h7mlprwAMihBKjm5oRmilCUmfFIAiEpBxnYdwOjAECdNj20YyeOfcdCPnBQXzKyNNjwvoC1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817178; c=relaxed/simple;
	bh=ckyVHnpaCu939Ku9MwRaGTj83ahW4Y59xvAgQDxB9ew=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=TfE63fy/RSI6/PR7ce3g3Ly+pj2SUdo/qM4WXbnKegzhcmtwb+ztFvaFf4W/fWtcMsSambxu0jY8AnOwZvQu9fTzRW6nyl+Ozxe+2bDFGtxMiwQTVoof75Dm/RF9kNpArQDtHgP/BkgsnO8y23CWgN9qvScPGeIMps15mxwYI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VbHWWOSa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VbHWWOSa"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782817174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WA2/ZzkCMn0aZhT1CXuvA5miIuRDxo17ehSDD0+sWZE=;
	b=VbHWWOSawz/lS65HcThTFZpu1xYPjfFbWZ0+11J8ffN7aZo+g/Z3l+OLoQkjOrxNLZ4cVi
	d8zKaAZ1r/PpZ5Acu6QNMp1m+dW6hS+ON+3OEPSTjUGP+lhKGvy9HXmNqWLo6mQAB6CiF1
	JxH6VeYipWwQFjjJ8mVM9va9fJsv4tU=
Date: Tue, 30 Jun 2026 10:59:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <d4924afb559896a4a22258f14e4a97c8d12d8527@linux.dev>
TLS-Required: No
Subject: [PATCH] drbd: reject oversized DataReply before signed conversion
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk
X-Migadu-Flow: FLOW_OUT

From: Tianchu Chen <flynnnchen@tencent.com>

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Reject DataReply payload lengths that cannot fit in recv_dless_read()'s
signed size argument so a bogus remote peer cannot wrap the length negati=
ve
and turn it into a huge heap OOB-write.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
index 58b95bf4b..5bd3df483 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -24,6 +24,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/slab.h>
+#include <linux/limits.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/sched/signal.h>
 #include <linux/pkt_sched.h>
@@ -1947,6 +1948,9 @@ static int receive_DataReply(struct drbd_connection=
 *connection, struct packet_i
 	if (unlikely(!req))
 		return -EIO;
=20
+=09if (pi->size > INT_MAX)
+		return -EINVAL;
+
 	err =3D recv_dless_read(peer_device, req, sector, pi->size);
 	if (!err)
 		req_mod(req, DATA_RECEIVED, peer_device);
--=20
2.51.0
