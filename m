Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034495;
	b=z0vrEKqv0/0S+FUQNh1bmXe9Q7BguEO2883XPnzNUHQKPfUI9OHopYsFREtEAcq8slyl
	 Of/YJ0cMNS+mWE9HNgFZH6oPweuHgpP6Z4aPnJhGkr3hOk27WQToZSuSMeXDV/Ks+gkpT
	 sui3U87CHEOzRqY6iO6F5P+Ynq5m2l4BA+w9TX7hhp8a+IDyjA3fHnF0D8uVYYVNbvhxO
	 0L8pFDW7f9+rDUIRlnPMLFeHxmSnH3eixD+p05ZUGfoqSpWqLe7cEseaw/jM4ADFrNLUO
	 las0+3qjogsofA8Hx5GYEgdVKvoA9hsI7o55fMJRMxd2tibTBI1ASD8I1T+I7Yds0Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034495;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=trXAchNUwzPTGAZKdFBTshj/9uxdD6sxzX9w44/PK7U=;
	b=S0MTsmO42XXfLlxghtdfX2V74VXCl31JPGcRba7qWP7G52T4SKn5DZxesfVtZOu9e82Y
	 pZwdn5/jca+05Gn2PaD/CXU0B82+Pq6KnhcErIFtX2oxqxWkYTukbDuHyc2nxNpza2qN8
	 G+rwNrsQTdSlrwsjZbCfSMgK7Q+qhPc0FoYJTXfk27D4srvyKxVT3RPmIomV61PZiUQVu
	 vwfge+ZOLFF0zi9LhJJ/CBStTzn6Ax36jXtimNQAuMLlzTen8NOeZprLbRXavbsA9hWGu
	 xbLAbSlOTGfF2s7hC2QIlwm0m7ySfAM03Yt81WLcOwoNT3nUrz5p8v4MDop8dJAZroQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=huawei.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72556606A334
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 06:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72556606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jM6Gd0Mk9z1rrTV
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2A87840577
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgAHwgQ1y+5qHB5yDQ--.31669S4;
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
Subject: [RFC PATCH 0/5] nbd: allow parallel genetlink operations
Date: Sat,  7 Nov 2026 14:46:24 +0800
Message-ID: <20261107064629.4093489-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
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
X-CM-TRANSID:_Ch0CgAHwgQ1y+5qHB5yDQ--.31669S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4fKryDuw13WF4xGrWDCFg_yoWkZrb_Wa
	4UuaykGr48GFWFkF9akF4rAryUKw4ayF1UAFnYyFZ7Zr1xXrZ8Xr4vvr4qvF18Xa17Arnr
	ur4qvw4Ikr47KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUFrcTDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Each nbd doit only touches the state of one device; the only global
state is nbd_index_idr, accessed briefly under nbd_index_mutex.
genl_mutex nevertheless serializes the whole genetlink doit path, and
nbd_disconnect_and_put() sleeps in flush_workqueue() while holding it,
so one device's teardown blocks every other device.  This series
enables parallel_ops for nbd.

Patches 1, 2 and 4 fix bugs that are reachable without parallel_ops;
patch 3 makes device publication and the status walk consistent for
concurrent genl handlers.  Patch 5 enables parallel_ops.

A minimal netlink client on an 8-vCPU KVM guest, 32 devices x 10
connect/disconnect cycles, median of 3 runs: 390 ms -> 25 ms.
Connect-only and status do not change.

Yang Erkun (5):
  nbd: validate the backend identifier under config_lock
  nbd: decrement nbd_total_devices when a device is removed
  nbd: publish devices atomically
  nbd: hold config_lock while updating nr_hw_queues
  nbd: allow genetlink operations to run in parallel

 drivers/block/nbd.c | 95 +++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 30 deletions(-)

-- 
2.52.0

