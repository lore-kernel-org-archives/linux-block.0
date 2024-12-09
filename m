Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB7218592;
	Mon,  9 Dec 2024 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745516; cv=none; b=DUY05VeMN2jVurwPzQuU86YrQ4vIBHgEElaI1CNX6RPhBOdCsLC3nOK/qRC5J/+YueaEje1cz2ZX0Ht+Do4LsJpYvxXOM4z0ub6WkH2xsAvDCPoqnHcf/cI7IsBH7dFtQ1H5/xZRMb30JhCjOXoxN5sULnJWj9ElC+s/gEUyKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745516; c=relaxed/simple;
	bh=R/TB68sn1vs2P3kBKeAUtfisWJDEYxhhHSWMShItaes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WHVr953f64R4QUazDPvmobIOh7dIR06b2qq+//s4Lb4iQrrNZ1sPae0oxWWwt51DUlHrR2u0Rt7Y/blwtx0OS6r7Prj2TECYVc+KlmwiYliyLhNWInypms+W/XgHT0P3ok6oFlSzXAqslM/HwnFIry82WJ1vo3h94wuLsTEVU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y6L3R1SpYz4f3kFL;
	Mon,  9 Dec 2024 19:58:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 61A3A1A0568;
	Mon,  9 Dec 2024 19:58:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4dk21Zn1extEA--.18505S4;
	Mon, 09 Dec 2024 19:58:30 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	yang.yang@vivo.com,
	ming.lei@redhat.com,
	yukuai3@huawei.com,
	bvanassche@acm.org,
	osandov@fb.com,
	paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC 0/3] lib/sbitmap: fix shallow_depth tag allocation
Date: Mon,  9 Dec 2024 19:55:19 +0800
Message-Id: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4dk21Zn1extEA--.18505S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY97AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxV
	WUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Yu Kuai (3):
  block/mq-deadline: Revert "block/mq-deadline: Fix the tag reservation
    code"
  lib/sbitmap: don't export sbitmap_get_shallow()
  lib/sbitmap: fix shallow_depth tag allocation

 block/kyber-iosched.c   |  2 +-
 block/mq-deadline.c     | 20 +++-----------------
 include/linux/sbitmap.h | 19 +------------------
 lib/sbitmap.c           | 34 ++++++++++++++++++++++++++--------
 4 files changed, 31 insertions(+), 44 deletions(-)

-- 
2.39.2

