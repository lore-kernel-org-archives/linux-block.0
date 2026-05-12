Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B120ED
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613564; cv=none; b=Mqgrd/8QKj0Xu5HewCLqUAh6M4hDeO/1618t5aCy4TdoIqZ8YeY7d4RTFCqoWMxVcGKfiNoy3HlU/VruJmHHoOv1m57OOfvTjMvMA1QWa8sXpRPcGpqwch3bc2CJJGQOhc4nX23RI1eTyelwf1Ie2XmXcxurcI4udDnohfEM0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613564; c=relaxed/simple;
	bh=/eUDJvjQhZtT13F9tJCelPzu1NYf4870S7CnTAPRx8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN7W5T9Zl1LS7x7naB8c3gKUPIdvf9aAQXnFt1DsI1pX/ty5VXQRf723tpjG36rIa/0BoQZuup050OvyfX6TC0lbu630VQ92aukA8zfDkObtXynnsaZZ3zXfdK9su2b+8O7VcPetgN5OdPY2e+7QjGq/Xb06tOMqQFRpXhU/D9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMtW5qaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMtW5qaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778613561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJnrhMDIuFKyFLPOH6R3UHD7NYRAy5Ebrou3hhWC828=;
	b=MMtW5qaAZbEUomOr8WZPmK8/PHqAwW8Mf/5AvAsCLOpaVRc1mm1FdY6YuZzehOlR6ipvWd
	pVlzSbyL0uqWXX9lASYknGHcjCxN3FJZf2wS42chVvkkghE2F9/Fut3SQQpngCz3yDr7/D
	9E5ZFyX/GYkJtELdzLpI0CM72aaCQas=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-Su3mhEboNFeuKKE1E3gSng-1; Tue,
 12 May 2026 15:19:20 -0400
X-MC-Unique: Su3mhEboNFeuKKE1E3gSng-1
X-Mimecast-MFC-AGG-ID: Su3mhEboNFeuKKE1E3gSng_1778613559
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 885C7195D011
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 19:18:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.2.16.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 304FB1955D84;
	Tue, 12 May 2026 19:18:53 +0000 (UTC)
Received: from fedora.redhat.com (localhost [127.0.0.1])
	by fedora.redhat.com (Postfix) with ESMTPS id DBAF11B5238;
	Tue, 12 May 2026 15:18:51 -0400 (EDT)
Received: (from sanasharma@localhost)
	by fedora.redhat.com (8.18.1/8.18.1/Submit) id 64CJIpH0045367;
	Tue, 12 May 2026 15:18:51 -0400
From: Sana Sharma <sansshar@redhat.com>
To: stefanha@redhat.com
Cc: afaria@redhat.com, linux-block@vger.kernel.org,
        Sana Sharma <sansshar@redhat.com>
Subject: [RFC PATCH v2] virtio_blk: add fua write support
Date: Tue, 12 May 2026 15:18:09 -0400
Message-ID: <20260512191808.45334-2-sansshar@redhat.com>
In-Reply-To: <20250508203313.GA63568@fedora>
References: <20250508203313.GA63568@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Continuing the work of Alberto Faria <afaria@redhat.com>
this patch addresses the remaining feedback regarding removing
VIRTIO_BLK_F_OUT_FUA from features_legacy[]

Link: https://lore.kernel.org/linux-block/20250508001951.421467-1-afaria@redhat.com/
Originally-by: Alberto Faria <afaria@redhat.com>
Signed-off-by: Alberto Faria <afaria@redhat.com>
Signed-off-by: Sana Sharma <sansshar@redhat.com>


---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5a6aa3dfb18a..aee2d503d6ef 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1665,7 +1665,7 @@ static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_OUT_FUA,
+	VIRTIO_BLK_F_SECURE_ERASE,
 }
 ;
 static unsigned int features[] = {
-- 
2.54.0

