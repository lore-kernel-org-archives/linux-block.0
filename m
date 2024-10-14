Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA0156649
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896487; cv=none; b=G1jA+6RAlvzISV55yTs5B4+S3Od6UdcMhnN35y+WL4SicZZmXapA2sJUKiaVMK8ocpPg5YGKOiZ+nZM3WyQKE4E81d/y8ssavEZy8RxQL3LSSyV+1fPFERYC/Vkku+bpQSIA/BaFyRuGm5gS4IAN/Ty1qoL6xmIOJ686A04wJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896487; c=relaxed/simple;
	bh=MGBpld9hapRB3WaJFAx+4VeIEi6wi/oZ9+DDuK15KyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s10wbAsjihHhl18slsGAas1VQZjysMYTRuYTwLksq0pLq0xOHm9sa68OikQ8j28bG2G2GCQw+RrIFFR6ivlPi13UXNymw30uvUEPTM2taYsjWo3clyMZLPbFIACvN1SGBUHhSpEs66+JSWLOmCaWBCZLaRLH4Hnmq6DbsCKm52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XhMjwe1v; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XhMjwe1v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728896481; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o7Jsq9VK08icpuHm5DwOaStudIi+XDXJGYtuwnNd5hU=;
	b=XhMjwe1vx81XuyiT3Di/zJcCKsTnFP6bIf0W+lFqJQYwN9uH304bOjv6ZfA+THpZ7RLvINJhOtrUhv7ATeSau8upQZ5cODKG2EEHRJh+nEru0AT17MmSvmGSrHw61nF8pwdUwfhzNl2uPikFPCIwqvA5Cdf1utJ8VxscKcSG+jI=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH3n2Jr_1728896476 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 17:01:21 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v4 0/2] Test the NVMe reservation feature
Date: Mon, 14 Oct 2024 17:01:14 +0800
Message-ID: <20241014090116.125500-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v3 to v4:
- Introduce var test_dev="/dev/${nvmedev}n1" instead of using
"/dev/${nvmedev}n1" everywhere.
- Filter the resv-report result.

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

 common/nvme        |  89 +++++++++++++++++++++++++++++++++------
 tests/md/001       |   4 +-
 tests/nvme/002     |   3 +-
 tests/nvme/016     |   7 +++-
 tests/nvme/017     |  10 +++--
 tests/nvme/030     |   6 ++-
 tests/nvme/052     |   5 ++-
 tests/nvme/054     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out |  68 ++++++++++++++++++++++++++++++
 tests/nvme/rc      |  11 ++++-
 10 files changed, 278 insertions(+), 26 deletions(-)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

-- 
2.43.0

