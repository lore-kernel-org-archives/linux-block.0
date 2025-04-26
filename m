Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC962221FC1
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745660488; cv=none; b=YTSeVgDwefPIN6Ezy7OKompIC8Dqv0+cswjhfOYccEYXxqvsFa9tblTlZXJrV5CP6FOh9EExS4jiADWhlKbUK9JKwMa7iTMOR5f4LH4Cd/Zu4K/YkKZQNkyo4FXOa2g7shNcSKttMTxgC/nF27tIbGcr9mWIlDCC3R7eir2MYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745660488; c=relaxed/simple;
	bh=cSvfXMWl00m70lT8oM2ogW4ycYtBP4A24mCMLa/Pm1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWUExyvd6o0EOiD62pv//nXcEjtboXOdxVXitSCYjc619iUHj8xt45eEdX9wlffaQKm+KR3NSODgb1a0V/1fNtWeSr+ZEywCnoa1yrZCTxE638eqPjxnOSi37oB9+xM9apYsa2VtjyzOAqhpl4Uw1pCQOtWOl20nDSTTHlq3+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2r02Tji; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2r02Tji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745660484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lu7aG5MgdTX3eULB3Z4HgwJjhh1oQpgT6jbnvweR0N4=;
	b=b2r02TjinSo3JhZIaF0ynhH75biX6d0Un+ygDIXSEZ09n+hrEqZJET2PDYph+R8O6KDVsy
	Vc5ovpazLqMjQLLmC5jCbtuD30MeZ8IFeOL7NOCjH4knu6RNuwGM6QOq+snuyYkDe/iuhA
	ECMrpi6FZ7RsHF0eSAFCW6fdFbJ9W/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-H0cGnaatPvCI2eYVQZ7V4w-1; Sat,
 26 Apr 2025 05:41:22 -0400
X-MC-Unique: H0cGnaatPvCI2eYVQZ7V4w-1
X-Mimecast-MFC-AGG-ID: H0cGnaatPvCI2eYVQZ7V4w_1745660481
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 302D41956094;
	Sat, 26 Apr 2025 09:41:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 130F6180045C;
	Sat, 26 Apr 2025 09:41:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] ublk: two fixes and support UBLK_F_AUTO_ZERO_COPY
Date: Sat, 26 Apr 2025 17:41:05 +0800
Message-ID: <20250426094111.1292637-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Jens,

The 1st patch fixes UBLK_F_NEED_GET_DATA implementation in selftest ublk utility,
meantime add test to cover this feature.

The 2nd patch enhances check for register/unregister IO buffer uring command.

The 3rd patch adds UBLK_F_AUTO_ZERO_COPY by registering zc buffer before delivering
io command to ublk server and un-registering zc buffer when completing io command.
This way not only improves zero copy perf, but also makes it much easier to use:

- ublk/null: iops is improved by 50%(--auto_zc vs. -z, -q 2)

- ublk server needn't to register/unregister io buffer uring_cmd any more,
  which is done automatically by ublk driver

- ublk server zc buffer consumer OPs need to depend on register/unregister
  io buffer uring_cmd any more. Without this feature, buffer consumer OP
  has to respect the dependency by IOSQE_IO_LINK.

The last patch adds function & stress tests for UBLK_F_AUTO_ZERO_COPY.

Thanks,
Ming

Ming Lei (4):
  selftests: ublk: fix UBLK_F_NEED_GET_DATA
  ublk: enhance check for register/unregister io buffer command
  ublk: add feature UBLK_F_AUTO_ZERO_COPY
  selftests: ublk: support UBLK_F_AUTO_ZERO_COPY

 drivers/block/ublk_drv.c                      | 110 +++++++++++++++---
 include/uapi/linux/ublk_cmd.h                 |  20 ++++
 tools/testing/selftests/ublk/Makefile         |   3 +
 tools/testing/selftests/ublk/file_backed.c    |   9 +-
 tools/testing/selftests/ublk/kublk.c          |  24 +++-
 tools/testing/selftests/ublk/kublk.h          |   7 ++
 tools/testing/selftests/ublk/null.c           |  43 +++++--
 tools/testing/selftests/ublk/stripe.c         |  14 +--
 .../testing/selftests/ublk/test_generic_07.sh |  25 ++++
 .../testing/selftests/ublk/test_generic_08.sh |  28 +++++
 .../testing/selftests/ublk/test_stress_03.sh  |   6 +
 .../testing/selftests/ublk/test_stress_04.sh  |   6 +
 .../testing/selftests/ublk/test_stress_05.sh  |   8 ++
 13 files changed, 257 insertions(+), 46 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_08.sh

-- 
2.47.0

