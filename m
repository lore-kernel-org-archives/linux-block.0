Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9391D88DB
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039023; cv=none; b=cObtOBwt5H4EiGyCtLyhIJiEoT7mV9s4qmr9i/8z7fQ5wg9VfFfj7RQcKWfobLuAQqZbPPd1IB0frj97J7/kZaxr6hTuBGS9nNCgDTUz0lyoCC8XYZpx3VgLtxwnjJ+UzwF/6SQq4E3fUiH8njuBmEnL4yyXZEsPacbDJiz+1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039023; c=relaxed/simple;
	bh=snfjKqTkVL/uV2W+5SHWqXllQb/4JX4TZ3Gn3FXE9VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG2+Ikwd+O9sEs3wS3avfNwADLtSpX7vnrHTWoFR37V5MQOJANqmSiNwmSARSDiTudxcptmDFDP1V42uV6iwt8P13mgJG3DnJwo8MkU4cGrxX/H/3XAE97vQgzaWjCJXNV1JqGm6mJCsd7uy8OARm7X1i/8nFFCBCHScX7rnSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2Wd0hB/q; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2Wd0hB/q"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y8QcB6bqtz6ClGyn;
	Thu, 12 Dec 2024 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734039016; x=1736631017; bh=LhUdU
	zi9MVWlR2pqU3gyxaVU3lJSD0lL003i+aKkYhI=; b=2Wd0hB/qHVY/1ZZg3wSmH
	3f4ejIDDCWNiFxbkAqRusW5xw8JbtWkP5WhXkxQFVUQOgiQUnfwvtCGoudAYDWtD
	CN+CwnR96JIQgP0L0oXokIsLjIY5ZvQ4hPO6OcmMQbIub5ku7ieHqs6xI8Rx85GW
	Nm2QcOF/umQBMBGKyphG7SMEkENfyZfE6yoizGR7WVR0N7WWJJgyu1L2gnw/1NWa
	7Sz8Vsvro4pycCRXTeD72+zO/A/uC4WD+0/a70lX6PHKVXQy4jtIVydUo6oE4P+J
	qYDnknrZ1d7RcA7T6PhGPUpw/N2zvS+ap7AdcmGQzSnu+/HZZACXPBgw/fv/CBwt
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vYfL6r6ilI91; Thu, 12 Dec 2024 21:30:16 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y8Qc62lhrz6CmQtD;
	Thu, 12 Dec 2024 21:30:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] block: Fix queue_iostats_passthrough_show()
Date: Thu, 12 Dec 2024 13:29:41 -0800
Message-ID: <20241212212941.1268662-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241212212941.1268662-1-bvanassche@acm.org>
References: <20241212212941.1268662-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make queue_iostats_passthrough_show() report 0/1 in sysfs instead of 0/4.

This patch fixes the following sparse warning:
block/blk-sysfs.c:266:31: warning: incorrect type in argument 1 (differen=
t base types)
block/blk-sysfs.c:266:31:    expected unsigned long var
block/blk-sysfs.c:266:31:    got restricted blk_flags_t

Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 110234da18ab ("block: enable passthrough command statistics")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4241aea84161..767598e719ab 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -263,7 +263,7 @@ static ssize_t queue_nr_zones_show(struct gendisk *di=
sk, char *page)
=20
 static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char=
 *page)
 {
-	return queue_var_show(blk_queue_passthrough_stat(disk->queue), page);
+	return queue_var_show(!!blk_queue_passthrough_stat(disk->queue), page);
 }
=20
 static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
