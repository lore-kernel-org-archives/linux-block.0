Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971152E1C78
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294570; cv=none; b=eqdv5aKeZOcwY4rnb2goscR7WS7Br87eAWZwN3X54gQiAdiE/l3jtEznYpcBWyshACc4fgkWqPjgAEAZGhmodp4d87HGlmZ2tf5wnYgDv82gjPpasFtgF0Fffc+TGGci1GG1wjZC4BBKKaeQysbccOQMp4v7+K73dZ70pIewmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294570; c=relaxed/simple;
	bh=wgh29TBAWfK7IKN4tu05jI5GQ1jj7c3Y9FY4aM9NduY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKffArmnc9dRYg5FLF1r9V5c1UQIplptxEH3Zslr3ZOS5zyN90hbcdSxUoGGvD5duwrFkJ56nqOjVFxryYXqRbnWd9+4JASci3YZRCR5ak9vD1dTcfqAirKMy4Uptqi61rxc4zFupt249HZHYdilPyqHMQn1YwMS6pEOxUwx4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4QNr4JO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4QNr4JO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756294567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=39v9pRG04LvRBmUW/1LxWE2Bfz+SiAEdqQeLGr3S5f8=;
	b=O4QNr4JO8SvfsaHPcnDlP29yZzVcmmDgK6zeqDst3YWDp75dGhNWHXtrd+SHKgdAYyh5Zm
	lT43V9HChxUghH5YLr1r3ynz0joe78u3HrsABD7RlIMU0apDdOhlX0MGbfq70KwirJRShv
	T8w1U1q1HBzWe2l16aMhUdDtqAC4AoU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-dKZKw90oNq2ZzKzLX-7iCA-1; Wed,
 27 Aug 2025 07:36:05 -0400
X-MC-Unique: dKZKw90oNq2ZzKzLX-7iCA-1
X-Mimecast-MFC-AGG-ID: dKZKw90oNq2ZzKzLX-7iCA_1756294564
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA6261955F29;
	Wed, 27 Aug 2025 11:36:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85AA730001A8;
	Wed, 27 Aug 2025 11:36:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] scsi: sr: Set rotational feature flag back
Date: Wed, 27 Aug 2025 19:35:50 +0800
Message-ID: <20250827113550.2614535-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Set rotational feature flag back for cd-rom which is really rotational disk,
and the flag is `cleared` since commit bd4a633b6f7c ("block: move the nonrot
flag to queue_limits"). And this way breaks some applications.

Move queue limits configuration from get_sectorsize() to
sr_revalidate_disk(), so that it is more readable to set rotational
feature flag and sector size limit in sr_revalidate_disk().

Cc: Christoph Hellwig <hch@lst.de>
Fixes: bd4a633b6f7c ("block: move the nonrot flag to queue_limits")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/sr.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index b17796d5ee66..add13e306898 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -475,13 +475,21 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 
 static int sr_revalidate_disk(struct scsi_cd *cd)
 {
+	struct request_queue *q = cd->device->request_queue;
 	struct scsi_sense_hdr sshdr;
+	struct queue_limits lim;
+	int sector_size;
 
 	/* if the unit is not ready, nothing more to do */
 	if (scsi_test_unit_ready(cd->device, SR_TIMEOUT, MAX_RETRIES, &sshdr))
 		return 0;
 	sr_cd_check(&cd->cdi);
-	return get_sectorsize(cd);
+	sector_size = get_sectorsize(cd);
+
+	lim = queue_limits_start_update(q);
+	lim.logical_block_size = sector_size;
+	lim.features |= BLK_FEAT_ROTATIONAL;
+	return queue_limits_commit_update_frozen(q, &lim);
 }
 
 static int sr_block_open(struct gendisk *disk, blk_mode_t mode)
@@ -721,10 +729,8 @@ static int sr_probe(struct device *dev)
 
 static int get_sectorsize(struct scsi_cd *cd)
 {
-	struct request_queue *q = cd->device->request_queue;
 	static const u8 cmd[10] = { READ_CAPACITY };
 	unsigned char buffer[8] = { };
-	struct queue_limits lim;
 	int err;
 	int sector_size;
 	struct scsi_failure failure_defs[] = {
@@ -795,9 +801,7 @@ static int get_sectorsize(struct scsi_cd *cd)
 		set_capacity(cd->disk, cd->capacity);
 	}
 
-	lim = queue_limits_start_update(q);
-	lim.logical_block_size = sector_size;
-	return queue_limits_commit_update_frozen(q, &lim);
+	return sector_size;
 }
 
 static int get_capabilities(struct scsi_cd *cd)
-- 
2.47.1

