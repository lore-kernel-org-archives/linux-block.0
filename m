Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D191A9F90
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044858; cv=none; b=pKO4Am5VUStiPCTA5GPf0PrIgNoyh22OpH7GPnzw1UL7iNjFcHeXuiAsS26ggVXVKbbxulJJu1ICrexMrd6Cf/ifbDLNhOsArQaEnRyGgZv3MYe0kUj0Fv47d/u+1IvSj5k83C7Y1FMUHa/oV6ZDLuSGunuc0hSifoXzXw3x6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044858; c=relaxed/simple;
	bh=HGZiA7x1ZmZhqE8f+DrMGS1Hthd2nFBg3LbAhPkwepI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PLaN0JhcZKq1ijFrGiVAtb32JBF/uLOmI1y7RS/zIqkWSAWoWwJu4Dkrr3AcePnrjYi0Sj4/6BUzUhy5mdRq8zuttUzrAMzg7JnRpT1y11ELdxWdPVjjdDi077rRudVTF7OTKaiDHJSYX2+QeAQehLSubBMbHXULqrqOQYW8wTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJ2K759W0zYQv2n;
	Fri,  5 Sep 2025 11:44:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A7661A134F;
	Fri,  5 Sep 2025 11:44:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIyWXLpoEr6_BQ--.19448S4;
	Fri, 05 Sep 2025 11:44:24 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	inux-raid@vger.kernel.org,
	song@kernel.org,
	linan122@huawei.com
Cc: yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [GIT PULL] md-6.17-20250905
Date: Fri,  5 Sep 2025 11:35:17 +0800
Message-Id: <20250905033517.1179192-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIyWXLpoEr6_BQ--.19448S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw17tw4rJw1ftrWktryUtrb_yoWDXFX_ua
	yxJayxJ3yUtr4Uuw43Jr1I9rW2gw4UGa15Cr1FyrWUX3sxZrnFvw1q9rWxXw1kXF1DCrs8
	JrZ8X3s0vw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jens

Please consider pulling following changes on your block-6.17 branch,
this pull request contains:

 - fix data lost for writemostly in raid1, by Yu Kuai;
 - fix potentional data lost by skipping recovery, by Li Nan;

The following changes since commit 95a7c5000956f939b86d8b00b8e6b8345f4a9b65:

  bcache: change maintainer's email address (2025-08-28 10:05:37 -0600)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.17-20250905

for you to fetch changes up to 7202082b7b7a256d04ec96131c7f859df0a79f64:

  md: prevent incorrect update of resync/recovery offset (2025-09-05 00:31:18 +0800)

----------------------------------------------------------------
Li Nan (1):
      md: prevent incorrect update of resync/recovery offset

Yu Kuai (1):
      md/raid1: fix data lost for writemostly rdev

 drivers/md/md.c    | 5 +++++
 drivers/md/raid1.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

