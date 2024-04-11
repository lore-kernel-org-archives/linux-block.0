Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18833147C77
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834021; cv=none; b=pnOWczeo2WTCpSdAR4PtJEO+m3GEUlgdFs4WUQ2tsaP9PXTPRsf4b0nmNiVTa4bdwR+3QhRoUVKOD9fEJR88TWv0RJdlDf/QoBio3QzTHeJYCo+ZPyf3+aPbr+ZHkAEey2GyfFmC9pkVJXUg8VG3I1nL515GIlI17jpI0liQa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834021; c=relaxed/simple;
	bh=JCcopkWyjABPnA3Nz3OFw5ugbGL4+hFWizVj5/ijcsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plWEICAnJR9kRvj3btgkw3Qk2KyNiwAM4jJn1lPvzvZqq1dihuUgZo9+aBNL8ZzcZYg6QCSXegDaQ+bq6GAq40q1clOu6wnNReYQ8LUY4lcHVX8P9vaG//2PylMkbQop/jG27IBbP8vu2qfuQg1rDSVbTy+LU/1GaXg3OodGtjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e1eyCfiu; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e1eyCfiu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712834020; x=1744370020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JCcopkWyjABPnA3Nz3OFw5ugbGL4+hFWizVj5/ijcsE=;
  b=e1eyCfiuVawEbZSWv51nUcHqWMRt/sRGiscmoadkO7Kon+AVNSLUZvGh
   jgL5xU1FiuM7ECbtVoTd2La6WG6cVQtuoO6s1k3qlBVnzBevway6m+Y6U
   f4p0HLNWk1MsfZif/GpxiyRRDaViKiZelJoluMOrOF3x2NkxxE4S6XcRP
   U0kAk7MQ53BXqLlsTZqpP5h1Ei2HVH6ScjbK0G9fQXuy8Rka42w2FZ0Xd
   uofwJLyF3r/yES6RRz6WmwC/ar+Sty82ASc+rhjd2UlUettkBqouel2pB
   RmZCEs0mFxl1Sede8ilZX3zFbfPRPMtmoVFnibyMvz+oByi/gbAv9BZpT
   w==;
X-CSE-ConnectionGUID: XcfAaWaRQ1uCP4MKutG7fg==
X-CSE-MsgGUID: ZfgUthdZQS+JeC42L9sTKA==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579860"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:30 +0800
IronPort-SDR: j1eqfwJgIsCdEbQfts8366qPXAXzb+CBVdvGOIuzbGtg13mm0JK5w1hjlVI0vCYDv2oETiBTdx
 55i+47TvPpHA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:15 -0700
IronPort-SDR: jQEYxQxcH3AH76wBVIlUFGDQeLiIBeAy/fFDEdz8+YbEP4QanpqdhwgcHvWiYJ/kAetEfYq2tZ
 EmcPDfUzNHEA==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:29 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 00/11] support test case repeat by different conditions
Date: Thu, 11 Apr 2024 20:12:17 +0900
Message-ID: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent discussion for nvme test group [1], two pain points were mentioned
regarding the test case runs.

1) Several test cases in nvme test group do exactly the same test except the
   NVME transport backend set up condition difference (device vs. file). This
   results in duplicate test script codes. It is desired to unify the test cases
   and run them repeatedly with the different conditions.

2) NVME transport types can be specified with nvme_trtype parameter so that the
   same tests can be run for various transport types. However, some test cases
   do not depend on the transport types. They are repeated in multiple runs for
   the various transport types under the exact same conditions. It is desired to
   repeat the test cases only when such repetition is required.

[1] https://lore.kernel.org/linux-block/w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72/

One idea to address these pain points is to add the test repeat feature to the
nvme test group. However, Daniel questioned if the feature could be implemented
in the blktests framework. Actually, a similar feature has already been
implemented to repeat some test cases for non-zoned block devices and zoned
block devices. However, this feature is implemented only for the zoned and non-
zoned device conditions. It can not fulfill the desires for nvme test group.

This series proposes to generalize the feature in the blktests framework to
repeat the test cases with different conditions. Introduce a new function
set_conditions() that each test case can define and instruct the framework to
repeat the test case. The first four patches introduce the feature and apply it
to the repetition for non-zoned and zoned block devices. The following seven
patches apply the feature to nvme test group so that the test cases can be
repeated for NVME transport types and backend types in the ideal way. Two of the
seven patches are reused from the work by Daniel. The all patches are listed in
the order that does not lose the test coverage with the default set up.

This series introduces new config parameter arrays NVME_TR_TYPES and
NVMET_BLOCK_DEV_TYPES. When these arrays are defined in the config file as
follows,

  NVME_TR_TYPES=(loop rdma tcp)
  NVMET_BLOCK_DEV_TYPES=(device file)

the test cases which depend on these parameters are repeated 3 x 2 = 6 times.
For example, nvme/006 is repeated as follows.

nvme/006 (nvmet bd=device tr=loop) (create an NVMeOF target) [passed]
    runtime  0.148s  ...  0.165s
nvme/006 (nvmet bd=device tr=rdma) (create an NVMeOF target) [passed]
    runtime  0.273s  ...  0.235s
