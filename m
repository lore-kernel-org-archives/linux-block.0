Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC6167296
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960241; cv=none; b=f54bqrTsnbgQakJvxmSRFoW3ocHDBogs6kmwZGUqbv+zrpHvUp/tN3X0MO4n8FvnRti4nK8xCKoyaxoDnTEU3tnmEXOjRhvO8Lq8qK/oQBc+5aNF2eS5nmcZjH1n5aLmiL8Tt6jhRBeNWicHLlYi+q6wIVq54OfIgVaQeOcCjlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960241; c=relaxed/simple;
	bh=7oc/FPXsaCLL1ADqsC/fFcxWWmJm8ih3LHe32RceLmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tx6OKl9OcPn5bNUQO4x0qYpDKL4eYAy+deXkh4jOpukszBJEwRc2EuHpczxYa4swr2XJFRLHcJsOEKYH8urtkWW6GEB8O6venEWDrFcs//br/ef6rgbN6ocCYZtOZEdapJ8txyuHbVKChx79wL98HyvgnhElADrK8bph1vz5xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F4TcF8br; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F4TcF8br"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728960235; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oQGUWzdlBtxMcgDJkoaLvIOSwHf8LlGnIqjsuVvZNds=;
	b=F4TcF8brA337Hu0a5muGSwQZjkK2jr54prcjfrnEIUtUKPggZJlsEfFHVvqHxtTMWxrO+Uhu1iJLCkQ/8rhpwGybY5jybSRYn1hoflN0IHDxhX4w6iCIki4MHRW7gUyfFd6FCnIVCtmeOJS9lyikS3b/B5SM8kHXG5YKsiZaDUA=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHBe6tV_1728960230 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 10:43:55 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v5 0/2] Test the NVMe reservation feature
Date: Tue, 15 Oct 2024 10:43:48 +0800
Message-ID: <20241015024350.16271-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v4 to v5:
- Remove hardcode ns_id.

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

