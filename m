Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E015664D
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012603; cv=none; b=Ao/ZDqgQIfvinXAwLc3yJmBAk5drktC3GvGIUp6QyYfzXeJ7LURwrGQsQ2Mk0/b3DYo+oIL0RAV9u2L5Vo2m79t5uNjWGzyvJZcrQXy7ymVCCJxjSShlOv7+Pm/tjxsVrltqvgtxyf+9E65jro7smGzDQlHCm2eFAfwlp5pvMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012603; c=relaxed/simple;
	bh=+zyUlT9KJFbGaq9cJIsLWXCQw64UitjH+LsLVwiP20M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlvjpWmePFsCIE88YQcn83q03+SXF9NxlVRrPPF6n9mjSmIrUb0VyA61NgGj9eaiTpUuu57NZFPbYXUctBQ0w9FB9Nk5h3EylnDlFJpK5K9JpVy8kZHaw/UX0JQPQCLXdzry/BHjtwqwBkmnDDXOzN8E71jyVLb1tCMNeSu5aZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLWwwQpz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLWwwQpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715012599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aIoSW/a8xQVbobfudbPMQ+S1MT42qVAVoLx53nUeMx8=;
	b=hLWwwQpz0BTY/XlqU4dO/eKFDESDGUO0ce84hm9UzIcpmcasvNCwhlW44Do8AppKDd6591
	9RpbGXZRmXorUnSQMrqi9oOPA9JCE/0PzfSSIhTex8mB5L5JclI0qGoKVxF9DglQzBYvUm
	TERsdOZbV7FnGXB3x5/xG9Q16qeXYOM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-9ulM3rN9M_qZ93qF4VPNig-1; Mon,
 06 May 2024 12:23:15 -0400
X-MC-Unique: 9ulM3rN9M_qZ93qF4VPNig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B103329ABA09;
	Mon,  6 May 2024 16:23:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B030C40C6DAE;
	Mon,  6 May 2024 16:23:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 0/9] io_uring: support sqe group and provide group kbuf
Date: Tue,  7 May 2024 00:22:36 +0800
Message-ID: <20240506162251.3853781-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hello,

The 1st 4 patches are cleanup, and prepare for adding sqe group.

The 5th patch supports generic sqe group which is like link chain, but
allows each sqe in group to be issued in parallel, so N:M dependency can be
supported with sqe group & io link together.

The 6th patch supports one variant of sqe group: allow members to depend
on group leader, so that kernel resource lifetime can be aligned with
group leader or group, then any kernel resource can be shared in this
sqe group, and can be used in generic device zero copy.

The 7th & 8th patches supports providing sqe group buffer via the sqe
group variant.

The 9th patch supports ublk zero copy based on io_uring providing sqe
group buffer.

Tests:

1) pass liburing test
- make runtests

2) write/pass two sqe group test cases:

https://github.com/axboe/liburing/compare/master...ming1:liburing:sqe_group_v2

covers related sqe flags combination and linking groups, both nop and
one multi-destination file copy.

3) ublksrv zero copy:

ublksrv userspace implements zero copy by sqe group & provide group
kbuf:

	git clone https://github.com/ublk-org/ublksrv.git -b group-provide-buf_v2
	make test T=loop/009:nbd/061:nbd/062	#ublk zc tests

When running 64KB block size test on ublk-loop('ublk add -t loop --buffered_io -f $backing'),
it is observed that perf can be doubled.

Any comments are welcome!

V2:
	- add generic sqe group, suggested by Kevin Wolf
	- add REQ_F_SQE_GROUP_DEP which is based on IOSQE_SQE_GROUP, for sharing
	  kernel resource in group wide, suggested by Kevin Wolf
	- remove sqe ext flag, and use the last bit for IOSQE_SQE_GROUP(Pavel),
	in future we still can extend sqe flags with one uring context flag
	- initialize group requests via submit state pattern, suggested by Pavel
	- all kinds of cleanup & bug fixes

Ming Lei (9):
  io_uring: add io_link_req() helper
  io_uring: add io_submit_fail_link() helper
  io_uring: add helper of io_req_commit_cqe()
  io_uring: move marking REQ_F_CQE_SKIP out of io_free_req()
  io_uring: support SQE group
  io_uring: support sqe group with members depending on leader
  io_uring: support providing sqe group buffer
  io_uring/uring_cmd: support provide group kernel buffer
  ublk: support provide io buffer

 drivers/block/ublk_drv.c       | 158 ++++++++++++++-
 include/linux/io_uring/cmd.h   |   7 +
 include/linux/io_uring_types.h |  48 +++++
 include/uapi/linux/io_uring.h  |  10 +-
 include/uapi/linux/ublk_cmd.h  |   7 +-
 io_uring/io_uring.c            | 356 +++++++++++++++++++++++++++++----
 io_uring/io_uring.h            |  29 ++-
 io_uring/kbuf.c                |  60 ++++++
 io_uring/kbuf.h                |  13 ++
 io_uring/net.c                 |  31 ++-
 io_uring/opdef.c               |   5 +
 io_uring/opdef.h               |   2 +
 io_uring/rw.c                  |  20 +-
 io_uring/timeout.c             |   3 +
 io_uring/uring_cmd.c           |  28 +++
 15 files changed, 724 insertions(+), 53 deletions(-)

-- 
2.42.0

