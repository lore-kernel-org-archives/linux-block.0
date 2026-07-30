Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB23B9DBB
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400201; cv=none; b=DbfoT+YhXdG1huANKh4u57O+APYW/yVe6ZsKqhxoRPmbKwucRAM5sN3+KlfI3bxJpT3Tb87mJabA0XohhYtGKMjG71O5tpzzbuXCstcquspzlisQGgONECnbWrosptbCCw42TR/hJDU9CJtIavLihUqz1HYww2nVe8dM+fgUpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400201; c=relaxed/simple;
	bh=BcwJ9+mY+Ya72BZsL6bADP+bK7GrkZN9uvwWwrKHiZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY6bJZU/jq1RmpXJs2Iye8dSDeoIEakIb45HbrtkTWSRIZcx7+imsWhLIT/yMAw3gnEgse5YLVbzotYwUFgHgIsqprbuYTQIUjv6LxMh1E7FDHdhekFcl7ApVL9wIsWQ4Ksx01hjumMzNqc/xkTsfEn8YnaYefqjdmsz07+JVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h9j62237TzKHMgj
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:28:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id ACBBB40EB2
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:29:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgCnlkV9C2tqwObjAQ--.20420S7;
	Thu, 30 Jul 2026 16:29:54 +0800 (CST)
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
Subject: [PATCH v5 3/8] nbd: reset write cache on disconnect
Date: Thu, 30 Jul 2026 16:20:41 +0800
Message-ID: <20260730082046.3459239-4-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260730082046.3459239-1-yangerkun@huawei.com>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnlkV9C2tqwObjAQ--.20420S7
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxCw47Aw1DJw13CFW8Crg_yoW8WF1DpF
	W3Ca47KryftF43AayUJayUGFy5CaykAFyxWa43A34Y9r95AryIkFZ0y34xtF1DJrn3JFW7
	XFs5GFykAFykCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JbIYCTnIWIevJa73UjIFyTuYvjxUFzVbDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

An inactive nbd device may refuse any I/O operations. The nbd_config_put
function calls invalidate_disk, which sets the device capacity to zero
to reject all read and write I/O. For zero-sector flush I/O requests
from blkdev_issue_flush, if the write cache is disabled, the zero-sector
flush I/O immediately returns 0 in submit_bio_noacct. However, since
nbd_config_put does not clear the write cache state, an inactive nbd
device might still have the write cache enabled. In this situation,
zero-sector flush I/O will return -EIO because there is no active socket.
Although this does not cause any bugs, resetting the write cache state
would make the behavior consistent.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7ec85f94f742..da4b48ef3c79 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1469,8 +1469,13 @@ static void nbd_config_put(struct nbd_device *nbd)
 	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
 					&nbd->config_lock)) {
 		struct nbd_config *config = nbd->config;
+		struct queue_limits lim;
 		nbd_dev_dbg_close(nbd);
 		invalidate_disk(nbd->disk);
+		/* reset write cache */
+		lim = queue_limits_start_update(nbd->disk->queue);
+		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
+		queue_limits_commit_update(nbd->disk->queue, &lim);
 		if (nbd->config->bytesize)
 			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,
-- 
2.52.0

