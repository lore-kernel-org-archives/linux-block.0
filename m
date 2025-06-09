Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49993610D
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471279; cv=none; b=KdqihhHem/UjwCQzOlYsOae8Vm63EFXdhN5L4rCjWLXPesZ1RwMmg0dIkBX1L21dfePCkqB8gtP77rHwi0X8YG5GBMsLqPT6+SAezPXHpegJYt+xMweDibrGT6cqkWfyYBwWPHma1hYv2QnuM7QOu0Gs7L2QPabnkknykai76WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471279; c=relaxed/simple;
	bh=CnbwAN5CeI4ihKQJftmmx1G7aOLegvfEIDr4jSfodXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uX4VV2eRaGk9zbSMmwlsxtK3a6fgvhX867YZ8dn7/SYAOutkEgaUaqpzlThoWHaixIcL725bfGQWzs6z8KaPSE2kRqZfKUP5jtefjx024KJQI+Kl7yNIVyyyLEQKsIBQfu0t8g983ZRL/YGtFAcBpgDbn/zciunM05JoAyIOOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ez7QfnmV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez7QfnmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749471277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1CfDae3ZYporZeKCrPShL8P1dMIfeXxy+k+zMTwH8/M=;
	b=ez7QfnmV0fR4+sRUIhp+GYupqA6ShDCRDtrIrQzjXtU6kDB1KPgKlhiz1gEye3mm1Wwi81
	nrI+pDGMUsMxV5vh8IMUbslaYILVFTgKUVjXyDo3oBaNrkAS+9FaIUOrdOIpahpR0EOyYR
	ESNwY24eZO/vDgnLwlu/p5JOCXylTOc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-biTBk_znOj2Jed4zFu8G0A-1; Mon,
 09 Jun 2025 08:14:36 -0400
X-MC-Unique: biTBk_znOj2Jed4zFu8G0A-1
X-Mimecast-MFC-AGG-ID: biTBk_znOj2Jed4zFu8G0A_1749471275
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B96BB1956086;
	Mon,  9 Jun 2025 12:14:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE2951956087;
	Mon,  9 Jun 2025 12:14:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
Date: Mon,  9 Jun 2025 20:14:26 +0800
Message-ID: <20250609121426.1997271-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Document recently merged feature auto buffer registration(UBLK_F_AUTO_BUF_REG).

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 67 ++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index c368e1081b41..16ffca54eed4 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -352,6 +352,73 @@ For reaching best IO performance, ublk server should align its segment
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
+This way not only simplifies ublk server implementation, but also makes
+concurrent IO handling becomes possible.
+
+Usage Requirements
+~~~~~~~~~~~~~~~~~~
+
+1. The ublk server must create a sparse buffer table on the same ``io_ring_ctx``
+   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_AND_FETCH_REQ``.
+
+2. If uring_cmd is issued on a different ``io_ring_ctx``, manual buffer
+   unregistration is required.
+
+3. Buffer registration data must be passed via uring_cmd's ``sqe->addr`` with the
+   following structure::
+
+    struct ublk_auto_buf_reg {
+        __u16 index;      /* Buffer index for registration */
+        __u8 flags;       /* Registration flags */
+        __u8 reserved0;   /* Reserved for future use */
+        __u32 reserved1;  /* Reserved for future use */
+    };
+
+4. All reserved fields in ``ublk_auto_buf_reg`` must be zeroed.
+
+5. Optional flags can be passed via ``ublk_auto_buf_reg.flags``.
+
+Fallback Behavior
+~~~~~~~~~~~~~~~~~
+
+When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
+
+1. If auto buffer registration fails:
+   - The uring_cmd is completed
+   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_flags``
+   - The ublk server must manually register the buffer
+
+2. If fallback is not enabled:
+   - The ublk I/O request fails silently
+
+Limitations
+~~~~~~~~~~~
+
+- Requires same ``io_ring_ctx`` for all operations
+- May require manual buffer management in fallback cases
+- Reserved fields must be zeroed for future compatibility
+
+
 References
 ==========
 
-- 
2.47.0

