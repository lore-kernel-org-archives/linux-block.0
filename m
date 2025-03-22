Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4B1C84D6
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635955; cv=none; b=DLnMmh1zAKJlWqfX4H74XH6luB55IWvOIc73EKgRuHGdwBiCsvKc9yRRcarltCpiK2jKfET8XiB4+Lu20BRAiB1Z0XKUHvUjCU28G6K4zcmfkDtHffbJQ8IMmkhlIoFucmmauAMB9cAQrGvYcH9YOeT5cL8nuxfF35FL8XuDgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635955; c=relaxed/simple;
	bh=UbDUrCIDFauzE59fSITgRfFE/IgI6uadD7HBg8dIcOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ohj8q19hdXAf5lZkT+fmt98jGuXWjiceBJdUzfV8l5vI8h1/9mZSBgiJtkuzbzsMZJixuZHCOvyYdLu3Kn3hkRqacXnLyJHYrIWiwYnMqE/HbSwKNc74XZx8hGG6Lk/0Bc6M2NPj8xFGVcgH3OvPggJQtavt7/q17grE1hch0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCQz0O2m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCQz0O2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Iih6lrj/TS6ZIyOpRtzSGwbuIDB8UIe/hXPLGweJVVc=;
	b=WCQz0O2mj2Cv2NcxGwWanYSwcZK4gAG6xnGY/f3R0Ug4Hj8ExMd0WTYAXHybCgvceJtYOk
	caVCxdWRP/jfOWPCASqcb+GtpQLmVaRKtQ/OJAHNQVPttcdVAjIVqb8mYbmPZIAC/DXAoo
	02Rr7zW1cIFAAwEHQ3M2dpAhrGGCfUQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-nAS_M481N5qaFrmYY_NZLQ-1; Sat,
 22 Mar 2025 05:32:30 -0400
X-MC-Unique: nAS_M481N5qaFrmYY_NZLQ-1
X-Mimecast-MFC-AGG-ID: nAS_M481N5qaFrmYY_NZLQ_1742635949
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AE1F180AB1C;
	Sat, 22 Mar 2025 09:32:29 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29BD8180175A;
	Sat, 22 Mar 2025 09:32:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/8] selftests: ublk: cleanup & more tests
Date: Sat, 22 Mar 2025 17:32:08 +0800
Message-ID: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Jens,

The 1st patch adds generic_01.sh for checking if IO is dispatched in order.

The 2nd ~ 7th patches clean up and simplify target implementation, add zc
for for null, which is useful for evaluating/comparing perf.

The 8th patch adds ublk/stripe target and two tests, which will be useful
for verifying multiple IOs aiming at same fixed kernel buffer, also can
be used for verifying vectored fixed kernel buffer in future if this
feature can be supported.


Ming Lei (8):
  selftests: ublk: add generic_01 for verifying sequential IO order
  selftests: ublk: add single sqe allocator helper
  selftests: ublk: increase max buffer size to 1MB
  selftests: ublk: move common code into common.c
  selftests: ublk: prepare for supporting stripe target
  selftests: ublk: enable zero copy for null target
  selftests: ublk: simplify loop io completion
  selftests: ublk: add stripe target

 tools/testing/selftests/ublk/Makefile         |   9 +-
 tools/testing/selftests/ublk/common.c         |  55 +++
 tools/testing/selftests/ublk/file_backed.c    | 167 ++++-----
 tools/testing/selftests/ublk/kublk.c          |  33 +-
 tools/testing/selftests/ublk/kublk.h          |  85 +++--
 tools/testing/selftests/ublk/null.c           |  72 +++-
 tools/testing/selftests/ublk/stripe.c         | 318 ++++++++++++++++++
 tools/testing/selftests/ublk/test_common.sh   |  22 ++
 .../testing/selftests/ublk/test_generic_01.sh |  44 +++
 tools/testing/selftests/ublk/test_null_02.sh  |  20 ++
 .../testing/selftests/ublk/test_stripe_01.sh  |  34 ++
 .../testing/selftests/ublk/test_stripe_02.sh  |  24 ++
 tools/testing/selftests/ublk/trace/seq_io.bt  |  25 ++
 13 files changed, 759 insertions(+), 149 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/common.c
 create mode 100644 tools/testing/selftests/ublk/stripe.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_02.sh
 create mode 100644 tools/testing/selftests/ublk/trace/seq_io.bt

-- 
2.47.0

