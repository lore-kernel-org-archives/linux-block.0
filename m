Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034501;
	b=b/QyJjVgYykQ6MblNwt+KPO2ES010zd2K+0uJq6Q0c2zvTCCsXhW02VM1xe0qmYWPJZC
	 19t2bOfZu1Zepmz3uk5V8FG1EZIDH2YHgspTqCRMlzrhKKM2ArYWRvoYqObJ4RuEPFNeV
	 QmpZ0k8MgGTM747flr+egq1hb1Qkwpe+/6w5tjhXuC+yguM42AgXaglWVL+gwk/ZXuiIc
	 e7qvDJeh3FwLgJKb9Ymwy5vxVbTOvT91ZmD9CvbOD7cp4g30rZ2LsKZyFIfScRSKuFF+G
	 Ut58NARube2PXezzy2XfjGaZWVLJkt8wuSxbx4IcSfiTbuW7SpdT7Q+2iH/StWjvsZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034501;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=p3qRKAcJN2E/tirzieHnKEexruwuxZ8bNmQDEWkZ1b4=;
	b=Y9s31co7ogOLnKDUyu758kRGDIT/C0zp7c+M093W8Z/+C8JxxcuMsi8x2QWJF7bAbVia
	 CpgK2uftcexiNP114ARA43Np9EepB3HzuKOhBF81215Av6EAxeulELkEL9lJzi/Luw/hg
	 Rv9GZ0NClJnvP3D3DML5wA0QRBXO7sb010IqVOUZRv8i9JA4IePUUBGnH6AEpbe0I+H9B
	 UN8UgjRNxsEsZKHIJjFi/RiCcIbmhVtKlYdh4ijHdaWxXJurYbPKio8mhqqMQkkvW9VOZ
	 qwyXcaM9QR5cBokID8ldh3fbX4XInXAHFbbhfFk90gKegSl1KrMPzbSRpMkSelsRyMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=huawei.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F736606A32D
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 06:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F736606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jM6Gc6V9fz1c1ZJ
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7C64D40576
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgAHwgQ1y+5qHB5yDQ--.31669S8;
	Sat, 07 Nov 2026 14:54:49 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: axboe@kernel.dk,
	josef@toxicpanda.com,
	xiubli@redhat.com,
	prasanna.kalever@redhat.com,
	ming.lei@redhat.com,
	yukuai@fygo.io,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	yangerkun@huawei.com,
	wangkefeng.wang@huawei.com,
	leijitang@huawei.com,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	houtao1@huawei.com,
	wozizhi@huawei.com
Subject: [RFC PATCH 4/5] nbd: hold config_lock while updating nr_hw_queues
Date: Sat,  7 Nov 2026 14:46:28 +0800
Message-ID: <20261107064629.4093489-5-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261107064629.4093489-1-yangerkun@huawei.com>
References: <20261107064629.4093489-1-yangerkun@huawei.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHwgQ1y+5qHB5yDQ--.31669S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4fKw4xKw4fuFy3KFyrXrb_yoWrAF4fpF
	W29a9Ikr4UG3WSgF47A348WF15t3s7KFWxGry7t3WY9FykCrZYvFykKw1IkFy8tr93AFs0
	qFWrXFZaka98A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAKsUUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Link [1] reports a possible deadlock, and the discussion there shows that
it is impossible.  In order to silence the warning, commit 8b428f42f3ed
("nbd: fix lockdep deadlock warning") released nbd->config_lock before
blk_mq_update_nr_hw_queues(), and then relocked it.

But releasing the lock has a real cost.  While nbd_start_device() runs
without config_lock, a concurrent disconnect can shut down the sockets,
and setup continues and reports success with a config that is already
dead.  This patch fixes it in another way, by using mutex_lock_nested().
Only nbd_genl_connect() and the NBD_DO_IT path in nbd_ioctl() reach
nbd_start_device(), so only these take the separate subclass; the other
ioctls keep the default one and stay fully checked by lockdep.

Fixes: 8b428f42f3ed ("nbd: fix lockdep deadlock warning")
Assisted-by: LLM
Link: https://lore.kernel.org/all/6855034f.a00a0220.137b3.0031.GAE@google.com/T/#u
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8c2cb312f209..cf2a47fc572d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1510,6 +1510,31 @@ static void nbd_config_put(struct nbd_device *nbd)
 	}
 }
 
+/*
+ * nbd_start_device() calls blk_mq_update_nr_hw_queues() with config_lock
+ * held.  del_gendisk() takes the tag set's update_nr_hwq_lock and then
+ * disk->open_mutex, while ->open()/->release() run with disk->open_mutex
+ * held and take config_lock (nbd_open(), and nbd_release() through
+ * nbd_disconnect_and_put() or nbd_config_put()), so lockdep reports the
+ * class-level cycle
+ *
+ *   config_lock -> update_nr_hwq_lock -> open_mutex -> config_lock
+ *
+ * as a possible deadlock.  It cannot happen: nbd_start_device() is called
+ * with an nbd reference held, and the open/release side takes config_lock
+ * while the open file still holds one, so nbd->refs cannot reach zero and
+ * nbd_dev_remove_work() -> del_gendisk() cannot run concurrently.  In
+ * addition, nbd_config_put() drops config_lock before nbd_put(), so the
+ * teardown path never calls del_gendisk() with config_lock held.
+ *
+ * Only the acquisitions that can reach nbd_start_device() are annotated:
+ * nbd_genl_connect(), and nbd_ioctl() for NBD_DO_IT (which ends up in
+ * nbd_start_device_ioctl()).  No other ioctl reaches it, so they keep the
+ * default subclass and stay fully checked.  This only changes the lockdep
+ * annotation, not the locking itself.
+ */
+#define NBD_CONFIG_LOCK_SETUP	1
+
 static int nbd_start_device(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
@@ -1526,17 +1551,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		return -EINVAL;
 	}
 
-retry:
-	mutex_unlock(&nbd->config_lock);
-	blk_mq_update_nr_hw_queues(&nbd->tag_set, num_connections);
-	mutex_lock(&nbd->config_lock);
-
-	/* if another code path updated nr_hw_queues, retry until succeed */
-	if (num_connections != config->num_connections) {
-		num_connections = config->num_connections;
-		goto retry;
-	}
-
+	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
 	nbd->pid = task_pid_nr(current);
 
 	nbd_parse_flags(nbd);
@@ -1695,7 +1710,10 @@ static int nbd_ioctl(struct block_device *bdev, blk_mode_t mode,
 	if (_IOC_TYPE(cmd) != 0xab)
 		return -EINVAL;
 
-	mutex_lock(&nbd->config_lock);
+	if (cmd == NBD_DO_IT)
+		mutex_lock_nested(&nbd->config_lock, NBD_CONFIG_LOCK_SETUP);
+	else
+		mutex_lock(&nbd->config_lock);
 
 	/* Don't allow ioctl operations on a nbd device that was created with
 	 * netlink, unless it's DISCONNECT or CLEAR_SOCK, which are fine.
@@ -2233,7 +2251,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	mutex_lock(&nbd->config_lock);
+	mutex_lock_nested(&nbd->config_lock, NBD_CONFIG_LOCK_SETUP);
 	if (refcount_read(&nbd->config_refs)) {
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
-- 
2.52.0

