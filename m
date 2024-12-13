Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D345188CC9
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075420; cv=none; b=VQsh4tkE/Ovli36UAOeLZkaeeJIhOhRs++gG1VZ8xpQoPOQ7pF3tmtdD3sd9FrVKbqKJz+McDaWwvgRd8nxLyoeOExv7x4O2cV8+i3Lk8dDQNzxv0tUPhSLmDHzJxbkq0YPfJaRv6IG3pMxZzBZl4cUvsN2YNu75E6iT0Q7PGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075420; c=relaxed/simple;
	bh=DpjGyW13gDLKMEkYmjPKA6xKzX3yn4Fjz4robHF1TVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghH+WbvZ5x5b8KdwsExT/wr69RqD38jchutei3c9TCtP7ShbyvRgIb66CIz+zYZIQdNXZlOSeVQlV22+HficMQAbnbOd5azD0KrnWVjh7i+sOX0lbRUcYviMr077HGkw/TGI0gg1Xer9dQn572MbQs02lzb2bNBba4U/Zj6Sclw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0zleH1q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0zleH1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734075416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6oQsBxusCFXcF5HPkI4dj5y7wKSTpylaP6yx6x99e2M=;
	b=b0zleH1qFU0OMoWTDeZDE8rzGrdw5cLbvUHhIr1ljCry8bZJeOExachhRYwmu8gigaUo7G
	JYlGIvgL2OS3GSyyIu5maJXR3EdghR7AKb1PISM2QfBi4Q0gbXSUiFFNw14rBTiJFtBhC+
	3aWbgEszOkAeZxhEoTqi8rdzC8bAuz0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-6NEerNsQP4KAi1FQ4QKhLQ-1; Fri,
 13 Dec 2024 02:36:55 -0500
X-MC-Unique: 6NEerNsQP4KAi1FQ4QKhLQ-1
X-Mimecast-MFC-AGG-ID: 6NEerNsQP4KAi1FQ4QKhLQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A67919560B1;
	Fri, 13 Dec 2024 07:36:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 145121955F41;
	Fri, 13 Dec 2024 07:36:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Zhang Yi <yi.zhang@redhat.com>
Subject: [PATCH] blktests: src/miniublk.c: fix segment fault when io_uring is disabled
Date: Fri, 13 Dec 2024 15:36:45 +0800
Message-ID: <20241213073645.2347787-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When io_uring is disabled, ublk_ctrl_init() will return NULL, so we
have to check the result.

Fixes segment fault reported from Yi.

Reported-by: Zhang Yi <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 src/miniublk.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/src/miniublk.c b/src/miniublk.c
index 73791fd..f98f850 100644
--- a/src/miniublk.c
+++ b/src/miniublk.c
@@ -1136,9 +1136,14 @@ static int ublk_stop_io_daemon(const struct ublk_dev *dev)
 static int __cmd_dev_del(int number, bool log)
 {
 	struct ublk_dev *dev;
-	int ret;
+	int ret = -ENODEV;
 
 	dev = ublk_ctrl_init();
+	if (!dev) {
+		ublk_err("del dev %d failed\n", number);
+		goto fail;
+	}
+
 	dev->dev_info.dev_id = number;
 
 	ret = ublk_ctrl_get_info(dev);
@@ -1208,8 +1213,14 @@ static int cmd_dev_del(int argc, char *argv[])
 
 static int __cmd_dev_list(int number, bool log)
 {
-	struct ublk_dev *dev = ublk_ctrl_init();
-	int ret;
+	struct ublk_dev *dev;
+	int ret = -ENODEV;
+
+	dev = ublk_ctrl_init();
+	if (!dev) {
+		ublk_err("list dev %d failed\n", number);
+		goto exit;
+	}
 
 	dev->dev_info.dev_id = number;
 
@@ -1223,7 +1234,7 @@ static int __cmd_dev_list(int number, bool log)
 	}
 
 	ublk_ctrl_deinit(dev);
-
+exit:
 	return ret;
 }
 
-- 
2.47.0

