Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32B3AC0E9
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833340; cv=none; b=nX1dklDWydONE8TcnzKQl51G2yCagQPZE5ApgXI+o9L1FzKmSkv9s4vuJJKyAwaW+Cpmy2quZwaJUKsFCu1akJbunAe/pxjTOI/kTR/9YH44O9AMURJ7Acz9T5TXALgZse/uuqsD0Z+Cu/LX6yV+PnxK6mwZbpRccfcHfA7b900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833340; c=relaxed/simple;
	bh=TKpkMdCYeifTinMW4pdygoIrg0D62NdMM+xpVWnJZco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiewiJCGoKfVOiR0bXwFuvt67J5TnlGxIhcnxMLY//1mXWfSjrcs+DX5AjWp89k44gxR7lWgy2xQmLK9lorze7Hbca8wQ8jp/1c5vTjYQQznFYj9eN8bnDaD+m8Oe80tS/MhedZ1t2GGa2Ic4eD5Etn1oq1rAGfZcAEOQMpMNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hDnJW5tj0zKHMkj
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:48:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2F11F40590
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:48:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgD35kVrp3Fq71VIBA--.52677S10;
	Tue, 04 Aug 2026 16:48:47 +0800 (CST)
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
Subject: [PATCH v6 6/8] nbd: factor out a nbd_genl_foreach_sock
Date: Tue,  4 Aug 2026 16:39:20 +0800
Message-ID: <20260804083922.1927105-7-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260804083922.1927105-1-yangerkun@huawei.com>
References: <20260804083922.1927105-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD35kVrp3Fq71VIBA--.52677S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw18Wr43tFWruF4kKw17ZFb_yoW7GrWUpF
	W0qFZ8Jr4DJr1xWFZ5Zw4kZa4SyF1xC3sIg3y7Kw1fZF17Cr43W3y8KryF9r45GryDWw13
	Ar4Yga1Ikw4DWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyCLUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

The NBD_ATTR_SOCKETS walk is duplicated in nbd_genl_connect (add sockets)
and nbd_genl_reconfigure (reconnect).  Factor out a single helper that
walks the list and calls a callback per fd; with a NULL callback it is a
pure counter, used by a later patch to learn nr_hw_queues before the
device exists.  Returns the number of fds walked (>= 0) or a negative
errno; a callback >0 will stops early.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 131 ++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 65 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 66f1b3263b94..c080bb95653b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1399,11 +1399,12 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 
 		atomic_inc(&config->live_connections);
 		wake_up(&config->conn_wait);
+		dev_info(nbd_to_dev(nbd), "reconnected socket\n");
 		return 0;
 	}
 	sockfd_put(sock);
 	kfree(args);
-	return -ENOSPC;
+	return 1;
 }
 
 static void nbd_bdev_reset(struct nbd_device *nbd)
@@ -2109,6 +2110,58 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 	return 0;
 }
 
+/*
+ * Walk the NBD_ATTR_SOCKETS nested list can call @cb for each socket fd.
+ *
+ * Return the number of fds walked, or a negative errno.
+ */
+static int nbd_genl_foreach_sock(struct genl_info *info,
+		int (*cb)(struct nbd_device *nbd, int fd),
+		struct nbd_device *nbd)
+{
+	struct nlattr *attr;
+	int rem, count = 0;
+
+	if (!info->attrs[NBD_ATTR_SOCKETS])
+		return 0;
+
+	nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS], rem) {
+		struct nlattr *socks[NBD_SOCK_MAX + 1];
+		int ret;
+
+		if (nla_type(attr) != NBD_SOCK_ITEM) {
+			pr_err("socks must be embedded in a SOCK_ITEM attr\n");
+			return -EINVAL;
+		}
+
+		if (nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
+						attr,
+						nbd_sock_policy,
+						info->extack)) {
+			pr_err("error processing sock list\n");
+			return -EINVAL;
+		}
+
+		if (!socks[NBD_SOCK_FD])
+			continue;
+
+		count++;
+		if (cb) {
+			ret = cb(nbd, (int)nla_get_u32(socks[NBD_SOCK_FD]));
+			if (ret > 0)
+				return count;
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return count;
+}
+
+static int nbd_genl_connect_sock_cb(struct nbd_device *nbd, int fd)
+{
+	return nbd_add_socket(nbd, fd, true);
+}
+
 static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nbd_device *nbd;
@@ -2228,36 +2281,9 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	if (info->attrs[NBD_ATTR_SOCKETS]) {
-		struct nlattr *attr;
-		int rem, fd;
-
-		nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS],
-				    rem) {
-			struct nlattr *socks[NBD_SOCK_MAX+1];
-
-			if (nla_type(attr) != NBD_SOCK_ITEM) {
-				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
-				ret = -EINVAL;
-				goto out;
-			}
-			ret = nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
-							  attr,
-							  nbd_sock_policy,
-							  info->extack);
-			if (ret != 0) {
-				pr_err("error processing sock list\n");
-				ret = -EINVAL;
-				goto out;
-			}
-			if (!socks[NBD_SOCK_FD])
-				continue;
-			fd = (int)nla_get_u32(socks[NBD_SOCK_FD]);
-			ret = nbd_add_socket(nbd, fd, true);
-			if (ret)
-				goto out;
-		}
-	}
+	ret = nbd_genl_foreach_sock(info, nbd_genl_connect_sock_cb, nbd);
+	if (ret < 0)
+		goto out;
 
 	if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
 		nbd->backend = nla_strdup(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
@@ -2346,6 +2372,11 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, int fd)
+{
+	return nbd_reconnect_socket(nbd, fd);
+}
+
 static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nbd_device *nbd = NULL;
@@ -2442,40 +2473,10 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	if (info->attrs[NBD_ATTR_SOCKETS]) {
-		struct nlattr *attr;
-		int rem, fd;
-
-		nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS],
-				    rem) {
-			struct nlattr *socks[NBD_SOCK_MAX+1];
-
-			if (nla_type(attr) != NBD_SOCK_ITEM) {
-				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
-				ret = -EINVAL;
-				goto out;
-			}
-			ret = nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
-							  attr,
-							  nbd_sock_policy,
-							  info->extack);
-			if (ret != 0) {
-				pr_err("error processing sock list\n");
-				ret = -EINVAL;
-				goto out;
-			}
-			if (!socks[NBD_SOCK_FD])
-				continue;
-			fd = (int)nla_get_u32(socks[NBD_SOCK_FD]);
-			ret = nbd_reconnect_socket(nbd, fd);
-			if (ret) {
-				if (ret == -ENOSPC)
-					ret = 0;
-				goto out;
-			}
-			dev_info(nbd_to_dev(nbd), "reconnected socket\n");
-		}
-	}
+	ret = nbd_genl_foreach_sock(info, nbd_genl_reconnect_sock_cb, nbd);
+	/* foreach_sock returns a positive count on success; doit must return 0 */
+	if (ret >= 0)
+		ret = 0;
 out:
 	mutex_unlock(&nbd->config_lock);
 	nbd_config_put(nbd);
-- 
2.52.0

