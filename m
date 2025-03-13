Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF41FECA4
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908873; cv=none; b=HcZhy3T/9mvWhO/8sEGRO+zm5ZumMfBw1TMAeuv7287G160dSj/G5c6xqKo7ieR0dYr5riC0/Z8fVlAR6uItSAiyRVSGHL2+h5GSvCd2nf5asGXwmctJFZ8/xnh2u5fa4m7+Ol1THc5xGOml96RwHTxltbfNfEsDj6b1iyxmBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908873; c=relaxed/simple;
	bh=NiNBTgNWjrimsWNddD2U+rQy0qV/K2c9VNKMA41DA0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgfOFnMnlUoDG48btKmY16V6HdXelB1fVfAkCJxmTrt1Ant8+zkqnM4TQNuW/M7cW12zxe3E15lSAsIXX7bofzt5WjL2sNmPbsz8e3IB9yUef4WCPYOnJelAMKQAEkEsYz0RknlGcRhEi6a7mQWiN5ji1rz8EQIaNe4zo45wnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKy3RLTy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKy3RLTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpR89Edjbx9ldmoLpMeX/2aHlbT7ns1oIoTcfz5jVJA=;
	b=QKy3RLTy7RrHVwi3dYcAdY56TJrs59dne4DLFRnLB2PtMA9SWledbHZOY/rKT+Ivwh9ZY9
	oDyRdDHswLccLkCZ5yhiWwUMVqXuZsK3s+hR55krZ/IQTdkpuUfZoJ9NRLvtqVVoLOLzD0
	akSD//ycYRwwC1LXRl7W/pweIjix7YM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-QLe6hXCdOD2nqvSGHu527Q-1; Thu,
 13 Mar 2025 19:34:29 -0400
X-MC-Unique: QLe6hXCdOD2nqvSGHu527Q-1
X-Mimecast-MFC-AGG-ID: QLe6hXCdOD2nqvSGHu527Q_1741908868
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35A6A19560AB;
	Thu, 13 Mar 2025 23:34:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED62D1828A83;
	Thu, 13 Mar 2025 23:34:25 +0000 (UTC)
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
Subject: [RFC PATCH 10/35] libceph: Convert notify_id_pages to a ceph_databuf
Date: Thu, 13 Mar 2025 23:33:02 +0000
Message-ID: <20250313233341.1675324-11-dhowells@redhat.com>
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

Convert linger->notify_id_pages to a ceph_databuf

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/ceph/osd_client.h |  2 +-
 net/ceph/osd_client.c           | 24 +++++++++++++-----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index fe51c6ed23af..5ac4c0b4dfcd 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -349,7 +349,7 @@ struct ceph_osd_linger_request {
 	void *data;
 
 	struct ceph_pagelist *request_pl;
-	struct page **notify_id_pages;
+	struct ceph_databuf *notify_id_buf;
 
 	struct page ***preply_pages;
 	size_t *preply_len;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e1dbde4bf2b9..fc5c136e793d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2841,9 +2841,7 @@ static void linger_release(struct kref *kref)
 
 	if (lreq->request_pl)
 		ceph_pagelist_release(lreq->request_pl);
-	if (lreq->notify_id_pages)
-		ceph_release_page_vector(lreq->notify_id_pages, 1);
-
+	ceph_databuf_release(lreq->notify_id_buf);
 	ceph_osdc_put_request(lreq->reg_req);
 	ceph_osdc_put_request(lreq->ping_req);
 	target_destroy(&lreq->t);
@@ -3128,10 +3126,13 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 	if (!lreq->is_watch) {
 		struct ceph_osd_data *osd_data =
 		    osd_req_op_data(req, 0, notify, response_data);
-		void *p = page_address(osd_data->pages[0]);
+		struct ceph_databuf *notify_id_buf = lreq->notify_id_buf;
+		void *p;
 
 		WARN_ON(req->r_ops[0].op != CEPH_OSD_OP_NOTIFY ||
-			osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
+			osd_data->type != CEPH_OSD_DATA_TYPE_DATABUF);
+
+		p = kmap_ceph_databuf_page(notify_id_buf, 0);
 
 		/* make note of the notify_id */
 		if (req->r_ops[0].outdata_len >= sizeof(u64)) {
@@ -3141,6 +3142,8 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 		} else {
 			dout("lreq %p no notify_id\n", lreq);
 		}
+
+		kunmap_local(p);
 	}
 
 out:
@@ -3224,9 +3227,9 @@ static void send_linger(struct ceph_osd_linger_request *lreq)
 			refcount_inc(&lreq->request_pl->refcnt);
 			osd_req_op_notify_init(req, 0, lreq->linger_id,
 					       lreq->request_pl);
-			ceph_osd_data_pages_init(
+			ceph_osd_databuf_init(
 			    osd_req_op_data(req, 0, notify, response_data),
-			    lreq->notify_id_pages, PAGE_SIZE, 0, false, false);
+			    ceph_databuf_get(lreq->notify_id_buf));
 		}
 		dout("lreq %p register\n", lreq);
 		req->r_callback = linger_commit_cb;
@@ -5016,10 +5019,9 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 	}
 
 	/* for notify_id */
-	lreq->notify_id_pages = ceph_alloc_page_vector(1, GFP_NOIO);
-	if (IS_ERR(lreq->notify_id_pages)) {
-		ret = PTR_ERR(lreq->notify_id_pages);
-		lreq->notify_id_pages = NULL;
+	lreq->notify_id_buf = ceph_databuf_reply_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!lreq->notify_id_buf) {
+		ret = -ENOMEM;
 		goto out_put_lreq;
 	}
 

