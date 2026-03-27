Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2325EFBE;
	Fri, 27 Mar 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603453; cv=none; b=fdgY9Z4oyRlooTz3+nHvavdEwLUtkfn870FqFKbe4JLXrDxjPZslq5SPYigfhSd6fnX5jDEbnCi/GaaiK8gj61LKf9vgq14HALaKw8/xT0q8KqD+euCHCooayIBfHTAx3n1+YDoLwUanP5KR4Iuo1eq/6YiqSAm9K1Zqyv9zli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603453; c=relaxed/simple;
	bh=PgAJeijFmYqZtbSCGfY/BTgjXI2R5AGFITDN/TTs1Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VyQ/FPiVDzYO69HCq2McMwUl/L0zBIdC1cJetDljRgOXv+Doc+3NiZ+1KXhs/4epAaPqo16y4Q7kIT7tYWjVYj4bk2iWz2jR7ml/y0aCkugBZgCnXweAz6OjdPhRCUFgr81wN0lt5PFWiyYR3+fCYkVKyzr0YCLsGUiG/MV16Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhwDT5NrNzKHMk3;
	Fri, 27 Mar 2026 17:23:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5A7914056E;
	Fri, 27 Mar 2026 17:24:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgAHC9uyTMZpTlaWCQ--.27625S4;
	Fri, 27 Mar 2026 17:24:03 +0800 (CST)
From: leo.lilong@huaweicloud.com
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: leo.lilong@huawei.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lonuxli.64@gmail.com
Subject: [PATCH 0/4] nbd: replace socks pointer array with xarray to eliminate queue freeze
Date: Fri, 27 Mar 2026 17:12:19 +0800
Message-Id: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHC9uyTMZpTlaWCQ--.27625S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4rGr1DXFWDWFy5CF1fXrb_yoW8Wr4xpF
	ZIk3Z3Cw1vqr43Gr9ayay0ka1fWw48J3yUGw1fWw48ZrZ8ZF97ZF429r4rCFyYkryvkw12
	vw1jgw48ua48ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUFXo7DU
	UUU
X-CM-SenderInfo: hohrhzxlor0w46kxt4xhlfz01xgou0bp/

From: Long Li <leo.lilong@huawei.com>

Hi,

Commit b98e762e3d ("nbd: freeze the queue while we're adding
connections") introduced blk_mq_freeze_queue() in the add-socket path
to prevent use-after-free when krealloc() relocates the config->socks
array while I/O is in flight. However, freezing the queue on every
connection setup introduces significant latency when establishing a
large number of connections.

This series eliminates the queue freeze by replacing the
krealloc-based struct nbd_sock **socks array with a struct xarray.
The xarray provides RCU-safe pointer publishing: each nbd_sock is
fully initialized before being stored via xa_store(), and concurrent
readers access individual entries through xa_load() without ever
holding a reference to the array itself. This removes the possibility
of UAF on array reallocation, making the queue freeze unnecessary.

The following test was performed with 256 connections on a local
nbd-server:

  nbd-server -M 256 -C /etc/nbd-server/config
  time nbd-client 127.0.0.1 10809 /dev/nbd0 -N myexport -C 256

  Before:  real 4.510s  user 0.004s  sys 0.038s
  After:   real 0.263s  user 0.009s  sys 0.032s

Connection setup time is reduced by ~94%.

Long Li (4):
  nbd: simplify find_fallback() by removing redundant logic
  nbd: replace socks pointer array with xarray
  nbd: remove redundant num_connections boundary checks
  nbd: remove queue freeze in nbd_add_socket

 drivers/block/nbd.c | 201 +++++++++++++++++++++++---------------------
 1 file changed, 106 insertions(+), 95 deletions(-)

-- 
2.39.2

