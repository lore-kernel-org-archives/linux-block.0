Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682325E476
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824169; cv=none; b=dsBwQr1EbN4jH0h42Mmt+ooof+vr54LHlwok9J2qV+7By7/KAEnrrgX0HbiAqnB6iARoyaUOac2yKFLTl8noA9iTJvMaNDDsqL9R/WSU0j3tBadRL5iRGnU5x9oaOy2Jb4Bk0fLAgR9JO7dgJh6n2vxYpiAei4w9YoxLX85sQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824169; c=relaxed/simple;
	bh=AzAN5NFT/P4TkEVTXa+HtzSo3blRvz4ZW8xUhNnJV7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bg0R+2KhRRBItn4QdkiBNkFV9noDkOQGAZYJkaQCTGTLauVWUl5bU+oju6/OwJrMg/tbp/MmylYs6aZJvLDE4bHPET7FsM7hLK60yJbhkJDL7YjVYUtq7V8jGl0bBzo6ETYqiK/RgzUyswc0TH4gInfgg/7FYitPqmdzyoyqn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZY9Ed1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZY9Ed1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5naekBr7yQCsXJvGDPIIRF9wkzoX03yreE2zvEF7XT0=;
	b=YZY9Ed1A2ZpVpE1hygz0KqrvNfp749NRCyr+xJ3gNFvRuU3+sUDbbZUK5gjGtVUlPpdcH7
	yoMyE+Emn5ChGF4V7rQBovk59R06aBUJmaEalBDRS5+dnGkXm55uii7auI9CMfpQTNrsmh
	+2hLoqV+kK472FowCtMVW0jEubdFr5o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-WIwN4FUMM6qn5Rg4CxwsPQ-1; Mon,
 24 Mar 2025 09:49:23 -0400
X-MC-Unique: WIwN4FUMM6qn5Rg4CxwsPQ-1
X-Mimecast-MFC-AGG-ID: WIwN4FUMM6qn5Rg4CxwsPQ_1742824162
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC7D61800A38;
	Mon, 24 Mar 2025 13:49:21 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E302180A802;
	Mon, 24 Mar 2025 13:49:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/8] ublk: cleanup & improvement & zc follow-up
Date: Mon, 24 Mar 2025 21:48:55 +0800
Message-ID: <20250324134905.766777-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Jens,

The 1st three patches are small cleanup.

The 4th & 5th patches are zc follow-up.

The 6th patch implements ->queue_rqs() and improves IOPS by > 10%.

The last two patches are self-test for ->queue_rqs() & segment parameter
change.

Each one is straight-forward.

Ming Lei (8):
  ublk: remove two unused fields from 'struct ublk_queue'
  ublk: add helper of ublk_need_map_io()
  ublk: truncate io command result
  ublk: add segment parameter
  ublk: document zero copy feature
  ublk: implement ->queue_rqs()
  selftests: ublk: add more tests for covering MQ
  selftests: ublk: add test for checking zero copy related parameter

 Documentation/block/ublk.rst                  |  28 +++--
 drivers/block/ublk_drv.c                      | 119 +++++++++++++++---
 include/uapi/linux/ublk_cmd.h                 |   9 ++
 tools/testing/selftests/ublk/Makefile         |   4 +
 tools/testing/selftests/ublk/null.c           |  11 +-
 tools/testing/selftests/ublk/test_common.sh   |   6 +
 .../testing/selftests/ublk/test_generic_02.sh |  44 +++++++
 .../testing/selftests/ublk/test_generic_03.sh |  28 +++++
 tools/testing/selftests/ublk/test_loop_01.sh  |  14 +--
 tools/testing/selftests/ublk/test_loop_03.sh  |  14 +--
 tools/testing/selftests/ublk/test_loop_05.sh  |  28 +++++
 .../testing/selftests/ublk/test_stripe_01.sh  |  14 +--
 .../testing/selftests/ublk/test_stripe_03.sh  |  30 +++++
 13 files changed, 298 insertions(+), 51 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_03.sh

-- 
2.47.0

