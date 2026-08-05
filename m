Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445938F93B
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933545; cv=none; b=POEWsip2lVz1kQaeiMjiZHNO+l3X8XboYhAJ9lluyXtLJEwOVCINwY+IHG7elHuHRl2MAKm7cmdQ9o7vMG5Q+KYdE9my3NEUY47P9/jeFfwmdGBYIzjQhvu+J6Wf4YPYRANF02rEwtBsCUxwaoDkcuQ5FxpTzxx/RhrT7zPxvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933545; c=relaxed/simple;
	bh=F0VlNGy/DGzbscKH+9Q6R3U+g4A9w4rJ2lZHJcEW4lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGJxtPBE2Apl0RTClMLUHZw02INhRd0G+9T9FG4TkT7gZGgtjmpy0CEUFzoR3iSVLZcJT8cmfm9J3oM0HopLFv3a9EHaT0IMnFm1Av2gRQJLLPkhHs99lM25zCnyNw0cTazqZNg8H7bSOctwCftLskI7fxNOFTlOYQUwndu/gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFVLj43CdzYQvby
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 995414058C
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkXfLnNqRJjWBA--.10386S10;
	Wed, 05 Aug 2026 20:38:58 +0800 (CST)
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
Subject: [PATCH v8 6/8] nbd: factor out a nbd_genl_foreach_sock
Date: Wed,  5 Aug 2026 20:29:28 +0800
Message-ID: <20260805122930.57647-7-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260805122930.57647-1-yangerkun@huawei.com>
References: <20260805122930.57647-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkXfLnNqRJjWBA--.10386S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr13Cr4kJr17AryDJry7Wrg_yoW7GFWfpF
	W8tFZ8Jr4DJr1xWFZ5Zw4kZa4SyF1xC3sIgay7Jw1xZF17CrW3u3y8KryF9r45JryDuw13
	Ar4Yga1Ikw4DXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUoF4EDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

The NBD_ATTR_SOCKETS walk is duplicated in nbd_genl_connect (add sockets)
and nbd_genl_reconfigure (reconnect).  Factor out a single helper that
walks the list and calls a callback per fd; with a NULL callback it is a
pure counter, used by a later patch to learn nr_hw_queues before the
device exists.  Returns the number of fds walked (>= 0) or a negative
errno; a callback >0 will stops early.

Reviewed-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 128 +++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 66 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index cb662ae4b91d..192c80aa738c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1344,7 +1344,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	return err;
 }
 
-static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
+static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, unsigned long arg)
 {
 	struct nbd_config *config = nbd->config;
 	struct socket *sock, *old;
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
+		int (*cb)(struct nbd_device *nbd, unsigned long fd),
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
+static int nbd_genl_connect_sock_cb(struct nbd_device *nbd, unsigned long fd)
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
@@ -2442,40 +2468,10 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
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