nvme/006 (nvmet bd=device tr=tcp) (create an NVMeOF target)  [passed]
    runtime  0.162s  ...  0.164s
nvme/006 (nvmet bd=file tr=loop) (create an NVMeOF target)   [passed]
    runtime  0.138s  ...  0.134s
nvme/006 (nvmet bd=file tr=rdma) (create an NVMeOF target)   [passed]
    runtime  0.216s  ...  0.201s
nvme/006 (nvmet bd=file tr=tcp) (create an NVMeOF target)    [passed]
    runtime  0.154s  ...  0.146s


Daniel Wagner (3):
  nvme/rc: add blkdev type environment variable
  nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type
    tests
  nvme/{021,022,025,026,027,028}: do not hard code target blkdev type

Shin'ichiro Kawasaki (8):
  check: factor out _run_test()
  check: support test case repeat by different conditions
  check: use set_conditions() for the CAN_BE_ZONED test cases
  meta/{016,017}: add test cases to check repeated test case runs
  nvme/rc: introduce NVMET_TR_TYPES
  nvme/rc: introduce NVMET_BLKDEV_TYPES
  nvme/{002-031,033-038,040-045,047,048}: support NMVET_TR_TYPES
  nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES

 Documentation/running-tests.md |   9 ++-
 Makefile                       |   3 +-
 check                          | 128 +++++++++++++++++++++------------
 common/shellcheck              |   2 +-
 common/zoned                   |  22 ++++++
 new                            |  21 ++++++
 tests/meta/016                 |  29 ++++++++
 tests/meta/016.out             |   2 +
 tests/meta/017                 |  29 ++++++++
 tests/meta/017.out             |   2 +
 tests/nvme/002                 |   4 ++
 tests/nvme/003                 |   4 ++
 tests/nvme/004                 |   4 ++
 tests/nvme/005                 |   4 ++
 tests/nvme/006                 |   9 ++-
 tests/nvme/007                 |  28 --------
 tests/nvme/007.out             |   2 -
 tests/nvme/008                 |   8 ++-
 tests/nvme/009                 |  36 ----------
 tests/nvme/009.out             |   3 -
 tests/nvme/010                 |   8 ++-
 tests/nvme/011                 |  39 ----------
 tests/nvme/011.out             |   3 -
 tests/nvme/012                 |   8 ++-
 tests/nvme/013                 |  43 -----------
 tests/nvme/013.out             |   3 -
 tests/nvme/014                 |   8 ++-
 tests/nvme/015                 |  48 -------------
 tests/nvme/015.out             |   4 --
 tests/nvme/016                 |   4 ++
 tests/nvme/017                 |   4 ++
 tests/nvme/018                 |   4 ++
 tests/nvme/019                 |   8 ++-
 tests/nvme/020                 |  40 -----------
 tests/nvme/020.out             |   4 --
 tests/nvme/021                 |  10 ++-
 tests/nvme/022                 |  10 ++-
 tests/nvme/023                 |   8 ++-
 tests/nvme/024                 |  40 -----------
 tests/nvme/024.out             |   2 -
 tests/nvme/025                 |  10 ++-
 tests/nvme/026                 |  10 ++-
 tests/nvme/027                 |  10 ++-
 tests/nvme/028                 |  10 ++-
 tests/nvme/029                 |   4 ++
 tests/nvme/030                 |   4 ++
 tests/nvme/031                 |   4 ++
 tests/nvme/033                 |   4 ++
 tests/nvme/034                 |   4 ++
 tests/nvme/035                 |   4 ++
 tests/nvme/036                 |   4 ++
 tests/nvme/037                 |   4 ++
 tests/nvme/038                 |   4 ++
 tests/nvme/040                 |   4 ++
 tests/nvme/041                 |   3 +
 tests/nvme/042                 |   3 +
 tests/nvme/043                 |   3 +
 tests/nvme/044                 |   3 +
 tests/nvme/045                 |   3 +
 tests/nvme/047                 |   4 ++
 tests/nvme/048                 |   4 ++
 tests/nvme/rc                  |  49 ++++++++++++-
 62 files changed, 422 insertions(+), 377 deletions(-)
 create mode 100644 common/zoned
 create mode 100755 tests/meta/016
 create mode 100644 tests/meta/016.out
 create mode 100755 tests/meta/017
 create mode 100644 tests/meta/017.out
 delete mode 100755 tests/nvme/007
 delete mode 100644 tests/nvme/007.out
 delete mode 100755 tests/nvme/009
 delete mode 100644 tests/nvme/009.out
 delete mode 100755 tests/nvme/011
 delete mode 100644 tests/nvme/011.out
 delete mode 100755 tests/nvme/013
 delete mode 100644 tests/nvme/013.out
 delete mode 100755 tests/nvme/015
 delete mode 100644 tests/nvme/015.out
 delete mode 100755 tests/nvme/020
 delete mode 100644 tests/nvme/020.out
 delete mode 100755 tests/nvme/024
 delete mode 100644 tests/nvme/024.out

-- 
2.44.0

