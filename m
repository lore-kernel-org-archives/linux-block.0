Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295528E8
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334885; cv=none; b=DIymHtrcMQTtU2XJ+j1u4jXJ7G5j+Jv1r40+I6wpnZSFilNbYfCuQG3Mhrv8+mKX9UJ43DXuI84aKeZEnyVFuHPbIeefqB2+IYHDF3Xc9clCURVizQLAzOLHfJX4Hebyb9OIhNlJ/Dt54c0KdekcmOBEhdqztVKX3lMGGXBIaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334885; c=relaxed/simple;
	bh=N8dOJKFL0Wn5SdOYX7xAxMuDSfKD867kHlrLi7oUfMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I2mjSZvpzeBtUvtTQUu5H/AOD6jWSgc+I+RlQqZ5gJ//kE6CNruln1lXAiWi4hwB5vnthX/l0U1GbOVXFES8yeQ2+Tgpi3+28Pb3GXr0sN+1KCN9R99El5rdVSaq3t2jyB1cBeMcrG3byEfmcUPHszNEhC9S+z/GoMOsTQtDYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z8Jmf3Dknz4f3lgS
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 16:07:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1D7B91A0D30
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 16:07:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGBYqcpn7EMnFw--.24390S4;
	Fri, 07 Mar 2025 16:07:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: shinichiro.kawasaki@wdc.com,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org
Cc: yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC 0/2] tests/throtl: add two regression tests
Date: Fri,  7 Mar 2025 16:03:16 +0800
Message-Id: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGBYqcpn7EMnFw--.24390S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY07kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxG
	rwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
	Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Yu Kuai (2):
  tests/throtl: add a new test 007
  tests/throtl: add a new test 008

 tests/throtl/007     | 65 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/007.out |  4 +++
 tests/throtl/008     | 39 ++++++++++++++++++++++++++
 tests/throtl/008.out |  6 ++++
 4 files changed, 114 insertions(+)
 create mode 100755 tests/throtl/007
 create mode 100644 tests/throtl/007.out
 create mode 100755 tests/throtl/008
 create mode 100644 tests/throtl/008.out

-- 
2.39.2

