Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E874EC67D
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557560; cv=none; b=Wk6K2TKjKbQvJ5Az+XsXun9kHwf5/TplOTMgqa8zy3YsG69KREXi4y0mNSuCDqlB7BcFxysm8Uj9INyeuc8YBDbE25zAG+1SAf1qYD1ROX+0FlTpMXxtwEQ1c2ZZtdn0ujK4acPDnXOiKmh/pROqMmQne5OFw59VVjYnb32Awto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557560; c=relaxed/simple;
	bh=KKn5izan883dGbl7DMnimzffLyvDSXzrlsfCzE77wDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URkSh1B2802XWuGbfYt5stqa40SiBEOwiiv1sEBfByXcc6ZyJVQW+xxVKlxE0HHRms1xIDEOkL3BOJN1u+fek5ZeIYRCrNwxweFZySVzzx92K343/tcPuS8Bq+YzLE4dOJkDRCwZQAwcT2/Keh+EcPJ9K3OI5IhItkpuC9962WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwdlTg5V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwdlTg5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789557545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qQz5T8Z7ouIU24J1UJLrLn+beSJZ7Hd9SwiUiHh25fI=;
	b=bwdlTg5VeKvbQ4fF3E0lX7gTNw5H9Of/5xINDeAJjPEoB7SiKABFZhhnQaqq/Td9Uhnz0D
	W72UTuyspNmitjeo2dMr7Sx3FtjJyO7oFep6+NsR3LFnnilDU03pMtGwn5yqk41BATaeqR
	foxeU8/4hwYD2ELuS73MVEF/v1EIPxE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-ZIDcAgp6PtmBiePkrjKCvg-1; Wed,
 16 Sep 2026 07:19:03 -0400
X-MC-Unique: ZIDcAgp6PtmBiePkrjKCvg-1
X-Mimecast-MFC-AGG-ID: ZIDcAgp6PtmBiePkrjKCvg_1789557542
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0768D1953994;
	Wed, 16 Sep 2026 11:19:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73F15418;
	Wed, 16 Sep 2026 11:18:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Fengnan Chang <changfengnan@bytedance.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix kerneldoc of bio_copy_kern()
Date: Wed, 16 Sep 2026 13:18:58 +0200
Message-ID: <20260916111858.661575-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The "op" parameter has been removed a while ago, so now there is this
warning when running "make htmldocs":

 WARNING: .../linux/block/blk-map.c:366 Excess function parameter 'op'
  description in 'bio_copy_kern'

Remove it to silence the warning.

Fixes: 05ce4c584cc6b ("block: use bio_alloc_bioset for passthru IO by default")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/blk-map.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9cb9605d1f62d..35212355b8cda 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -356,7 +356,6 @@ static void bio_copy_kern_endio_read(struct bio *bio)
  *	@rq: request to fill
  *	@data: pointer to buffer to copy
  *	@len: length in bytes
- *	@op: bio/request operation
  *	@gfp_mask: allocation flags for bio and page allocation
  *
  *	copy the kernel address into a bio suitable for io to a block
-- 
2.55.0

