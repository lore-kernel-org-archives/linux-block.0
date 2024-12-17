Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406112595;
	Tue, 17 Dec 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403475; cv=none; b=J5fOm4rI08uMGdQZ+U5G////WmYeIRW/PAhwJMVv5O13D/wOmz9n9CcQ40abyEaWwuhcY3UCKo0I1DqUcLiFk9rbQ/ypQJCUQGu40jGJ7rrkoRMYOnIWIgOW2GGkaH9U7zS15MNjNejmgM0DcDGtyKtZ6S9I0fZThXHXp01yKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403475; c=relaxed/simple;
	bh=FRfUUccdYlSbqR0CKnuQQmf1Ww0JiHGw8NKAGCRzJc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GcBMmmAVCFzYPKVLLpXzCYaWM0YQbWpTw9clpDghbaTJkjCe/ntx1Aoa3HFVGWL3RAd+zbCUo/h69AxM3bwq8gCWbDM/3tQtSrEnKi3mhulJktN3FKu++/dclHHSSEtsu7Qr8JW+MnY3/NhsA6SraNZEK93tqunVywlcE1ZfxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YC1NM3zR0z4f3jXT;
	Tue, 17 Dec 2024 10:44:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 021681A018C;
	Tue, 17 Dec 2024 10:44:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYWE5WBndhZJEw--.48443S4;
	Tue, 17 Dec 2024 10:44:22 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	bvanassche@acm.org,
	osandov@fb.com,
	paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 0/4] lib/sbitmap: fix shallow_depth tag allocation
Date: Tue, 17 Dec 2024 10:40:43 +0800
Message-Id: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHMYWE5WBndhZJEw--.48443S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XrykGw18JryxGr13GF1UGFg_yoW3XFg_JF
	WkAa48Jwn3J3Zxua4UtF15JrWjyr48tr15AF1DtFs3Zr13CF1UArWkAFWUZr1UZF4UAwn5
	ArykZr4vyr1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in RFC v2:
 - update commit message for patch 1;
 - also handle min_shallow_depth in patch 2;
 - add patch 3 to choose none elevator by default;
 - add patch 4 to fix default wake_batch;

Yu Kuai (4):
  block/mq-deadline: Revert "block/mq-deadline: Fix the tag reservation
    code"
  lib/sbitmap: fix shallow_depth tag allocation
  block/elevator: choose none elevator for high IO concurrency ability
    disk
  block/mq-deadline: introduce min_async_depth

 block/elevator.c        | 11 +++++++++
 block/mq-deadline.c     | 35 +++++++++++++-------------
 include/linux/sbitmap.h |  6 ++---
 lib/sbitmap.c           | 55 +++++++++++++++++++++--------------------
 4 files changed, 59 insertions(+), 48 deletions(-)

-- 
2.39.2

