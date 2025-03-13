Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFB210F44
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908949; cv=none; b=BannG4bwvgwpOUUExL2+1nA5d/EO8wGbcTP6pupee8e5Of5eL1n9JP64+Wdvlda/udA8IpZfjHSSwU73lAX8mVRvPr74rA5r9mdIyzfcv9QB/ysrIhYVc94jxfNMD5ifAacwa/Gbs9AyX+Ejzj0lGQmM6+6hHciAgCSNJ3FCg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908949; c=relaxed/simple;
	bh=gCChVgMBzGvrlJ7sZIvOLzGNcSU2zki3HyYavWVM5pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTglKK6reSVCUAZ6sBc82s9g/mw9CpQbTlhBbZ9WktrPyGFt2GDEW0op6Drb0/vsrnjfFPkLz/osorQ7fHWdHgIQIuDdRqvnWUXMUkUG/Q8GpL7yY+7zoixQInfDKFqjta78yLmOUMerqbIvgRrWTHcCDebBoUbgnxLxCAZnLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSZbiXXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSZbiXXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d01oWNmun+xrcu/GBCdvzw0vab4iyfs4NG678lUElAM=;
	b=LSZbiXXgljtmdpl47TxF7NbLCPKBrdh57gWklNDwjMV8T/ioAKW92K33nYgn4PBvJ2rUMa
	trqteE4sEPcgGoLY56TB7ckHM6crSKIoMVTcAeIKKw8WrrLAHBNm2VFZFZ6MJ4+FvU6Y0T
	7LRI8ScuDSrBb1Y8wfQwrx8uPr1u/qA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-PyevtBxrP3KxREWu0FWF4g-1; Thu,
 13 Mar 2025 19:35:46 -0400
X-MC-Unique: PyevtBxrP3KxREWu0FWF4g-1
X-Mimecast-MFC-AGG-ID: PyevtBxrP3KxREWu0FWF4g_1741908944
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B36101801A07;
	Thu, 13 Mar 2025 23:35:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E5E8300376F;
	Thu, 13 Mar 2025 23:35:42 +0000 (UTC)
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
Subject: [RFC PATCH 31/35] netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int
Date: Thu, 13 Mar 2025 23:33:23 +0000
Message-ID: <20250313233341.1675324-32-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix netfs_unbuffered_read() to return an ssize_t rather than an int as
netfs_wait_for_read() returns ssize_t and this gets implicitly truncated.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_read.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 15a6923a92ca..5e4bd1e5a378 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -201,9 +201,9 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
  * Perform a read to an application buffer, bypassing the pagecache and the
  * local disk cache.
  */
-static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
+static ssize_t netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 {
-	int ret;
+	ssize_t ret;
 
 	_enter("R=%x %llx-%llx",
 	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
@@ -231,7 +231,7 @@ static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 	else
 		ret = -EIOCBQUEUED;
 out:
-	_leave(" = %d", ret);
+	_leave(" = %zd", ret);
 	return ret;
 }
 

