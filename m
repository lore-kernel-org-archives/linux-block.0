Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197EA4A08
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425061; cv=none; b=r4kxuDVw7nYsL+ag56tT4CposuDGcXW5UEJZAUADmTGfpaNICoNkU3/GO55u+Ibj5b6vc27iyZU4eWKB8ZDdZVrr3s2fs5glrjNsJb8ima/r9sTXMkLvUjhv8KA0GHICaSkyFp/VhNpqQ6voBYIqS8e9Q4FqUZJxjF8RKvcwrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425061; c=relaxed/simple;
	bh=K11n1iCPGAK7NWbPTyASLszti/kXnv0MxLO1P2QAe/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CK+JpVvjM3U+qVpYtyyxeokj86foW7DEmUcT5bk3y9iAA0vAcM7sWt+kZdIua6Xi2xrKZGIHpvhiHrVnHAQQYqAKj59tfy6duswen4KiXJh2PI0sBFhJ7+Rce3uFacMKcCeMNU0MXVL9vaBlvRkQBBtrd5kH+A0LHotsHUZt5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZTM5mhJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZTM5mhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OvJeTDzXoORR/6zOVom79oVMNaH+288Y/L/1zBEmEeg=;
	b=PZTM5mhJXgzUGrbiUgHBNN+MqdczC4cHE32mcd1/U3RY2EPMtJuNHDo4RfD1BVqiG70bwP
	yrOuJqRI/pjTRqMKjI3PeUtRcXE2rg9xYLdh8X+YGcCul+87Cn8BaCon6diE/X2zgF0tqR
	ZRER9JfmuftVCYL43iArqQQaL/j6ywc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-l-_3M4nWMcWlnWCdCF7RCA-1; Fri,
 11 Apr 2025 22:30:52 -0400
X-MC-Unique: l-_3M4nWMcWlnWCdCF7RCA-1
X-Mimecast-MFC-AGG-ID: l-_3M4nWMcWlnWCdCF7RCA_1744425047
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7CBA1809CA5;
	Sat, 12 Apr 2025 02:30:46 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CEB2180B487;
	Sat, 12 Apr 2025 02:30:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 00/13] selftests: ublk: test cleanup & add more tests
Date: Sat, 12 Apr 2025 10:30:16 +0800
Message-ID: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Jens,

This patchset cleans up ublk selftests and add more tests:

- two bug fixes(1, 2)

- cleanup (3, 4)

- allow to run tests in parallel(5), also big simplification on
test script

- add two stress tests for zero copy(6)

- kublk misc change(7, 8, 9), helps for evaluating performance

- support target specific command line, so help to add new
target(Uday is working on fault-inject target) (10)

- add two tests for covering recovery features(11)

- add one heavy io & remove test over recovery enabled device(12),
which can catch io hang triggered by several recent patches.

- the last patch is for making sure ublk temp file is cleaned up
if test is skipped

With this change, kernel built-in ublk selftests can :

- cover almost all tests done by ublksrv 'make test T=generic', which has
been effective to capture driver issue early, so it will make ublk driver
development more efficiently

- add more stress tests for covering ublk zc feature, which has found one
kernel panic issue introduced recently, fix merged already

- help to add new tests, such as per-target command line, which
will help to write fault-inject target


Thanks,

V2:
	- use ARRAY_SIZE() (Johannes Thumshirn)
	- drop one driver bug fix
	- fix ublk temp file cleanup
	- improve document

Ming Lei (13):
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
  selftests: ublk: move creating UBLK_TMP into _prep_test()

 tools/testing/selftests/ublk/Makefile         |   5 +
 tools/testing/selftests/ublk/kublk.c          | 342 ++++++++++++++++--
 tools/testing/selftests/ublk/kublk.h          |  39 +-
 tools/testing/selftests/ublk/stripe.c         |  28 +-
 tools/testing/selftests/ublk/test_common.sh   | 142 ++++++--
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
 21 files changed, 786 insertions(+), 174 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_05.sh

-- 
2.47.0

