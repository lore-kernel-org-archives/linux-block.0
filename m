Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4271EC4EF;
	Sat, 21 Dec 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774067; cv=none; b=WlFw0HeEOKhowkJ6zG02a53e5olEEapOpdr8yqRYLcvp7pSoSsnsjVSQzEpIlVhnAOM8R7pcfF5szgjEumxrZBXY0uUoLVlBy1pYsXel3hy4P2gWUeJr2h0fEUkLccFqq1JV2nWNOGt+mAcUqe460TUCznv98lSj/kZ79GM6MvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774067; c=relaxed/simple;
	bh=br4oV0ufQ+C/9USSistq4rp4GB3JLp0t0J67xc+FdPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYDBebye7GGGFgSudJ4M+4D4qwtP6fpwgv6DrHWmz8vxCaXYW/XiLXBiLVtFzA7nvs4L/07qJbO4gssc38Wq5M1Wn+/6rEW16lxzsS6yhn5Nc8pPpTwncMIzBA2eBTfNWemSRiziRKb5zXaCTdVWw0AO8brHuK2RGcKirXGK4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YFfRM36g5z4f3jkc;
	Sat, 21 Dec 2024 17:40:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EECE61A018D;
	Sat, 21 Dec 2024 17:41:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoYqjWZnocfeFA--.21383S7;
	Sat, 21 Dec 2024 17:41:01 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	yukuai3@huawei.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v3 3/7] block/elevator: add new ops async_depth_updated()
Date: Sat, 21 Dec 2024 17:37:06 +0800
Message-Id: <20241221093710.926309-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241221093710.926309-1-yukuai1@huaweicloud.com>
References: <20241221093710.926309-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoYqjWZnocfeFA--.21383S7
X-Coremail-Antispam: 1UD129KBjvdXoWruw15Ar47Gr17Kr1xurWUCFg_yoWfJwc_Cr
	yqkwn7Wrn5Gr1fZr1jgF43uFyvgws5XFsrWa4agFykX3WDGa4rCr48Cry5WrW7GrWxua43
	JF4DZr47Xrs0qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The new api will be used in mq-deadline and kyber in following patches,
prepare to refactor async_depth.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/elevator.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/elevator.h b/block/elevator.h
index dbf357ef4fab..21a431873f48 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -29,6 +29,7 @@ struct elevator_mq_ops {
 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*depth_updated)(struct blk_mq_hw_ctx *);
+	int (*async_depth_updated)(struct request_queue *, unsigned int);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
 	bool (*bio_merge)(struct request_queue *, struct bio *, unsigned int);
-- 
2.39.2

