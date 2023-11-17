Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ju8pn1bi"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA2DB9
	for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 04:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700222753; x=1731758753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7GuL9vIgDwAK9OU7Hdh+8V9imPbos4b/qdabvxGYJ+M=;
  b=Ju8pn1biQVDmV0BFrDx6NBiyr1FtjrRzBBgz7fCtkRYL9XPQokoTeQKc
   muhvkEMH+dh7WKXTQ6gGwlobjTJdDyRun5yE4HENqId1AAtiR8Kav7Hz9
   j8KZi4Pd07AX8Jq2BrRR8u7WCi/1oWAzq+h9YW7RGWRKBnPMs27lxkveT
   6YZRt/R+5JDa9Jof7RTBEeX4GrjBixQ0tJ2R0YOTNM5McSTesJx8ltKJb
   oW1RixClEzCMta4Uu+upYC6nMehn+elwJaRLKF5Qb+Robz5vnMDMtzdSN
   BkrXGmeHcGaC54F/TR5s4hq6EDNsdRBpSB9Th6w5l4UEelGAXBD1a3Ela
   g==;
X-CSE-ConnectionGUID: DZj5IlTbQDCkS2cE5LXqUQ==
X-CSE-MsgGUID: O6n8Y+3YS7a7kwE7QLMvWA==
X-IronPort-AV: E=Sophos;i="6.04,206,1695657600"; 
   d="scan'208";a="2575194"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2023 20:05:52 +0800
IronPort-SDR: xg/tOLb4JRU3GFxaohirW6xlnZKrcbAWhV8uXK19b6r080KpDUJdODBTBsd2VbMQu3dnPMleB9
 /8bjsPeYTS5P6x+BNkJFXZ3I3dEc6tNuck3jCfsAddMUsYB8PKuh/IFreqXe6EJ94L6behqmdk
 0PGnFNnksxxZK9qDPZS4/Z7Te80673uHTYAiTR2KMK6Wy8ow8ROqZkA0LdIWUHUFy0FA5PsXST
 /AuVcMAXwdN0TycvTtzg5I/EWCe8k1m8emkAwVk+mKAa4M3O57XVgbJCq6iEdA/zqm/Cc92OAH
 0DA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2023 03:11:35 -0800
IronPort-SDR: MdRz7VVGxq96nRl6HbozjHBGuA4duHlM3PsJOnnhCITN3yUypf4sW6dtaV6UTPpO5YVrgOPECX
 8RMnCNsrKwsQ/ZSJMvn+u1GnnEwKcb+7O/wfYTNhDhX7Z1kJ+Z+jdY3/RLf7LGb6dT0bvUlPx5
 n8nxup0s+KO0TbdO3wBmzwxrBArUCrEGH6GIBNb3MTTkncKQ8igOvizhj3zsssXKA42qlQeR+y
 /m2zQNFeX4lL5dGr0cxb+3sdSalfCtnMYYeD9UU1yRuw1TVNCizAwSnU4RLfq2xC6NZl9omJEa
 X94=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Nov 2023 04:05:51 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/2] nvme: Allow for pre-defined UUID and subsystem NQN
Date: Fri, 17 Nov 2023 21:05:48 +0900
Message-ID: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the discussion to run nvme test group with real RDMA hardware, Hannes pointed
out that pre-defined UUID and subsystem NQN will be obstacles. To address them,
he created two patches in a PR [1]. I post the patches here for review by linux-
nvme and linux-block members.

[1] https://github.com/osandov/blktests/pull/127

Changes from v1:
* 2nd patch: remove only subsystem NQN part from the "nvme disconnect" output

Hannes Reinecke (2):
  nvme: do not print UUID to log files
  nvme: do not print subsystem NQN to stdout

 tests/nvme/003.out |  2 +-
 tests/nvme/004     |  3 +--
 tests/nvme/004.out |  4 +---
 tests/nvme/008     |  3 +--
 tests/nvme/008.out |  4 +---
 tests/nvme/009     |  3 +--
 tests/nvme/009.out |  4 +---
 tests/nvme/010     |  3 +--
 tests/nvme/010.out |  4 +---
 tests/nvme/011     |  3 +--
 tests/nvme/011.out |  4 +---
 tests/nvme/012     |  3 +--
 tests/nvme/012.out |  4 +---
 tests/nvme/013     |  3 +--
 tests/nvme/013.out |  4 +---
 tests/nvme/014     |  3 +--
 tests/nvme/014.out |  4 +---
 tests/nvme/015     |  3 +--
 tests/nvme/015.out |  4 +---
 tests/nvme/018     |  3 +--
 tests/nvme/018.out |  4 +---
 tests/nvme/019     |  3 +--
 tests/nvme/019.out |  4 +---
 tests/nvme/020     |  3 +--
 tests/nvme/020.out |  4 +---
 tests/nvme/021     |  3 +--
 tests/nvme/021.out |  2 --
 tests/nvme/022     |  3 +--
 tests/nvme/022.out |  2 --
 tests/nvme/023     |  3 +--
 tests/nvme/023.out |  2 --
 tests/nvme/024     |  3 +--
 tests/nvme/024.out |  2 --
 tests/nvme/025     |  3 +--
 tests/nvme/025.out |  2 --
 tests/nvme/026     |  3 +--
 tests/nvme/026.out |  2 --
 tests/nvme/027     |  3 +--
 tests/nvme/027.out |  2 --
 tests/nvme/028     |  3 +--
 tests/nvme/028.out |  2 --
 tests/nvme/029     |  3 +--
 tests/nvme/029.out |  2 --
 tests/nvme/033.out |  2 +-
 tests/nvme/034.out |  2 +-
 tests/nvme/035.out |  2 +-
 tests/nvme/036.out |  2 +-
 tests/nvme/041.out |  4 ++--
 tests/nvme/042.out | 14 +++++++-------
 tests/nvme/043.out | 16 ++++++++--------
 tests/nvme/044.out |  8 ++++----
 tests/nvme/045.out |  2 +-
 tests/nvme/048.out |  2 +-
 tests/nvme/rc      | 27 ++++++++++++++++++++++++++-
 54 files changed, 87 insertions(+), 125 deletions(-)

-- 
2.41.0

