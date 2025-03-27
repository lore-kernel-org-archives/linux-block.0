Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F41FF7D1
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069098; cv=none; b=uJ1vTLySKmEzPRIFykTzhj5l8rVKUbaM63QHhg7Sq6ystnQLzLUpewRPv0JPCEwDoEJHT/QfRavYsh0pXY/VrxsPOhV+mg26Hn1HHkMHplBXS8HioppTqzdaeKDUaUGEMOZ5NP54oYWT05YsrB+YhuNvgb8guATxB7UY8s/cvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069098; c=relaxed/simple;
	bh=0Uubhvslg/Kx8DcG9nL161RJTUb03gtKGUJYI2/bwcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUQdXoYw6/YmngIb8gmSXiklwNlZgmwjJM48GuxxSYoM7IELZr9gS1xoyJg01fEg0wgxrR0Z+HHNXeCpr4sWMLUVMi1lBpoFqvgsaMHYNXkPasMvskT9UbN3CE7uzaRD0rKHm5gU9pQh/fNS+Y88sx9xx+dvIrDZcUQbyPbpDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SB9mvxc+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SB9mvxc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hQZvyFAfbXgG9mlLVmS1FxGaSBKoaaeClTY6dlBO6nY=;
	b=SB9mvxc+eGM4nqeN2bAGGwRhJQQrVx6Mz+OgAYpSbA7ZV6UIiNwMmVT1b+O23aReEW6/zZ
	GGzx681P4F5qtsgW2gCKFyI71VRfQZqXixvzh2OEtgfmGBMXRVQQ99eQHJUQYW/GntUWnB
	NtGsIgZ0+XmVp+Cv6HXUHqXRXugJcqU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-xLwqN1xAPpi_wPZCgV4tFA-1; Thu,
 27 Mar 2025 05:51:33 -0400
X-MC-Unique: xLwqN1xAPpi_wPZCgV4tFA-1
X-Mimecast-MFC-AGG-ID: xLwqN1xAPpi_wPZCgV4tFA_1743069092
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DF701809CA6;
	Thu, 27 Mar 2025 09:51:32 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1428E1956095;
	Thu, 27 Mar 2025 09:51:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 00/11] ublk: cleanup & improvement & zc follow-up
Date: Thu, 27 Mar 2025 17:51:09 +0800
Message-ID: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello Jens,

The 1st two fixes ublk_abort_requests(), and adds comment on handling
ubq->canceling.

The 3rd ~ 5th patches are cleanup.

The 6th and 7th are zc-followup.

The 8th & 9th patch implements ->queue_rqs() and improves IOPS by > 10%.

The last two patches are self-test for ->queue_rqs() & segment parameter
change.

V2:
	- use io_uring_cmd_to_pdu() (Uday)
	- improve zc document (Caleb)
	- consolidate segment parameter interface (Caleb)
	- add reviewed-by
	- add one fix and comment on ubq->canceling
	- fix one hang bug in V2


Ming Lei (11):
  ublk: make sure ubq->canceling is set when queue is frozen
  ublk: comment on ubq->canceling handling in ublk_queue_rq()
  ublk: remove two unused fields from 'struct ublk_queue'
  ublk: add helper of ublk_need_map_io()
  ublk: call io_uring_cmd_to_pdu to get uring_cmd pdu
  ublk: add segment parameter
  ublk: document zero copy feature
  ublk: implement ->queue_rqs()
  ublk: rename ublk_rq_task_work_cb as ublk_cmd_tw_cb
  selftests: ublk: add more tests for covering MQ
  selftests: ublk: add test for checking zero copy related parameter

 Documentation/block/ublk.rst                  |  35 ++-
 drivers/block/ublk_drv.c                      | 214 ++++++++++++++----
 include/uapi/linux/ublk_cmd.h                 |  25 ++
 tools/testing/selftests/ublk/Makefile         |   4 +
 tools/testing/selftests/ublk/null.c           |  11 +-
 tools/testing/selftests/ublk/test_common.sh   |   6 +
 .../testing/selftests/ublk/test_generic_02.sh |  44 ++++
 .../testing/selftests/ublk/test_generic_03.sh |  28 +++
 tools/testing/selftests/ublk/test_loop_01.sh  |  14 +-
 tools/testing/selftests/ublk/test_loop_03.sh  |  14 +-
 tools/testing/selftests/ublk/test_loop_05.sh  |  28 +++
 .../testing/selftests/ublk/test_stress_01.sh  |   6 +-
 .../testing/selftests/ublk/test_stress_02.sh  |   6 +-
 .../testing/selftests/ublk/test_stripe_01.sh  |  14 +-
 .../testing/selftests/ublk/test_stripe_03.sh  |  30 +++
 15 files changed, 397 insertions(+), 82 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_03.sh

-- 
2.47.0

