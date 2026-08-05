Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175D3E1D14
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913698; cv=none; b=tXi3L5BUndl7nwwWRwSY3Rjk/UzkGpoko2AvlyI5XHeut1fDi8a24RCwQyn39UlM/yJeFRzgFDlCUVs3N3zvH0Rc8bl6Kj0B2aHzuYFLAC2OB4b8QcpzSEqHhFT3TGp92ABlcqljSm03cqmAziL7TNLbFWQdEjqiLFQu28g06k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913698; c=relaxed/simple;
	bh=7U3y1LGc3pky/EE5P/s6JSSJK4/nPlhre3BDTQVjvKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YH0QZQ3Vr+ROfNI/xas1g1bkiOFRYshIgcvUcSgjAqszks5CtZOQPhww9nV/dSZUr1HSEpUrkKvoHMmPz/JJm4ARNRLxdn+hfrbH2LiFU1B3UneiZMAofqGykI+wTA9RG6KP7w6rRB0OuBYT0t7vuHsFV71Tro6zwqp+cFH2gi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hFM1x2GKszKHNWG
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 15:08:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2FB5040597
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 15:08:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgBXR0ZW4XJqGly6BA--.6211S6;
	Wed, 05 Aug 2026 15:08:10 +0800 (CST)
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
	huawei.libin@huawei.com,
	leijitang@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v7 2/8] nbd: disallow NBD_SET_SOCK on an active device
Date: Wed,  5 Aug 2026 14:58:37 +0800
Message-ID: <20260805065843.3332859-3-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260805065843.3332859-1-yangerkun@huawei.com>
References: <20260805065843.3332859-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXR0ZW4XJqGly6BA--.6211S6
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW3WFyUWw48Jw1kWF13CFg_yoWDKrg_Cr
	y8uw18Xws3CFW5u39093W5Zryjya129FsY9F12yrZ3XFy2vasaqFn2vrZxAw1UXrWjgFsr
	Aryj9w4xAr4fJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
for netlink can only active an inactive socket. But for ioctl path, we can
call NBD_SET_SOCK after NBD_DO_IT, reject this using nbd->pid which has
been setted when NBD_DO_IT. Besides, it is the root cause for commit
b98e762e3d71 ("nbd: freeze the queue while we're adding connections").

Reviewed-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b1a5acd57426..7ec85f94f742 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1278,6 +1278,13 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	/* Arg will be cast to int, check it to avoid overflow */
 	if (arg > INT_MAX)
 		return -EINVAL;
+
+	if (nbd->pid) {
+		dev_err(disk_to_dev(nbd->disk),
+			"Cannot add socket to a running device\n");
+		return -EBUSY;
+	}
+
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
-- 
2.52.0

