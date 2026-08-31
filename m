Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E23337B81
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174494; cv=none; b=u6gjfM362b/ugnE6FwdwXsdAXC4MaCioQkv6ylj/lk4vp1H0731OsoBJ/F702t6pZxBGGLSS5J5DHPJ0tAK/VlJxJp2n/wXejXPsSJky/YljyfcX8o05N48blaPqiFrRR7UPExm1jSQAFLuS8fYh/EX9XACbzGYf3KKIn+6hhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174494; c=relaxed/simple;
	bh=KqIqR2hmRHpMVMIwLXf7CXOdLA11xQhRzRtUBc3Abtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1JcNVkAT/fj85RFpnk8GdMHBw+BkPm1iuMxgWIqauRpoiocYgdzGatXQwVJVQmobuyk0AhujJjntRjkdaegDrXSWBRgw6xLEyiFjh256pynWq1ViPKATocD1rtWRFxDPBC2f2rwwQGPMLbvjHtRWEhCpb9DiWrOfzZ7HUj7ETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hYR633twSzYQv3f
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:07:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DE4FD406E8
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:08:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHMAuPYJVqZo_vAA--.44034S7;
	Mon, 31 Aug 2026 19:08:00 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH v2 3/4] block/mq-deadline: add module parameter for prio_enable
Date: Mon, 31 Aug 2026 19:01:43 +0800
Message-Id: <20260831110144.2648156-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831110144.2648156-1-yebin@huaweicloud.com>
References: <20260831110144.2648156-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHMAuPYJVqZo_vAA--.44034S7
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1rWr1xCr45XFykKF45Jrb_yoW8Zr4UpF
	4UXFs5Kr48W3WxGrWxZF45XrySkws7Gry3Jr97G3y293Z8CrWvqFyFkrs0gFZ3XF9xJFyS
	grs2qFykWr1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07UiL05UUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Allow the default of prio_enable to be overridden at load time:

  - built-in:  mq_deadline.prio_enable=0 on the kernel command line
  - module:    modprobe mq_deadline prio_enable=0

A value of zero disables I/O priority from boot/load: every request is
filed in the best-effort bucket and the priority aging path is
bypassed, so systems that do not want RT/BE/IDLE distinction can opt
out without writing to sysfs after every queue creation.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/mq-deadline.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 276ce249d326..b30924e0b297 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -37,6 +37,17 @@ static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SO
  * inversion.
  */
 static const int prio_aging_expire = 10 * HZ;
+
+/*
+ * Whether to enable I/O priority support (RT/BE/IDLE distinction).
+ * When false every request is filed in the best-effort bucket and the
+ * priority aging path is bypassed, so systems that do not want RT/BE/IDLE
+ * distinction can opt out.
+ */
+static bool prio_enable = true;
+module_param(prio_enable, bool, 0644);
+MODULE_PARM_DESC(prio_enable,
+		 "Enable I/O priority (RT/BE/IDLE); 0 = best-effort only.");
 static const int writes_starved = 2;    /* max times reads can starve a write */
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
 				     by the above parameters. For throughput. */
@@ -561,7 +572,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
-	dd->prio_enable = true;
+	dd->prio_enable = prio_enable;
 	spin_lock_init(&dd->lock);
 
 	/* We dispatch from request queue wide instead of hw queue */
-- 
2.34.1

