Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251E86340
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089928; cv=none; b=JYgLT6P9owSrLx6Zb7tsTKin5y6QeexpGeIepBdi4oEOuqdzKiwwGPAB7NWfNw59ixc251UdPW0lR+VhBBBkoIapWQHXj2S8FQNagFf6q4bDpEskAcqSBGJdc5C/s9jRfq3VgMN77zJx2vvGtwaBj2V9xtL+hrlP/piHNvOlrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089928; c=relaxed/simple;
	bh=yzG10VZQ/5p8sqVp7TWQ1/IGrYoBt3ptr2EGtWpvuIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhNi782J6KSHub0sgQ16sUSXZ7SJZ63XIkSih99aNZstZlFt43jQAEY+JyznbLipmrHwIl3aSvkc/2x6QCwbDNLHrQl2DqJXsAnk9GoHnH6r1o/PznpKG2w4t5nOxoCGq9CDu90sva8oad09hpl1IQ0NVQZKM0f9nc44CXn65v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUqbhWca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUqbhWca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750089925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o4HAA+WVSTniXz7q+g/2/Z3lhEqhcm1mcpOyYqlTy6g=;
	b=fUqbhWcaK/3fB7SjapTiCA1W2eyKcKjJP84lFDXbYiQKQX4D8k2GS+ai1X0GxD961q/IUk
	02l61Alp3QgfPBCnGGSYWrHIQu/iVjgFsMYdL1dZ9MwyqUnjTyBzj1jv4TabTfk15jp1KV
	hJnsdZNzUA6HjcxYaEYg/ZUX0WcStI8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-UmNW4DqSNcGhKFD2JO3GSw-1; Mon,
 16 Jun 2025 12:05:18 -0400
X-MC-Unique: UmNW4DqSNcGhKFD2JO3GSw-1
X-Mimecast-MFC-AGG-ID: UmNW4DqSNcGhKFD2JO3GSw_1750089917
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F07651809C8A;
	Mon, 16 Jun 2025 16:05:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D05418002B5;
	Mon, 16 Jun 2025 16:05:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [PATCH] scsi: storvsc: set max_segment_size as UINT_MAX explicitly
Date: Tue, 17 Jun 2025 00:05:09 +0800
Message-ID: <20250616160509.52491-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Set max_segment_size as UINT_MAX explicitly:

- storvrc uses virt_boundary to define `segment`

- strovrc does not define max_segment_size

So define max_segment_size as UINT_MAX, otherwise __blk_rq_map_sg() takes
default 64K max segment size and splits one virtual segment into two parts,
then breaks virt_boundary limit.

Before commit ec84ca4025c0 ("scsi: block: Remove now unused queue limits helpers"),
max segment size is set as UINT_MAX in case that virt_boundary is
defined.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Fixes: ec84ca4025c0 ("scsi: block: Remove now unused queue limits helpers")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/storvsc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2e6b2412d2c9..1e7ad85f4ba3 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1897,6 +1897,7 @@ static struct scsi_host_template scsi_driver = {
 	.no_write_same =	1,
 	.track_queue_depth =	1,
 	.change_queue_depth =	storvsc_change_queue_depth,
+	.max_segment_size   = 0xffffffff,
 };
 
 enum {
-- 
2.47.0

