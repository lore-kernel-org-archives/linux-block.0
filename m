Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A223EA83
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651333; cv=none; b=PmWkazbMujreQx3oPLSnj0PmVgjbPyEF7j8fIeNuR2uVeF4s9kA6KlqEpniL/Rk+81jl8gT9YzfIoGaJvEc31tFgHFchP0UoVQUjmaoIV5reee2TJZp2LnFyfyDfQ1YxBwyL606Go0Lxze711DnfgCy4uSMnXrQHBF0koU0bnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651333; c=relaxed/simple;
	bh=ErW+OWDNIhPXWHwbUlV2kpoKvm/LGkix9dxZH2JX7Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=toSIv7uoZbmBlWaImuKe1Pvp72GXW8cdf97nyvQBII6hEr7Fj/y5yKqYeaVT+cyBvgu04fMbmeDl04DIe+t/8bS9Hx1P5nI8wrEOtEEEg+Ad1WoesEjoWxZ1vkIM1qCWre42F6AZEu6EXKJpsAOtOgD+YfLJkXOh3cn+WYOUkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fZ86C0mH2zYQtrb
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:54:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BD6C24057D
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:55:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgA3Otp6xbdpKYBhBA--.38497S4;
	Mon, 16 Mar 2026 16:55:22 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	yukuai@fnnas.com,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH 0/2] blk-throttle: minor fixes and cleanup
Date: Mon, 16 Mar 2026 16:44:53 +0800
Message-Id: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3Otp6xbdpKYBhBA--.38497S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY47AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx
	8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU15CztUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

This series contains two minor patches for blk-throttle.

Patch1: simple cleanup
Patch2: fix timer scheduled on tg_flush_bios()

Zizhi Wo (2):
  blk-throttle: remove leftover carryover checks in
    tg_within_[bps/iops]_limit
  blk-throttle: fix timer scheduled on wrong service_queue in
    tg_flush_bios

 block/blk-throttle.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.39.2

