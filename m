Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1C13C67B
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350534; cv=none; b=fV73W6a62n4v+LDbxYMrm/pDSXamcaYSwydAd5J4+SKQ+LgV92pRzRhsy5aK5KtWV3cCTenwqiMJqyPUm4dEt4xJHso47NPOWkLEqptQ6zSYMc3Qtn3oJ7HxSnxe8Q2FNMFunDYpM9Ekc4AuPpRwAK5eDGtm+C/B0pCjBSQ8QUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350534; c=relaxed/simple;
	bh=c9I8MKTorsqgSs+cuc1YuXPtLTUYdZF/snt/sNrGyYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UljN1llkgkBXO9DHQPjOW7g/t1bv3zqEHeNejj+Ot26wuzED2RZo6PxlOTJRF7OpGHa3uECTYRggG6Xg57NDmreIQ/gOCT80qpAhErO3taqGYJifL1y/viPcwkwbSqQE9n/JbfPn4zZU4KTn2jJt5mJFZDCC6r8UxBbZBdmjp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h2mHWzEs; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h2mHWzEs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713350532; x=1744886532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c9I8MKTorsqgSs+cuc1YuXPtLTUYdZF/snt/sNrGyYE=;
  b=h2mHWzEsBk7n9pjhLpsi8YsIBhD5rg5kKaED+7LAsFEQH29453A7cOLY
   e07mXLO+akY0m3t6bwsRScZx7Zg1kVw0Nz4avG5TVQeNojnhceotihvlN
   ksakh/INouP2RbAL45aO6CROK+nUaKgcUbpCYLU1+1Q7jmTCz0DxzmwPs
   YyLcygPvdDuAN5VL9ti7ujMPvFqJZUA/beiPjrBIuKPt5+cQYYmuMg5oH
   ov1SL6iym7BjRBFSEA9yWw6C4xyWxpk02RA0S0rM5XOKZrL4V+S0BOik9
   y2dup7m8V0v5N0bhSANgY3KMSmZMOBw2yqW7E4ivo1D5QIjrHytrHoBAX
   Q==;
X-CSE-ConnectionGUID: wcSzcvXdRJW7yZbl6U0H2Q==
X-CSE-MsgGUID: VgBMNodVR0SfO6mGMzCMYw==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14913458"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 18:42:11 +0800
IronPort-SDR: TkVIrZvQ/9or2m237iwVdSVrzSoELPk2SkV2YY5HIFlSujaxCPQ7iIl24MqXxx7JmVGfDipE3u
 WcQm095WWZCaR0O7TQU/bxQXfn16xuNl+M2knM0OMt5EgAz+LTJiqhVBPbi00YSKm+lOdtNZ1z
 QyyktyoGW4DnyRnXgksvtD+voNeVlK40V3PDWzCXgBRe1ei8r2fWPAhqNeyKqHBzquhkXKY0tL
 m6N+bAeGQwHCeWltSceeIylehdTcxmHPVa5UEHP+HmrXWLzbVF/ov4v4hHOP0tCskhQ6SjkHjN
 /74=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2024 02:44:49 -0700
IronPort-SDR: nhvOm7+mm9Tu8HVUa41b97RB9gTP8gKbsbU2gNAH9ZqYsnPEVz5fpNaOiQE0qgZDhbtp7qIN3X
 zj6uZNCS4dQm1mlia1X3CMNoIdJuxtK1nNU+m/1KLw6DSKl0tUO5+qg03nZtNo9qnxn8ApL+lr
 kyquhx1wmVen0tiswwkkglseDKUAUzjEU1NxahT9KbgELqDCmvKoEqI0KotL0xyh1sMJ5uxrvP
 CWmysnvhax1HoFQTCct243yWUIfErij0iOQnRUA9KF5Q5LMtPnamnPmzuidE0f4nA57L+P6zQj
 +Y4=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2024 03:42:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: nbd@other.debian.org,
	Josef Bacik <josef@toxicpanda.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/2] fix nbd/002
Date: Wed, 17 Apr 2024 19:42:07 +0900
Message-ID: <20240417104209.2898526-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, CKI project found blktests nbd/002 failure. The test case sets up the
connection to the nbd device, then checks partition existence in the device to
confirm that the kernel reads the partition table in the device. Usually, this
partition read by kernel is completed before the test script checks the
partition existence. However, the partition read often completes after the
partition existence check, then the test case fails. I think the test script
checks the partition existence too early, and this should be fixed in the test
script.

During this investigation, I noticed that the test case nbd/002 handles the
ioctl interface and the netlink interface opposite. The first patch fixes this
wrong interface handling. The second patch addresses the too early partition
existence check issue.

Link to v1 patch: https://lore.kernel.org/linux-block/20240319085015.3901051-1-shinichiro.kawasaki@wdc.com/

Changes from v1:
* Added another patch to fix ioctl/netlink interface handling mistake
* Avoid the nbd/002 failure by repeating the partition existence check

Shin'ichiro Kawasaki (2):
  nbd/002: fix wrong -L/-nonetlink option usage
  nbd/002: repeat partition existence check for ioctl interface

 tests/nbd/002 | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
2.44.0

