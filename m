Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD682185BC
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803188; cv=none; b=TvXnpvaCX2b0aJYYDJL6UX/IPD/7q4QQYZB9moig/NzSjGROcybW/5GwB1SRiUd4zMS4HYxz1CCwkhbLwg7QiLWFnkqGmq+tfkrbn/QbCRMU8eeB4qGpwveiqw3ltY1JgTuuxj8Ow/nsMzaPgFDMJ9VxxHB+lzQIp5SN0iFtnfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803188; c=relaxed/simple;
	bh=9ucrJYnxSsEQakSx8n1gfQcHBvzJN2tBitaC0Sh3Rjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gir8sRCdwxuj+V2VMD1pwlxV1z990G4SOxwb3dnTXeE6KeNBo1Kb8v8BmaAtXyUoFT8pnf97f+ehVCamI/6v+/Ez9Lc9b7917SQAEMRIAjTA7pv1bLXf80iybXftNDtl+WS5zSLotfV1n0bghmZBIgEllNL+p2kDDxwUNabXg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/EoCJOu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/EoCJOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746803185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Oxd4NQ9t6ND1wwWPB3GqpmJsS2bcNCesFk98k8Aj2vo=;
	b=K/EoCJOucKP8+f2He56lxE72cUmEO8Y0Xkz3nh+kc7txYNC7fQmD0golNFTl3r+KOdT1rR
	8WUTCtnkT7wHVXi5V8Ck07p0c3ANBIpQrEGiue+W9onOW+6EY1qw2/iSE7sud+r7i/yUK8
	CVmUB+uJ6NBsxtd7T5gm4tSQYP5ciPc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-5ifKW5aANIio8hkn5iPLpg-1; Fri,
 09 May 2025 11:06:22 -0400
X-MC-Unique: 5ifKW5aANIio8hkn5iPLpg-1
X-Mimecast-MFC-AGG-ID: 5ifKW5aANIio8hkn5iPLpg_1746803181
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4BB8180035C;
	Fri,  9 May 2025 15:06:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EE15195607A;
	Fri,  9 May 2025 15:06:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/6] ublk: support to register bvec buffer automatically
Date: Fri,  9 May 2025 23:06:03 +0800
Message-ID: <20250509150611.3395206-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello Jens,

This patch tries to address limitation from in-tree ublk zero copy:

- one IO needs two extra uring_cmd for register/unregister bvec buffer, not
  efficient

- introduced dependency on the two buffer register/unregister uring_cmd, so
  buffer consumer has to linked with the two uring_cmd, hard to use & less
  efficient

This patchset adds feature UBLK_F_AUTO_BUF_REG:

- register request buffer automatically before delivering io command to ublk server

- unregister request buffer automatically when completing the request

- buffer index is specified from ublk uring_cmd header

With this way, 'fio/t/io_uring -p0 /dev/ublkb0' shows that IOPS is improved
by 50% compared with F_SUPPORT_ZERO_COPY in my test VM.

kernel selftests are added for covering both function & stress test.

V3:
	- simplify UAPI interface by passing auto-buf-reg data via sqe->addr

	- cleanup implementation & document

V2:
	- drop RFC
	- not cover buffer registering to external io_uring, so drop io_uring
	  changes, and it can be done in future, the defined UAPI interface
	  provides this extension
	- add one extra patch for relaxing context constraint for buffer register/
	unregister command
	- support to fallback to ublk server for registering buffer in case of auto
	buffer register failure, add tests for covering this feature
	- code cleanup & comment improvement(Caleb Sander Mateos) 

Link: https://lore.kernel.org/linux-block/20250428094420.1584420-1-ming.lei@redhat.com/

Ming Lei (6):
  ublk: allow io buffer register/unregister command issued from other
    task contexts
  ublk: convert to refcount_t
  ublk: prepare for supporting to register request buffer automatically
  ublk: register buffer to local io_uring with provided buf index via
    UBLK_F_AUTO_BUF_REG
  selftests: ublk: support UBLK_F_AUTO_BUF_REG
  selftests: ublk: add test for covering UBLK_AUTO_BUF_REG_FALLBACK

 drivers/block/ublk_drv.c                      | 165 +++++++++++++++---
 include/uapi/linux/ublk_cmd.h                 |  90 ++++++++++
 tools/testing/selftests/ublk/Makefile         |   3 +
 tools/testing/selftests/ublk/fault_inject.c   |   5 +
 tools/testing/selftests/ublk/file_backed.c    |  17 +-
 tools/testing/selftests/ublk/kublk.c          |  58 +++++-
 tools/testing/selftests/ublk/kublk.h          |  18 ++
 tools/testing/selftests/ublk/null.c           |  55 ++++--
 tools/testing/selftests/ublk/stripe.c         |  26 +--
 .../testing/selftests/ublk/test_generic_08.sh |  32 ++++
 .../testing/selftests/ublk/test_generic_09.sh |  28 +++
 .../testing/selftests/ublk/test_stress_03.sh  |   7 +
 .../testing/selftests/ublk/test_stress_04.sh  |   7 +
 .../testing/selftests/ublk/test_stress_05.sh  |   9 +
 14 files changed, 464 insertions(+), 56 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_09.sh

-- 
2.47.0

