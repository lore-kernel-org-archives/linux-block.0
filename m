Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089B2777EA
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475158; cv=none; b=RB0CJrAsctbdEKOFc3oL1bNN6ufDHwnlTvl7nNe8z3jrIw4ocFazV0NIxPNSk3crlDYx2dZL3ZtXwrnS/F/gLJSj2t1JLIooFER02XL7pQBBGd+bQ1yMu+ZMDFyzetCAF8zoXy8XYVgXxBTxm/EploDqLQajs2N3udL4EqhdxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475158; c=relaxed/simple;
	bh=HLSTlPe7A6VuPNsoBy9as5REr6xZr6babdaUxICnObM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jq7JNGXa6xRqm2qGzhJ2jJvaRcwucEQzfD6ubDIKzsiKbYqEDKruvjntQZMKD4831rhMsTxgV7EuR/D1MyoAmn1QdKKnqZWxWcBbnPekGWwgfUdntX+MrNc6NccRs7jOoNH+YRQEfZRsb0lQ2ZzGmn/fJyLAybklgXeNruhVv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nvcTaIBm; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nvcTaIBm"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pD5RVhzlgyGn;
	Wed, 25 Mar 2026 21:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475153; x=1777067154; bh=1Kg2Y
	sjoGXuXvLzKhCom9V9Hac54CWBBOn5IETU+Gm4=; b=nvcTaIBmbHrzhAsH1ATmN
	bIfnOMStineGW3NekROTwSb+0t7IjSphjhuYl+4Aez590WyAjFprn9ptmxuM3Zse
	73xvyOvOh948xkr9Hq2Ml4xWH1CHTgYigQQNG5picSrpM3NHaREd2oWLGI5ZSl6y
	d8VjWnGsa8gu6VwkWfsyYe89mS7kGueF30Ty0ZERvf/BfaHcR0tsMRP4baC7a+SG
	J7FqXo7rzusboNraMv43bx6oo/6LG4C4lAsJvf49eASiLxAYU1Uuv/s1g7jhQahS
	Do4GdTb7xiVnVNRa5NFd+mO8PUZRB8eSrIxCI8hr0qh2reKkHFuGGGZjkHsq0ao2
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6UUQhy8PamKL; Wed, 25 Mar 2026 21:45:53 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0p81563zlgyGm;
	Wed, 25 Mar 2026 21:45:51 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 10/26] block/ioctl: Add lock context annotations
Date: Wed, 25 Mar 2026 14:44:51 -0700
Message-ID: <20260325214518.2854494-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a lock context annotation that is required for Clang's thread-safety
analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 0b04661ac809..784f2965f8bd 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -518,6 +518,7 @@ static int blkdev_pr_read_reservation(struct block_de=
vice *bdev,
=20
 static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 		unsigned long arg)
+	__cond_acquires(0, bdev->bd_holder_lock)
 {
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
