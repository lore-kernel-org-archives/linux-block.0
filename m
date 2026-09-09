Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09748EC97
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992963; cv=none; b=J3WWgj/y8NhUC50Yy4rHELE+JKq60inRoI7gAILUwy41RHSTR77flG7HbagDZeVX46Ml2lJ8b+7DvZKVmBiKB/zY16fyBQa59DS/F+VxjxjQj81jNsDZQQv61n97hd5744WvU0OAhaV6dUitgTAOAJlWg/gxvuS3M+0gmQcztSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992963; c=relaxed/simple;
	bh=UC0n0v4vYaBJdkv8cGUVcJsYvlxPbTS5WG8JuIhvJeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDqvWEFPZ2sgT5JbC3bBwd0DnEbIZvnJXE36NUhkw/zUeVEMnW8qHbVa8G6v81iqaKUfFZ/2cvnJf0Af/NsS9YYZISW0TGL7klaCzUs+J2Ib80h+gXP+7XOw2C2+mprwvfSMKXpryIx7yhf+p2wGoFNwnnwCfE3XXmJwCa5cgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UC6XZZWO; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UC6XZZWO"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-398fb0feb91so191697a91.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sAKhWIfpeZ5+jLFDZPzZcWORkKqrMwJSrxhzssQpKO4=;
        b=UC6XZZWO7Y2WVo+vecCCGpTK5490/d0MCNMvRYhcwMPdbt9jQv3twGsqjOZ4oHjQRu
         bVen1RumNS2Jj3NS+cI1VWF+gqIUFuwRtBXJZpZtkqyiPi0rs4WxgrP25AE0z8F7mLP2
         F9pAo49LPwFToA8WKwOkc6wtIbOiz9X0Fbl50lozmPMXeuTWVmbMVMMrlOs+h0K+9wR1
         h2EsvRDwhnA9bBse6xBEmzCl8Ycs9I2IwyoW3PgCS+KukNxeHxgQz1c7HMm+Md4sRhp5
         ZFjYkYu/veuIoLEgfaSeb9o3RCZIO1SHUY6CROnURLFCicTNgAyWcIKWTJPGsO4od829
         +3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAKhWIfpeZ5+jLFDZPzZcWORkKqrMwJSrxhzssQpKO4=;
        b=qFzVsLAW7Q9iRFBPCbkDYWgHkhZ3W+cGAU/iyUW7j5/dod7bz4ByMKtIF34WK0T8X8
         2pHbirfuojNjpYl7GUfqWWktzy5U3SwKXkHiYYQTbI0vcVQapGYO7mOd4u/owvflDzqz
         Go9DOwlwwMPxJSoy4tJa1BLElPpKzVbKJZRBYkrWevCA/l5hD9ksk7IKrjkEPsxMGy9N
         4mKUG5J9Jyx3C1nhjBWWpUBkLWbq+fIOB4t648pCW+O4Z59Mudz6c39sxhOrCRSWbffY
         74luCrqyaTh5R8a1YK1GtNwzeyhCaZY1y6C/OkglPdhp8ol8J5KPDTGYGnedGkUY2oaD
         E0LQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiM1B+tQpd9gl46+MxtjskObp0h+4tgneb31Ap7m+hON++4iPzDnZYM6/8U/8X+9nTsaj6rWO8aRd3kw==@vger.kernel.org
X-Gm-Message-State: AFuF++lD6XmK32RTBXX1Z5iDAG611ghfZ8qwkWmBmE//Uk1YxYX/0U9S
	wFLrhypRUEbCflXF2TGrvJEYcKbTrBe6jqe9SHGKF/cKIeh4FD52WvRqLkALqYLUAlWKIjs7kxW
	uoG9FfAPCVVUZU1tM6JAKal1db9wgs4CpJhVOvKFFTX/wCQezABUE
