Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45F83E4C88
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789899130; cv=none; b=MVFPjkFu77cZP4oKDM7rbsTpDBzShj03/T5ymB6P2soSlOaxETX7xigYUzWk3iln5O66EOo2BG71Ul3V3w71GxWOPowS+0NaIQbHG16QzVPZsAJbnLmgxrnPVmDE3y67i4xlg6IILlIpHfv1dWWy4H36USYnNemyCGkVxUa+Z/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789899130; c=relaxed/simple;
	bh=hV/Dv+J6xToFeRB9UYu4UCSInN3o/IE5FfTxqpVRGC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UVsVLnFO9ff7Q9oSj7zFezgiwt2BVeJUm3DWh4k3rVLnY+lTSRBKtKVdDUxC4a4sXhhrI8tYeK7oR7728V6fEn6jmgkR4GuEmJrtuoAF7I5jMdcTGoKavFdAl5AiW4CTUl3FHwSHpPiY2ONK7+QXneDem+T2P4maMQBBt9981ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pFmfOrAK; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pFmfOrAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NS
	WeqbZV2HrNHo30qS4ZtsCIu1ggOiev/NymXiVQvUY=; b=pFmfOrAKBpxBEqjOVw
	LigMY72hXijnD0BECAh+3rCsaJYXWrFleLVn0gdrTWM1uYu87gUH3qioJZgUHZLJ
	u1XSnkI81O3ENs2Uk9pozxUcS1lVLBjWWOnkjSMIB4sgrojYHUyAHtVSHFT6KaqN
	0x2ypkCeXr0QX0CSGrEqTWYrQ=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3dchgsa9qvH+FAQ--.48876S2;
	Sun, 20 Sep 2026 18:11:45 +0800 (CST)
From: huhai <15815827059@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	shikemeng@huaweicloud.com,
	Henry Hu <huhai@kylinos.cn>
Subject: [PATCH 0/2] blk-mq: fix dispatch waiter accounting for reserved tags
Date: Sun, 20 Sep 2026 18:11:30 +0800
Message-Id: <cover.1789890726.git.huhai@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3dchgsa9qvH+FAQ--.48876S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWfAw4kKr1fXry7Cr13twb_yoWftrc_WF
	yjyFy0qan7WFZ3WFy2gr1jqry5Xw45J3W8CF48JrZ7tr1xJ3y5Kr4rCFWUur47u3y7CFy5
	tr1jqw4xAr1xZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1MUDtUUUUU==
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbCzgELkGqvsWEQ8QAA3g

From: Henry Hu <huhai@kylinos.cn>

blk_mq_mark_tag_wait() may queue hctx->dispatch_wait on breserved_tags
and increment that queue's ws_active. The wakeup path always decrements
bitmap_tags.ws_active, though. So the reserved counter stays elevated
and the regular counter can be decremented without a matching
increment, which may cause later wakeups to be skipped.

This is reachable and commit 98b99e9412d0 made the waiter side pick the
right queue but left the wakeup side hardcoded to bitmap_tags.

Henry Hu (2):
  sbitmap: add __sbitmap_add_wait_queue()
  blk-mq: fix dispatch waiter accounting for reserved tags

 block/blk-mq.c          | 33 +++++++++++++--------------------
 include/linux/blk-mq.h  |  2 +-
 include/linux/sbitmap.h |  9 ++++++++-
 lib/sbitmap.c           | 23 +++++++++++++++++++----
 4 files changed, 41 insertions(+), 26 deletions(-)


base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
-- 
2.40.1

