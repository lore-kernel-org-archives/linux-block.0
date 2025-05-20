Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BAD2459C7
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747716912; cv=none; b=HQbfxONu7HjU3tURVhn2225lWvjbSTO7uvvUqxTV1CqSjqaoPUIfFXuc061rEBRonT3CdGZ2CXs2nn03GBKO4VS53oEcvc1fsEgTwfuLurTn3o8sjtckhdfhxOGIrKLN/DPmHRznGMp+Da7A7LG7noOz6FL5rSSdgS4SHvc9r3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747716912; c=relaxed/simple;
	bh=pD8ryWB5JBbXndENDVPfIzoy+hY2l2/gKgUOclHEam8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzHxiS6pAsJ3V+1l3jhcDTrvoWRQQHWDuvRQb/EDceo0bD2LEASj3O1dUOpQRoffjyiSID4xggdCrNXJVhk8TzBLNVXCrcJhgAWFd1t2A6cvp5iodHbl9cb+twnbua728Pg94UZkRR2cO3UKSGvV99wFckALcIRs0Hh52r8gUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTsd9+FV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTsd9+FV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747716909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lH62eA+ZkZvZQMoJig9aFhMnPh18+GZctia/VCOwB4Q=;
	b=TTsd9+FVvtbMedFiAxnvVm0yR4cFDHzJNe1AqM2ZouegsTh/s0f9yhVc8HbrXyMt7bgA69
	HXKalPBM91szIOk/r6LORT5ZJS0ILkEH0pcj97qqpBjflS5xmBUK0GCjSFRiX3VSjHdCXs
	cRhA4BLM6q2YxKc+sK4XK/JFUaFUs0s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-LKomg88BP_aahwTPsGQO6w-1; Tue,
 20 May 2025 00:55:06 -0400
X-MC-Unique: LKomg88BP_aahwTPsGQO6w-1
X-Mimecast-MFC-AGG-ID: LKomg88BP_aahwTPsGQO6w_1747716904
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CECB180048E;
	Tue, 20 May 2025 04:55:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2659418003FD;
	Tue, 20 May 2025 04:55:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 0/6] ublk: support to register bvec buffer automatically
Date: Tue, 20 May 2025 12:54:30 +0800
Message-ID: <20250520045455.515691-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

V5:
	- move ublk_set_auto_buf_reg() before completing ublk request (Caleb Sander
	  Mateos)
	- improve uapi document a bit
	- small improvement on the last patch for adding
	  UBLK_AUTO_BUF_REG_FALLBACK test

V4:
	- drop patch "ublk: allow io buffer register/unregister command issued
	  from other task contexts", which doesn't belong to this patchset

	- split out 'ublk: support UBLK_AUTO_BUF_REG_FALLBACK' (Caleb Sander
	  Mateos)

	- patch style & cleanup & document for addressing Caleb Sander Mateos's
	  comment

V3:
	- simplify UAPI interface by passing auto-buf-reg data via sqe->addr

	- cleanup implementation & document

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
  ublk: convert to refcount_t
  ublk: prepare for supporting to register request buffer automatically
  ublk: register buffer to local io_uring with provided buf index via
    UBLK_F_AUTO_BUF_REG
  ublk: support UBLK_AUTO_BUF_REG_FALLBACK
  selftests: ublk: support UBLK_F_AUTO_BUF_REG
  selftests: ublk: add test for covering UBLK_AUTO_BUF_REG_FALLBACK

 drivers/block/ublk_drv.c                      | 153 +++++++++++++++---
 include/uapi/linux/ublk_cmd.h                 |  97 +++++++++++
 tools/testing/selftests/ublk/Makefile         |   3 +
 tools/testing/selftests/ublk/fault_inject.c   |   5 +
 tools/testing/selftests/ublk/file_backed.c    |  17 +-
 tools/testing/selftests/ublk/kublk.c          |  59 ++++++-
 tools/testing/selftests/ublk/kublk.h          |  18 +++
 tools/testing/selftests/ublk/null.c           |  55 +++++--
 tools/testing/selftests/ublk/stripe.c         |  26 +--
 .../testing/selftests/ublk/test_generic_08.sh |  32 ++++
 .../testing/selftests/ublk/test_generic_09.sh |  28 ++++
 .../testing/selftests/ublk/test_stress_03.sh  |   7 +
 .../testing/selftests/ublk/test_stress_04.sh  |   7 +
 .../testing/selftests/ublk/test_stress_05.sh  |   9 ++
 14 files changed, 462 insertions(+), 54 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_09.sh

-- 
2.47.0

