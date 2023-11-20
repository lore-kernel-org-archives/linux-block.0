Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o0ZAtkhx"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E513A
	for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 18:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700448574; x=1731984574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EJjx07eaa3eOPS2MmLCRFA0098DB9H/f5+N2JcKQMLo=;
  b=o0ZAtkhxAksmCbbP3I/svrhexkSPBd9hDLdnjOKZHV6cbYMfY58tUMHN
   VsEoX9Yih07de2ffkS5g4t7QGuYF2qXbC1MczRjju/sphdnlpnKJRYIpt
   DJBU5qBcE98trU6SHZTBgAjqKf3lqsfX00kuM7moObd1bZYtO59YwRWGQ
   SV/8cfE+1dP9h7tu8+ZCeFlaAt3b+lgbos/myF+TT6QdtnbZXugxs6KnD
   j8mYaJriSMtuVAE3ZPtsa/ZbvI/QEI7KU/Hz90FaiB+Uo7Lm+BErAbmnt
   9aDUgxQlbWmwbF0I1pIkXmcPpDV5DoEF+9uBB0sJXfqL/Bgy1SykKcIkh
   w==;
X-CSE-ConnectionGUID: X9m5X8LXQ9aAbzI9kCDvVg==
X-CSE-MsgGUID: QWEx3uLCTOiVPo6HC5X9CA==
X-IronPort-AV: E=Sophos;i="6.04,212,1695657600"; 
   d="scan'208";a="2825571"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2023 10:49:33 +0800
IronPort-SDR: 07S6t6SkyyiM/aeebjh/gVJJOIJHScAXigAuwxcqyPjaLq4Pu3iCYWTDsLpE65Bv0v9QJToTbB
 9T0zCilOqfu5ksKCoA+UtV93bWHDCADvT+V11zQUlmdlTwsN7+XCRNAkUncFZrcPyZtpJ1M0bh
 8QuSqwn7jbp8JQ2R+lsFCuxtvDB3b96DFtGGzyf4IUJuaTmow60ZiDHS45pCUGNeaXo3BN1pZq
 yBQtbKgR1nJc3v66zYlNMOPRDACJUuYFBzYkzYz+Odm12tdcsPwaOTCeT6QNUlyWJ0OdXtLeTT
 AOw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2023 17:55:14 -0800
IronPort-SDR: wnUDoEhcIpZYbVJ9SHvH8Lg0lW3RA+bgddTHpZO5ooRQ1nVtFbemp0FXh5NkNksHOWIq4egR7/
 NCUOXD2DTray/rFGM2rQ4DL9r5e3o9f93e0M1HjGJ56aHqBRHkcL0lPegBHpOJf0VBbtN1ccoa
 fUhOpAOhZVo3yBwBL/vKPvKp4kdUA7o1V+cF6RRXXmdcp2vi45mp9x2OghPtdDmPV+KZFEjB5R
 FkXrPjI3cqpMJM4JkFaFvpo8IKkzbPUicF4Mm8uD79I/I/GpSu5YGuOyvsKTcQ18BZnwrX7gzF
 3AM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2023 18:49:32 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/1] nvme: require kernel config NVME_HOST_AUTH
Date: Mon, 20 Nov 2023 11:49:30 +0900
Message-ID: <20231120024931.3076984-1-shinichiro.kawasaki@wdc.com>
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
NVME_HOST_AUTH. This fix patch modifies the test cases to ensure the
requirement. I added a Reviewed-by tag by Daneil per record on GitHub [2].

[1] https://lore.kernel.org/linux-block/CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com/
[2] https://github.com/kawasaki/blktests/commit/81110ce8056f16716d09774e6f237ea0393579e1

Changes from v1:
* Refer nvme-fabrics sysfs attribute to not rely on kernel version

Shin'ichiro Kawasaki (1):
  nvme/{041,042,043,044,045}: check dhchap_ctrl_secret support by
    nvme-fabrics

 tests/nvme/041 |  1 +
 tests/nvme/042 |  1 +
 tests/nvme/043 |  1 +
 tests/nvme/044 |  1 +
 tests/nvme/045 |  1 +
 tests/nvme/rc  | 16 ++++++++++++++++
 6 files changed, 21 insertions(+)

-- 
2.41.0

