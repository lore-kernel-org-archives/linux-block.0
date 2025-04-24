Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F231A9B5B
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508126; cv=none; b=WPLKavfgm41J97EFcvOlxUTqMoqVCn0whue88KN3WKpd2wo2OpJsQ8y5MxMvJ+/lDG2qZn/CpH34lIp7db2xZzzOVfu2VqZpXJew4jCV+gYiNx7Y0SHSd/6rHsY7akDPfJX3n3qbMCBM4uAyC50koj2qP2JnDS1HRLbbvAuB4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508126; c=relaxed/simple;
	bh=P9rqbG50jZIeBZ1E6a31LF+iStji9QUe4KY1J9b/kUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckBSbxvNdL9amZ97aHlOBOQ+lQ2GBzmH67WkjHjYNnZDK09Yd3qrLlLv+PpyfOiyDIpTW78oM13FhZtY0XszOXDIEdUNqCYG5IRkzLxi71KZciaxtNJ1zZ+KnAXwf5HnyjtqTCiMddw41wO8IvLyOdk5Kqh+kMiPsTTS1cPK0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGr94dQK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGr94dQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drobN6YlgzRmZMEbC9GvzCsY7PPzBvTqq4eP/L4uEig=;
	b=GGr94dQKHC6nVYP9jQTQ+VEbxiVDpMrJ1y5p22ZHW7gWJUq+eqOLOBBLIPw054LuLtX810
	mybxcX/Oiw/q6vvRsStgef6VxVAsEGgy240hGPG+6o4hJXbu+K7LKSnvGDrEsm4iZBGnA5
	KGdoD38R+6h7h6S6C04HKnNYnoZ+LqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-cS4gtEmXO5KrNFBhSo4DMg-1; Thu,
 24 Apr 2025 11:22:00 -0400
X-MC-Unique: cS4gtEmXO5KrNFBhSo4DMg-1
X-Mimecast-MFC-AGG-ID: cS4gtEmXO5KrNFBhSo4DMg_1745508119
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C751A180036F;
	Thu, 24 Apr 2025 15:21:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CD1D18001DA;
	Thu, 24 Apr 2025 15:21:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V3 01/20] block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
Date: Thu, 24 Apr 2025 23:21:24 +0800
Message-ID: <20250424152148.1066220-2-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue(), and publish
this request queue to tagset after everything is setup.

This way is safe because BLK_MQ_F_TAG_QUEUE_SHARED isn't used by
blk_mq_map_swqueue(), and this flag is mainly checked in fast IO code
path.

Prepare for removing ->elevator_lock from blk_mq_map_swqueue() which
is supposed to be called when elevator switch can't be done.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Closes: https://lore.kernel.org/linux-block/567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 554380bfd002..29cfc7ce2e0a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4581,8 +4581,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->nr_requests = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
-	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
+	blk_mq_add_queue_tag_set(set, q);
 	return 0;
 
 err_hctxs:
-- 
2.47.0

