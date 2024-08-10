Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF93FEC
	for <linux-block@vger.kernel.org>; Sat, 10 Aug 2024 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262582; cv=none; b=ZrbsNSFx3HKqJ9Bq79S5cK3YCJJyi9dqiTld8rGCc04da8iLuHZn++TXaqQVUxpON4rhsiQcGFpyUQ3m6Qw3YxrZ6M8SxvNU18K/pBSkfUpurk1A7fgOdAGddMdzlXwByEq13JYWtwpzt7NJzSzUXWZudRSItkJny5MpcgTv7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262582; c=relaxed/simple;
	bh=8XC0U/VPysFi9si6UmJbM45ljr3f40dzr2kY37TzLYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBzlfyQqHZEETqmX4MjsjBdoqA9TkwnAQukfg3sDp+D6hdDuPOqLWdMAJs5QGbMUxkimXsewOU9mNy0etrRJvxB8elaEbI2Hl6UhdG0crrWXIq7Db8wFzvs7m7Bph1LuE4speM8/rf9Myb24ot/V0pW7Hq6Wyw8pxNMPTykptSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdBxx7/R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdBxx7/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723262578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/HzBfH6xrgVs9IqWruyPYxdcch9/sRkazCZFJwOaGT4=;
	b=MdBxx7/RwWi6rAAaME4L3quTaT0SBmiSZ3JtKHRN108TCx9vNDX4TFFjcaU7SWycrNhIbv
	bdQAusdNeMo3PAfijv+7kFEgaQ4rq84WYvqEx5LYTVG9RCwPcUg8i9sz5S6GNXKSBlDaEN
	xoX+FXzqhwsM8blfspTwzUbWlzU0acU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-w9LscJEfMCqzY6bA1l0h1g-1; Sat,
 10 Aug 2024 00:02:51 -0400
X-MC-Unique: w9LscJEfMCqzY6bA1l0h1g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB12719560A6;
	Sat, 10 Aug 2024 04:02:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36D2E19560A7;
	Sat, 10 Aug 2024 04:02:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH] ublk: move zone report data out of request pdu
Date: Sat, 10 Aug 2024 12:02:39 +0800
Message-ID: <20240810040239.437215-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

ublk zoned takes 16 bytes in each request pdu just for handling REPORT_ZONE
operation, this way does waste memory since request pdu is allocated
statically.

Store the transient zone report data into one global xarray, and remove
it after the report zone request is completed. This way is reasonable
since report zone is run in slow code path.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 62 +++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 890c08792ba8..0e295471318a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -71,9 +71,6 @@ struct ublk_rq_data {
 	struct llist_node node;
 
 	struct kref ref;
-	__u64 sector;
-	__u32 operation;
-	__u32 nr_zones;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -214,6 +211,33 @@ static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 
+struct ublk_zoned_report_desc {
+	__u64 sector;
+	__u32 operation;
+	__u32 nr_zones;
+};
+
+static DEFINE_XARRAY(ublk_zoned_report_descs);
+
+static int ublk_zoned_insert_report_desc(const struct request *req,
+		struct ublk_zoned_report_desc *desc)
+{
+	return xa_insert(&ublk_zoned_report_descs, (unsigned long)req,
+			    desc, GFP_KERNEL);
+}
+
+static struct ublk_zoned_report_desc *ublk_zoned_erase_report_desc(
+		const struct request *req)
+{
+	return xa_erase(&ublk_zoned_report_descs, (unsigned long)req);
+}
+
+static struct ublk_zoned_report_desc *ublk_zoned_get_report_desc(
+		const struct request *req)
+{
+	return xa_load(&ublk_zoned_report_descs, (unsigned long)req);
+}
+
 static int ublk_get_nr_zones(const struct ublk_device *ub)
 {
 	const struct ublk_param_basic *p = &ub->params.basic;
@@ -308,7 +332,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int zones_in_request =
 			min_t(unsigned int, remaining_zones, max_zones_per_request);
 		struct request *req;
-		struct ublk_rq_data *pdu;
+		struct ublk_zoned_report_desc desc;
 		blk_status_t status;
 
 		memset(buffer, 0, buffer_length);
@@ -319,20 +343,23 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			goto out;
 		}
 
-		pdu = blk_mq_rq_to_pdu(req);
-		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
-		pdu->sector = sector;
-		pdu->nr_zones = zones_in_request;
+		desc.operation = UBLK_IO_OP_REPORT_ZONES;
+		desc.sector = sector;
+		desc.nr_zones = zones_in_request;
+		ret = ublk_zoned_insert_report_desc(req, &desc);
+		if (ret)
+			goto free_req;
 
 		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
 					GFP_KERNEL);
-		if (ret) {
-			blk_mq_free_request(req);
-			goto out;
-		}
+		if (ret)
+			goto erase_desc;
 
 		status = blk_execute_rq(req, 0);
 		ret = blk_status_to_errno(status);
+erase_desc:
+		ublk_zoned_erase_report_desc(req);
+free_req:
 		blk_mq_free_request(req);
 		if (ret)
 			goto out;
@@ -366,7 +393,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
-	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
+	struct ublk_zoned_report_desc *desc;
 	u32 ublk_op;
 
 	switch (req_op(req)) {
@@ -389,12 +416,15 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 		ublk_op = UBLK_IO_OP_ZONE_RESET_ALL;
 		break;
 	case REQ_OP_DRV_IN:
-		ublk_op = pdu->operation;
+		desc = ublk_zoned_get_report_desc(req);
+		if (!desc)
+			return BLK_STS_IOERR;
+		ublk_op = desc->operation;
 		switch (ublk_op) {
 		case UBLK_IO_OP_REPORT_ZONES:
 			iod->op_flags = ublk_op | ublk_req_build_flags(req);
-			iod->nr_zones = pdu->nr_zones;
-			iod->start_sector = pdu->sector;
+			iod->nr_zones = desc->nr_zones;
+			iod->start_sector = desc->sector;
 			return BLK_STS_OK;
 		default:
 			return BLK_STS_IOERR;
-- 
2.45.2

