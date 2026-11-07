Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034495;
	b=XszeoShXpmV3spBvDTq0i7e4rU6BHFZGiZ+FBfqdudr+lBFLj06r7DQTrn5Bqp07IVqi
	 f2eUQic8iyrwN6HnrYwm9N1MjjEFDUCu5wQHrPbuRcZkdq07PaMVr1F8Nti5HoXAq3oMg
	 PbcdGJUKqZd6qhGqrpnueVyi6YBHQPglioljWN9nQ9vbxWC8uG3ynxV8/8f8qckNtNtqj
	 yGF9DHci8OyXUQK0yhnrSma1EyDUTGCldoUQNlrFWX6L78hrk441ntAykwH9398kdKyuX
	 TxcJq8ph9VlAIAhfm8vx8vKsMO6CwnjBxSKALOHV6Y3O06sbw5SRF4STqOvoXWgFK0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034495;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=GPxfm6opWzC+ss/dbnY2OqqcxL98uKSFV0jjpONrZFM=;
	b=njlhiIve1XjUm/+ZnMzIx39H2aLZxFaZOTfYgRQmL2wl+bluAXwqr/gGE7WKi3OaIatR
	 7x+uK90LPJaj4QrOFsup9H4RiNqVmsPcEVE1hg5pwigOCpIhT1SmPMVezJAYrC35dQ5l9
	 oonD9jPAz663Zx3Tjswldf3Q9f04cb2VSoCWRz6yOpoBB+ebFmt8l/3K1LAw43KXctFpC
	 miUvs/FwpYIIh3dbQXoTrOteeFHjPhGXV/SeS7Jk5Z+UqumcUJ91KJH6my2gTFxxahYoF
	 BbrKcAkK5qH7yrpaWFXUL/DFnxhtIjLlJcWjDKrgvFvehvCZ1OiY0e/dIDzYY8XweUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=huawei.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BD606A332
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 06:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D3BD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jM6Gd16Cfz1rrZR
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4489840573
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgAHwgQ1y+5qHB5yDQ--.31669S5;
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
Subject: [RFC PATCH 1/5] nbd: validate the backend identifier under config_lock
Date: Sat,  7 Nov 2026 14:46:25 +0800
Message-ID: <20261107064629.4093489-2-yangerkun@huawei.com>
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
X-CM-TRANSID:_Ch0CgAHwgQ1y+5qHB5yDQ--.31669S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF18Wry7Ar17Cw1kuF45Wrg_yoW5Aw17pF
	WxGFy7Gry8GF1rWFs5t347uF15Kan7AFWkWa93C3WfZry3Ary7Zr97KFyF9FZ5GryxJw17
	Ca45u3W0k3ZFkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxU266zUUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

nbd_genl_reconfigure() reads nbd->backend with only nbd_index_mutex
held, while nbd_config_put() frees it under config_lock.  A teardown
running concurrently triggers:

BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 819 Comm: a.out Not tainted 7.3.0-dirty #11 PREEMPT(lazy)
RIP: 0010:strlen+0x4/0x30
...
Call Trace:
 nla_strcmp+0x20/0x100
 nbd_genl_reconfigure+0x1f7/0xd00 [nbd]
 genl_family_rcv_msg_doit+0x1e5/0x2c0
 genl_family_rcv_msg+0x35f/0x5b0
 genl_rcv_msg+0xa3/0x130
 netlink_rcv_skb+0x12a/0x390
 genl_rcv+0x28/0x40
 netlink_unicast+0x7b2/0xb30
 netlink_sendmsg+0x6fe/0xb90
 __sys_sendto+0x325/0x380
 __x64_sys_sendto+0xe0/0x1c0
 do_syscall_64+0xc1/0x5e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Validate the identifier after taking config_lock and a config
reference.  A device that still has a backend identifier but is no
longer bound, for example because it was disconnected while the block
device stayed open, now reports "not configured" instead of a backend
mismatch.

Fixes: 6497ef8df568 ("nbd: provide a way for userspace processes to identify device backends")
Assisted-by: LLM
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..fbade6ae4481 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2401,22 +2401,6 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		pr_err("couldn't find a device at index %d\n", index);
 		return -EINVAL;
 	}
-	if (nbd->backend) {
-		if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
-			if (nla_strcmp(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
-				       nbd->backend)) {
-				mutex_unlock(&nbd_index_mutex);
-				dev_err(nbd_to_dev(nbd),
-					"backend image doesn't match with %s\n",
-					nbd->backend);
-				return -EINVAL;
-			}
-		} else {
-			mutex_unlock(&nbd_index_mutex);
-			dev_err(nbd_to_dev(nbd), "must specify backend\n");
-			return -EINVAL;
-		}
-	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
 		pr_err("device at index %d is going down\n", index);
@@ -2441,6 +2425,22 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	if (nbd->backend) {
+		if (!info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
+			dev_err(nbd_to_dev(nbd), "must specify backend\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (nla_strcmp(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
+			       nbd->backend)) {
+			dev_err(nbd_to_dev(nbd),
+				"backend image doesn't match with %s\n",
+				nbd->backend);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	ret = nbd_genl_size_set(info, nbd);
 	if (ret)
 		goto out;
-- 
2.52.0

