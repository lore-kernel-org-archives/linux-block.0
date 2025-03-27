Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51B20D4F9
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069131; cv=none; b=U3diJgySewR+6XYroDuNhmME/mwHBOGy2arUZaqsYSt7YCCWgKoJFJMhhj/ogzrYbu2K99fCoHXeQ0X/ukAovqhOOXvtnxTrNvcMOUITl6k63RoRPAlp3aYM5LVDp5VVeXMSXsT23kqim4dQMfzmBQy/c8vnt/DnvMhC0W2TRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069131; c=relaxed/simple;
	bh=YR9H23ELDAR2h+U151ru/9gfbkLqACHvu2O0ca7Lj/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhDnBVND6S7Cde+rLBFlznfQ6pvPnyyRy/if6HTHYWh5Vt5u6+kw3WY7G2FZVR7rbBw5UanU1LpDWBfke9jJnFTfe6xlHyUDQelv9XLm7xYSKm0X9WKDkozXCgRhGUw5qL6NtiJeguCmXjRDKDx/304KUJyHUnyihQRKHrSNhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hc3P8tZy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc3P8tZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xk+exhIlCPp8aznnhECR4dZ0OnIYMDVjf7IHKcKbC+w=;
	b=Hc3P8tZyxshDh9Y1Bj7J7zmWqO3LrAyKHGw/2upm4G1rtrpTpFIdG8LU9jLLDTbar1cQzf
	7FAVPis+e7MX/NWek6VZePxCRdd1qEBghwlTRasZYCaqfL9Mkbj0V1jaa7iCjaG7J2zyC3
	ElCjdOdz9ekFABniwh0e3FUaZdvXQ0g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-9WvFzHUBOO6T5rpEva95FA-1; Thu,
 27 Mar 2025 05:52:08 -0400
X-MC-Unique: 9WvFzHUBOO6T5rpEva95FA-1
X-Mimecast-MFC-AGG-ID: 9WvFzHUBOO6T5rpEva95FA_1743069127
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B12BF180035C;
	Thu, 27 Mar 2025 09:52:06 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B79F91801750;
	Thu, 27 Mar 2025 09:52:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 07/11] ublk: document zero copy feature
Date: Thu, 27 Mar 2025 17:51:16 +0800
Message-ID: <20250327095123.179113-8-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add words to explain how zero copy feature works, and why it has to be
trusted for handling IO read command.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 1e0e7358e14a..74c57488dc9a 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -309,18 +309,35 @@ with specified IO tag in the command data:
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
-
+ublk zero copy relies on io_uring's fixed kernel buffer, which provides
+two APIs: `io_buffer_register_bvec()` and `io_buffer_unregister_bvec`.
+
+ublk adds IO command of `UBLK_IO_REGISTER_IO_BUF` to call
+`io_buffer_register_bvec()` for ublk server to register client request
+buffer into io_uring buffer table, then ublk server can submit io_uring
+IOs with the registered buffer index. IO command of `UBLK_IO_UNREGISTER_IO_BUF`
+calls `io_buffer_unregister_bvec()` to unregister the buffer, which is
+guaranteed to be live between calling `io_buffer_register_bvec()` and
+`io_buffer_unregister_bvec()`. Any io_uring operation which supports this
+kind of kernel buffer will grab one reference of the buffer until the
+operation is completed.
+
+ublk server implementing zero copy or user copy has to be CAP_SYS_ADMIN and
+be trusted, because it is ublk server's responsibility to make sure IO buffer
+filled with data for handling read command, and ublk server has to return
+correct result to ublk driver when handling READ command, and the result
+has to match with how many bytes filled to the IO buffer. Otherwise,
+uninitialized kernel IO buffer will be exposed to client application.
+
+ublk server needs to align the parameter of `struct ublk_param_dma_align`
+with backend for zero copy to work correctly.
+
+For reaching best IO performance, ublk server should align its segment
+parameter of `struct ublk_param_segment` with backend for avoiding
+unnecessary IO split, which usually hurts io_uring performance.
 
 References
 ==========
-- 
2.47.0

