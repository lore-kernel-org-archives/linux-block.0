Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7F312E5D
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796124; cv=none; b=YbBNCeJOiCu7nN+QY+lYSxSlsd0XY7fFFyh+kiG8LTU5+ewSf9r/1RZ6FuHVRXhQnWc2vIcp9tA0C+7oBxQZ3r8yVyvVQL2DYs4YmaUdSztIryvcmJgwW+5D4AbduYEgwE6w2BcjQAyUBIay2kzkYusgth+FEj0PHaZbqiNJdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796124; c=relaxed/simple;
	bh=DC9HFAWkuPXvmgnIogRFBCr/UCpTKlEECiNDWxlhvr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnZhYr28kuS0MEObWGZbcT1d/brlZ7R2bWainOoCwKVtpHwgQhSvTciZXFUBIWiibhhnpzQHQ/jgipag/a8/ug9X5x+pcKiBynFCd9g2y188Hu7I7TIZbAHBQq3cvumZDyuWeodbpIUZEfTA8ubfb9l+Rgtq80pippWcjEMwnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOWmHTPz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOWmHTPz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747796121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsjTUo6xlVd3ACxrDgFuhjRMww4G2lq3aRsZ/YyrsUo=;
	b=YOWmHTPzkSkh/I4D23d5XRWcCfxEqdGGzD+u0gV1VO3nLRELwBgDBDV9gWDY4ac1RhE2ZH
	zh+7WyyIZVd43GYpdsDxFWdgSzJ2cXSoTbJoaJArSex96ku5502nNjuWYGGekIJNNZkmVJ
	fuYnhL1saqrgRAyDmOu5VzMhhKBf6+0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-fzFqNWKEPQ2Rvw0WcoqlkA-1; Tue,
 20 May 2025 22:55:18 -0400
X-MC-Unique: fzFqNWKEPQ2Rvw0WcoqlkA-1
X-Mimecast-MFC-AGG-ID: fzFqNWKEPQ2Rvw0WcoqlkA_1747796117
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 445011956088;
	Wed, 21 May 2025 02:55:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.109])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29D5619560AD;
	Wed, 21 May 2025 02:55:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] ublk: handle ublk_set_auto_buf_reg() failure correctly in ublk_fetch()
Date: Wed, 21 May 2025 10:54:59 +0800
Message-ID: <20250521025502.71041-2-ming.lei@redhat.com>
In-Reply-To: <20250521025502.71041-1-ming.lei@redhat.com>
References: <20250521025502.71041-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If ublk_set_auto_buf_reg() fails, we need to unlock and return,
otherwise `ub->mutex` is leaked.

Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG")
Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 69230f4575d4..fcf568b89370 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2075,7 +2075,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	if (ublk_support_auto_buf_reg(ubq)) {
 		ret = ublk_set_auto_buf_reg(cmd);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ublk_fill_io_cmd(io, cmd, buf_addr);
-- 
2.47.0

