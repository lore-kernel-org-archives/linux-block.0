Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCAD30B
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479478; cv=none; b=k+3CkqNCYiuC4mi2AsOdUxQrp0/aqr8nriavHgik93Tu2nkjfSktGn8RFsFSRmdaA0sorPcXoKIvmXR9HayDx6i2lKQUVFBL03kyQRRW3NLCvri6yJrCZffAoDXGiah1jUW/9XAMwSe4u4qYPW1SgTiPsR+GP/J+QfwPi8WMOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479478; c=relaxed/simple;
	bh=5Q5XlmiKjhd1EBFq0YBhPhoTZcw6oBtp2bKB4ClOL1I=;
	h=X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=uGsBmybKB4pmLJokyDOU334xu36fw/w0AVo3a7sFVKnFRM5VOWL9t2oDyclZnGBJe53v5N8hcB3qwC8TFoD0OAuxxMAgje8U5hiTTYMS+TbjKmhYBIrnq5yHPkAap17YU1hyUTzp8r2+M7BosxVC9TgkkWYjMEFqSlZ/7dE6aI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-om2pZ_1705479462;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-om2pZ_1705479462)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 16:17:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com
Cc: chaitanyak@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] *** Test the NVMe reservation feature ***
Date: Wed, 17 Jan 2024 16:17:40 +0800
Message-ID: <20240117081742.93941-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1 to v2:
- Add a new patch to add a optinal argument --resv_enable.

- Make resv-report fit the new --eds argument.

- Filter the hosid output to make the new test case independent from
hostid.

- Change the new test case name to "Test the NVMe reservation feature".

Guixin Liu (2):
  nvme/{rc,002,016,017,030,031}: introduce --resv_enable argument
  test/nvme/050: test the reservation feature

 tests/nvme/002     |   3 +-
 tests/nvme/016     |   7 ++-
 tests/nvme/017     |  10 +++--
 tests/nvme/030     |   6 ++-
 tests/nvme/031     |   3 +-
 tests/nvme/050     |  96 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc      | 100 ++++++++++++++++++++++++++++++++++-------
 8 files changed, 308 insertions(+), 25 deletions(-)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

-- 
2.30.1 (Apple Git-130)

