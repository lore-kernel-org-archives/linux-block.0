Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F8246BDE
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084402; cv=none; b=TO56VHeTNd377lzZLl/nA1wpG8FJfcA5sE6S2P39Bjm8OYMvMg38Ao5rI/gRIhRpGrtpNzocjLoT27pF9zHBQCfz6sgmbcq0zk3BqcJAKhDFclaNfUOsZajxvml3mhcosbg+/HevIwihHhb0z1nTHwpL1vByDWrK8havEm+bwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084402; c=relaxed/simple;
	bh=ZX4yqukWlH3AXdzxpFJcOkZYWtK/KdUuT9kqZmuB8Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qayOqEeGDKj9iS9ylNECglGnZj8GLWktMLE28g99Y91iX1aFnts0mrkzh06w9XuTNSY4Y+4NWv4L9kOdhVse6JrE5kQKYlBjpuGGlwdoic0u0X2AHqeM/mI+AES+DY4roDQc1r6j7rMOOv9wsaOYrhiqcePvjLSHTNBCfG7XBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IpBjd9OB; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IpBjd9OB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760084400; x=1791620400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZX4yqukWlH3AXdzxpFJcOkZYWtK/KdUuT9kqZmuB8Eo=;
  b=IpBjd9OBqbXb2N2gnZGC9YI4vwjKz+vsNPTsNS6jnskyEGanBGCClU/I
   fy810rwQ5vv92SMrtOTC+KnvF8ro+DGrQn4KQGZrDenxbGe8NP8zfHhAi
   Zgj9DxoebSdnvSjVYUIDUhhpfFc3gzeyiED8YDG9kVr698Mbt5e2XxxnP
   6yfykq0GZ876FGRrF959FlmZ5Z8pZo/eyQFsVpBDKIzY33cKi2tynpLHq
   50RdYxoDs3Ba7LtOYwCQsHwOBMCxpPGJ8wKl579R6fbMpM0VyJG8uwT+n
   63yeB8AdrFYJ3MOLkMc/xYnJVsk4MYhckWI0c5naFIohFqjOuBc64FaEq
   A==;
X-CSE-ConnectionGUID: r2RnhnZzRxmJSqXP2d5DOw==
X-CSE-MsgGUID: 3kmeNVrGTFi0WWMAtGO0/A==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="132653542"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 16:19:53 +0800
IronPort-SDR: 68e8c1a9_NQIYMpn1ipfa/B/UXGSJExDi12ZtEpZq/wehy7wuAxjD7b3
 Dc17YTjQ3KcVhwncdYStHvkt+qH755DJC+MYlbA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2025 01:19:54 -0700
WDCIronportException: Internal
Received: from 5cg2148fq4.ad.shared (HELO shinmob.wdc.com) ([10.224.163.88])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Oct 2025 01:19:53 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/4] throtl: support test with scsi_debug
Date: Fri, 10 Oct 2025 17:19:48 +0900
Message-ID: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the throtl test cases set up null_blk devices as test
targets. It is desired to run the tests with scsi_debug devices also
to expand test coverage and identify failures that do not surface with
null_blk [1].

Per suggestion by Yu Kuai, this series supports running the throtl test
cases with scsi_debug [2]. The first two patches prepare for the
scsi_debug support. The third patch introduces the scsi_debug support.
The forth patch supports running tests with both null_blk and scsi_debug
in a single run.

Of note is that currently throtl/002 fails with scsi_debug. This needs
further debug effort.

[1] https://lore.kernel.org/linux-block/20250918085341.3686939-1-yukuai1@huaweicloud.com/

[2] blktests console

$ sudo bash -c "THROTL_BLKDEV_TYPES='nullb sdebug' ./check throtl/"
throtl/001 (nullb) (basic functionality)                     [passed]
    runtime  4.479s  ...  4.541s
throtl/001 (sdebug) (basic functionality)                    [passed]
    runtime  5.276s  ...  5.426s
throtl/002 (nullb) (iops limit over IO split)                [passed]
    runtime  2.473s  ...  2.569s
throtl/002 (sdebug) (iops limit over IO split)               [failed]
    runtime  5.541s  ...  5.732s
    --- tests/throtl/002.out    2025-09-23 14:05:35.011885439 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_sdebug/throtl/002.out.bad    2025-10-10 16:53:39.032380883 +0900
    @@ -1,4 +1,4 @@
     Running throtl/002
    -1
    -1
    +3
    +2
     Test complete
throtl/003 (nullb) (bps limit over IO split)                 [passed]
    runtime  2.444s  ...  2.411s
throtl/003 (sdebug) (bps limit over IO split)                [passed]
    runtime  2.953s  ...  3.027s
throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime  1.087s  ...  1.044s
throtl/004 (sdebug) (delete disk while IO is throttled)      [passed]
    runtime  1.441s  ...  1.586s
throtl/005 (nullb) (change config with throttled IO)         [passed]
    runtime  3.405s  ...  3.412s
throtl/005 (sdebug) (change config with throttled IO)        [passed]
    runtime  3.972s  ...  4.162s
throtl/006 (nullb) (test if meta IO has higher priority than data IO) [passed]
    runtime  12.810s  ...  12.777s
throtl/006 (sdebug) (test if meta IO has higher priority than data IO) [passed]
    runtime  5.842s  ...  5.611s
throtl/007 (nullb) (bps limit with iops limit over io split) [passed]
    runtime  4.442s  ...  4.541s
throtl/007 (sdebug) (bps limit with iops limit over io split) [passed]
    runtime  4.959s  ...  4.986s


Shin'ichiro Kawasaki (4):
  throtl: introduce helper functions to manage test target block devices
  throtl/004: adjust to scsi_debug
  throtl/rc: support test with scsi_debug
  throtl: support tests with both null_blk and scsi_debug in a single
    run

 Documentation/running-tests.md |  17 ++++++
 tests/throtl/001               |   4 ++
 tests/throtl/002               |   9 ++-
 tests/throtl/003               |   9 ++-
 tests/throtl/004               |  10 ++-
 tests/throtl/004.out           |   3 +-
 tests/throtl/005               |   4 ++
 tests/throtl/006               |   6 +-
 tests/throtl/007               |   9 ++-
 tests/throtl/rc                | 108 ++++++++++++++++++++++++++++++---
 10 files changed, 157 insertions(+), 22 deletions(-)

-- 
2.51.0

