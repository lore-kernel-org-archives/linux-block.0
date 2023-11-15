Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538E7E
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C112J0fG"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0470BDB
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700027541; x=1731563541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XuGMDp+MYlIW2ppNs8zzsWYAuUNTvQjHo1ZIFlWJOKI=;
  b=C112J0fGGCf/nGq1wOCt9s7zFerj9gtkSDVwJAYJURJqNhIfotUExjp9
   qJTquQMMOPBRQhWpQ0OGodCE9LCtmxMZY15qy7BknAJOuuRnQBP6qv3/O
   j98wgcmxV0or/Ro0oUEiIchCL1qcK8wtZ76+sdsQXC12EJTRj1VILJULo
   XXaLDDW4UrkRp5msDZJnmrop+qdHRtx9XYjOGrT2Is+TWR49XjyKOt7R+
   bJPBOSqWmYwtKzc9ZXKP1Dw4+EY3FX0Mw7KIC7CaHaxvdATiTOE9Gg0KT
   67Lbw7WwsD+X9tgo95xoHu7UmLjAcHfdkeIKk2amhNTZ+Bu09jrxWFl2J
   A==;
X-CSE-ConnectionGUID: qB/8I2PwTeeS7IkYQHC1Bw==
X-CSE-MsgGUID: ZOdYWRquSO2cICnXk5hf/Q==
X-IronPort-AV: E=Sophos;i="6.03,304,1694707200"; 
   d="scan'208";a="2334142"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 13:52:21 +0800
IronPort-SDR: nqVuKzpBdAm6dx6CXUeyO/hzzlwTfIzC/UjmbMFhddOu2Kbzs48NAFMvvlnePFCC2GDMS3bPY1
 6UZ+hBzCl5FNHvlM0fuW2PC7hKyW5r0B7DDtraxR/msZwGmIoN0QQTFb0ADstixfDapPSouGyt
 UpFVJX+MpvgdnOEI4k6YgEeqIahyCxNN2m/0ASktEHJR9lBtca2csQKs/oE7/OXtFt9u9JHi8b
 w2wag0QiJ+Abpvxtcao/C2/v/snHC9e+Sr8DbyQRYfc0A9/6QAwVzjwTmsw0JIP6uykk1GlF6G
 TYw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2023 21:03:48 -0800
IronPort-SDR: vZERQIrBW0NT+fgf7ylgTTwXX76YXbJwski8BkY/3fsWjYdeHMR2J4tXRPGe28nDJtfH9iEUXa
 Q9FG/RaMS9MJvl807IZMDNMU8k2HYMAyj56KQp3s7kF2HxEK2Iqihj/RITRDmeTdoj5ehK40pe
 Z+hvkmXkI7YZdnUVh13gZZ29JoRbv4aJgxeG/X8ZbhC4/pvZ1HgT3PV+6o9rP1hP71XGO2/8Ot
 ASzv1PgNODENT4nFNycbOqtGUCy8UmTWgInwPtlA0lGoUE+/OV2XAqMuIHc6phuJ/qbvYYhHXQ
 oZY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2023 21:52:21 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: require kernel config NVME_HOST_AUTH
Date: Wed, 15 Nov 2023 14:52:18 +0900
Message-ID: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yi Zhang reported test cases for nvme authentication feature fail with
linux-block/for-next kernel [1]. I observed the failures with kernel v6.7-rc1.
Chris Leech pointed out that the test cases require kernel config option
NVME_HOST_AUTH. This series modifies the test cases to ensure the requirement.
The first patch introduces a new helper function. The second patch adds checks
for the requirement using the function.

[1] https://lore.kernel.org/linux-block/CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com/

Shin'ichiro Kawasaki (2):
  common/rc: introduce _kver_gt_or_eq
  nvme/{041,042,043,044,045}: require kernel config NVME_HOST_AUTH

 common/rc      | 17 ++++++++++++-----
 tests/nvme/041 |  1 +
 tests/nvme/042 |  1 +
 tests/nvme/043 |  1 +
 tests/nvme/044 |  1 +
 tests/nvme/045 |  1 +
 6 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.41.0

