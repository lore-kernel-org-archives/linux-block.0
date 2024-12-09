Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F76E374D1
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711011; cv=none; b=s8xHo1eHfX+5TtqLv5ADD6dYBbaI3WGukqx730Y7XS4HL+8ZE1JIZH3/4+0OmJYqkA72ZYWFFgeVI4/5qe6Ajw1mLTvqXw6nysTtbXXkaG1vvF7iPXH7k/uL45XOUXD4hSySzIXuQfph+cA3cSR3qPKLVyHrmm5xiyVCVkcONaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711011; c=relaxed/simple;
	bh=I7sIlq4zUqoU1JL5OQa51FB7RPaAYcBswu+zmXyMTNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsrElR8q4ouF6CjJbcrQh59Bp7HIp8b9OwVG6aR90kGpz2XYbeyW0PVlngvgMdCLu9kSNYOuxdZuGQhqxrw38EY4bn4pDl1VHibKVjPJtUXVJjD/WoHobh5Qr5HjVB6vMkUojhqItsSF5XvhtDWhVXZf5gcEJP2QC5c/IRsUOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y65Hk19Sfz4f3lDq
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 10:22:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 599B41A058E
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 10:23:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgDHWMWQVFZnhqTODw--.40212S4;
	Mon, 09 Dec 2024 10:23:18 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: axboe@kernel.dk,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH] block: retry call probe after request_module in blk_request_module
Date: Mon,  9 Dec 2024 10:20:33 +0800
Message-ID: <20241209022033.288596-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHWMWQVFZnhqTODw--.40212S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17Aw17Kw43Jw1kCw4fAFb_yoW8CFWrpr
	4fJan8Kr9F9rs8Xa1fXa4UW3W5Ca4IgFWFqwnxJFyfJrykKr43ZrWUtw1Y9a4jkr93Zan3
	WF48WFy5GFW0kF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
	c7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20x
	yl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UZvtAUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Set kernel config:

 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_LOOP_MIN_COUNT=0

Do latter:

 mknod loop0 b 7 0
 exec 4<> loop0

Before commit e418de3abcda ("block: switch gendisk lookup to a simple
xarray"), open loop0 will success. lookup_gendisk will first use
base_probe to load module loop, and then the retry will call loop_probe
to prepare the loop disk. Finally open for this disk will success.
However, after this commit, we lose the retry logic, and open will fail
with ENXIO. Block device autoloading is deprecated and will be removed
soon, but maybe we should keep open success until we really remove it.
So, give a retry to fix it.

Fixes: e418de3abcda ("block: switch gendisk lookup to a simple xarray")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 block/genhd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 79230c109fca..950fdabaef2e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -802,7 +802,10 @@ void blk_request_module(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
+	int retry = 0;
+	int error;
 
+retry:
 	mutex_lock(&major_names_lock);
 	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
 		if ((*n)->major == major && (*n)->probe) {
@@ -813,9 +816,16 @@ void blk_request_module(dev_t devt)
 	}
 	mutex_unlock(&major_names_lock);
 
-	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("block-major-%d", MAJOR(devt));
+	if (retry++)
+		return;
+
+	error = request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt));
+	if (!error)
+		goto retry;
+
+	/* Make old-style 2.4 aliases work */
+	if (error > 0 && !request_module("block-major-%d", MAJOR(devt)))
+		goto retry;
 }
 #endif /* CONFIG_BLOCK_LEGACY_AUTOLOAD */
 
-- 
2.46.1

