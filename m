Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB955253B7C
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031754; cv=none; b=nhlpEgtHFittz2tCVw9VdGxxB6yc4SchvYa66iuqlWNDLD1ptZ/7xDMDrRaJhNvMOp8dwBTc4qUahU+alKkmpdNrYVHw0loTatMLZ5Eynw3xXGjaJZlmYl0ttQJnw3aBok8NCSwodMCcT82hrtTl/kMD7v/MyLwiVP/DXdZqtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031754; c=relaxed/simple;
	bh=rg1W7c5oHkCdeXrFt4PwzJv7TJw0E4k9deA9lsCQtlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2ywM6Rl/wN6An3FIZw+bBwR9Z6IRrnoTDwmSEYE2pTQlTTmMAJb/QUZF6/pJWOMvhc+kL+q/928BLvL9WptyEEnD7jpdfGxVan3a+xwwRXORoRqJ6JO5YHxV+c3miKVlRacBx6eXbd2FAeMk0JFSMi4vz5zVX33gbHypcZBztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuZ/jdlT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuZ/jdlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BtQOZlbRRt9IpXzX9qB7o/gUmaTk1uGg/EWUf3kce24=;
	b=NuZ/jdlT5BlwZ18JxZJnnRk/HFXCLBzuEpUJoLDFUyeWm7BWYEUO5CZ++yGM4NYCTf35VS
	hGl0TV0Cv1DKFq2XtbZHynG1fRKIcqZjzPAEyo9jjhxvT906CgnSpAsUC/erIcIBZCtV4L
	5tt+BMEUvm1G9SxbxzBOQ/n8hs8561s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-9UWSTRa-PHWEZI3zkbZeBg-1; Mon,
 07 Apr 2025 09:15:45 -0400
X-MC-Unique: 9UWSTRa-PHWEZI3zkbZeBg-1
X-Mimecast-MFC-AGG-ID: 9UWSTRa-PHWEZI3zkbZeBg_1744031744
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8C9C1955DC5;
	Mon,  7 Apr 2025 13:15:43 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFF933001D13;
	Mon,  7 Apr 2025 13:15:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 00/13] ublk: one driver bug fix and selftest change
Date: Mon,  7 Apr 2025 21:15:11 +0800
Message-ID: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The 1st patch fixes kernel panic caused by aborting zc request, which
can be observed by the added stress_03/stress_04 tests.

The other patches are ublk selftest change:

- two bug fixes(2, 3)

- cleanup (4, 5)

- allow to run tests in parallel(6), also big simplification on
test script

- add two stress tests for zero copy(7)

- kublk misc change(8, 9, 10), helps for evaluating performance

- support target specific command line, so help to add new
target(Uday is working on fault-inject target) (11)

- add two tests for covering recovery features(12)

- add one heavy io & remove test over recovery enabled device(13),
which can catch io hang triggered by several recent patches.

Thanks,

Ming Lei (13):
  ublk: delay aborting zc request until io_uring returns the buffer
  selftests: ublk: fix ublk_find_tgt()
  selftests: ublk: add io_uring uapi header
  selftests: ublk: cleanup backfile automatically
  selftests: ublk: make sure _add_ublk_dev can return in sub-shell
  selftests: ublk: run stress tests in parallel
  selftests: ublk: add two stress tests for zero copy feature
  selftests: ublk: setup ring with
    IORING_SETUP_SINGLE_ISSUER/IORING_SETUP_DEFER_TASKRUN
  selftests: ublk: set queue pthread's cpu affinity
  selftests: ublk: increase max nr_queues and queue depth
  selftests: ublk: support target specific command line
  selftests: ublk: support user recovery
  selftests: ublk: add test_stress_05.sh

 drivers/block/ublk_drv.c                      |  31 +-
 tools/testing/selftests/ublk/Makefile         |   5 +
 tools/testing/selftests/ublk/kublk.c          | 341 ++++++++++++++++--
 tools/testing/selftests/ublk/kublk.h          |  37 +-
 tools/testing/selftests/ublk/stripe.c         |  28 +-
 tools/testing/selftests/ublk/test_common.sh   | 140 +++++--
 .../testing/selftests/ublk/test_generic_04.sh |  40 ++
 .../testing/selftests/ublk/test_generic_05.sh |  44 +++
 tools/testing/selftests/ublk/test_loop_01.sh  |   8 +-
 tools/testing/selftests/ublk/test_loop_02.sh  |   8 +-
 tools/testing/selftests/ublk/test_loop_03.sh  |   8 +-
 tools/testing/selftests/ublk/test_loop_04.sh  |   9 +-
 tools/testing/selftests/ublk/test_loop_05.sh  |   8 +-
 .../testing/selftests/ublk/test_stress_01.sh  |  45 +--
 .../testing/selftests/ublk/test_stress_02.sh  |  45 +--
 .../testing/selftests/ublk/test_stress_03.sh  |  38 ++
 .../testing/selftests/ublk/test_stress_04.sh  |  37 ++
 .../testing/selftests/ublk/test_stress_05.sh  |  64 ++++
 .../testing/selftests/ublk/test_stripe_01.sh  |  12 +-
 .../testing/selftests/ublk/test_stripe_02.sh  |  13 +-
 .../testing/selftests/ublk/test_stripe_03.sh  |  12 +-
 .../testing/selftests/ublk/test_stripe_04.sh  |  13 +-
 22 files changed, 811 insertions(+), 175 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_05.sh

-- 
2.47.0