X-Gm-Gg: AYBFou3cftefFE5cS/96Kt7CcLdzC7yY7SEjWCAR2oA2l4jBf/Zq+O50s7vnMHtqchk
	MsIvMwvmqn5+bx0MKWK1k20BmSn7cDVCYyeYtrrDTlBa6hfrkzLU0WMDBJGmMk5EXY3HIjNOMsN
	YX4pwovUAM6/Mx+WYOktc2FA5uJkn8olT8LghhNHfpAxmhqUxbW6hepQpQox4dO4dy+WVUOOYY5
	BIssI2irGoBweJVjQNunyW18FruJ1WHZvc/t75g1ARsyBejMI8rbO2DHKK+rYdsmeLjtHTKqRD/
	iQ7UZKgMktDzmKZDMDRUq19H8RGJGA1lzOa2iDPjmaUjuYmRkVYJpWJeF8FR6/4kcL+OPsk8z9J
	qFE4Yyj5UXXk6oUCn
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id 98e67ed59e1d1-39b3d8377camr32217761a91.6.1788992943615;
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d77406179sm490112a91.5.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E70B9402A9;
	Wed,  9 Sep 2026 16:29:02 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DE5A0E40322; Wed,  9 Sep 2026 16:29:02 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/6] io_uring/nvme: support fixed buffer for metadata
Date: Wed,  9 Sep 2026 16:28:30 -0600
Message-ID: <20260909222836.2475352-1-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring NVMe passthrough supports using a "fixed" (registered) buffer
for data, but not metadata. On high-IOPS workloads, the pinning and
unpinning overhead for the metadata pages is significant and could be
avoided if fixed metadata buffers were supported.

This patch series adds the necessary plumbing to allow NVMe passthrough
commands to use fixed buffers for their metadata. The metadata and data
fixed buffer indices can be specified (or omitted) independently.
Supporting separate fixed buffers is important as metadata buffers are
often stored in separate memory from the corresponding data buffers. For
ublk zero-copy I/Os, sharing a buffer index would be impossible as the
data buffer is a kernel registered buffer while the metadata buffer is a
userspace registered buffer.

My main question is which layer the metadata fixed buffer should belong
to: core io_uring, io_uring_cmd, or NVMe passthrough? In this initial
implementation, the io_uring_cmd layer stores the metadata buffer node
and the NVMe passthrough layer defines the UAPI.

The main argument for moving the implementation to a more generic layer
would be to reuse it for other io_uring request types. For example,
IORING_RW_ATTR_FLAG_PI could also benefit from a fixed metadata buffer
option, though this series doesn't implement it yet.

On the other hand, core io_uring_sqe and io_kiocb space is very limited,
so it may be undesirable to dedicate it for a somewhat niche use case.
The metadata buffer node storage could be pushed to the NVMe passthrough
layer after my in-flight series [1] to reclaim nvme_uring_cmd_pdu space.
However, managing request-scoped resources from a ->uring_cmd()
implementation is a pain, as the same request can call ->uring_cmd()
multiple times and may or may not complete when ->uring_cmd() returns,
depending on the ->uring_cmd() return value. io_req_uring_cleanup(), in
contrast, provides a single cleanup path for all uring_cmds.

[1]: https://lore.kernel.org/io-uring/20260909155848.2069290-1-csander@purestorage.com/T/

Caleb Sander Mateos (6):
  bio-integrity: remove dead bio_integrity_copy_user() error path
  nvme/ioctl: remove struct nvme_uring_data
  blk-integrity: pass iov_iter to blk_rq_integrity_map_user()
  nvme/ioctl: pass iov_iter to nvme_map_user_request()
  io_uring/cmd: support fixed buffer for metadata
  nvme/ioctl: support fixed buffer for metadata

 block/bio-integrity.c           | 51 ++++++++++--------
 block/blk-integrity.c           |  7 +--
 drivers/nvme/host/ioctl.c       | 91 +++++++++++++++++++--------------
 include/linux/bio-integrity.h   |  1 +
 include/linux/blk-integrity.h   |  6 +--
 include/linux/io_uring/cmd.h    | 12 ++++-
 include/uapi/linux/nvme_ioctl.h |  5 +-
 io_uring/rsrc.c                 | 28 ++++------
 io_uring/rsrc.h                 | 17 ++++++
 io_uring/uring_cmd.c            | 30 ++++++++++-
 10 files changed, 160 insertions(+), 88 deletions(-)

-- 
2.55.0

