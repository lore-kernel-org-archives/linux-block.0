Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC9215040
	for <linux-block@vger.kernel.org>; Mon, 17 Mar 2025 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742186722; cv=none; b=K4sMufBeV7FRtWnKP1b8mPBd1kRXqRHe6u+Z0M50sSfKS+/LUUv2GP/5b1KZlGjReDpWdKOMhPW2NWx25n87yinme2E2KnYlxvaCyyV83ZE/+c8zjAH9eTFmhRiCsq/ptV+GhC61xqn3iUPybvdIZ5nTHI1EEhLyS/BTtk0HNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742186722; c=relaxed/simple;
	bh=79Iz68fntPRFIZIxlkxI6B6WsLznUqgckDnCkswLdZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMGlRxFsC5nr0cCUhgNiA7PT+1Yt4fzIDC6iy/ROmCSJfNVC8PzRlPxr+09xQ2KY35Ly1soYlVZHQmiCS7Jnm4TUPg4QefJMfi6P3WcGJxExb57NqbmYHqYmt46By63+WXXZuamac15ZQZp4FpfpCLulVkC9VFkKSwbTnMCfOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foh8DgTj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foh8DgTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742186718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C81+Pdz0tp6ARDKNY27QzSrdA4N9lXGz/6auv5mqWME=;
	b=foh8DgTjoqG/3S9kd0ftIKHH+aABKbVn+MrhomUEc8iof8dy/xtotiPHBqiuv0Od+2VAAE
	dEebrsi5TxCXY6cGs8JEcUz6Hp/uL2echsefOBEpe0I86XKvX2yll/N3XM5fB2b913b/KD
	HDeMeoJmGjU1xPGcwC+kQdtQwAcmcPU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-xouzEVscNyWhDfCaH0jpyA-1; Mon,
 17 Mar 2025 00:45:15 -0400
X-MC-Unique: xouzEVscNyWhDfCaH0jpyA-1
X-Mimecast-MFC-AGG-ID: xouzEVscNyWhDfCaH0jpyA_1742186714
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A7EC180025C;
	Mon, 17 Mar 2025 04:45:13 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 832111956094;
	Mon, 17 Mar 2025 04:45:12 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52H4jBmY2200870
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 00:45:11 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52H4jBS42200869;
	Mon, 17 Mar 2025 00:45:11 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/6] dm: free table mempools if not used in __bind
Date: Mon, 17 Mar 2025 00:45:06 -0400
Message-ID: <20250317044510.2200856-3-bmarzins@redhat.com>
In-Reply-To: <20250317044510.2200856-1-bmarzins@redhat.com>
References: <20250317044510.2200856-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With request-based dm, the mempools don't need reloading when switching
tables, but the unused table mempools are not freed until the active
table is finally freed. Free them immediately if they are not needed.

Fixes: 29dec90a0f1d9 ("dm: fix bio_set allocation")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f5c5ccb6f8d2..292414da871d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2461,10 +2461,10 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		 * requests in the queue may refer to bio from the old bioset,
 		 * so you must walk through the queue to unprep.
 		 */
-		if (!md->mempools) {
+		if (!md->mempools)
 			md->mempools = t->mempools;
-			t->mempools = NULL;
-		}
+		else
+			dm_free_md_mempools(t->mempools);
 	} else {
 		/*
 		 * The md may already have mempools that need changing.
@@ -2473,8 +2473,8 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		 */
 		dm_free_md_mempools(md->mempools);
 		md->mempools = t->mempools;
-		t->mempools = NULL;
 	}
+	t->mempools = NULL;
 
 	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
 	rcu_assign_pointer(md->map, (void *)t);
-- 
2.48.1

