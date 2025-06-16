Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB818FDDB
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750039647; cv=none; b=nb8yl5tqcIkk6xrX0R58uwg2FOCQmC+N/QNf1Uc4bECBDb4oXmcGcvCZjqgWZCM7x0FTFY3MVQ36zDUBnsGn+9TmPdngMw6f65kzNimXtN0DEeSDZkmzD2g9uVdkmtocR89MGdei12dcDxQAUKReBU6PiF/dXeoB7d7aC6aZ+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750039647; c=relaxed/simple;
	bh=a23zc64JCl1Eks8CpQP0iYIGP+/xmfrIA9EMxx5T83w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQNSovr4aWptZGFe5da8qX+stutsrGjDBPGXV02Nnz+/q21ihbXlDHLm6jch7kgA5OR3vyiMv2IyWtaNG+hnILWhh7ONijKJy4HwO54uxqu+BzS8O/jXcF7bFcVRnvJrMDo/ytwf2qxmG46Ah0ujcfWprbbVLkU2rOgbTRTsCnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Dwd99zWU; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dwd99zWU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750039645; x=1781575645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a23zc64JCl1Eks8CpQP0iYIGP+/xmfrIA9EMxx5T83w=;
  b=Dwd99zWUyFEDoSunC1EoyH5JMEgAOpHz2eBkGOCDQWx7LL0bMOy/bJaK
   5Cj2JadSvb5UIiEyhSwnFVL6B+wv1T7HoOn13hDuPowhWKl6jbrSqKBmY
   IDnvhahTgnpWRFRfH7pQ5JAMpPg6tLa88QHutK2hap82NM/I0Pfdqafbo
   jTSKIansZa5OhoRPlV8o8vzHgq5tHOwsXKKmvmboYzeyuiqzYJ0KFUiW9
   1z1MkJhX23L9FI5hfbPnw1uf45iOru/eraJVUf/p4GPvjFPWjipHMpfvQ
   2ZJPHcGYsQ0nRThT1VXom2BK51NWB6SpQu5dMxmRRR+LoP+zeflU6PM5Y
   A==;
X-CSE-ConnectionGUID: XAjdVmZtTGKE+aELZN2R5A==
X-CSE-MsgGUID: DNdw9guTTAKHS9whhSOqZg==
X-IronPort-AV: E=Sophos;i="6.16,240,1744041600"; 
   d="scan'208";a="84623406"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2025 10:07:18 +0800
IronPort-SDR: 684f6de5_DAvyPG5UDCBbn86OWUnz/PNkeFtreKZj97trXaExPFI7rMK
 y/e4CfyyCNDTSUiAXjNI5khEv4kuuVjS/9Vu5Qg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2025 18:05:42 -0700
WDCIronportException: Internal
Received: from wdap-do3irrikgj.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.172])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jun 2025 19:07:17 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@meta.com>,
	Keith Busch <kbusch@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: add nvme metadata passthrough test
Date: Mon, 16 Jun 2025 11:07:14 +0900
Message-ID: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keith contributed a test case to cover nvme metadata passthrough [1],
which confirms a kernel fix by the commit 43a67dd812c5 ("block: flip iter
directions in blk_rq_integrity_map_user()"). I made some slight
improvements on it and repost as this series. The first patch introduces
two helper functions to check requirements of the test target
namespaces. The second patch adds the test case.

[1] https://lore.kernel.org/linux-nvme/20250609154122.2119007-1-kbusch@meta.com/

P.S. When I ran blktests to confirm this patch using QEMU nvme
     namespaces with metadata as TEST_DEV, I found some existing test
     cases fail: nvme/034, 035, 049 and 053. Three of the test cases
     need improvements to avoid the failure. I'm preparing another
     series for it. The other test case nvme/053 shows weird fio
     failure. It passes with metadata size 8 bytes and 16 bytes (md=8 and
     md=16 QEMU options. But it fails when metadata size is 64 bytes
     (md=64). This needs some more debug effort.

Keith Busch (1):
  nvme: add nvme metadata passthrough test

Shin'ichiro Kawasaki (1):
  nvme/rc: introduce helper functions to check namespace metadata

 src/.gitignore              |   1 +
 src/Makefile                |   1 +
 src/nvme-passthrough-meta.c | 232 ++++++++++++++++++++++++++++++++++++
 tests/nvme/064              |  34 ++++++
 tests/nvme/064.out          |   2 +
 tests/nvme/rc               |  23 ++++
 6 files changed, 293 insertions(+)
 create mode 100644 src/nvme-passthrough-meta.c
 create mode 100755 tests/nvme/064
 create mode 100644 tests/nvme/064.out

-- 
2.49.0

