Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5925E476
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824194; cv=none; b=b0TPh3i0CJA/Y2MfRB93jWw4XuJlRQLQjMPw1PED6339x6bZYg86TR57FpFybYU4TgS+bX2z0OSsg9anpLvamLQ+fMgBfQxbPINy9yxBgIHIg/4+yhI2lOK0hvElgyQiQVd7xsoHkaaJb2et3SAy3wpfNlmvU3Nu2tdacsfN/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824194; c=relaxed/simple;
	bh=uO0ex7mYUuchFkDH26Bemv6xqrgCb4Ey2g+BgPojhOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCfj8LcS6aO1qPXgOpMTF3yCWtxoobLdbPSjpu6iUoBcVaUy3etFWwb/nbUTcAR7DnBwXULhZJ7/rW8NDPaOWnZi48Tw7qx8PZX9qqirmHalRxxYLovPHOhKDVkeVMIUWV1EjS+0/7yav2bSn49rPx6p7xnzviKtAn9UKTt62zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OABgLBHO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OABgLBHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXYfJAan71G16ycBv7QtmpdVC1fzWuoJs2SA9FsCCIM=;
	b=OABgLBHOFz7AGycWjJvoJ2/+wLrjXCZThINxFlmhBn4g+Zi2dUAjlu5hBj1cMW7WDadeBf
	afKd8lfUjSpRf0RcYJZInejIA2mTCCjFQ9DZeBHoffyInOVETl0+XMecrM8kIqJUb5dgp6
	i1blUCbxmAUrfLcl3IM11fKqA2PKhB8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-iiG9NoG5P8SRBKePKtaQmw-1; Mon,
 24 Mar 2025 09:49:48 -0400
X-MC-Unique: iiG9NoG5P8SRBKePKtaQmw-1
X-Mimecast-MFC-AGG-ID: iiG9NoG5P8SRBKePKtaQmw_1742824187
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C17E18001FC;
	Mon, 24 Mar 2025 13:49:47 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1761C30001A1;
	Mon, 24 Mar 2025 13:49:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/8] ublk: document zero copy feature
Date: Mon, 24 Mar 2025 21:49:00 +0800
Message-ID: <20250324134905.766777-6-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-1-ming.lei@redhat.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add words to explain how zero copy feature works, and why it has to be
trusted for handling IO read command.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 1e0e7358e14a..33efff25b54d 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -309,18 +309,30 @@ with specified IO tag in the command data:
   ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
   the server buffer (pages) read to the IO request pages.
 
-Future development
-==================
-
 Zero copy
 ---------
 
-Zero copy is a generic requirement for nbd, fuse or similar drivers. A
-problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to userspace
-can't be remapped any more in kernel with existing mm interfaces. This can
-occurs when destining direct IO to ``/dev/ublkb*``. Also, he reported that
-big requests (IO size >= 256 KB) may benefit a lot from zero copy.
+ublk zero copy relies on io_uring's fixed kernel buffer, which provides
+two APIs: `io_buffer_register_bvec()` and `io_buffer_unregister_bvec`.
+
+ublk adds IO command of `UBLK_IO_REGISTER_IO_BUF` to call
+`io_buffer_register_bvec()` for ublk server to register client request
+buffer into io_uring buffer table, then ublk server can submit io_uring
+IOs with the registered buffer index. IO command of `UBLK_IO_UNREGISTER_IO_BUF`
+calls `io_buffer_unregister_bvec` to unregister the buffer.
+
+ublk server implementing zero copy has to be CAP_SYS_ADMIN and be trusted,
+because it is ublk server's responsibility to make sure IO buffer filled
+with data, and ublk server has to handle short read correctly by returning
+correct bytes filled to io buffer. Otherwise, uninitialized kernel buffer
+will be exposed to client application.
+
+ublk server needs to align the parameter of `struct ublk_param_dma_align`
+with backend for zero copy to work correctly.
 
+For reaching best IO performance, ublk server should align its segment
+parameter of `struct ublk_param_segment` with backend for avoiding
+unnecessary IO split.
 
 References
 ==========
-- 
2.47.0

