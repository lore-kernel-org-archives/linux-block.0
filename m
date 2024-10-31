Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCB19CD1D
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381866; cv=none; b=QksSeAngtp0AEmXoxvffYjs+qnP//hvihQitg4mYnuNy98QkOGFbQlKM08TmanvK1YOee7Kz8wKhsZm0bFGzJG/4cuWf64dynAwXhUoh/u1Ne7tE3VMpX/zrK1bvWyqfP+5rt8tRuDJBMkXv55hN0LDOiwSYe+jXftsQDPlNnIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381866; c=relaxed/simple;
	bh=/CQLOeOX7Yxb7fu+TRpioy3MlE9WQB5HYl04xteojpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JudIEYxXl3bujoAxOICvCSRXUXLk69TV0DIv3BSz7azAeHPd1teGwtlTbaMH2VcPeIVgm1+uXAkN+FJmIHsaSuTadTTdPpaHfgmXLMN2WwA29CZYo9nuH5sbxT+SlEhqd4XLPdSYeN1SMnJaja0AekMwB+OptQLmPMMNUDd/IcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBKH1jsL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBKH1jsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730381864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTWGXpFitux/EZ1K2MgYezwe7vB3Ge44iejd4Oayvbo=;
	b=HBKH1jsL/YwtGZrAYwlIRveGLrSlgW0x8gjcgSb3gva+IlhMwkluEP0pP7ZcFKkKwREJCK
	E+vE2061Fi9j/LtxIyfGsi8EIwhGakWjomwXCq65VsPySryrVQ6za297spZr8XjSbkch2I
	uyUR0yNJgsF29BUIlt+kC8J+/PaexWs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-2IbC_PBiNwewjS-Uiv6tEw-1; Thu,
 31 Oct 2024 09:37:42 -0400
X-MC-Unique: 2IbC_PBiNwewjS-Uiv6tEw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFCEC19560BE;
	Thu, 31 Oct 2024 13:37:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 842BE1956052;
	Thu, 31 Oct 2024 13:37:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH V2 2/4] rbd: unfreeze queue after marking disk as dead
Date: Thu, 31 Oct 2024 21:37:18 +0800
Message-ID: <20241031133723.303835-3-ming.lei@redhat.com>
In-Reply-To: <20241031133723.303835-1-ming.lei@redhat.com>
References: <20241031133723.303835-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Unfreeze queue after returning from blk_mark_disk_dead(), this way at
least allows us to verify queue freeze correctly with lockdep.

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9c8b19a22c2a..ac421dbeeb11 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -7284,6 +7284,7 @@ static ssize_t do_rbd_remove(const char *buf, size_t count)
 		 */
 		blk_mq_freeze_queue(rbd_dev->disk->queue);
 		blk_mark_disk_dead(rbd_dev->disk);
+		blk_mq_unfreeze_queue(rbd_dev->disk->queue);
 	}
 
 	del_gendisk(rbd_dev->disk);
-- 
2.47.0

