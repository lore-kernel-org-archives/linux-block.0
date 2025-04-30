Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3D1311AC
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987749; cv=none; b=eWdfRxzLs19m2WPqhsDcLm+r2Z8wG04njnIYruWq/xXPI/as556nkeZkt7cEQBJf0Wu7YmxJyIH0ypGVE96w9/oBRMQAHkxgAFYI4kJezs0Jj7zVh7kLT5aaJy1zkSsJlUn8fXQwsxbDMnK5uA8yXkcUyD0NNDbE40AB1FFnJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987749; c=relaxed/simple;
	bh=P9rqbG50jZIeBZ1E6a31LF+iStji9QUe4KY1J9b/kUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7hD73YYw3IRCpUTgceY/Zy9eK1yymku9jzjmWDmQWRQJaT5Ei/+BDGamwTSMoeRMZ94R1jkTXH9f2u0XJdhuUe1VaJf0IXdF/1L3re3oCB6yUVMQLxvcNwrj6oZIYKWBiM74PAWn+NMBS/KdLo6GqymOm9CIAYTpUxwu4u+2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEq/1BAH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEq/1BAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drobN6YlgzRmZMEbC9GvzCsY7PPzBvTqq4eP/L4uEig=;
	b=cEq/1BAHgg5kBMp2FRQ/SbKeApKr1SUTKcmJmBD4Xb2H2X5li9RdiCD2Q0K2/QsNs4cwf1
	c3MuzESMDVuxSb/4fS7svIhYhB/Bec3fWFRPuHcM5qXNO436skYOepGz0rOcZQo2Zj9kQT
	97lev4CjoBrJ7bqLxEY6kswSgoPj164=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-eS1whNdfMt6VHdzppTSavw-1; Wed,
 30 Apr 2025 00:35:42 -0400
X-MC-Unique: eS1whNdfMt6VHdzppTSavw-1
X-Mimecast-MFC-AGG-ID: eS1whNdfMt6VHdzppTSavw_1745987741
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CD7B18004A7;
	Wed, 30 Apr 2025 04:35:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E873F180045B;
	Wed, 30 Apr 2025 04:35:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 01/24] block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
Date: Wed, 30 Apr 2025 12:35:03 +0800
Message-ID: <20250430043529.1950194-2-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
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

