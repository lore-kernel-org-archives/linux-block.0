Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8D1C4609
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927256; cv=none; b=fAFS4RnavpJHaeX4jLH//wWNLpKIt1JtpJKJsTQFvll4gYGKyefINOFt/dvE81fcvNFaC51XX8reRNH3GbzuS28hWRO7e6wwQa7eksY4wfWa2/oUTVng40F3/ZvtdqwCCDR3KSssP2Quo8sImUwyWk40aqqVWxNdy7fp3mRhsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927256; c=relaxed/simple;
	bh=5yFSgnRCoR5hzBRX4z5o/Vzs3rICy6rloKsSv5U2L9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+6V7Z2621kSS3j66c+hF00i1kwfL4tdPnn5a/UOtbgSAbHliWPW4zjYhUCD3IyM5gHm705cM6tWJg6GpYQVeDPoKmk53a0s9dNylS1W6kMwLrgQH88wqvV8KdY2hnV1BsxLl033OfY4p74X0Llop4VDIjO02SNt0OP0CeJUT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fni6Kqwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fni6Kqwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747927253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9DIEUIVSfCSgYfBN1pN9oMgRu83Kfd7kAcmYyKh5ED0=;
	b=fni6Kqwij7XPucZroHy6QYbqkiH/mPQAWFIDCRFHhpUPhPO4E/fIO9fy9VQxB1UaPXRmXz
	8kB6S3maiWtEFWrkJpg/HqMVwsu1YTBosiIih/ew7LhxTOq5LFPEjHskvqZg9RCv1dAX8B
	wP7YnSwseE6xlCrHOfSzd+hQfAz2dpg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-rU0b94KJPEaVI6gkqm4BFA-1; Thu,
 22 May 2025 11:20:52 -0400
X-MC-Unique: rU0b94KJPEaVI6gkqm4BFA-1
X-Mimecast-MFC-AGG-ID: rU0b94KJPEaVI6gkqm4BFA_1747927251
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 057E51800366;
	Thu, 22 May 2025 15:20:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0361F18003FC;
	Thu, 22 May 2025 15:20:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] ublk: run auto buf unregister on same io_ring_ctx with register
Date: Thu, 22 May 2025 23:20:38 +0800
Message-ID: <20250522152043.399824-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Jens,

The 1st patch adds helper io_uring_cmd_ctx_handle().

The 2nd one use the added helper to run auto-buf-unreg on the same
io_uring_ctx with the register one.

Thanks,
Ming

V2:
	- return `void *` from io_uring_cmd_ctx_handle() (Caleb Sander Mateos)
	- typo & document fix (Caleb Sander Mateos)


Ming Lei (2):
  io_uring: add helper io_uring_cmd_ctx_handle()
  ublk: run auto buf unregisgering in same io_ring_ctx with registering

 drivers/block/ublk_drv.c      | 19 ++++++++++++++++---
 include/linux/io_uring/cmd.h  |  9 +++++++++
 include/uapi/linux/ublk_cmd.h |  6 +++++-
 3 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.47.0

