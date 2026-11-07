Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034496;
	b=gUFiv4wIt1ua+0VkjVw+zJAeiDNky915wpKRsZGNb59RChbXEIAxmqEBwoYCqd+rYytm
	 ODGIwYNPCq3NZduGbe9p9tn6KqjZVjlFFIjvWcbsz2Z0jE8258jYIaBF+jVUVxy4cI7ua
	 wDz6MkGumZDl/XnhQe59qy4e5dBDdBL8Qu6W0E0ZfZ/DeV4EM0x2ttLOaGPUHAF4//U3c
	 rTRZr7SSkxH2S/Fg10m6iaqdP8Cyyi9mrf2ObhkS5OLc7HlVJFuNqTlqvLhRQ9gm0DdOS
	 JpTANrfT8K+upXtPD3WbpbMDj6LqbrsX2Wa3SIi5PRHJU9InlqldcXtEo4+4w1uRYIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034496;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=l96LmI8pJLNzPFH9ySmXS4gLTHLAsPZvo7Ax2hmQcgo=;
	b=h5PneumpsseALOHpyxXhcmA9EVjgGUo4fYcAhWUuT3NtcGmD2AH7QwY5sAsG/sxOfLMy
	 t+KbMvmRSwyC/sHHRJCriRmM4qXZ2gg0q3l7lk+eBUDcgWLGxlNk/0yBhAM0RFH/bgXwA
	 sxtiXvzUFKLZG6D+t//AsMRjzhDmvh4e3pGYO7dMFdm9lLKCiixsT8z9I7s02goMAS3li
	 aTrimTS85Bxaq5sUYN417GXl6gGL9uo+3x89sOv9Dr7eTqLqGuMxySm/5FWOPAYQHwLP8
	 fIs8GwVMLBOjsYTyp3jrI1yHzvALrVJHr9GCq8az6KkySZ3KgKDnSA+C8Dti1Ann2Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=huawei.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F7606A33B
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 06:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED5F7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jM6Gd1cWKz1rrbp
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 55BF840573
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgAHwgQ1y+5qHB5yDQ--.31669S6;
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
Subject: [RFC PATCH 2/5] nbd: decrement nbd_total_devices when a device is removed
Date: Sat,  7 Nov 2026 14:46:26 +0800
Message-ID: <20261107064629.4093489-3-yangerkun@huawei.com>
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
X-CM-TRANSID:_Ch0CgAHwgQ1y+5qHB5yDQ--.31669S6
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47XrW7Cw1ftw4xGr43trb_yoWfKrX_Aw
	17CF4kZrykKF4UCr4Uta1fZry0y3WIga1FkF1IqFZ3Xa47XFn3XwsFvr9Iq348WFW7C3Zx
	Z345WrWIyr1xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb9xYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUF0eHDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

nbd_total_devices is incremented in nbd_dev_add() but never decremented,
so it ends up larger than the number of devices left in nbd_index_idr.
nbd_genl_status() sizes the reply from it, so status allocates for
devices that no longer exist.

Decrement it in nbd_dev_remove() under nbd_index_mutex.

Fixes: 47d902b90a32 ("nbd: add a status netlink command")
Assisted-by: LLM
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fbade6ae4481..1448ee63fab5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -275,6 +275,7 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	 */
 	mutex_lock(&nbd_index_mutex);
 	idr_remove(&nbd_index_idr, nbd->index);
+	nbd_total_devices--;
 	mutex_unlock(&nbd_index_mutex);
 	destroy_workqueue(nbd->recv_workq);
 	put_disk(disk);
-- 
2.52.0

