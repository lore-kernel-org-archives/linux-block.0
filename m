Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EBBFC1F
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233378; cv=none; b=HT1m+jsLGy90mA3RlhcdvHXHJpl0ToGUNK2OOyfzgTpa2q2Ssm5mJtbibFZ7899Wqd4ycflsbf3cIlkzcbW68NZVn3hE5aRoFkvIaXaAQSzMLv6pzERcohHALo3q0gmlCAbC9lz82XUiWI5jrF9DZaN0P02+7aWIoNP9HcbPr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233378; c=relaxed/simple;
	bh=gT1RK5wOvK16xzytI47o2nmxt06m/wf/d1TPLf8n5MY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzMYEmdqrG/Nsqb3wgVNxGmvbyjzfF3SdZk88XUpytpWbFcokgkUFVSMR1zng5q1cvGUn9GEn/yrCxoxJklBvEg0jPgyaJb/CtyzmRWf7Oja3k8rkgHsKijc1LoVkGxS6P7fzaiWNjl87ykEKkthbjTD4NMmN4AawGq5dJwIm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJSCK5q1Yz4f3nJf
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ABCEA1A10A9
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7U3R1mMNVnKA--.11112S4;
	Tue, 16 Apr 2024 10:09:26 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: linux-block@vger.kernel.org,
	saranyamohan@google.com,
	axboe@kernel.dk,
	tj@kernel.org
Cc: yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH blktests 0/5] add new tests for blk-throttle
Date: Tue, 16 Apr 2024 10:00:37 +0800
Message-Id: <20240416020042.509291-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7U3R1mMNVnKA--.11112S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4DCrW5CFW3tF1kGw4xCrg_yoW8JF4fpa
	yUtF45ta1xJFnrJr13Ga17GayrXw4rCr47Aw17Xr1YvFy0v3y7Gr12gw1UtFWrAF17XryU
	A3Wktr4rGF1UZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Yu Kuai (5):
  tests/throtl: add first test for blk-throttle
  tests/throtl: add a new test 002
  tests/throtl: add a new test 003
  tests/throtl: add a new test 004
  tests/throtl: add a new test 005

 tests/throtl/001     | 84 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/001.out |  6 ++++
 tests/throtl/002     | 81 ++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/002.out |  4 +++
 tests/throtl/003     | 82 ++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/003.out |  4 +++
 tests/throtl/004     | 79 +++++++++++++++++++++++++++++++++++++++++
 tests/throtl/004.out |  4 +++
 tests/throtl/005     | 83 +++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/005.out |  3 ++
 tests/throtl/rc      | 15 ++++++++
 11 files changed, 445 insertions(+)
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

