Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101F26F469
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695968; cv=none; b=YQt0n8HX6urffhz+OSvMPVyMLJc6w0UYJt63MWusyLPgZz8I9+IHjkRfyP0CssXtfYz7uElAiBaqFjFk0gNl4/nwy6bU5HxL5cgr6wOHLmAreWxZtWMYRHIVaXRdabzrBsBKkGCXIEwp+MGaSVY+pgwRPgT9UmE9AtlO3uRHurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695968; c=relaxed/simple;
	bh=/e7mSNjJ60tQ8JkBcq+Zqp6nwg0ys3Vn78OeGJtHryo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t1ArnZGHg4c6dpVn2OAWyDCju7mwXAvlxNfoEDfY+YkDnL9MfReo9Ph6khwUyX/1XyQT7iTcu1z4XRXDXoIlkoWqrPtGC/x6w093n020/i5QZcCfxIFjn2vMN/27vy9TCgx3sm3BZtR+5LxudYq1RhZmW3E2poIqniRfEvpjHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ASpfbFoE; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ASpfbFoE"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMbmhi032434
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 14:39:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=tGmuivmMHmt4jFgZMi
	c73AMs0v4Z1lHbqPxCC+pdAbM=; b=ASpfbFoEdU/KznfrV6HeguHKDk/nVJvHz2
	3b4AltKvwffZWw7yH+2Uhpw7UJBfwRNK140pV4xalP5PHy+nTsg2jOhTXFJziny0
	By/mS5/VMYZrTvD77rdwwy/TbZs2QWthnBBiXKJIYrFzApN8t5BSquWSp+ueXRya
	AjqLZ73t4F/IrwZpYw0OlsS5npL8cS/weEuhp7EWuatInnkFBVU6lIK6plM50//Q
	OBUr5iLaJSErW0sINmbFUrLrBfOsu6TwhzEauXZ1X27LRR+D3muEoma1RDrLB6BJ
	JLNXCEKVwiagjYlVy7Am3TO7OjFZ7gKMoPfPyaBX5/F0n5mUMHcQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4530qwg44m-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 14:39:25 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 22:39:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 684D91888280A; Thu, 27 Feb 2025 14:39:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <axboe@kernel.dk>, <asml.silence@gmail.com>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-nvme@lists.infradead.org>, <csander@purestorage.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv8 0/6] ublk zero copy support
Date: Thu, 27 Feb 2025 14:39:10 -0800
Message-ID: <20250227223916.143006-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vX2vMbcrXLTg3G8dJqpjxo1v74uzRWRA
X-Proofpoint-GUID: vX2vMbcrXLTg3G8dJqpjxo1v74uzRWRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

This one completed liburing 'make runtests' successfully.

Changes from v7:

  Prep patch, mostly from Jens, that removes the "do_import" parameter
  from the generic rw prep.

  Added check for kernel buffers in rw's loop submit. This file
  operation requires __user pointers, so can't use it there (Pavel)

  Added a bool, is_kbuf, so that we don't use the existence of the
  "release" callback to distinguish user vs kernel buffers. And had user
  buffers define its own release function so that we can remove a branch
  check on free.

  The io node and imu caching is moved from the table to ring ctx. This
  is the simplest solution to situations where the node outlives the
  table it came from.

  Fixed missing (parens) logical error checking for ublk flags.

  Minor cleanups to reduce diff churn.

Keith Busch (5):
  io_uring/rw: move buffer_select outside generic prep
  io_uring/rw: move fixed buffer import to issue path
  io_uring: add support for kernel registered bvecs
  ublk: zc register/unregister bvec
  io_uring: cache nodes and mapped buffers

Xinyu Zhang (1):
  nvme: map uring_cmd data even if address is 0

 drivers/block/ublk_drv.c       |  59 ++++++++--
 drivers/nvme/host/ioctl.c      |   2 +-
 include/linux/io_uring/cmd.h   |   7 ++
 include/linux/io_uring_types.h |   2 +
 include/uapi/linux/ublk_cmd.h  |   4 +
 io_uring/filetable.c           |   2 +-
 io_uring/io_uring.c            |   5 +
 io_uring/opdef.c               |   4 +-
 io_uring/rsrc.c                | 189 +++++++++++++++++++++++++++++----
 io_uring/rsrc.h                |  13 ++-
 io_uring/rw.c                  |  85 ++++++++++-----
 io_uring/rw.h                  |   2 +
 12 files changed, 318 insertions(+), 56 deletions(-)

--=20
2.43.5

