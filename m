Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9A1FDA90
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908860; cv=none; b=KFzG4jhHOG45HR6Do2fjfKpHXrvXTao8EEsEfKfD4LAWCzwiJQnlLZOAI3ONxKuGEgVM6qkz8zLoacrve12h6TOqOIuV0hw+u4mc858amXfQQAHe1EHX1qK917mOCJqlqsXb2C2ERHgMlhgKHbJoy+mPz1U3o3Y6x+g5MdgO4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908860; c=relaxed/simple;
	bh=ELZzfLVThklEhnRD+KdNugmxtZtmQlgpGDgVylXS9mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOZKneRSc+1QjKwSM7xV7A0NgtrQyhGpKVUf+VpZFpMGzRoy1vwxqrh/SWoHKuiEmPMsMTHr7+4ypZmcp46P+91MIHUS5hIlxEJrCVFV0nqlq4YGqhnwzUVp7tB5/7MR+phssPV1k3aah6iEFW1a7QeSOXD++RK2W/pk3Hbh9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHV5JdkC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHV5JdkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8xJClgE/4f6GHAhKkjiBRStsaqLXa6LjfKIeZiOaMo=;
	b=BHV5JdkC8vKmsn7RByzJ3a8LcLYUrNAQCOFMedR8ftfPPp1HTvj+RYt1p1QnD2uAahwH7P
	/7XCFYCUJo9TKZQm1pu3nBLkJpp8C4BHKetWyZX4vwC4LpveuRui7iCS0sTCXUKahcCGlx
	Ke3TcwpSH6yYvioX/kQBenFwx5QLeSA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-QAzyDBykOfuW1A5NVtncvg-1; Thu,
 13 Mar 2025 19:34:14 -0400
X-MC-Unique: QAzyDBykOfuW1A5NVtncvg-1
X-Mimecast-MFC-AGG-ID: QAzyDBykOfuW1A5NVtncvg_1741908853
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C50419560B9;
	Thu, 13 Mar 2025 23:34:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31DC11828A87;
	Thu, 13 Mar 2025 23:34:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/35] rbd: Use ceph_databuf for rbd_obj_read_sync()
Date: Thu, 13 Mar 2025 23:32:58 +0000
Message-ID: <20250313233341.1675324-7-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Make rbd_obj_read_sync() allocate and use a ceph_databuf object to convey
the data into the operation.  This has some space preallocated and this is
allocated by alloc_pages() and accessed with kmap_local rather than being
kmalloc'd.  This allows MSG_SPLICE_PAGES to be used.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index faafd7ff43d6..bb953634c7cb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4822,13 +4822,10 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 			     struct ceph_object_id *oid,
 			     struct ceph_object_locator *oloc,
-			     void *buf, int buf_len)
-
+			     struct ceph_databuf *dbuf, int len)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct ceph_osd_request *req;
-	struct page **pages;
-	int num_pages = calc_pages_for(0, buf_len);
 	int ret;
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_KERNEL);
@@ -4839,15 +4836,8 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	ceph_oloc_copy(&req->r_base_oloc, oloc);
 	req->r_flags = CEPH_OSD_FLAG_READ;
 
-	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
-	if (IS_ERR(pages)) {
-		ret = PTR_ERR(pages);
-		goto out_req;
-	}
-
-	osd_req_op_extent_init(req, 0, CEPH_OSD_OP_READ, 0, buf_len, 0, 0);
-	osd_req_op_extent_osd_data_pages(req, 0, pages, buf_len, 0, false,
-					 true);
+	osd_req_op_extent_init(req, 0, CEPH_OSD_OP_READ, 0, len, 0, 0);
+	osd_req_op_extent_osd_databuf(req, 0, dbuf);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_KERNEL);
 	if (ret)
@@ -4855,9 +4845,6 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 
 	ceph_osdc_start_request(osdc, req);
 	ret = ceph_osdc_wait_request(osdc, req);
-	if (ret >= 0)
-		ceph_copy_from_page_vector(pages, buf, 0, ret);
-
 out_req:
 	ceph_osdc_put_request(req);
 	return ret;
@@ -4872,12 +4859,18 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
 				  struct rbd_image_header *header,
 				  bool first_time)
 {
-	struct rbd_image_header_ondisk *ondisk = NULL;
+	struct rbd_image_header_ondisk *ondisk;
+	struct ceph_databuf *dbuf = NULL;
 	u32 snap_count = 0;
 	u64 names_size = 0;
 	u32 want_count;
 	int ret;
 
+	dbuf = ceph_databuf_req_alloc(1, sizeof(*ondisk), GFP_KERNEL);
+	if (!dbuf)
+		return -ENOMEM;
+	ondisk = kmap_ceph_databuf_page(dbuf, 0);
+
 	/*
 	 * The complete header will include an array of its 64-bit
 	 * snapshot ids, followed by the names of those snapshots as
@@ -4888,17 +4881,18 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
 	do {
 		size_t size;
 
-		kfree(ondisk);
-
 		size = sizeof (*ondisk);
 		size += snap_count * sizeof (struct rbd_image_snap_ondisk);
 		size += names_size;
-		ondisk = kmalloc(size, GFP_KERNEL);
-		if (!ondisk)
-			return -ENOMEM;
+
+		ret = -ENOMEM;
+		if (size > dbuf->limit &&
+		    ceph_databuf_reserve(dbuf, size - dbuf->limit,
+					 GFP_KERNEL) < 0)
+			goto out;
 
 		ret = rbd_obj_read_sync(rbd_dev, &rbd_dev->header_oid,
-					&rbd_dev->header_oloc, ondisk, size);
+					&rbd_dev->header_oloc, dbuf, size);
 		if (ret < 0)
 			goto out;
 		if ((size_t)ret < size) {
@@ -4907,6 +4901,7 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
 				size, ret);
 			goto out;
 		}
+
 		if (!rbd_dev_ondisk_valid(ondisk)) {
 			ret = -ENXIO;
 			rbd_warn(rbd_dev, "invalid header");
@@ -4920,8 +4915,8 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
 
 	ret = rbd_header_from_disk(header, ondisk, first_time);
 out:
-	kfree(ondisk);
-
+	kunmap_local(ondisk);
+	ceph_databuf_release(dbuf);
 	return ret;
 }
 

