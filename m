Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396D13D521
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417287; cv=none; b=EOQhzalhkil2r/jEpoLXaETpIFePn/80wz+agADevsNGLEAPvcz10fNByahG0Rhnmv0NdokaM4MfZoFf7iB0QQ4VLBUzbRjUna/9aHSdBbWiYFce8ij/FGxSjZq89EwMSLYmxytQBlY0pQc2pbKRjVwusiffqVa3GqyVo6+M4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417287; c=relaxed/simple;
	bh=a46v+ZxmElHQ+FmSqZEzEs/QVv/BKz0Z3fesl9WQUAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLDkvnChxslPyczb7V9Wq6o+rKkTgydiWhQ5uugQmDDobs3AoZXOy1xssJNQ1h54N6K4iE5sJZxNVMnyqpMW/X2WIvu7h2VaGAMXnmplYatv85tp2eWa6I3Sjw+YCefZ/3oKLKt1p5Wj2kiHaTd1DOyCqCXXvlXwVNjPT+a+aVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATlerhei; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATlerhei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPlsPigIQj4ybCwjHgXfE7i3v/fl37e4fq53q7QB4oc=;
	b=ATlerheiTpHIaKbdFpgKqQv1i+mGG/v5XjAAGy32Q6LePfVw3L/IKCa/u3aBtlc7xtkDUD
	WV2xI2NZqxh72g7EaKHtO3Pm7ZInKLCJiE4JfAffMyrI8MLxvwg1FhM0uyoduUWuqY+iWg
	eHFUCHHlTJgAeiwUGajF/wsrIq34OAU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-SSaNGN9mO--AqFe4hwCK7g-1; Sun,
 13 Jul 2025 10:34:40 -0400
X-MC-Unique: SSaNGN9mO--AqFe4hwCK7g-1
X-Mimecast-MFC-AGG-ID: SSaNGN9mO--AqFe4hwCK7g_1752417279
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F1151956094;
	Sun, 13 Jul 2025 14:34:39 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 032A3180035E;
	Sun, 13 Jul 2025 14:34:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 04/17] ublk: let ublk_fill_io_cmd() cover more things
Date: Sun, 13 Jul 2025 22:33:59 +0800
Message-ID: <20250713143415.2857561-5-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Let ublk_fill_io_cmd() clear UBLK_IO_FLAG_OWNED_BY_SRV too.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 73c6c8d3b117..f251517baea3 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2014,6 +2014,8 @@ static inline void ublk_fill_io_cmd(struct ublk_io *io,
 {
 	io->cmd = cmd;
 	io->flags |= UBLK_IO_FLAG_ACTIVE;
+	/* now this cmd slot is owned by ublk driver */
+	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
 	io->addr = buf_addr;
 }
 
@@ -2229,9 +2231,6 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	}
 
 	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-
-	/* now this cmd slot is owned by ublk driver */
-	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
 	io->res = ub_cmd->result;
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
@@ -2353,7 +2352,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		 */
 		req = io->req;
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
-- 
2.47.0

