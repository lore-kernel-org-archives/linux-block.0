Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3928B415;
	Mon, 10 Nov 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779486; cv=none; b=UpkVJomAHVebkjiJexb4E6dPkKa9a36GblEKcdYhfbahW+bWHP7MFyaS3pVOJhi4p8zzI1YIk3fZX81jxN2Xu6r8d1OsCS2J04f1VTvIoEWtGk8wDNMzoMsUrueDTEYSFoaKd7YpV0Uh/WURBGVNa67m41XRh1n8T6snmb8o/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779486; c=relaxed/simple;
	bh=pns06N2Youi4f1wGvNXHVEUQOTtynPEsqQVZbJ+wnBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DY836AF+7TO8VQ4BvSIFT3okOCIrZG535nc7TFXb9b8oCmZN/QbvkLlBnADaBXei+KpDeQ9xCkYves06q6sOlC8M2TKtNrP/ncOVH0o6hHL23odCbAKC83mGpAD1+PKJI5Ce0yKe64PYNwj2mJGa/3GyUEldx2tBHx+LbNR4v28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d4qSv1cZkzYQvBq;
	Mon, 10 Nov 2025 20:57:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4D9D71A0FB8;
	Mon, 10 Nov 2025 20:58:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgAHZXtX4RFpBDUQAQ--.13239S4;
	Mon, 10 Nov 2025 20:58:00 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH] nbd: defer config unlock in nbd_genl_connect
Date: Mon, 10 Nov 2025 20:49:20 +0800
Message-Id: <20251110124920.1333561-1-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHZXtX4RFpBDUQAQ--.13239S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13JFyrKFW5KF4kZr1xuFg_yoW8Cw1rpa
	1akFZ7Gw18Ja1rWrWkC3s7W3W5tasrKr1xKry7Jw1Fv3s3A34xur4kK34fXFyUXr9rJFW3
	AFW8W3WIkFWvkwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UpCJPUUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

There is one use-after-free warning when running NBD_CMD_CONNECT and
NBD_CLEAR_SOCK:

nbd_genl_connect
  nbd_alloc_and_init_config // config_refs=1
  nbd_start_device // config_refs=2
  set NBD_RT_HAS_CONFIG_REF			open nbd // config_refs=3
  recv_work done // config_refs=2
						NBD_CLEAR_SOCK // config_refs=1
						close nbd // config_refs=0
  refcount_inc -> uaf

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 24 PID: 1014 at lib/refcount.c:25 refcount_warn_saturate+0x12e/0x290
 nbd_genl_connect+0x16d0/0x1ab0
 genl_family_rcv_msg_doit+0x1f3/0x310
 genl_rcv_msg+0x44a/0x790

The issue can be easily reproduced by adding a small delay before
refcount_inc(&nbd->config_refs) in nbd_genl_connect():

        mutex_unlock(&nbd->config_lock);
        if (!ret) {
                set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
+               printk("before sleep\n");
+               mdelay(5 * 1000);
+               printk("after sleep\n");
                refcount_inc(&nbd->config_refs);
                nbd_connect_reply(info, nbd->index);
        }

Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 215fc18115b7..a05ff68e58d0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2241,12 +2241,13 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 
 	ret = nbd_start_device(nbd);
 out:
-	mutex_unlock(&nbd->config_lock);
 	if (!ret) {
 		set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
 		refcount_inc(&nbd->config_refs);
 		nbd_connect_reply(info, nbd->index);
 	}
+	mutex_unlock(&nbd->config_lock);
+
 	nbd_config_put(nbd);
 	if (put_dev)
 		nbd_put(nbd);
-- 
2.39.2

