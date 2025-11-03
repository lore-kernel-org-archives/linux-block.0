Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F32868B5
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152303; cv=none; b=SOy87x8R1OO8pic335pVvQARW7X5xnSgIOiUyGcBG6yVbJGJL5+efpgy7WUTXfOQzlFSm878+1tdrLbZyPfT5ebV+0y0sYZq+9h1M8cj5JqFzcpCjkzdWo3fx89s5cAnPahxN2lcZRkikYOuBcSo/hO6oeR+aIDPL7scyCMix/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152303; c=relaxed/simple;
	bh=uPDq7dc1kWnNBQmUij9CvS1dXDdwcXGDu0qDHhmzu4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJhm7wuRX62WFogBY2zzzW0yYGlDlNVwPeLvFMHxtwZ+UAdhIJSQYsytKO2RzUeEnZndnXORXFRJTX7W90D2BDL+cM6QkxC9BKnkA5WywxHw3JH6wN7GQ6NSKWRqZKM1UnZHmG1jai9857efgq5b6zdfWBeEuWGsQpxK1/peRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TfEvxVvm; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TfEvxVvm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762152301; x=1793688301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uPDq7dc1kWnNBQmUij9CvS1dXDdwcXGDu0qDHhmzu4U=;
  b=TfEvxVvmiWAFRzSsdulxVXaV2JJGtOXBYKwGEkRR/nclMeH5629r62PU
   lfFcdXzvzVJ0j51OiLImSBSU/eQcseJ7kmOPMjmfdV8nfXqpfJmN/9LJQ
   uBQuo9bk3unsGyh5bYKHQ1XfRI196zpfvjkR/IhQjqxTxZ8v4gqRQa+vz
   llVjbfCQHazHojENH0gyya/bTmTAQKGND2c+HabKoTWZy056ZIGuNMOlA
   KZ7CZY/dOaIyuhBSXLrFZ4yKGX+DyIsWlAURqxyB/h69dyKFgeqUvLdRy
   h47X9p8Vq+bDYohf469gGAOMMaJRp1Dv4axt6fSeXVLubnrVvLfwN03n6
   w==;
X-CSE-ConnectionGUID: OIfPRq2sS3yiHCsLtVAU4A==
X-CSE-MsgGUID: gPmo9albRXywu2XmnRKBPA==
X-IronPort-AV: E=Sophos;i="6.19,275,1754928000"; 
   d="scan'208";a="134391236"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 14:44:55 +0800
IronPort-SDR: 69084f67_JIc06W5OGDyQs6BjAmz3uxbhpOwxOZXI9N14ySnjW0b4NgD
 n+GFt9xkQJgXwqt0u5PZRD4t0UsTdQcFc8e2d8g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2025 22:44:55 -0800
WDCIronportException: Internal
Received: from wdap-zcgq2z60ds.ad.shared (HELO shinmob.flets-east.jp) ([10.224.109.249])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Nov 2025 22:44:55 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/5] throtl: support test with scsi_debug
Date: Mon,  3 Nov 2025 15:44:49 +0900
Message-ID: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
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
cases with scsi_debug [2]. The first three patches prepare for the
scsi_debug support. The fourth patch introduces the scsi_debug support.
The fifth patch supports running tests with both null_blk and scsi_debug
in a single run.

Changes from v1:
* Added the 2nd patch to fix the throtl/002 failure
* 5th patch: changed the default of THROTL_BLKDEV_TYPES to 'nullb sdebug'


[1] https://lore.kernel.org/linux-block/20250918085341.3686939-1-yukuai1@huaweicloud.com/

[2] blktests console

$ sudo bash -c "./check throtl"
throtl/001 (nullb) (basic functionality)                     [passed]
    runtime  5.028s  ...  5.036s
throtl/001 (sdebug) (basic functionality)                    [passed]
    runtime  5.793s  ...  5.578s
throtl/002 (nullb) (iops limit over IO split)                [passed]
    runtime  2.936s  ...  2.917s
throtl/002 (sdebug) (iops limit over IO split)               [passed]
    runtime  3.349s  ...  3.272s
throtl/003 (nullb) (bps limit over IO split)                 [passed]
    runtime  2.862s  ...  2.807s
throtl/003 (sdebug) (bps limit over IO split)                [passed]
    runtime  3.284s  ...  3.281s
throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime  1.435s  ...  1.413s
throtl/004 (sdebug) (delete disk while IO is throttled)      [passed]
    runtime  1.779s  ...  1.805s
throtl/005 (nullb) (change config with throttled IO)         [passed]
    runtime  3.798s  ...  3.679s
throtl/005 (sdebug) (change config with throttled IO)        [passed]
    runtime  4.256s  ...  4.207s
throtl/006 (nullb) (test if meta IO has higher priority than data IO) [passed]
    runtime  16.700s  ...  13.957s
throtl/006 (sdebug) (test if meta IO has higher priority than data IO) [passed]
    runtime  5.916s  ...  5.870s
throtl/007 (nullb) (bps limit with iops limit over io split) [passed]
    runtime  4.769s  ...  4.740s
throtl/007 (sdebug) (bps limit with iops limit over io split) [passed]
    runtime  5.243s  ...  5.341s


Shin'ichiro Kawasaki (5):
  throtl: introduce helper functions to manage test target block devices
  throtl/rc,002: adjust to scsi_debug
  throtl/004: adjust to scsi_debug
  throtl/rc: support test with scsi_debug
  throtl: support test with both null_blk and scsi_debug in a single run

 Documentation/running-tests.md |  17 +++++
 tests/throtl/001               |   4 ++
 tests/throtl/002               |  14 +++--
 tests/throtl/003               |   9 ++-
 tests/throtl/004               |  10 ++-
 tests/throtl/004.out           |   3 +-
 tests/throtl/005               |   4 ++
 tests/throtl/006               |   6 +-
 tests/throtl/007               |   9 ++-
 tests/throtl/rc                | 112 ++++++++++++++++++++++++++++++---
 10 files changed, 165 insertions(+), 23 deletions(-)

-- 
2.51.0

