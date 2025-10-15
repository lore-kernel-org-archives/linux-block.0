Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809731B126
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526475; cv=none; b=ZDA2jMDGVyQZucTb5o1IDU7HB4g0X9FNtRJaFfA6O5UNIZBYNHiN44xAA1VyFZ29UNh/oIgKqMci1ho/3zJWwe8+llh1FI+J8n6X3OWDwFAr+3VbXbbqufCCgFLEhsBCa07BvYC6HmKTNI136UorxouU1GwHMHG55+xYYEtkzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526475; c=relaxed/simple;
	bh=WFQy7Mc6x2CvbixLnZF28ReifYRSw3+8WX5aDrTwlcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nmp6RwXLhwI1LMQcB04Kf2YkDmweoPNHbyqLW4kbJxDgUmQoYqPhbdcuNJ5CqdN61wNnx8Oyr7O0VoomX0pnF036/ya3NPZQAE+tovnldmlVln90T9sn57FQMP/C7QdK/auP0+L5G14TtdW7xdboS+dztlvkeVLNnxKRH1dTsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfTNwIrV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfTNwIrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760526472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8pAXgWyE9GjvTf/aoS6e1A6VsLWuClIIEsEZgzQGcw=;
	b=hfTNwIrV3aj80mJ6tX3XdneT86H3/K5Zom5V3LNi0iGC6MGpYeEk0e1a+OoGvW7cQbrTk1
	/82w3FEijcHqHLwURakD0rPWOtr/V8vPGTjNpDAZ75hNDYz2WyG6jbtlwBxvfIrX9UE8um
	nRAQMHlTUZYXTFZdUrfbR7Ss1otWjJ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-zRYexjqbMcSD-HnLJMSisg-1; Wed,
 15 Oct 2025 07:07:51 -0400
X-MC-Unique: zRYexjqbMcSD-HnLJMSisg-1
X-Mimecast-MFC-AGG-ID: zRYexjqbMcSD-HnLJMSisg_1760526470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0A031808997;
	Wed, 15 Oct 2025 11:07:50 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A71DD30001A1;
	Wed, 15 Oct 2025 11:07:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 1/6] loop: add helper lo_cmd_nr_bvec()
Date: Wed, 15 Oct 2025 19:07:26 +0800
Message-ID: <20251015110735.1361261-2-ming.lei@redhat.com>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add lo_cmd_nr_bvec() and prepare for refactoring lo_rw_aio().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 053a086d547e..af443651dff5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -337,6 +337,19 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 	lo_rw_aio_do_completion(cmd);
 }
 
+static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct req_iterator rq_iter;
+	struct bio_vec tmp;
+	int nr_bvec = 0;
+
+	rq_for_each_bvec(tmp, rq, rq_iter)
+		nr_bvec++;
+
+	return nr_bvec;
+}
+
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		     loff_t pos, int rw)
 {
@@ -348,12 +361,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
 	unsigned int offset;
-	int nr_bvec = 0;
+	int nr_bvec = lo_cmd_nr_bvec(cmd);
 	int ret;
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
-
 	if (rq->bio != rq->biotail) {
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
-- 
2.47.0

