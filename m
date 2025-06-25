Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970125C704
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851908; cv=none; b=qPYnEyum0Fsk7cPx3LxucUqRSpAtIOBLociL3xGxPCperJSd9r81j9hNZU1D2WqKpO6wl4kUATGhOtn0sjL5FnCRkNsebPpoRUrm1SbRSkso0dNMxfuJJ6O00WGgj3UsYpeg22LPDQ5+nst6HkgMFfnjPpZk3dvElE3vUQxb/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851908; c=relaxed/simple;
	bh=L4iolfUlrjcvKRCrK0EY039xTf5KB94qyUrsaP4ddQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OebwSGk9my6igrW6yCUzQevxJs2DpbaHeeUErRCxUDA8cikHfst16ZMkminOR7jv4I3FoLVxs1zuEh2jfccNCpyjW8s7yOx3s7g+aHkDgcXiPBn3WQyDVR0ZeRRBwXIWt54fryy/pdxXvMggJ6KJuQpbQj9loRM1q4O71DXzl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XCf6Wnjl; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XCf6Wnjl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851907; x=1782387907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L4iolfUlrjcvKRCrK0EY039xTf5KB94qyUrsaP4ddQE=;
  b=XCf6WnjlnNFytg0W/I+PO6i2hTuKgHjwYnoGFOL8S9IWoBwBEPlKKkPU
   +sLGp7oLqu/dsaj4xw5cwsqJG0rMENFH3hD7WoaBSpQw6tnKBx8lGnw2J
   kqOwLalDTjq2Cc8A2kQ1Ss4m0mph2HL45PL7UF+9sQqD0DLrAC5fzVaON
   MQMRoQAMHNLcySJeesbDghEPS+jOuOHaa6Pp4DqKmwmtKK6kNETPZzxic
   dKUgx9FlcaPrtGwROnKXXbQT+rwVcCX4sXj9yhVcH7x0Rdk7g0SlGdphe
   IxrhgmU5IjIYcY3N4HoO7DbkJJySWDii9VexGCP6ZUMCZ1GmyW5HwteZS
   g==;
X-CSE-ConnectionGUID: PAfyxJorRviipWduMByuXQ==
X-CSE-MsgGUID: NmUlI/vqTyO7UjZAQ3qZOg==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85207164"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:45:06 +0800
IronPort-SDR: 685bd2c2_kfPgzYzm1OYjJmr4PffbGAwih9C63ENWKszDHX9WTy2oUiM
 2PUb5JO8lyS9V2xsDUWiQPFs+VuzeX8+MrPO4tg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2025 03:43:14 -0700
WDCIronportException: Internal
Received: from 5cg2075g47.ad.shared (HELO shinmob.wdc.com) ([10.224.173.209])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2025 04:45:05 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: avoid failures of TEST_DEV with metadata
Date: Wed, 25 Jun 2025 20:45:03 +0900
Message-ID: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, the new test case nvme/064 was introduced to cover namespaces
formatted with metadata [1]. To run the test case, it is required to
specify namespaces with metadata as TEST_DEV. When this TEST_DEV is used
for other test cases, a few other test cases fail. This series addresses
the failures. The first patch allows skipping nvme/034 and nvme/035 when
TEST_DEV has metadata. The second patch adds an option to the fio
command in nvme/049 that is required for TEST_DEV with metadata.

[1] https://lore.kernel.org/linux-nvme/20250616020716.2789576-1-shinichiro.kawasaki@wdc.com/

P.S. I had observed nvme/053 failure using TEST_DEV with metadata, but
     it was because I configured QEMU NVME namespace as TEST_DEV with
     512b block size. With 4k block size, the failure disappeared.


Shin'ichiro Kawasaki (2):
  nvme/{034,035}: skip when the test target namespace has metadata
  nvme/049: add fio md_per_io_size option

 tests/nvme/034 |  1 +
 tests/nvme/035 |  1 +
 tests/nvme/049 | 13 +++++++++++++
 tests/nvme/rc  |  8 ++++++++
 4 files changed, 23 insertions(+)

-- 
2.49.0

