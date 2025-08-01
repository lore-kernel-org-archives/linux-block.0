Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A700A223707
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048700; cv=none; b=MwzqBolL/OEyKaIKee681DUbIX0CEKP9eQZE/O3YSz1h4vAQofGfcTHrSNspm72CWEdWGRvkHxp+ZdhjGiuIAt8aHXmO72b3XCXgrwQXBEk6iU5jZhjV0SrSlcBlqrtzTIpVABMyf+RSlK6y+nyAPugXyahK9DhAuzGa3EEsnw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048700; c=relaxed/simple;
	bh=BE7c08Vlo71YEAgDUIJCsPgp3AApEL5BNiUifnxT6sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LM7rwJTU5ipkJuYgL+LrPPSRQVYCUvbJthxYDzfftxdFUf1CKvrRNLCj32eOIrSu4c81nfmVvn2E8YyyC4VRuDyYCK+WTVgbVgYUD3F4MmSR+qZ5nfJIiucfdi8QfU4IQwfUJhk6AdDBcmh46FDXnyXRhpqRiivwl79VITf1voc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkMb+N7c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkMb+N7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754048696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tdiP23F9gX8FDkVI395T5GUJCR7QgfW9iB6rpXsK4EM=;
	b=KkMb+N7co5h3t0rVn4JQAJ16Iru3Tai8wW1xe4eMvPSN6LgC3Gzb8G1dzF5Hw/IlQQrEsL
	v7biT/Q+bC7kk6htfvCYvw16rYXnTV7jRa1N/5kw5qYSIca5VV6QEvri7LRzgIS988tWf9
	tiCb1bRLjieghP4AJ2LVRoR2ZgWzbRw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-vrhxSqx_OwCrK5bxHAC8BQ-1; Fri,
 01 Aug 2025 07:44:53 -0400
X-MC-Unique: vrhxSqx_OwCrK5bxHAC8BQ-1
X-Mimecast-MFC-AGG-ID: vrhxSqx_OwCrK5bxHAC8BQ_1754048692
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A116F180045B;
	Fri,  1 Aug 2025 11:44:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CF3C1800B7D;
	Fri,  1 Aug 2025 11:44:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] blk-mq: Replace tags->lock with SRCU for tag iterators
Date: Fri,  1 Aug 2025 19:44:32 +0800
Message-ID: <20250801114440.722286-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Jens,

Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
around the tag iterators.

Avoids scsi_host_busy() lockup during scsi host blocked  in case of big cpu
cores & deep queue depth.

Also it becomes possible to use blk_mq_in_driver_rw() for io accounting now.

Take the following approach:

- clearing rq reference in tags->rqs[] and deferring freeing scheduler requests
in SRCU callback

- replace tags->lock with srcu read lock in tags iterator.


Ming Lei (5):
  blk-mq: Move flush queue allocation into blk_mq_init_hctx()
  blk-mq: Pass tag_set to blk_mq_free_rq_map/tags
  blk-mq: Defer freeing of tags page_list to SRCU callback
  blk-mq: Defer freeing flush queue to SRCU callback
  blk-mq: Replace tags->lock with SRCU for tag iterators

 block/blk-mq-sched.c   |  4 +-
 block/blk-mq-sysfs.c   |  1 -
 block/blk-mq-tag.c     | 38 +++++++++++++++---
 block/blk-mq.c         | 87 +++++++++++++++++++++---------------------
 block/blk-mq.h         |  4 +-
 block/blk.h            |  1 +
 include/linux/blk-mq.h |  2 +
 7 files changed, 82 insertions(+), 55 deletions(-)

-- 
2.47.0

