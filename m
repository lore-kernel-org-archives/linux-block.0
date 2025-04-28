Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0B264628
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745833482; cv=none; b=XCqCYv3/5szL0x1S1V5KTd+LmMJ04R6QRgPi832SgJF5PwAFvplX3jKVaQ45VPW4gB3/W+R1kx0vbYqBV9NJCr69e7unlW1hCRe9VQE8zjmRa2teP3tSls/8u/imiRWUkEJnVsIfwUKV3To9vmsiqAEn9twTectOGTQgp0hMs8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745833482; c=relaxed/simple;
	bh=nyIp/cP+ImVyfgsCQzedCWxfSXvFZ8EHfmo6uU5BzK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YS8mIh1NYBmRV7Xpp9nyICfDc5jYATZ1MjDibGM4VeKSUbXjtWU8RGjI7RA+y3c0/TkZ2SbzCU3dQB0aYy+snTab1STMSeQBUZMyoHPl6X8q6+zpm3vBd5Jk6uzgr9vGo9H7IfRNfK5XbmMSAmOMBto+jJlx57GRXw7EDdQq72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gv8IyQtO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv8IyQtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745833479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0wSm44iymHLUeNH7RrnsvIt4Qra2S4j4z3mK7tPws/4=;
	b=gv8IyQtOkKCxvprgm5nCIVBCvQc978Lk7h8acm9deO73bANm2GeKDrCdRRx0KN8fMSY/YX
	AMXdrm61CgJcuokEBogf0ISakmrYhnZbrfZVZIM6EsMsV3nHm+0XjV6/15ngecobBVOpdQ
	Uf/5zUO8i/HOlyOV6Og1jyPr++KeC4Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-E-R_Bx6fMOmk5pT58phCRA-1; Mon,
 28 Apr 2025 05:44:35 -0400
X-MC-Unique: E-R_Bx6fMOmk5pT58phCRA-1
X-Mimecast-MFC-AGG-ID: E-R_Bx6fMOmk5pT58phCRA_1745833474
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDFF31956086;
	Mon, 28 Apr 2025 09:44:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C62CF19560A3;
	Mon, 28 Apr 2025 09:44:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 0/7] ublk: support to register bvec buffer automatically
Date: Mon, 28 Apr 2025 17:44:11 +0800
Message-ID: <20250428094420.1584420-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jens,

This patch tries to address limitation from in-tree ublk zero copy:

- one IO needs two extra uring_cmd for register/unregister bvec buffer, not
  efficient

- introduced dependency on the two uring_cmd, so the buffer consumer has to
linked with the two uring_cmd, hard to use & less efficient

This patchset adds feature UBLK_F_AUTO_BUF_REG:

- register request buffer automatically before delivering io command to ublk server

- unregister request buffer automatically when completing the request

- both io_uring context and buffer index can be specified from ublk
  uring_cmd header

With this way, 'fio/t/io_uring -p0 /dev/ublkb0' shows that IOPS is improved
by 50% compared with F_SUPPORT_ZERO_COPY in my test VM.

kernel selftests are added for covering both function & stress test.

Please review & comment!

Thanks,
Ming

Ming Lei (7):
  io_uring: add 'struct io_buf_data' for register/unregister bvec buffer
  io_uring: add helper __io_buffer_[un]register_bvec
  io_uring: support to register bvec buffer to specified io_uring
  ublk: convert to refcount_t
  ublk: prepare for supporting to register request buffer automatically
  ublk: register buffer to specified io_uring & buf index via
    UBLK_F_AUTO_BUF_REG
  selftests: ublk: support UBLK_F_AUTO_BUF_REG

 drivers/block/ublk_drv.c                      | 165 ++++++++++++++----
 include/linux/io_uring/cmd.h                  |  15 +-
 include/uapi/linux/ublk_cmd.h                 |  38 ++++
 io_uring/rsrc.c                               | 141 ++++++++++-----
 tools/testing/selftests/ublk/Makefile         |   2 +
 tools/testing/selftests/ublk/file_backed.c    |  12 +-
 tools/testing/selftests/ublk/kublk.c          |  24 ++-
 tools/testing/selftests/ublk/kublk.h          |   6 +
 tools/testing/selftests/ublk/null.c           |  43 +++--
 tools/testing/selftests/ublk/stripe.c         |  21 +--
 .../testing/selftests/ublk/test_generic_08.sh |  32 ++++
 .../testing/selftests/ublk/test_stress_03.sh  |   6 +
 .../testing/selftests/ublk/test_stress_04.sh  |   6 +
 .../testing/selftests/ublk/test_stress_05.sh  |   8 +
 14 files changed, 409 insertions(+), 110 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_08.sh

-- 
2.47.0

