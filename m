Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78271586F6
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945606; cv=none; b=ZLf1nmKvYBvqkYZBnH9KUIARdpJQtpMlHheKBoJaHdCPyBtmcFsiMjF8/ja5Nm7jduxOmyVzYhDmDSQQBgxVtqxE5sko9gAxlHnjp/b2NiOZF/95iG2IWZHug/Ts0eekB7p04slkV4PKoIAcpERbdlZsoZcb1wAHfqqwPeOm85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945606; c=relaxed/simple;
	bh=7u9FNA3ZfGP8XEDUmPTcZGwiQtZFPdXbcZ7OzAiOzzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fxeGbQu2AtT9Pli3lUFQrey5ExY1RihD3CmBtaOoAo93n3OTxZq8p6VpdOmvpeh7O4GqYLUNz7ou8n3U4hQi6/L0Qj5ZmQHeICtB9VFVq2CvUkT1+18JcSNrSecpHcLygp+yxgF2QAdOK7RmeC499Gj19uFRwvlEmlezLIsJiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MFcLaXVp; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MFcLaXVp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945603; x=1745481603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7u9FNA3ZfGP8XEDUmPTcZGwiQtZFPdXbcZ7OzAiOzzI=;
  b=MFcLaXVptaqrgpTjulfIqvAO680mHhAA/va475vwJz6HMUx9elPMgUhV
   nZwr/Wx0WoAshBtKiSjSGIoTGWIfkxNQP0W2Mb1cYjYpvE34ALSbdU73l
   oAS5xYoIwPicZQduZ0rztTaRvZ2AbzSzZP9An1t71EYUki+1MVcMj18mA
   bkkHlXYQhKUCiCXpuVmflo9ufO5qmrVqeWphwcijE4FGvMmmdl/zn2J3P
   up70Tt4UsdvdLst7RnsPad4Ka26tMIIFrQDM3dqIuzwL6PtGBwvJJrO/E
   SkbF18nk1DcjU4FRUALcrd6yWEz7VmQd+575i+t1B2nT0HmIgZZEq8FW/
   A==;
X-CSE-ConnectionGUID: GaNOKvukT1yMai0m5hfeBg==
X-CSE-MsgGUID: w2P0T9FRTiGubdQm6A1sgg==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515666"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 15:59:56 +0800
IronPort-SDR: tEJFCfI9v4shJ/Q2aFjILwC48Vnq/czsg6X2ED6OMyEActRuPHRcsm62lI2WbUXB90U8tB5TL4
 84En+5zP2RDITNfZMb3HMZ3yqoKOOH0IxYkWkrG6ZfXZlPqFklTkE71LInbyt4/aARTsTMkEBG
 V1y5puRR6e+239vyWSoivKkTl/CCsqVuj6fpVw6WSMLje6RT9yv9MARpwnaUaP2qgtw42mik54
 WharBCE9xaseAdd+DgAfKtajsYa8y+HZHi27QSK0yFGDDyvJXrDfFxgaiINdaTOTH4Gunn2era
 3rA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:06 -0700
IronPort-SDR: GbQKuRSrDUqLNB2yjJEh+EXn7A40K09xkSKttjnPiHhYP0TAKKMKhLoBxzid/sB9gzf1l8ZHW/
 BXSLxd2yOSxgzAMbv1rKZuihbioltev6UvdrlFkzeSJtXmSUqKn0n961DHnZrENyrYi+1yrkgO
 9wkGcLKIc2Kuaohto5lk5XeNcmDoWHNLhzIGnM7nFqsgS4XXBimEi3VWa7cPuSntC758zzFVvg
 QB27hdVsNT1toqmAd4tTaaJDzRDW+chrA8HxOqG3JSIUV+TBq8Oo8TsjZTwpCMNrj4HDCAK3h/
 T/Q=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 00:59:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 00/15] support test case repeat by different conditions
Date: Wed, 24 Apr 2024 16:59:40 +0900
Message-ID: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
repeat the test case. This series applies this feature to nvme test group so
that the test cases can be repeated for NVME transport types and backend types
in the ideal way. For this purpose, this series introduces new config parameters
NVMET_TRTYPES and NVMET_BLKDEV_TYPES. Taking this chance, it renames other
lowercase config parameters nvme_img_size, nvme_num_iter and use_rxe to
uppercase to follow the guide for environment variables.

The first four patches introduce the feature and apply it to the repetition for
non-zoned and zoned block devices. The fifth patch introduces a helper function
to prepare config parameter rename to uppercase. The following seven patches
apply the test case repeat feature to nvme group. Three of the seven patches are
reused from the work by Daniel. The last three patches rename the config
parameters. The all patches are listed in the order that does not lose the test
coverage with the default set up.

As an example of the repeated test run, let's say NVMET_TRTYPES and
NVMET_BLKDEV_TYPES are defined in the config file as follows:

  NVMET_TRTYPES="loop rdma tcp"
  NVMET_BLKDEV_TYPES="device file"

