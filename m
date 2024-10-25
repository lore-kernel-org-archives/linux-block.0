Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABC1E8845
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858988; cv=none; b=CMfqHgW/775wU6Gu92b8hRVv1SLJ/vvvEfCIj9lQ8cNo64wgospL2iFoNA55s91fu/0v+RWalxkPoBsEg72Wa7s0bu954ExcJmWCrdoTFV+GUnKMKn0c2Z/D/Cg+P8eAmyhWUICdU1QU1X41YmofimnJwm9tu2InI1P7mb4c58w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858988; c=relaxed/simple;
	bh=I6aoGfKCl0APFmTK67nSHC/72awP993YKmH57omgJes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXI3A9xmIvCLzbBbz3esLJqlN7eVk8ISaBXAYDcXuxXHL8FVTcZ3NIw9ZiSsGbZw/yfstXPlBAb6jH10fynPfbZIOuY9d4VU1nfK7DjWRo5NO9amKQCiSh2NBIO/y0yno00AEX/Uh6HRikWOZelgKujKIs3cr2qjxUyU8EWBshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQ1UmjLw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ1UmjLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729858984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=50C2E5Vn0HYMm1sID5gQl+qSeFw/SbFRxPAJ9iENK5g=;
	b=DQ1UmjLwyFCK8QRfRBRKoilL2kUbuHtUZIsRdHEihtn06OyNStAyNvlkeQLfm6ENHUH27x
	3zbp2N4gCyd+DT4PIZ9tcHkYp+x/qJWBIt1qy91c3W15M1YUAVt0IRGn1AL8Ynl4fBbPe1
	xSsWcvqvyWC+bjFPTH1JtbYwp5/0z7w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-G7g6_4qrPGiCoaaOGTPWfw-1; Fri,
 25 Oct 2024 08:23:02 -0400
X-MC-Unique: G7g6_4qrPGiCoaaOGTPWfw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1B6C1955D52;
	Fri, 25 Oct 2024 12:23:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.106])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84CC830001AC;
	Fri, 25 Oct 2024 12:22:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V8 0/8] io_uring: support sqe group and leased group kbuf
Date: Fri, 25 Oct 2024 20:22:37 +0800
Message-ID: <20241025122247.3709133-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The 1st 3 patches are cleanup, and prepare for adding sqe group.

The 4th patch supports generic sqe group which is like link chain, but
allows each sqe in group to be issued in parallel and the group shares
same IO_LINK & IO_DRAIN boundary, so N:M dependency can be supported with
sqe group & io link together.

The 5th & 6th patches supports to lease other subsystem's kbuf to
io_uring for use in sqe group wide.

The 7th patch supports ublk zero copy based on io_uring sqe group &
leased kbuf.

Tests:

1) pass liburing test
- make runtests

2) write/pass sqe group test case and sqe provide buffer case:

https://github.com/ming1/liburing/tree/uring_group

- covers related sqe flags combination and linking groups, both nop and
one multi-destination file copy.

- cover failure handling test: fail leader IO or member IO in both single
  group and linked groups, which is done in each sqe flags combination
  test

- cover io_uring with leased group kbuf by adding ublk-loop-zc

V8:
	- simplify & clean up group request completion, don't reuse 
	SQE_GROUP as state; meantime improve document; now group
	implementation is quite clean
	- handle short read/recv correctly by zeroing out the remained
	  part(Pavel)
	- fix one group leader reference(Uday Shankar)
	- only allow ublk provide buffer command in case of zc(Uday Shankar)

V7:
	- remove dead code in sqe group support(Pavel)
	- fail single group request(Pavel)
	- remove IORING_PROVIDE_GROUP_KBUF(Pavel)
	- remove REQ_F_SQE_GROUP_DEP(Pavel)
	- rename as leasing buffer
	- improve commit log
	- map group member's IOSQE_IO_DRAIN to GROUP_KBUF, which
	aligns with buffer select use, and it means that io_uring starts
	to support leased kbuf from other subsystem for group member
	requests only

V6:
	- follow Pavel's suggestion to disallow IOSQE_CQE_SKIP_SUCCESS &
	  LINK_TIMEOUT
	- kill __io_complete_group_member() (Pavel)
	- simplify link failure handling (Pavel)
	- move members' queuing out of completion lock (Pavel)
	- cleanup group io complete handler
	- add more comment
	- add ublk zc into liburing test for covering
	  IOSQE_SQE_GROUP & IORING_PROVIDE_GROUP_KBUF 

V5:
	- follow Pavel's suggestion to minimize change on io_uring fast code
	  path: sqe group code is called in by single 'if (unlikely())' from
	  both issue & completion code path

	- simplify & re-write group request completion
		avoid to touch io-wq code by completing group leader via tw
		directly, just like ->task_complete

		re-write group member & leader completion handling, one
		simplification is always to free leader via the last member

		simplify queueing group members, not support issuing leader
		and members in parallel

	- fail the whole group if IO_*LINK & IO_DRAIN is set on group
	  members, and test code to cover this change

	- misc cleanup

V4:
	- address most comments from Pavel
	- fix request double free
	- don't use io_req_commit_cqe() in io_req_complete_defer()
	- make members' REQ_F_INFLIGHT discoverable
	- use common assembling check in submission code path
	- drop patch 3 and don't move REQ_F_CQE_SKIP out of io_free_req()
	- don't set .accept_group_kbuf for net send zc, in which members
	  need to be queued after buffer notification is got, and can be
	  enabled in future
	- add .grp_leader field via union, and share storage with .grp_link
	- move .grp_refs into one hole of io_kiocb, so that one extra
	cacheline isn't needed for io_kiocb
	- cleanup & document improvement

V3:
	- add IORING_FEAT_SQE_GROUP
	- simplify group completion, and minimize change on io_req_complete_defer()
	- simplify & cleanup io_queue_group_members()
	- fix many failure handling issues
	- cover failure handling code in added liburing tests
	- remove RFC

V2:
	- add generic sqe group, suggested by Kevin Wolf
	- add REQ_F_SQE_GROUP_DEP which is based on IOSQE_SQE_GROUP, for sharing
	  kernel resource in group wide, suggested by Kevin Wolf
	- remove sqe ext flag, and use the last bit for IOSQE_SQE_GROUP(Pavel),
	in future we still can extend sqe flags with one uring context flag
	- initialize group requests via submit state pattern, suggested by Pavel
	- all kinds of cleanup & bug fixes

Ming Lei (7):
  io_uring: add io_link_req() helper
  io_uring: add io_submit_fail_link() helper
  io_uring: add helper of io_req_commit_cqe()
  io_uring: support SQE group
  io_uring: support leased group buffer with REQ_F_GROUP_KBUF
  io_uring/uring_cmd: support leasing device kernel buffer to io_uring
  ublk: support leasing io buffer to io_uring

 drivers/block/ublk_drv.c       | 159 +++++++++++++-
 include/linux/io_uring/cmd.h   |   7 +
 include/linux/io_uring_types.h |  58 +++++
 include/uapi/linux/io_uring.h  |   4 +
 include/uapi/linux/ublk_cmd.h  |  11 +-
 io_uring/io_uring.c            | 389 ++++++++++++++++++++++++++++++---
 io_uring/io_uring.h            |  11 +
 io_uring/kbuf.c                |  58 +++++
 io_uring/kbuf.h                |  31 +++
 io_uring/net.c                 |  25 ++-
 io_uring/rw.c                  |  26 ++-
 io_uring/timeout.c             |   6 +
 io_uring/uring_cmd.c           |  13 ++
 13 files changed, 750 insertions(+), 48 deletions(-)

-- 
2.46.0

