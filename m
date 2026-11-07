Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034501;
	b=dLi7u1KiqEWUTCLQm5gcfOrAOQZ0AdpYZM5HkkHroF9oi4EW+zFyx/VgKriGNbfgnkvF
	 fEW/HWdGGo7SCx1vMmUAdqQ9PDHC2evkwztfdGlEpHjBvtYyw/DOz3SCw76NVUuzW1ZIz
	 Q8qQ52IMoa5rqNvgmKTdoH3UdTJC5Dyjh52w8TajjxngpVgZ+Ux4h1D56zxBt7TCVHzFY
	 1g9F5g6X7sv9IkhSMhmpehLNIIqVZ8tNRSycSn56eEbx+w4AbnAm4Svtz1etNNmBovKkA
	 CF6OrxeZqGRH7h8P1hqncSynOgf/LG2Pd0Gq/nJYDQspLYW/0tNq3f/+GLkz5NK7Jsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034501;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=tTyy2Odm0CC2H0Otnjb4/F1KvcgaCWIP7CB3t+Td7Rw=;
	b=pE+eXNAnCqqv3mvLIL35RT7aG2bbMkkguwlYBApVbXE1U7UkojwgSSReIpcJGkdqdr4v
	 ZdwVVN4+JVjGV96dQtb6AACwc3Pjo794NaVEvtaBxtp8YGSgb729U0LkNborNAEV4aHKd
	 ohkxFZ0zw4PcY9/3Iv1j3y605QRPGUd6iaUDE+pSnFckPlNAG0qbDK2gFEBioRhI36UEA
	 CcWh/xGClVq18w9WaW6xLblPbHMaz2YedeZg1YcyO7VCIjgIzPCEkcy4sj3GVkzEPfeCf
	 Df/AheH4ecgqWH4ykzGqPVO4nLqoIImpY/fNoYkk+aKuCmfwlQYO70juKbFPMIEML2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=huawei.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F5606A32C
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 06:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 072F5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jM6Gc64z6z1c19b
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6FC9C4099B
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgAHwgQ1y+5qHB5yDQ--.31669S7;
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
Subject: [RFC PATCH 3/5] nbd: publish devices atomically
Date: Sat,  7 Nov 2026 14:46:27 +0800
Message-ID: <20261107064629.4093489-4-yangerkun@huawei.com>
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
X-CM-TRANSID:_Ch0CgAHwgQ1y+5qHB5yDQ--.31669S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJryUWr43KryUWF1DZFy3twb_yoW8tr13pF
	4YqFZrKryDCr4fGr48A3ZrWF15Jw4kAayrGryUJ3429FZ3Cr9Ig34rtFy5t3ZrJrZ5AFWk
	tFW7Z3yvka1DJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07UWc_-UUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

nbd_dev_add() inserts the device into nbd_index_idr as soon as it has
an index, but sets nbd->refs and nbd_total_devices only after add_disk(),
the latter without nbd_index_mutex. With parallel_ops enabled in a later
patch, a status walk can then report the half-initialized device while
nbd_total_devices does not account for it yet, and overflow the reply
(-EMSGSIZE).

Set nbd->refs and nbd_total_devices together under nbd_index_mutex, and
skip devices with a zero refcount in populate_nbd_status().  Then
nbd_total_devices is an upper bound on the devices status reports, and a
reply sized from it can't overflow.

Assisted-by: LLM
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1448ee63fab5..8c2cb312f209 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2029,10 +2029,15 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs,
 		goto out_free_work;
 
 	/*
-	 * Now publish the device.
+	 * Now publish the device.  nbd->refs and nbd_total_devices are
+	 * updated together under nbd_index_mutex, so a concurrent idr
+	 * lookup either sees a fully initialised device or one that it has
+	 * to skip because its refcount is still zero.
 	 */
+	mutex_lock(&nbd_index_mutex);
 	refcount_set(&nbd->refs, refs);
 	nbd_total_devices++;
+	mutex_unlock(&nbd_index_mutex);
 	return nbd;
 
 out_free_work:
@@ -2537,6 +2542,16 @@ static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
 	u8 connected = 0;
 	int ret;
 
+	/*
+	 * nbd_dev_add() inserts the device into the idr before it is fully
+	 * initialised and only publishes it (sets nbd->refs) after
+	 * add_disk(); skip a device that is not published yet or is already
+	 * going away, so that the walk never reports a device that
+	 * nbd_total_devices does not account for.
+	 */
+	if (!refcount_read(&nbd->refs))
+		return 0;
+
 	/* This is a little racey, but for status it's ok.  The
 	 * reason we don't take a ref here is because we can't
 	 * take a ref in the index == -1 case as we would need
-- 
2.52.0

