Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FF1714B3
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629966; cv=none; b=G5nDccI9ayGOgwJ/ZuhNSz4ovunAu58YDlsQiGZri0Xwif1LgEWssKnwvmZVo1s15yPyUE89yM4azoIisVVENDOwyTb9aWUBzHEzQqy7PXTmzaiTdT54L3Dome2RxpxeE260ANby1RmoRlgJJhu6bTxTN4dfoKW9kbkKfGJsEEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629966; c=relaxed/simple;
	bh=sGqCBzTIst1Mo8BcDYlTqyF6BzvgaFezMWO/QEugyp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5ijCmSoMqadZUQk2828yTo4ok+yOPSSrpYsfr7KU1GX5GkJWeOTuh/KoB+9xq/Ec+a47HJj9jBrxqCfDb6dsfl0tZWlIH1HZ+jED6TZbEHxv0yFFiHGYc7fAduRyyMbRiWmV1S26ZAZdhN7ZiB5yokXHu2EwF+3gUANY9xH+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2kGVTOs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2kGVTOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744629963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uk3lEGVd6Ogx6M+2IsPezWpbiqyQVqbHFRqfWWpkf+U=;
	b=L2kGVTOstRusJin5szUswyaFOQivY719BG0b5qRMhULZHrKvm44oo4z7uTtPfAbq0IXVOO
	0ftQHK38lB7L84b+gqFjy2Rc50UIEHmW9ZS+Muq+Sb5z3LZeNLDEALIyGhLI79U/eOAp2s
	GL9E3JlIk1zr+OcWT/V0/wcbiONOmnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-5BaWa13gPMu7m5QDLsGyXQ-1; Mon,
 14 Apr 2025 07:26:00 -0400
X-MC-Unique: 5BaWa13gPMu7m5QDLsGyXQ-1
X-Mimecast-MFC-AGG-ID: 5BaWa13gPMu7m5QDLsGyXQ_1744629959
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D85031801A1A;
	Mon, 14 Apr 2025 11:25:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D46E53001D13;
	Mon, 14 Apr 2025 11:25:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/9] ublk: simplify & improve IO canceling
Date: Mon, 14 Apr 2025 19:25:41 +0800
Message-ID: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello,

The 1st patch is one bug fix.

Patch 2nd ~ 8th simplifies & improves IO canceling when ublk server daemon
is exiting by taking two stage canceling:

- canceling active uring_cmd from its cancel function

- move inflight requests aborting into ublk char device release handler

With this way, implementation is simplified a lot, meantime ub->mutex is
not required before queue becomes quiescing, so forward progress is
guaranteed.

This approach & main implementation is from Uday's patch of
"improve detection and handling of ublk server exit".

The last patch is selftest code for showing the improvement ublk server
exit, 30sec timeout is avoided, which depends on patchset of
"[PATCH V2 00/13] selftests: ublk: test cleanup & add more tests"[1].

[1] https://lore.kernel.org/linux-block/20250412023035.2649275-1-ming.lei@redhat.com/T/#medbf7024e57beaf1c53e4cef6e076421463839d0

Pass both ublk kernel selftests and ublksrv 'make test T=generic'.

Thanks,


Ming Lei (6):
  ublk: don't try to stop disk if ->ub_disk is NULL
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

 drivers/block/ublk_drv.c                      | 484 +++++++++---------
 tools/testing/selftests/ublk/Makefile         |   4 +-
 tools/testing/selftests/ublk/fault_inject.c   |  98 ++++
 tools/testing/selftests/ublk/kublk.c          |   3 +-
 tools/testing/selftests/ublk/kublk.h          |  12 +-
 .../testing/selftests/ublk/test_generic_06.sh |  41 ++
 6 files changed, 397 insertions(+), 245 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/fault_inject.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_06.sh

-- 
2.47.0

