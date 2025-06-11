Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4E227E89
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632209; cv=none; b=V9AvbWKMFvgr8n53YqF77cc/XPvaAC2h6rEFfI7JM1eEJNyYePcyv/HozT+rakgT8T2xb9KzlRAu4ekkIaxVA9ZBMPiN/DdtwXfbXpr+uVeAuaYLIhHsmARRSZ/Rsjw2LkifNyc9Ig35N3gicuTVgbqImVTz15xgCEp+An6WLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632209; c=relaxed/simple;
	bh=M0SYQoXyH5plQGVqvER8c9RcqL8gtAs/KByvOhhpCVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LptYuWH6mScAVX7T9KHoMU9swxuwgKYPF7D70as0BJnk1jU37JjQ5xmoQ7pVcniOvfZw1S4gfKpQpi9xwD4o5eN7cqPlGSwaF8DvS7ubVuV9qCdwOgrXDhUKgM7FRipLKfuBfcS98odOFdppyMwVE/FQjRMiTSKikCuYKJFgTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VD4EidJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VD4EidJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749632206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X1ujjzgbgxzGK1ALpiv8f/2fS+TmYhf8FOSyYVhK8Ko=;
	b=VD4EidJe2UcZvsNnfitgaEDq+eiNMnJlzfxVz+4461ro5986eEPlLy/g3xy+AwvWYJYnTi
	Dkp39vFWvSaKkYnlX1INTfbo3TIy9tBAVKeYLyp4CGJeSTlb+ot8ObWu/nTVUCMXaSKtCs
	QGJHsgksFZFXGXaLOYAE3ILqJXY6fCc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-y_sq_sgHO5SEv4dPOQi-BQ-1; Wed,
 11 Jun 2025 04:56:42 -0400
X-MC-Unique: y_sq_sgHO5SEv4dPOQi-BQ-1
X-Mimecast-MFC-AGG-ID: y_sq_sgHO5SEv4dPOQi-BQ_1749632202
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D22DE1800282;
	Wed, 11 Jun 2025 08:56:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.142])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FF651956087;
	Wed, 11 Jun 2025 08:56:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH V2] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
Date: Wed, 11 Jun 2025 16:56:32 +0800
Message-ID: <20250611085632.109719-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Document recently merged feature auto buffer registration(UBLK_F_AUTO_BUF_REG).

Cc: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- address Caleb's comment
	- clarify "concurrent IO handling" becomes possible by this feature
	  wrt. zero copy
	- improve `Fallback Behavior` description
	- add io_ring_ctx buffer table size limitation

 Documentation/block/ublk.rst | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index c368e1081b41..abec524a04ed 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -352,6 +352,81 @@ For reaching best IO performance, ublk server should align its segment
 parameter of `struct ublk_param_segment` with backend for avoiding
 unnecessary IO split, which usually hurts io_uring performance.
 
+Auto Buffer Registration
+------------------------
+
+The ``UBLK_F_AUTO_BUF_REG`` feature automatically handles buffer registration
+and unregistration for I/O requests, which simplifies the buffer management
+process and reduces overhead in the ublk server implementation.
+
+This is another feature flag for using zero copy, and it is compatible with
+``UBLK_F_SUPPORT_ZERO_COPY``.
+
+Feature Overview
+~~~~~~~~~~~~~~~~
+
+This feature automatically registers request buffers to the io_uring context
+before delivering I/O commands to the ublk server and unregisters them when
+completing I/O commands. This eliminates the need for manual buffer
+registration/unregistration via ``UBLK_IO_REGISTER_IO_BUF`` and
+``UBLK_IO_UNREGISTER_IO_BUF`` commands, then IO handling in ublk server
+can avoid dependency on the two uring_cmd operations.
+
+IOs can't be issued concurrently to io_uring if there is any dependency
+among these IOs. So this way not only simplifies ublk server implementation,
+but also makes concurrent IO handling becomes possible by removing the
+dependency on buffer registration & unregistration commands.
+
+Usage Requirements
+~~~~~~~~~~~~~~~~~~
+
+1. The ublk server must create a sparse buffer table on the same ``io_ring_ctx``
+   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_AND_FETCH_REQ``. If
+   uring_cmd is issued on a different ``io_ring_ctx``, manual buffer
+   unregistration is required.
+
+2. Buffer registration data must be passed via uring_cmd's ``sqe->addr`` with the
+   following structure::
+
+    struct ublk_auto_buf_reg {
+        __u16 index;      /* Buffer index for registration */
+        __u8 flags;       /* Registration flags */
+        __u8 reserved0;   /* Reserved for future use */
+        __u32 reserved1;  /* Reserved for future use */
+    };
+
+   ublk_auto_buf_reg_to_sqe_addr() is for converting the above structure into
+   ``sqe->addr``.
+
+3. All reserved fields in ``ublk_auto_buf_reg`` must be zeroed.
+
+4. Optional flags can be passed via ``ublk_auto_buf_reg.flags``.
+
+Fallback Behavior
+~~~~~~~~~~~~~~~~~
+
+If auto buffer registration fails:
+
+1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
+   - The uring_cmd is completed
+   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_flags``
+   - The ublk server must manually deal with the failure, such as, register
+     the buffer manually, or using user copy feature for retrieving the data
+     for handling ublk IO
+
+2. If fallback is not enabled:
+   - The ublk I/O request fails silently
+   - The uring_cmd won't be completed
+
+Limitations
+~~~~~~~~~~~
+
+- Requires same ``io_ring_ctx`` for all operations
+- May require manual buffer management in fallback cases
+- io_ring_ctx buffer table has a max size of 16K, which may not be enough
+  in case that too many ublk devices are handled by this single io_ring_ctx
+  and each one has very large queue depth
+
 References
 ==========
 
-- 
2.47.1

