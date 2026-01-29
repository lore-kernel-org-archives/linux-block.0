Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC8335081
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703617; cv=none; b=g0Sz5N9fgfA4a5bGRK4ZUBqRXwrJltYO7REENV3VFk3qXcPUlHbxYpZo/aSUVGFKuV8Axv86Tg+psWpM5NdAsS3k0uXss19cCXc2JZfbRMGVHeTadDFmUlCXKI9S7b8Fc6ZVtss3YtSqzwyov/jowhN4lerjna3ki/Csn+aMFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703617; c=relaxed/simple;
	bh=wL4XT7bERUJVcWn4agiZKnnXM4Zex5aUsU1tY0KR4Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkElJn55i3jxud+x0hiFI4GOm0+RXpK30JV+SOt7INZZP+l6JB84LFRJVl/TeGaMRiUPJ3cwODVl5jK9CKUilyBNs6/eJ/JSz5zWeVjbicX6q9L9owBci7Rz4XvMr4srYrXa2C/Cjojfbbly8oPz5nwG4dU7m0lexsmB0Z9qKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahPHatdf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahPHatdf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sl+8jC4IqsC0EBLVufkIGzsqkMv3gZPWkJg65tUFMRA=;
	b=ahPHatdftgXdXKo9vHjwUq1WvsVykVpPmJo22zmi5fJxe0r6SCbDaTaQcybqxc9QKtURTD
	a1kq5tfvlFbURjDTqW7734Il/zEKw2eb96d17mZuGaJmck4kTEPS/luOjvodcV19RuJIDV
	0TUpcTiMih0nvYzbE/i8A0t/BhBPlss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-JjYYZAfMN-muhdCzmu6k9w-1; Thu,
 29 Jan 2026 11:20:11 -0500
X-MC-Unique: JjYYZAfMN-muhdCzmu6k9w-1
X-Mimecast-MFC-AGG-ID: JjYYZAfMN-muhdCzmu6k9w_1769703609
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6886F19560B3;
	Thu, 29 Jan 2026 16:20:09 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36B1719560A2;
	Thu, 29 Jan 2026 16:20:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/9] ublk: misc improvement in driver and selftests
Date: Fri, 30 Jan 2026 00:19:49 +0800
Message-ID: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The 1st patch improves fetch command removal and canceling, which is
reported as risk from AI.

The 2nd patch adds UBLK_F_NO_AUTO_PART_SCAN for disabling partition
scanning during adding disk.

The other patches improves ublk selftests:
	- rename test_generic_15 to test_part_02
	- refactor test_null_04 into separate functions and simplifying
	  implementations
	- kill IO verify failure in null/integrity tests by not scanning partition
	- mark each test start and end in dmesg log
	- move all temp files/dir into single directory, and allow user to
	  override default temp dir
  	- derive TID automatically from script name

V2:
	- add `selftests: ublk: move test temp files into a sub directory` for
	  avoiding conflict
	- avoid wq schedule for UBLK_F_NO_AUTO_PART_SCAN(Caleb Sander Mateos)
	- avoid sed in retrieving TID (Alexander Atanasov)
	- commit log typo fix on 2nd patch(Alexander Atanasov)
	- more ublk selftests improvement:
		- rename test_generic_15 to test_part_02
		- refactor test_null_04 into separate functions and simplifying implementations
		- kill IO failure in null/integrity tests by not scanning partition
		


Alexander Atanasov (2):
  selftests: ublk: mark each test start and end time in dmesg
  selftests: ublk: move test temp files into a sub directory

Ming Lei (7):
  ublk: check list membership before cancelling batch fetch command
  ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
  selftests: ublk: derive TID automatically from script name
  selftests: ublk: add selftest for UBLK_F_NO_AUTO_PART_SCAN
  selftests: ublk: rename test_generic_15 to test_part_02
  selftests: ublk: refactor test_null_04 into separate functions
  selftests: ublk: disable partition scan for integrity tests

 drivers/block/ublk_drv.c                      |  30 ++-
 include/uapi/linux/ublk_cmd.h                 |   3 +
 tools/testing/selftests/ublk/Makefile         |   4 +-
 tools/testing/selftests/ublk/kublk.c          |   6 +-
 tools/testing/selftests/ublk/kublk.h          |   3 +-
 tools/testing/selftests/ublk/test_batch_01.sh |   1 -
 tools/testing/selftests/ublk/test_batch_02.sh |   1 -
 tools/testing/selftests/ublk/test_batch_03.sh |   1 -
 tools/testing/selftests/ublk/test_common.sh   |  18 +-
 .../testing/selftests/ublk/test_generic_01.sh |   1 -
 .../testing/selftests/ublk/test_generic_02.sh |   1 -
 .../testing/selftests/ublk/test_generic_03.sh |   1 -
 .../testing/selftests/ublk/test_generic_04.sh |   1 -
 .../testing/selftests/ublk/test_generic_05.sh |   1 -
 .../testing/selftests/ublk/test_generic_06.sh |   1 -
 .../testing/selftests/ublk/test_generic_07.sh |   1 -
 .../testing/selftests/ublk/test_generic_08.sh |   1 -
 .../testing/selftests/ublk/test_generic_09.sh |   1 -
 .../testing/selftests/ublk/test_generic_10.sh |   1 -
 .../testing/selftests/ublk/test_generic_11.sh |   1 -
 .../testing/selftests/ublk/test_generic_12.sh |   1 -
 .../testing/selftests/ublk/test_generic_13.sh |   1 -
 .../testing/selftests/ublk/test_generic_14.sh |   1 -
 .../testing/selftests/ublk/test_generic_16.sh |   1 -
 tools/testing/selftests/ublk/test_loop_01.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_02.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_03.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_04.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_05.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_06.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_07.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_08.sh  |   1 -
 tools/testing/selftests/ublk/test_null_01.sh  |   1 -
 tools/testing/selftests/ublk/test_null_02.sh  |   1 -
 tools/testing/selftests/ublk/test_null_03.sh  |   1 -
 tools/testing/selftests/ublk/test_null_04.sh  | 249 +++++++-----------
 tools/testing/selftests/ublk/test_part_01.sh  | 104 ++++++++
 .../{test_generic_15.sh => test_part_02.sh}   |   1 -
 .../testing/selftests/ublk/test_stress_01.sh  |   1 -
 .../testing/selftests/ublk/test_stress_02.sh  |   1 -
 .../testing/selftests/ublk/test_stress_03.sh  |   1 -
 .../testing/selftests/ublk/test_stress_04.sh  |   1 -
 .../testing/selftests/ublk/test_stress_05.sh  |   1 -
 .../testing/selftests/ublk/test_stress_06.sh  |   1 -
 .../testing/selftests/ublk/test_stress_07.sh  |   1 -
 .../testing/selftests/ublk/test_stress_08.sh  |   1 -
 .../testing/selftests/ublk/test_stress_09.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_01.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_02.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_03.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_04.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_05.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_06.sh  |   1 -
 53 files changed, 249 insertions(+), 213 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_part_01.sh
 rename tools/testing/selftests/ublk/{test_generic_15.sh => test_part_02.sh} (99%)

-- 
2.47.0

