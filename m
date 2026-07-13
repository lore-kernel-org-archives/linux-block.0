Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37F36894D
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926307; cv=none; b=BgIvIWWgD5AsP1ubDLTXcnoe1H4Lgp0ksPM6ks2NhIaSUIvHJ6OLMFlfown/aHc9vcIPHrT5HQRASd7sw5NmgCIZxXxXxKsT66c6DI1HRVbkigPbU8eBvuSkKzHm1E1zA0mcFYOhtKM9BEjlg2FbeiaFR+pRpqllI7BuLKa9fwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926307; c=relaxed/simple;
	bh=lXkykSfhdMXwQ8GHG6k9wl+RaF7SQLYA0UbLcnMxvfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi5n182QMJu4ydeIEXbmqZfz2KCWSRZ7kmlAIJJ4SAvkeDCKORoMYxrQhrpWRyS/cFtwT7epUYskm+p7ZuKEtl0nGYemuwcTS0kmWtTaMVlpiHG2vCwpTGOLDapqxkOj5zSHuW1oAxNVDxlJPVE6kj43f6xudwbhaBGYakQGkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gzD2N293DzKHMP4
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0090E40594
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgD3B3QQjlRq9dc7BA--.38720S6;
	Mon, 13 Jul 2026 15:04:56 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@lst.de,
	yukuai@kernel.org
Cc: yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	echo.chenlin@huawei.com,
	leo.lilong@huaweicloud.com,
	wangkefeng.wang@huawei.com,
	yangerkun@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v3 2/6] nbd: disallow NBD_SET_SOCK on an active device
Date: Mon, 13 Jul 2026 14:56:40 +0800
Message-ID: <20260713065644.1637594-3-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713065644.1637594-1-yangerkun@huawei.com>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3B3QQjlRq9dc7BA--.38720S6
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW3WF4rXr15Cr1UWw4UArb_yoWDJrXEkw
	4ru348Wws3GFW3u3yYkw15ZrW0yan2vF1v9F1jyrsagFyIvasavFn2vrZxAw1DXFWUWF15
	AryUZws7ZryxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb9xYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUF6pBDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

We cannot add a socket to an already running nbd device, the reconfigure
for netlink can only active dead socket. But for ioctl path, we can call
NBD_SET_SOCK after NBD_DO_IT, reject this using nbd->pid which has been
setted when NBD_DO_IT. Besides, it is the root cause for commit
b98e762e3d71 ("nbd: freeze the queue while we're adding connections").

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b1a5acd57426..a15553ab4b97 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1302,6 +1302,13 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		goto put_socket;
 	}
 
+	if (nbd->pid) {
+		dev_err(disk_to_dev(nbd->disk),
+			"Cannot add socket to a running device\n");
+		err = -EBUSY;
+		goto put_socket;
+	}
+
 	nsock = kzalloc_obj(*nsock);
 	if (!nsock) {
 		err = -ENOMEM;
-- 
2.52.0

