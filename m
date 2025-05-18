Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E314EC5B
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747573999; cv=none; b=IineJ3AWr6eJcdtO6rMOqG/Db4BpPGolIO1kq+ReYU9PZJlbyoVe9olKfomODPB8iWxZeOXetxrl5U1kUVqppSny4VcxlRP7in1l4Z4uO3Hm49LmhpggDYoYQlYZAEYtLKKDFmQ46RlOjv2Qff2MA0JMfVmYA89UIGYYDrn3OAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747573999; c=relaxed/simple;
	bh=99KfNliyIB9d3AyaZyrX8AxvWdwimqxJ/isPw2jpAMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCFF8mp7NEVjwFjI1N/EthTBFe0NCFUKl+JMnyddO+cI2MRJuDl3Ic9VhDMJaadkphEfqY1PrCzGGi6Myw1BSUjK7lhUVvezWIh8CD7hmw+nr5/ogKkYPSz53Jr/i2t17IqRg5YD32L3Aty6P6CM1YSRYaXh5yQC825CqDby1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQTI0d4L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQTI0d4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747573996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VylvFd9me41K46rDGJCEdFBYRRGqWLOxsXQ+nKkB0d0=;
	b=fQTI0d4LAJknV1muZJQZ/ZL9a7l/VNyEw54QbdjbwBYMc3X8DP7xZSrsMr4JAgaMS6dg6V
	Sk8ZbNCJjO3QdtS6UCq9l+vWXJ6bATO89l90/DoSIoQLQtIHTf+bG3euYu8aIR5o+cX8ml
	cVhjXnvrOt7P8nQaRZDQy8/ISIbr+TU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-jNcG38i5NvGBvBeHrwEb8w-1; Sun,
 18 May 2025 09:13:13 -0400
X-MC-Unique: jNcG38i5NvGBvBeHrwEb8w-1
X-Mimecast-MFC-AGG-ID: jNcG38i5NvGBvBeHrwEb8w_1747573992
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FB8619560AA;
	Sun, 18 May 2025 13:13:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.32])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A4C0180049D;
	Sun, 18 May 2025 13:13:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/6] ublk: support to register bvec buffer automatically
Date: Sun, 18 May 2025 21:12:55 +0800
Message-ID: <20250518131303.195957-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

V4:
	- drop patch "ublk: allow io buffer register/unregister command issued
	  from other task contexts", which doesn't belong to this patchset

	- split out 'ublk: support UBLK_AUTO_BUF_REG_FALLBACK' (Caleb Sander
	  Mateos)

	- patch style & cleanup & document for addressing Caleb Sander Mateos's
	  comment

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
  ublk: convert to refcount_t
  ublk: prepare for supporting to register request buffer automatically
  ublk: register buffer to local io_uring with provided buf index via
    UBLK_F_AUTO_BUF_REG
  ublk: support UBLK_AUTO_BUF_REG_FALLBACK
  selftests: ublk: support UBLK_F_AUTO_BUF_REG
  selftests: ublk: add test for covering UBLK_AUTO_BUF_REG_FALLBACK

 drivers/block/ublk_drv.c                      | 148 +++++++++++++++---
 include/uapi/linux/ublk_cmd.h                 |  90 +++++++++++
 tools/testing/selftests/ublk/Makefile         |   3 +
 tools/testing/selftests/ublk/fault_inject.c   |   5 +
 tools/testing/selftests/ublk/file_backed.c    |  17 +-
 tools/testing/selftests/ublk/kublk.c          |  58 ++++++-
 tools/testing/selftests/ublk/kublk.h          |  18 +++
 tools/testing/selftests/ublk/null.c           |  55 +++++--
 tools/testing/selftests/ublk/stripe.c         |  26 +--
 .../testing/selftests/ublk/test_generic_08.sh |  32 ++++
 .../testing/selftests/ublk/test_generic_09.sh |  28 ++++
 .../testing/selftests/ublk/test_stress_03.sh  |   7 +
 .../testing/selftests/ublk/test_stress_04.sh  |   7 +
 .../testing/selftests/ublk/test_stress_05.sh  |   9 ++
 14 files changed, 449 insertions(+), 54 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_09.sh

-- 
2.47.0

