Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F732E157
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573219; cv=none; b=XwammK/skUHeHl/OGdxWM71F9Wqd4jgsTRjCttndrRV6iv7Qf1wIaccsfC9uw8d1HrgQ7xF3Log9dJ8VFaMY1SpheJznzRpWsThlmSIINM+MDeQnH7kKkzNsCtsAP2/WvXpHFEDmWygkPn69ztGQONbTWJlt7/7wQh0SYE0aY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573219; c=relaxed/simple;
	bh=VQlluY2N78Sev5R234GbP6hsFvX6V/Y3DnyHDihpbkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBSQHfPtDToi/iXYsYQu1TUx+IP/rmOJ/uj+npdAUYmZLyFexRlnV8e4QXSJ6OxDNW21xGnXXSXAiQT7WLzho3OTfwIWzh7Z0qLkqtWq3SZ8/c86F+5jjN/vgrtmJk0be6AH3brIbZfccjaOTSK2NFkHsxCNpiSQFdEWOpeVkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWBL6yAA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWBL6yAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLcF+JUNiQP9L0JV6nLwc8ajodUt/2Cxa+DbWvvn4cc=;
	b=XWBL6yAACKk5kMP8U/ISuy8urL+8YNWDLO0KwkeaGVBrEnC4hhZSO+8is2R1AcS2WA15Pb
	yHniIFfIdS1niGEHpBo3t+xmxtgOLC5caarDRFiS9KlS/tqukvWO6j2dDPYUpH9GA0b7/U
	VjDo2QlmcGB5c01YD41XWPTL2JvqEEY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-TrTB11LeO0eYr3Nj1EGbFw-1; Fri,
 16 Jan 2026 09:20:09 -0500
X-MC-Unique: TrTB11LeO0eYr3Nj1EGbFw-1
X-Mimecast-MFC-AGG-ID: TrTB11LeO0eYr3Nj1EGbFw_1768573208
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9B48180034D;
	Fri, 16 Jan 2026 14:20:07 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62D2A1800665;
	Fri, 16 Jan 2026 14:20:04 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 12/24] ublk: document feature UBLK_F_BATCH_IO
Date: Fri, 16 Jan 2026 22:18:45 +0800
Message-ID: <20260116141859.719929-13-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Document feature UBLK_F_BATCH_IO.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 64 +++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 8c4030bcabb6..6ad28039663d 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -260,9 +260,12 @@ The following IO commands are communicated via io_uring passthrough command,
 and each command is only for forwarding the IO and committing the result
 with specified IO tag in the command data:
 
-- ``UBLK_IO_FETCH_REQ``
+Traditional Per-I/O Commands
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-  Sent from the server IO pthread for fetching future incoming IO requests
+- ``UBLK_U_IO_FETCH_REQ``
+
+  Sent from the server I/O pthread for fetching future incoming I/O requests
   destined to ``/dev/ublkb*``. This command is sent only once from the server
   IO pthread for ublk driver to setup IO forward environment.
 
@@ -278,7 +281,7 @@ with specified IO tag in the command data:
   supported by the driver, daemons must be per-queue instead - i.e. all I/Os
   associated to a single qid must be handled by the same task.
 
-- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
+- ``UBLK_U_IO_COMMIT_AND_FETCH_REQ``
 
   When an IO request is destined to ``/dev/ublkb*``, the driver stores
   the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
@@ -293,7 +296,7 @@ with specified IO tag in the command data:
   requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH_REQ``
   is reused for both fetching request and committing back IO result.
 
-- ``UBLK_IO_NEED_GET_DATA``
+- ``UBLK_U_IO_NEED_GET_DATA``
 
   With ``UBLK_F_NEED_GET_DATA`` enabled, the WRITE request will be firstly
   issued to ublk server without data copy. Then, IO backend of ublk server
@@ -322,6 +325,59 @@ with specified IO tag in the command data:
   ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
   the server buffer (pages) read to the IO request pages.
 
+Batch I/O Commands (UBLK_F_BATCH_IO)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``UBLK_F_BATCH_IO`` feature provides an alternative high-performance
+I/O handling model that replaces the traditional per-I/O commands with
+per-queue batch commands. This significantly reduces communication overhead
+and enables better load balancing across multiple server tasks.
+
+Key differences from traditional mode:
+
+- **Per-queue vs Per-I/O**: Commands operate on queues rather than individual I/Os
+- **Batch processing**: Multiple I/Os are handled in single operations
+- **Multishot commands**: Use io_uring multishot for reduced submission overhead
+- **Flexible task assignment**: Any task can handle any I/O (no per-I/O daemons)
+- **Better load balancing**: Tasks can adjust their workload dynamically
+
+Batch I/O Commands:
+
+- ``UBLK_U_IO_PREP_IO_CMDS``
+
+  Prepares multiple I/O commands in batch. The server provides a buffer
+  containing multiple I/O descriptors that will be processed together.
+  This reduces the number of individual command submissions required.
+
+- ``UBLK_U_IO_COMMIT_IO_CMDS``
+
+  Commits results for multiple I/O operations in batch, and prepares the
+  I/O descriptors to accept new requests. The server provides a buffer
+  containing the results of multiple completed I/Os, allowing efficient
+  bulk completion of requests.
+
+- ``UBLK_U_IO_FETCH_IO_CMDS``
+
+  **Multishot command** for fetching I/O commands in batch. This is the key
+  command that enables high-performance batch processing:
+
+  * Uses io_uring multishot capability for reduced submission overhead
+  * Single command can fetch multiple I/O requests over time
+  * Buffer size determines maximum batch size per operation
+  * Multiple fetch commands can be submitted for load balancing
+  * Only one fetch command is active at any time per queue
+  * Supports dynamic load balancing across multiple server tasks
+
+  It is one typical multishot io_uring request with provided buffer, and it
+  won't be completed until any failure is triggered.
+
+  Each task can submit ``UBLK_U_IO_FETCH_IO_CMDS`` with different buffer
+  sizes to control how much work it handles. This enables sophisticated
+  load balancing strategies in multi-threaded servers.
+
+Migration: Applications using traditional commands (``UBLK_U_IO_FETCH_REQ``,
+``UBLK_U_IO_COMMIT_AND_FETCH_REQ``) cannot use batch mode simultaneously.
+
 Zero copy
 ---------
 
-- 
2.47.0

