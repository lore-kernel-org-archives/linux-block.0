Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA343DD85F
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138980; cv=none; b=G2h+JY6LA8RCg2/jyTnhCBjpfYLbUibKJ69XKTZbg3KB+SCA/thQI3LR+pmh1Y0ayuULyW4UqDvKmMLFHa3nIl2Mz7dHaZe0g1HIXkugDarx5bttAGEPVcx0UbbJpH1IDufbtHBnnAioCsLU4vwaT6dDzXzD2P4rJ2jrBwRmapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138980; c=relaxed/simple;
	bh=f8+5IwfkS1xP1mq1yeSXGpKiDJ+MhvYSZ4BK7ARsMPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqlpwuujOF1YRvl4F95Od/0YyQnLkO3KrDjyVuyQDsreoaSrhobnH4tP/UjckQYEzrhpl+vPA2cmHN8fdBwy+ywo2uMbuvQjmNa2/mJvJr5gTgGBEDmSX8yIANwNd5E7sCerSXa32fJ19F9J6yx7/jWFTz20+iNuTucCp6rrZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h7rVy1q95zYQtx3
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:55:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8113E4082D
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:56:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkUbD2dqjEJ1AA--.26468S9;
	Mon, 27 Jul 2026 15:56:15 +0800 (CST)
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
Subject: [PATCH v4 5/7] nbd: factor out a nbd_genl_foreach_sock
Date: Mon, 27 Jul 2026 15:47:16 +0800
Message-ID: <20260727074718.414868-6-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727074718.414868-1-yangerkun@huawei.com>
References: <20260727074718.414868-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkUbD2dqjEJ1AA--.26468S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43GrWrtw4kWr1xKr47twb_yoWrZFyrpF
	W8tFZ8Jr4DJr1fWFZ5Zw4DZasayF1xG3sIg3y7tw1fZF17Cr43W3y8GryF9r15GryDWw13
	CF4Yqa1Ikw4DWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbWxR3UUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

The walk for NBD_ATTR_SOCKETS in nbd_genl_connect and
nbd_genl_disconnect seems duplicated, factor out nbd_genl_foreach_sock,
and this will be use in latter patch.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 135 +++++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e2fb787248c8..4b9f0349877e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2103,6 +2103,59 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
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
+
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
@@ -2222,36 +2275,9 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
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
@@ -2340,6 +2366,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, int fd)
+{
+	int ret = nbd_reconnect_socket(nbd, fd);
+
+	if (!ret) {
+		dev_info(nbd_to_dev(nbd), "reconnected socket\n");
+		return 0;
+	}
+
+	if (ret == -ENOSPC)
+		return 1;
+	return ret;
+}
+
 static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nbd_device *nbd = NULL;
@@ -2436,40 +2476,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
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
 out:
 	mutex_unlock(&nbd->config_lock);
 	nbd_config_put(nbd);
-- 
2.52.0

