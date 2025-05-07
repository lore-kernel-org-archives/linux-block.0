Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445212BB13
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592769; cv=none; b=IqR6zVpULBcIf19dD2TP6VYMBjpR5+xzTp1GFhytHOwT7k+O4MOW7a+JrLKrhcxogqoAEa2BNRd0ieCOY0kmNIrYRB/xHlx/KAZVxywR/ZT9+j5E9PhnY7E0FZVkQX87D+nOcB0+ukKJ2t/9j19cCuS0+imGhKL28Pa7vbZoIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592769; c=relaxed/simple;
	bh=ZdIaCmFhpFtFMHC15bn+7Tr8Zwt+HNPqvK1xxKVuM/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxYDHv2tzSYKipKM99UEXPmUi+kCIcELHVOlvDjzoc4vKop1qZb/S/rs0dNlZFyok/MIMcrvyRe5zURNo9aZkqgNRp3GeYvMz8B//FVxgwQYM8tM0R+ikMGNQZh94EkWWC5CBse76hKfqky3GUxewwahydbEYWlDrBKk6qJkvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDY2LSs2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDY2LSs2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746592766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T/fRNe3zVRXU8xL1eXOduKfwiJwVJaMJfyA9538+U/Q=;
	b=TDY2LSs2jzMlTZUvRxOtlrX9yFZiG/mHk8gfCvJUAyAbHva9YzY225dR885XK34fEedpPc
	OqCsIaf0zSVbD8hvxlJFkuUH6Jrix9zHIQmJ6sk5LbnEZjBM5KHS8e2eAP18wyI8a5xFRr
	qqB/JJd69gJ7wzC5mS3dxRzL0mBMRA8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-DK6LuIUxMpKnVJLueT2VWQ-1; Wed,
 07 May 2025 00:39:22 -0400
X-MC-Unique: DK6LuIUxMpKnVJLueT2VWQ-1
X-Mimecast-MFC-AGG-ID: DK6LuIUxMpKnVJLueT2VWQ_1746592761
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7831A1801BC7;
	Wed,  7 May 2025 04:39:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63F3B1800874;
	Wed,  7 May 2025 04:39:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/6] ublk: support to register bvec buffer automatically
Date: Wed,  7 May 2025 12:38:51 +0800
Message-ID: <20250507043859.2978132-1-ming.lei@redhat.com>
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
  ublk: allow io buffer register/unregister command issued from other
    task contexts
  ublk: convert to refcount_t
  ublk: prepare for supporting to register request buffer automatically
  ublk: register buffer to local io_uring with provided buf index via
    UBLK_F_AUTO_BUF_REG
  selftests: ublk: support UBLK_F_AUTO_BUF_REG
  selftests: ublk: add test for covering UBLK_AUTO_BUF_REG_FALLBACK

 drivers/block/ublk_drv.c                      | 157 ++++++++++++++----
 include/uapi/linux/ublk_cmd.h                 |  64 +++++++
 tools/testing/selftests/ublk/Makefile         |   3 +
 tools/testing/selftests/ublk/fault_inject.c   |   5 +
 tools/testing/selftests/ublk/file_backed.c    |  17 +-
 tools/testing/selftests/ublk/kublk.c          |  49 +++++-
 tools/testing/selftests/ublk/kublk.h          |  18 ++
 tools/testing/selftests/ublk/null.c           |  55 ++++--
 tools/testing/selftests/ublk/stripe.c         |  26 +--
 .../testing/selftests/ublk/test_generic_08.sh |  32 ++++
 .../testing/selftests/ublk/test_generic_09.sh |  28 ++++
 .../testing/selftests/ublk/test_stress_03.sh  |   7 +
 .../testing/selftests/ublk/test_stress_04.sh  |   7 +
 .../testing/selftests/ublk/test_stress_05.sh  |   9 +
 14 files changed, 417 insertions(+), 60 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_09.sh

-- 
2.47.0

