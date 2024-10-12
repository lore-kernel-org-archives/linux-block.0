Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5851547CD
	for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731534; cv=none; b=KD7an2tm0zUvIiZ8XgY9wnLwVLzidYXc+9BOUANhKl8WoWIgj8I6FfjidgJ1J4puOwQzuEAeX80myymXSCfuyNoEZWI+AvUmd6d+A4S9C/CgKw1MquHqbPAKHqR11FqXoywE8GCY06cmKnTZfW063jlFXum2Wb36fkP0fiGcA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731534; c=relaxed/simple;
	bh=jWuTIAC0wwre0t4Hc+xweVO1Rzn/G8glABOFV8BAFYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SF47Qa2oadoyt+CwgCg5CD4t7Ip/hV0EMfLZWXTdewEZLcZxiPMti5IzdnmVd5yPZgCQEbuUsnHWJ+Xd2xdgvWdBLN2yrUs8z781inUZqkCAuJlp9A6AHAv9e5/BYj6JX8Nv4L45y6B3tjj6Z/S1JVxgQ28BTFN9WlTkQMnsKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c0tvOslg; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c0tvOslg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728731522; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0WZzXU/RPPADO63xVPX1HrAdtftwLLDpevHHz2xeA68=;
	b=c0tvOslgnYfabQ8ECRpDev4GNbryNA7pTtWcQECSGE5XaGAGuyt8HS/VadFJ8tnT4J1Xxp/t+zqEshx0GomjL1hhg3Y1Iio4QSMlDLa78BkaJr74iRveKh3B5DcQHxyIYGkid+tZaDdbJC4eoJpUbalpdNmBAoYkyvcVmLqH5Ok=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGvl9YH_1728731517 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 19:12:02 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v3 0/2] Test the NVMe reservation feature
Date: Sat, 12 Oct 2024 19:11:55 +0800
Message-ID: <20241012111157.44368-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v2 to v3:
- Put calling "resv-report --help" to the beginning of test_resv().
- Introduce a hlper resv_report.
- Fit newest blktests version. 

Changes from v1 to v2:
- Add a new patch to add a optinal argument --resv_enable.

- Make resv-report fit the new --eds argument.

- Filter the hosid output to make the new test case independent from
hostid.

- Change the new test case name to "Test the NVMe reservation feature".

Guixin Liu (2):
  nvme/{md/001,rc,002,016,017,030,052}: introduce --resv_enable argument
  nvme: test the nvme reservation feature

 common/nvme        |  89 +++++++++++++++++++++++++++++++------
 tests/md/001       |   4 +-
 tests/nvme/002     |   3 +-
 tests/nvme/016     |   7 ++-
 tests/nvme/017     |  10 +++--
 tests/nvme/030     |   6 ++-
 tests/nvme/052     |   5 ++-
 tests/nvme/054     |  99 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc      |  11 ++++-
 10 files changed, 316 insertions(+), 26 deletions(-)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

-- 
2.43.0

