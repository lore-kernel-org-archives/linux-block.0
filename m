Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B622B8BD
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876648; cv=none; b=kObxnVzHzg30N2qOKBTPVO4k+SrGFU0B5syd8/AS/8o1LCF0ELuOY1U/bUJO0sQMuwrsGXQYDW5hg/bvoKQ7C/WyCGZB5C3cs1KT2KmrfcM9znRLweaH2CAUQYOXIj9X78M/92m8IkCkPzxcaUbvr3P83tsK/ATgDmXONoXICEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876648; c=relaxed/simple;
	bh=8IkpL3fG1wFEl2K6cUYryGkZNhDoYAJk1YaUYAfJ9IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL4UBNIMKrtn2fJhw0w/HaTE41/gA2CP8hPs2os1SRdxeCGpSATk0/HuU710wV3aLvaUTJO8jXqBx5ssGtd/BulXU4NB05HIkUKlFYdBX+rsBsqw/5saD9IXFmR7gP6hpisLP/hmxYOvEOB3WbRWkDcGQikLcBh3Znzvcv1SKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvYQ1flx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvYQ1flx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ssUp3Bgqcayra+cN6beKmooUoDbpPqzp7aq+FQYxFFo=;
	b=TvYQ1flxnJMET74y0LfIU1xJ83Q9btJemw0T3cj+SysMrqADAFHDBOo6irhhp5bsRmS65h
	27BFsJzBOB3Vya5yvCQCbZk4pKZuCJRJKjyABpO0QbTxI+sxffiZacJu9AmQcK8C8omD8e
	jT7YpcxlFex3Abynubk5FZ7ifeN7KEA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-jit4zEFFOSqQnn2-TfRDuA-1; Sat,
 31 Jan 2026 11:23:59 -0500
X-MC-Unique: jit4zEFFOSqQnn2-TfRDuA-1
X-Mimecast-MFC-AGG-ID: jit4zEFFOSqQnn2-TfRDuA_1769876638
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 894891800451;
	Sat, 31 Jan 2026 16:23:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EF011956056;
	Sat, 31 Jan 2026 16:23:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/9] selftests: ublk: test infrastructure improvements
Date: Sun,  1 Feb 2026 00:23:31 +0800
Message-ID: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

This series improves the ublk selftests infrastructure with better
organization and parallel test execution support.

Key improvements:

1. Infrastructure enhancements:
   - Add helper functions for device cleanup and parallel execution
   - Implement group-based test targets for running test subsets
   - Track created devices for proper per-test cleanup
   - Increase timeouts to accommodate parallel test execution
   - Test time can be reduced to 1/3 with parallel execution by passing JOBS=8

2. Test organization:
   - Reorganize tests into logical groups (integrity, recover)
   - Refactor large tests into modular functions for maintainability

3. I/O ordering verification:
   - Remove test_generic_01.sh prone to false positives from block layer reordering
   - Improve test_generic_02.sh with bpftrace-based verification
   - Use block_io_start/block_rq_complete tracepoints for accurate tracking

These changes make the test suite more maintainable, easier to run in parallel,
and more reliable in detecting actual ublk driver issues vs. false positives.


Ming Lei (9):
  selftests: ublk: simplify UBLK_TEST_DIR handling
  selftests: ublk: refactor test_loop_08 into separate functions
  selftests: ublk: add _ublk_del_dev helper function
  selftests: ublk: track created devices for per-test cleanup
  selftests: ublk: add group-based test targets
  selftests: ublk: add _ublk_sleep helper for parallel execution
  selftests: ublk: increase timeouts for parallel test execution
  selftests: ublk: reorganize tests into integrity and recover groups
  selftests: ublk: improve I/O ordering test with bpftrace

 tools/testing/selftests/ublk/Makefile         |  54 ++++++-
 tools/testing/selftests/ublk/test_common.sh   |  51 +++++--
 .../testing/selftests/ublk/test_generic_01.sh |  47 ------
 .../testing/selftests/ublk/test_generic_02.sh |  22 ++-
 .../testing/selftests/ublk/test_generic_16.sh |   4 +-
 .../{test_null_04.sh => test_integrity_01.sh} |   8 +-
 .../selftests/ublk/test_integrity_02.sh       | 141 ++++++++++++++++++
 tools/testing/selftests/ublk/test_loop_08.sh  | 110 --------------
 tools/testing/selftests/ublk/test_part_02.sh  |   6 +-
 ...{test_generic_04.sh => test_recover_01.sh} |   0
 ...{test_generic_05.sh => test_recover_02.sh} |   0
 ...{test_generic_11.sh => test_recover_03.sh} |   0
 ...{test_generic_14.sh => test_recover_04.sh} |   0
 tools/testing/selftests/ublk/trace/seq_io.bt  |  47 ++++--
 14 files changed, 284 insertions(+), 206 deletions(-)
 delete mode 100755 tools/testing/selftests/ublk/test_generic_01.sh
 rename tools/testing/selftests/ublk/{test_null_04.sh => test_integrity_01.sh} (96%)
 create mode 100755 tools/testing/selftests/ublk/test_integrity_02.sh
 delete mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
 rename tools/testing/selftests/ublk/{test_generic_04.sh => test_recover_01.sh} (100%)
 rename tools/testing/selftests/ublk/{test_generic_05.sh => test_recover_02.sh} (100%)
 rename tools/testing/selftests/ublk/{test_generic_11.sh => test_recover_03.sh} (100%)
 rename tools/testing/selftests/ublk/{test_generic_14.sh => test_recover_04.sh} (100%)

-- 
2.47.0

