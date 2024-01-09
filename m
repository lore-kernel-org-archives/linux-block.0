Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D2364B9
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qldrX4cR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704797121; x=1736333121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jkv4cA/svKg8OTtDXDLOO2Z/dSunImz1BxfOYmNYZ0k=;
  b=qldrX4cRA/l6Sr3F1pIMb5cAguuzKmM1EVf/7HyqIEGLGTlZYajcInqh
   qoHzkiP47y/KzrwbXVM2gW5V/W0zet70iTfGTnKgsHgPmF+2kTDBmCaZL
   yTpEKDw/khW9HkQDDtLYQU+5czagFxuEj/b47MKnQPZWyTmnOmpSMSeRK
   Rq7qUww9jXiESSUjeDfPa0HrGleHvIG/3Ta7z1ItCmtO6S7l2YbL9xVGH
   LQZxUv0CWsgpeaLGiCHo23fedo4ckvUoLlS/0EOjNVhc/McGwdgNMSrPo
   b+ZceoB68V9Mzo7Ed0OClQeWm9Mdt3pbZz61TMgJr6qZ/2bRXZACg1Vzp
   g==;
X-CSE-ConnectionGUID: ziK1OPMgRnOzxx1a/m/ZMg==
X-CSE-MsgGUID: dVQltaAiQxC8JB39SyENJQ==
X-IronPort-AV: E=Sophos;i="6.04,182,1695657600"; 
   d="scan'208";a="6473952"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2024 18:44:53 +0800
IronPort-SDR: mW2DQnYkMZFBgWUvEV6vWWA6x8mU2gMO4O3QAxkTOjqzOJGfS56xav9Wns3ovSbNekeI4oKPZG
 eIddGkCsxnag==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 01:55:13 -0800
IronPort-SDR: 5LNfFDmOSPSLaQFXw6G7ixBoUzJks1C1rzEpURb87636Whv9Vq9jVASbGTLDWCrfJIBu/x8QW9
 XuX6gPTtX2ZQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jan 2024 02:44:54 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/2] block/031: allow to run with built-in null_blk driver
Date: Tue,  9 Jan 2024 19:44:51 +0900
Message-ID: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case block/031 now requires loadable null_blk driver. This series
allows it to run with built-in null_blk driver. The first patch prepares for it.
The second patch does the change.

Changes from v1:
* Added null_blk driver status check in _have_null_blk_feature()

Shin'ichiro Kawasaki (2):
  common/null_blk: introduce _have_null_blk_feature
  block/031: allow to run with built-in null_blk driver

 common/null_blk | 15 +++++++++++++++
 tests/block/031 | 27 +++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.43.0

