Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75D2CA6
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YV2ucJK1"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED28F
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 22:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699426076; x=1730962076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AuLEQId7sKW9FEIAlwUYpzGQPwGNoby4mB8sQwyNPIY=;
  b=YV2ucJK10LBndJvdkp8LUNOH1VayHftl+r0ZljelkYo6J6N7QXUqgv45
   qRP+Vtpg2jTrFEyG6LFPZG/spd3VVZtBS6PyoNr721vo4j/Y38/fLFrHQ
   VBk40SvyJkfdkvatZWp8tEEalPXXzg/mx0Py96ZcC8GGlvKrBlIsfftWP
   UObmIu150B46Iat83A960wKZH7PUGFG+7Gclz9tq4e51e4OXlAbQjbTjg
   5TiUkFYUbeN7Zd+8mf1pqH3TvT5w26zF3dqe/vjVGdIJLmpMYvaiBBT87
   /yzuXkhWcxb2VeumAVGSvHUN4c1UFIYcdzdQl0GgRYaqEzS1u2Qs7vUaV
   A==;
X-CSE-ConnectionGUID: fY72M88uR8mwDuJkb2aaTQ==
X-CSE-MsgGUID: IG4G3+MiQueq8RplRG6Gfg==
X-IronPort-AV: E=Sophos;i="6.03,285,1694707200"; 
   d="scan'208";a="1616002"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2023 14:47:55 +0800
IronPort-SDR: l4jYJm69BKkT7qIbDFpqaD2bUDBQ9Ml/rUWDrFacUfyLLUuefQW3VWm7T1QLZm9eqcCrBnbepD
 FDM403atTJpgfU7hF4Zyf6dZIhclylgU3c4qfVyvViJizFyT5Aocr4X0/I2iXYjBbkt4YnshS1
 a993JM2618kaVEZJuXnlKptt7YC3Y/2OvmLx9NJblAeXnKsXHxQM3yA2O5Qg7LH0SogQ6Z4FCc
 USGJDIKvIZ1pG69ZFbxN6oxlLWLQCU+pU1DPON1Lz3bqLEYyUC9oZprMoUKD6msfn9H5z50Lq6
 ztw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2023 21:53:50 -0800
IronPort-SDR: 0fmUHDIK2utaiN/GvvQNaqUEXgo6Y94hM6jLmRgIsZ+BEqSHkM+O6PWzQW4yhxjQVgiBHd8O0F
 1kpOch6J0nLKnBgoAW22IzpTu+4OqkpnlaZr9OAiADWG4sqiGRfNtBb6NHFL68LLfIHF5tzCBW
 1YRTCuqCXt8EqzlCNAXDF/oE7rwyLnsvdjkG2zDEkPfqvNrSuTyQml7nV993etwyH8+TdYWkjR
 kr0X5F7vyb9EEzAaRt2SU1c/GGP7xsbWOf3A5jqU2NZ8FWkJ6A+m8pHeS+oqpXjJ5jrxakY7i0
 8jE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2023 22:47:54 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: Allow for pre-defined UUID and subsystem NQN
Date: Wed,  8 Nov 2023 15:47:51 +0900
Message-ID: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>
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

Hannes Reinecke (2):
  nvme: do not print UUID to log files
  nvme: do not print subsystem NQN to stdout

 tests/nvme/003.out |  1 -
 tests/nvme/004     |  3 +--
 tests/nvme/004.out |  3 ---
 tests/nvme/008     |  3 +--
 tests/nvme/008.out |  3 ---
 tests/nvme/009     |  3 +--
 tests/nvme/009.out |  3 ---
 tests/nvme/010     |  3 +--
 tests/nvme/010.out |  3 ---
 tests/nvme/011     |  3 +--
 tests/nvme/011.out |  3 ---
 tests/nvme/012     |  3 +--
 tests/nvme/012.out |  3 ---
 tests/nvme/013     |  3 +--
 tests/nvme/013.out |  3 ---
 tests/nvme/014     |  3 +--
 tests/nvme/014.out |  3 ---
 tests/nvme/015     |  3 +--
 tests/nvme/015.out |  3 ---
 tests/nvme/018     |  3 +--
 tests/nvme/018.out |  3 ---
 tests/nvme/019     |  3 +--
 tests/nvme/019.out |  3 ---
 tests/nvme/020     |  3 +--
 tests/nvme/020.out |  3 ---
 tests/nvme/021     |  5 ++---
 tests/nvme/021.out |  2 --
 tests/nvme/022     |  5 ++---
 tests/nvme/022.out |  2 --
 tests/nvme/023     |  5 ++---
 tests/nvme/023.out |  2 --
 tests/nvme/024     |  5 ++---
 tests/nvme/024.out |  2 --
 tests/nvme/025     |  5 ++---
 tests/nvme/025.out |  2 --
 tests/nvme/026     |  5 ++---
 tests/nvme/026.out |  2 --
 tests/nvme/027     |  5 ++---
 tests/nvme/027.out |  2 --
 tests/nvme/028     |  5 ++---
 tests/nvme/028.out |  2 --
 tests/nvme/029     |  5 ++---
 tests/nvme/029.out |  2 --
 tests/nvme/031     |  2 +-
 tests/nvme/033.out |  1 -
 tests/nvme/034.out |  1 -
 tests/nvme/035.out |  1 -
 tests/nvme/036.out |  1 -
 tests/nvme/037     |  2 +-
 tests/nvme/041.out |  2 --
 tests/nvme/042.out |  7 -------
 tests/nvme/043.out |  8 --------
 tests/nvme/044.out |  4 ----
 tests/nvme/045.out |  1 -
 tests/nvme/047     |  4 ++--
 tests/nvme/048.out |  1 -
 tests/nvme/rc      | 26 +++++++++++++++++++++++++-
 57 files changed, 59 insertions(+), 138 deletions(-)

-- 
2.41.0

