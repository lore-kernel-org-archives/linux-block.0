Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4526ED2A;
	Thu, 26 Feb 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113255; cv=none; b=VDPPKU1fKAxzOfSyAuOeVC06poJr0IqrK2MLw3TTWznS0LwrgY23t9v1xe1cLTMJDAKMi6dcIS1VN7IkdAGBouraI94bEssAj7y6pnmM6hx/t3ojH292ENDSlzhMn7SdPzg1j0Iu0ZInpdME/W2T8vr361jv0KWL6biKwnT0y3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113255; c=relaxed/simple;
	bh=5ZcuTz3+YBdE+R8fryGg6F5tFWRxAHOThfKfUi/9ASM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nkaxkgoUGRaECtNEER2afZRBgt0ne3zehg+nHIuql6/4NbmcQdRCs1p7DEL9ZvYMd6kiHOkWL0RU+AG3WDeh36w11pEQ5EFTAQBZg6N5ZxV8jW0TDuuC4b9QBzVUMrI2U6I7j+7R5yS49whILdEj8360CMZCCWMjXZEmWo5N9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNP8X/S1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNP8X/S1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF39C116C6;
	Thu, 26 Feb 2026 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113255;
	bh=5ZcuTz3+YBdE+R8fryGg6F5tFWRxAHOThfKfUi/9ASM=;
	h=From:Subject:Date:To:Cc:From;
	b=vNP8X/S1tpF9GlxszO3VoRbNEMKwCSWJXtjVrO65gxhxA89w//ozcZwi5VQruoruz
	 ah6AQG1DoFBYgdph9RZeaFL2ON7aXOFtZ14fATjwyVD9SuWSB3b0Eoa0EVJtNdtZtu
	 CHMkDURH2nOw1pMG5MO65Fo3w6JYGh/A8Tjp3MbnQY12yGgaDWoQVhmqu9pkrcHRcp
	 /OgvR4rkmPE6owQA0uwrh2YncQR2eMjMmZtatc0RS5NOBZeyTLPCa9ObpK+Rag7BDZ
	 V26u67PO4+4mUqj+e8LTSDrlB4YKG+sEET1sk4rEulaCwjjOS8umz3ryawmL3ymH3m
	 J5zlHDtNx+t3w==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/3] block: revert avoid acquiring cpu hotplug lock in
 group_cpus_evenly
Date: Thu, 26 Feb 2026 14:40:34 +0100
Message-Id: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M3QpAQBBGX0VzbWpsrJ9XkYttDSZCu0jJu5vcn
 VPn+x6IHIQjNMkDgS+Jsq0qWZqAn9w6MkqvDoaMJWMsasThQL+fiq7HZfMz1rmtCqKSKnKg0z3
 wIPd/23bv+wERvvVCZgAAAA==
X-Change-ID: 20260226-revert-cpu-read-lock-94685007080a
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

The 0263f92fadbb ("lib/group_cpus.c: avoid acquiring cpu hotplug lock in
group_cpus_evenly") commit removed the CPU read lock.

The lock was removed because the nvme-pci driver reset handler attempted to
acquire the CPU read lock during CPU hotplug offlining (holds the write lock).
As a result, the block layer offline callback could not make progress because
in-flight requests were detected.

	static bool blk_mq_has_request(struct request *rq, void *data)
	{
		struct rq_iter_data *iter_data = data;
	
		if (rq->mq_hctx != iter_data->hctx)
			return true;
	
		iter_data->has_rq = true;
		return false;
	}

In order to bring back the CPU read lock, introduce an explicit handshake
protocol between the driver and the block layer. This allows the driver to
signal when it is safe to ignore any remaining pending requests.

I've tried several different approaches, like looking at the request_queue state
in blk_mq_has_request or at the request state but I could not convienced myself
that this works.

For example, when a requests is right before nvme_prep_rq in nvme_queue_rq, the
request is not yet marked as in flight nor are there any queue state checks left
in the remaining path:

	static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
				 const struct blk_mq_queue_data *bd)
	{
		[...]
	
		if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
			return nvme_fail_nonready_command(&dev->ctrl, req);
	
		ret = nvme_prep_rq(req);
		if (unlikely(ret))
			return ret;
		spin_lock(&nvmeq->sq_lock);
		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
		nvme_write_sq_db(nvmeq, bd->last);
		spin_unlock(&nvmeq->sq_lock);
		return BLK_STS_OK;
	}
	
Thus a check like

	 if (!blk_mq_request_started(rq) && blk_queue_quiesced(rq->q))

in blk_mq_has_request is not enough.

I've tested this by a hammering the system with PCI resets and CPU
onlining/offlining while generating load with fio. The original problem was
fairly simple to reproduce (wihtin a minute or so) and with this patches it
survived a whole night.

This unblocks my isolcpu work which touches group_cpus_evenly.

https://lore.kernel.org/linux-nvme/87cy7vrbc4.ffs@tglx/

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (3):
      nvme: failover requests for inactive hctx
      blk-mq: add handshake for offlinig hw queues
      Revert "lib/group_cpus.c: avoid acquiring cpu hotplug lock in group_cpus_evenly"

 block/blk-mq-debugfs.c        |  1 +
 block/blk-mq.c                | 36 +++++++++++++++++++
 drivers/nvme/host/core.c      | 83 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c | 43 ----------------------
 drivers/nvme/host/nvme.h      |  3 +-
 drivers/nvme/host/pci.c       |  3 ++
 include/linux/blk-mq.h        |  3 ++
 lib/group_cpus.c              | 21 +++--------
 8 files changed, 132 insertions(+), 61 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260226-revert-cpu-read-lock-94685007080a

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

