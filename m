Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA715E9D
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RV9n5sAz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704963644; x=1736499644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Al3e7a3a5eqXACC7YNMVhepDxdzPs6p799q40w6u6Dk=;
  b=RV9n5sAzSVgcX4/KFrJ6pc7nPFBJONLfFjXvWj32SQRjwo0B4q7NmOmQ
   G/pVMYSN1pjWUoG3iX5A8YpGZMxyLH8g+VDEPYT28mbM4BQ72NF5iC+FY
   /IwhDJndqOfY5VTZokWJJa7eRSrg9Hm2fvBDRiEYqR0J8tiC7rZS4SMP3
   f6guTkeHk8WjHNFJ6K2Jw/yC9Bs4aH6jNyuXpGkQZ4oh0QbXZUzpLjIWb
   7f1j/V2Abj1xPQI79yrZsCUXDZQNoT4+EQMdcC/3nplS+bCvj2Osi3Xz2
   T6HRu/SelrhHJgIFixTxW2NQrmKfG12vfASvY+Yk+Qur1aGrFBa7uIYlg
   g==;
X-CSE-ConnectionGUID: XV3ceKJSRkSQTfbjFtexcQ==
X-CSE-MsgGUID: puS8a15ZTdiMgiD6YqHb4w==
X-IronPort-AV: E=Sophos;i="6.04,185,1695657600"; 
   d="scan'208";a="6622105"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2024 17:00:41 +0800
IronPort-SDR: UxsAdWyLhbZoUmdyW8yYGAK7V3OzB2oF9UChPVfvBwTcMfliZ6LbUabIFgrrUx2YGtNEHlBX7Y
 u3a0+/8XEI1A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2024 00:10:58 -0800
IronPort-SDR: tYgSOaJSuOUVM4ptiUOPwIdvxJRshARt5q659S3TL0SB09PU/runnzPQouza0ht5RSXyc0xWP8
 J1Yx7vRxQPUw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2024 01:00:39 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 0/2] block/031: allow to run with built-in null_blk driver
Date: Thu, 11 Jan 2024 18:00:36 +0900
Message-ID: <20240111090038.4045250-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case block/031 now requires the loadable null_blk driver. This series
allows it to run with the built-in null_blk driver. The first patch prepares for
it. The second patch makes the change.

Changes from v2:
* 2nd patch: Improved the commit message and the inline comments
* Added Reviewed-by tags

Changes from v1:
* Added null_blk driver status check in _have_null_blk_feature()

Shin'ichiro Kawasaki (2):
  common/null_blk: introduce _have_null_blk_feature
  block/031: allow to run with built-in null_blk driver

 common/null_blk | 15 +++++++++++++++
 tests/block/031 | 29 +++++++++++++++++++++--------
 2 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.43.0