In this case, the test cases which depend on these parameters are repeated
3 x 2 = 6 times. For example, nvme/006 is repeated as follows.

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


Changes from v2:
* 5th patch: added to prepare for the parameter rename
* 6th patch: modified nvme_trtype description and added NVMET_TRTYPES check
* 13-15th patches: added for the parameter rename
* Applied Reviewed-by tags
* Rebased to the latest master branch tip

Changes from v1:
* Renamed NVMET_TR_TYPES to NVMET_TRTYPES
* 1st patch: reflected comments on the list and added Reviewed-by tag
* 5th patch: changed NVMET_TRTYPES from array to variable
* 7th patch: changed NVMET_BLKDEV_TYPES from array to variable
* Reflected other comments on the list


Daniel Wagner (3):
  nvme/rc: add blkdev type environment variable
  nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type
    tests
  nvme/{021,022,025,026,027,028}: do not hard code target blkdev type

Shin'ichiro Kawasaki (12):
  check: factor out _run_test()
  check: support test case repeat by different conditions
  check: use set_conditions() for the CAN_BE_ZONED test cases
  meta/{016,017}: add test cases to check repeated test case runs
  common/rc: introduce _check_conflict_and_set_default()
  nvme/rc: introduce NVMET_TRTYPES
  nvme/rc: introduce NVMET_BLKDEV_TYPES
  nvme/{002-031,033-038,040-045,047,048}: support NMVET_TRTYPES
  nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
  nvme/{rc,010,017,031,034,035}: rename nvme_img_size to NVME_IMG_SIZE
  nvme/{rc,016,017}: rename nvme_num_iter to NVME_NUM_ITER
  nvme/rc,srp/rc,common/multipath-over-rdma: rename use_rxe to USE_RXE

 Documentation/running-tests.md |  33 ++++++---
 Makefile                       |   3 +-
 check                          | 129 ++++++++++++++++++++++-----------
 common/multipath-over-rdma     |   5 +-
 common/rc                      |  27 +++++++
 common/shellcheck              |   2 +-
 common/zoned                   |  22 ++++++
 new                            |  21 ++++++
 tests/meta/016                 |  29 ++++++++
 tests/meta/016.out             |   2 +
 tests/meta/017                 |  29 ++++++++
 tests/meta/017.out             |   2 +
 tests/nvme/002                 |   4 +
 tests/nvme/003                 |   4 +
 tests/nvme/004                 |   4 +
 tests/nvme/005                 |   4 +
 tests/nvme/006                 |   8 +-
 tests/nvme/007                 |  27 -------
 tests/nvme/007.out             |   2 -
 tests/nvme/008                 |   8 +-
 tests/nvme/009                 |  36 ---------
 tests/nvme/009.out             |   3 -
 tests/nvme/010                 |  10 ++-
 tests/nvme/011                 |  39 ----------
 tests/nvme/011.out             |   3 -
 tests/nvme/012                 |   8 +-
 tests/nvme/013                 |  43 -----------
 tests/nvme/013.out             |   3 -
 tests/nvme/014                 |   8 +-
 tests/nvme/015                 |  48 ------------
 tests/nvme/015.out             |   4 -
 tests/nvme/016                 |   6 +-
 tests/nvme/017                 |   8 +-
 tests/nvme/018                 |   4 +
 tests/nvme/019                 |   8 +-
 tests/nvme/020                 |  40 ----------
 tests/nvme/020.out             |   4 -
 tests/nvme/021                 |  10 ++-
 tests/nvme/022                 |  10 ++-
 tests/nvme/023                 |   8 +-
 tests/nvme/024                 |  40 ----------
 tests/nvme/024.out             |   2 -
 tests/nvme/025                 |  10 ++-
 tests/nvme/026                 |  10 ++-
 tests/nvme/027                 |  10 ++-
 tests/nvme/028                 |  10 ++-
 tests/nvme/029                 |   4 +
 tests/nvme/030                 |   4 +
 tests/nvme/031                 |   6 +-
 tests/nvme/033                 |   4 +
 tests/nvme/034                 |   6 +-
 tests/nvme/035                 |   8 +-
 tests/nvme/036                 |   4 +
 tests/nvme/037                 |   4 +
 tests/nvme/038                 |   4 +
 tests/nvme/040                 |   4 +
 tests/nvme/041                 |   3 +
 tests/nvme/042                 |   3 +
 tests/nvme/043                 |   3 +
 tests/nvme/044                 |   3 +
 tests/nvme/045                 |   3 +
 tests/nvme/047                 |   4 +
 tests/nvme/048                 |   4 +
 tests/nvme/rc                  |  74 ++++++++++++++++---
 tests/srp/rc                   |   2 +-
 65 files changed, 493 insertions(+), 404 deletions(-)
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

