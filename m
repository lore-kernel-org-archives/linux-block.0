Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460482DFA49
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775702; cv=none; b=KRqU1BRe7A3Czqdry8OjVtHbRzXWx0ISfIR1yEOh+qQfU3t92SILPzQ+UUv64Ce+GNeqeZrRxWtdAjsi5TpdR0mYdQa1Cf9jKSD5HKmxQaWFsrA/x+1W076VhttX3/f+NcAgqFq91uZ3Mk8THy1+UcfPguj74avssQOMhX9l6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775702; c=relaxed/simple;
	bh=5ufKDZ9UgNkslkr8f39Hg8TAxKztyhagrNWkshhrOwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZX6XlQvixWsaMYZgB8R39idypgmZg/vAd6cfXUa+LWgKX7RQr8CCVSwikmM8gbj3CbyTdWlS8xVyK6XMsmxCCNTKaFHNPT3tV0D+bCKDo+dTErvDIX2KWIf5p0mBqmeGZKVF4UxmT0ut2JWM2YBdsi13nn89WJh3kqR5WimM/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXg/xNCb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXg/xNCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744775699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yGvLhMEqJdSK11JnMaL/tXoB2sQ4lW3KMWrRH9uHOjs=;
	b=JXg/xNCb0ptIZIpaLxUpZ69rxvvFHqjKJyjjaAQRNrnRbZOLKPU85aWsbw8St7ufBoIK3c
	V92OBHzcIFO8TXQLh8KO6v9IHFJKrEF4RW6lAYSVO2SBS7cnVt1bw7KiEGe2pQ7xjuXikq
	zgI7wILO2Muttl38HvzFbYrGO7k9pCI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63--c0i9mlPODCktf7M4JlGVQ-1; Tue,
 15 Apr 2025 23:54:55 -0400
X-MC-Unique: -c0i9mlPODCktf7M4JlGVQ-1
X-Mimecast-MFC-AGG-ID: -c0i9mlPODCktf7M4JlGVQ_1744775694
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFED61956089;
	Wed, 16 Apr 2025 03:54:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AC2E1801A65;
	Wed, 16 Apr 2025 03:54:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/8] ublk: simplify & improve IO canceling
Date: Wed, 16 Apr 2025 11:54:34 +0800
Message-ID: <20250416035444.99569-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello,

Patch 1st ~ 7th simplifies & improves IO canceling when ublk server daemon
is exiting by taking two stage canceling:

- canceling active uring_cmd from its cancel function

- move inflight requests aborting into ublk char device release handler

With this way, implementation is simplified a lot, meantime ub->mutex is
not required before queue becomes quiesced, so forward progress is
guaranteed.

This approach & main implementation is from Uday's patch of
"improve detection and handling of ublk server exit".

The last patch is selftest code for showing the improvement ublk server
exit, 30sec timeout is avoided, which depends on patchset of
"[PATCH V2 00/13] selftests: ublk: test cleanup & add more tests"[1].

[1] https://lore.kernel.org/linux-block/20250412023035.2649275-1-ming.lei@redhat.com/T/#medbf7024e57beaf1c53e4cef6e076421463839d0

Pass both ublk kernel selftests and ublksrv 'make test T=generic'.

Thanks,

V2:
	- drop 1st patch in V1, which isn't necessary
	- update "ublk: properly serialize all FETCH_REQs", which puts
	FETCH handling into single function, add comment on NONBLOCK
	- comment & commit log improvement
	- small cleanup from 5/8, 6/8

Ming Lei (5):
  ublk: add ublk_force_abort_dev()
  ublk: rely on ->canceling for dealing with
    ublk_nosrv_dev_should_queue_io
  ublk: move device reset into ublk_ch_release()
  ublk: remove __ublk_quiesce_dev()
  ublk: simplify aborting ublk request

Uday Shankar (3):
  ublk: properly serialize all FETCH_REQs
  ublk: improve detection and handling of ublk server exit
  selftests: ublk: add generic_06 for covering fault inject

 drivers/block/ublk_drv.c                      | 532 +++++++++---------
 tools/testing/selftests/ublk/Makefile         |   4 +-
 tools/testing/selftests/ublk/fault_inject.c   |  98 ++++
 tools/testing/selftests/ublk/kublk.c          |   3 +-
 tools/testing/selftests/ublk/kublk.h          |  12 +-
 .../testing/selftests/ublk/test_generic_06.sh |  41 ++
 6 files changed, 425 insertions(+), 265 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/fault_inject.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_06.sh

-- 
2.47.0

