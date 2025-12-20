Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CA1B424F
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766224431; cv=none; b=hiKeHP6CY4TADK5S9elfytDbvuRmIHNNezK565jwD3jGOITOwVR2oeKB2U/V+FeZ7lnFhbk2NCHbv2dodSur47WPXfzE8oOU3Ruel0fQzz1bTNEmPOKW9kqHvQ8WJ/mvDoC533o5hWKeK7YlQxF0EMGHjvmJJKWegNd7/WTZpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766224431; c=relaxed/simple;
	bh=Vx24/kMrA1cIZt/GZLJFdIxf81COT6QwxpCqCLrWdAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdFRW+/osokq1PxZYa3Vf4Ksoya2yGvX8WncUkjB42/DYfP0R4srPxJwLCeAZxCko2aFW7+ZHtNmZ8qOiIGxt7NTW1BEQD0MDGsDkaVrNjDj4OjFY49SeDlKJnSMSV0jtYG4eRxTbCkKnofIqUIVZKJQs5NSckRtbdbVW/iDl14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3H1hTrj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3H1hTrj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766224427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7hmgtMT4K4t5oMIHPp/kngi4M87knuek1BwEHzHTL3o=;
	b=H3H1hTrjMzZI3f9TafTrj0f/k8Bry+/GhFcW6Aa7pSdAZUc+KM1ZWq23fdhMCh/x7ruoSi
	FNiz1Widi88YL3tFgCx/K/gSvYPH/SIiUJ3F8YbGAmFjkCyydCC/uul1DqY2lmpq/HIK8r
	0JrEmnirG8Bl9cWGCrr4D8O2OHoY8xM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-P4I14QmPOKuVexFt9nNgtQ-1; Sat,
 20 Dec 2025 04:53:42 -0500
X-MC-Unique: P4I14QmPOKuVexFt9nNgtQ-1
X-Mimecast-MFC-AGG-ID: P4I14QmPOKuVexFt9nNgtQ_1766224421
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 573BE18002DE;
	Sat, 20 Dec 2025 09:53:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B9531955F1A;
	Sat, 20 Dec 2025 09:53:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
Date: Sat, 20 Dec 2025 17:53:20 +0800
Message-ID: <20251220095322.1527664-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello,

Add UBLK_F_NO_AUTO_PART_SCAN for avoiding to scan partition in start dev
command automatically, which is useful for network target.

Also add selftest code to make sure it works as expected.


Ming Lei (2):
  ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
  ublk: add selftest for UBLK_F_NO_AUTO_PART_SCAN

 drivers/block/ublk_drv.c                      |  16 ++-
 include/uapi/linux/ublk_cmd.h                 |   8 ++
 tools/testing/selftests/ublk/Makefile         |   1 +
 tools/testing/selftests/ublk/kublk.c          |   6 +-
 tools/testing/selftests/ublk/kublk.h          |   1 +
 .../testing/selftests/ublk/test_generic_14.sh | 105 ++++++++++++++++++
 6 files changed, 133 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh

-- 
2.47.0

