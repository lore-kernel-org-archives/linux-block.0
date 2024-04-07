Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305717C9
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712459845; cv=none; b=XqZHxw84bJJREEn4ml7LnB67HiLf2t9FcSZpBgse9OYONf2rlONr68IHxDh8nTWSr5EOCalnfc7j0qkjh01Ww9XY4H/HKxnw/69GIlv7NigGIzv9eLXOx7BgJD45Cv6L44xXfQ4peGnHSUzbQYfDlaH1ieiOfDcENlG9m85Z4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712459845; c=relaxed/simple;
	bh=tAeQLjN5dd5JmIr/vYIUhaCJR4Vyfa97merTCqrtI4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l3xcOD9eej9gLzXYhvWml7ZftFP1PvD3li20ciLg6m6ir7H5NyWof/EQg9D4NIMuJjgAdqQfPyixKoTgL2wvm73XMQZsoM4UytxaYpKAo3JhYYrSO9FWVIblo2mUoUlyakE0YlQRUbe6LmmlRbaP0A8iwlkL0cBovaxmqZRSN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxJK4OVn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxJK4OVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712459843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=etZFhB5TopIYdY4s3aeiLtKNevD4lArmEoeCIn/eqvM=;
	b=TxJK4OVniIGl2FJMbaYJMyxN9+i4EJoEc3nJcDuSg37FpqBRmbEgM45ajg/NCNz14zl+wR
	GXCjsaYNkDgABgmjQ5VT3bg73E+3UGMTx3+2QgmBJkWJKZnXHYAi3MGu6lw4xOl2YaYWj2
	zWZbss3Hhu8qzNbDNXPYrjXEBgawwPA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-PfGKzCmeNwa8FHiifp0CyA-1; Sat,
 06 Apr 2024 23:17:20 -0400
X-MC-Unique: PfGKzCmeNwa8FHiifp0CyA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEB2C3C025C0;
	Sun,  7 Apr 2024 03:17:19 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 41DE341F355;
	Sun,  7 Apr 2024 03:17:17 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-block@vger.kernel.org
Cc: dwagner@suse.de,
	shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests 1/2] nvme/011: fix filename path
Date: Sun,  7 Apr 2024 11:17:08 +0800
Message-Id: <20240407031708.3945702-1-yi.zhang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Fixes: e55c4e0 ("nvme: don't assume namespace id")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/011 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/011 b/tests/nvme/011
index eee044c..4810459 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -29,7 +29,7 @@ test() {
 	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
-		--filename="$/dev/{ns}"
+		--filename="/dev/${ns}"
 
 	_nvme_disconnect_subsys
 
-- 
2.34.3

