Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181B26BD8D
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749233; cv=none; b=cUiLPu6VREeIn6ErhRg54+fMcf4M6SqWpKvVvMUO8iAu1X2VKqtc1wFtnc+UuZHp5aGzOLPRNc7mw1ccHPZxHj61JYoTNqh87ZHd/6Yc3CBCIJ2GxmMl5AXLu9fwrTnHsQ5g5tqGZIEgmt4GVYbs/nzFz/D19pX7LVDZ/3T16rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749233; c=relaxed/simple;
	bh=KPOB2AYJr5gna029vG1wufnazs6UV76ojYqm3oR89gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nB0gcsa/hfvl7Dnye3Hf90EjpAmBi1VDM04cXWuql5/yVq0SelZkobSYv2f9wsZhsgP8zUuXgtVN/xQPMpYFaVgLFlga1e2j9ce8zY6Bbyjx5qjeJJACO/MzzSVLrnqDOUfTRYVskvdEFY53mb0G1QxqrnBJLAR4gO7AgDH7tK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtdwBmnk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtdwBmnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740749230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C1XpkFS6LLQ0U/ZCpI92sCviJdXtSp72E4IF5B081d4=;
	b=AtdwBmnkfu0wgg5OgFsV3TYv7nNqb6Klqmqxil98komPEuCsFrW3JLlcWRpZ3UHjMPIH3x
	FEsKVutLYH66hOTtAzr6MJ7V3Nrtsgzqzg46T4VkYKgzj9QYZhIWPkxl3laTvHuKnD/kCX
	yvcSO30W7Ww1G0t2EUPK2Xo3wFwo710=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-KDzXFPrPPPyVNt2ZxhH49g-1; Fri,
 28 Feb 2025 08:27:06 -0500
X-MC-Unique: KDzXFPrPPPyVNt2ZxhH49g-1
X-Mimecast-MFC-AGG-ID: KDzXFPrPPPyVNt2ZxhH49g_1740749226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D70D8193585F;
	Fri, 28 Feb 2025 13:27:05 +0000 (UTC)
Received: from localhost (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F34A180094C;
	Fri, 28 Feb 2025 13:27:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH] block: fix 'kmem_cache of name 'bio-108' already exists'
Date: Fri, 28 Feb 2025 21:26:56 +0800
Message-ID: <20250228132656.2838008-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Device mapper bioset often has big bio_slab size, which can be more than
1000, then 8byte can't hold the slab name any more, cause the kmem_cache
allocation warning of 'kmem_cache of name 'bio-108' already exists'.

Fix the warning by extending bio_slab->name to 12 bytes, but fix output
of /proc/slabinfo

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index f0c416e5931d..6ac5983ba51e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -77,7 +77,7 @@ struct bio_slab {
 	struct kmem_cache *slab;
 	unsigned int slab_ref;
 	unsigned int slab_size;
-	char name[8];
+	char name[12];
 };
 static DEFINE_MUTEX(bio_slab_lock);
 static DEFINE_XARRAY(bio_slabs);
-- 
2.47.0

