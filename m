Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759114A8C
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713603249; cv=none; b=RVCJvFIQZrIwhXYJw1fgP60umSgSkexq2ci3vj3cbSXyAj0Nx0IOfxuWQk3WJyF8RJi99sQUX+plqz1xRFszzklnx/SOnPG0oAmz1og+UsK6HMhLG1NZyAOhdDT91IcnWeyjXQT3TEPTrrtHZcJhSMHYaCokBopJjd5fdnnkhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713603249; c=relaxed/simple;
	bh=K+8dp9LS0TlVidOTDyNDSceSGgZleq1WwTyGuGjYFIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AtuJ56kpDyrrFV9Ow9yhAlgsGY8UsEOFqHwbKWFsOgtzbvKuLClx5E+0/QW7u7vRvNi7VCwFYlyUTS6DoYqhosPmejr+2h3Z7sfuvflsif9EOb7OaHEFqYGudUcreLjXlfWzsRSfn9cF7M1SCGdVAgxbfNNbkD8D41Qu1HsVmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VM50N1HV4z4f3khX
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:53:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 80A551A0568
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:54:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGqgiNmW_HiKQ--.35908S4;
	Sat, 20 Apr 2024 16:54:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v3 blktests 0/5] add new tests for blk-throttle
Date: Sat, 20 Apr 2024 16:45:00 +0800
Message-Id: <20240420084505.3624763-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGqgiNmW_HiKQ--.35908S4
X-Coremail-Antispam: 1UD129KBjvJXoW7JFW3Xr4ktrWxWw47Cr18Grg_yoW8JF13pa
	yUKa1Yga1xGFnrJF43Ga17GayrXw4rCF47Aw17Xr1YvFy0v3yxGry29w1UtFWFyF17ZryU
	Z3Wktr4rGF1UZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VCY1x0262k0Y48FwI0_Jr0_Gr1lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UHGQDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

changes in v3:
 - lots of style changes suggested by Shinichiro

changes in v2:
 - move lots of functions to rc

Yu Kuai (5):
  tests/throtl: add first test for blk-throttle
  tests/throtl: add a new test 002
  tests/throtl: add a new test 003
  tests/throtl: add a new test 004
  tests/throtl: add a new test 005

 tests/throtl/001     | 39 ++++++++++++++++++
 tests/throtl/001.out |  6 +++
 tests/throtl/002     | 30 ++++++++++++++
 tests/throtl/002.out |  4 ++
 tests/throtl/003     | 32 +++++++++++++++
 tests/throtl/003.out |  4 ++
 tests/throtl/004     | 37 +++++++++++++++++
 tests/throtl/004.out |  4 ++
 tests/throtl/005     | 37 +++++++++++++++++
 tests/throtl/005.out |  3 ++
 tests/throtl/rc      | 96 ++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 292 insertions(+)
 create mode 100755 tests/throtl/001
 create mode 100644 tests/throtl/001.out
 create mode 100755 tests/throtl/002
 create mode 100644 tests/throtl/002.out
 create mode 100755 tests/throtl/003
 create mode 100644 tests/throtl/003.out
 create mode 100755 tests/throtl/004
 create mode 100644 tests/throtl/004.out
 create mode 100755 tests/throtl/005
 create mode 100644 tests/throtl/005.out
 create mode 100644 tests/throtl/rc

-- 
2.39.2

