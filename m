Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595D1DE4F3;
	Tue, 28 Jan 2025 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082114; cv=none; b=h9hNcVrvVTbwHTsoqq+/gDnuyyg8QzkxXisn9SX4kAr/M569fimmfUJYm6iwG9hG87OJIZyDQCkHg/UDKujLgnzNTWjDZDrJnHkPE5ydLTDUaodmFPpL3AyJEHTpz1fitATzjMC5IUOr9wJFjoY1JfCNy8Ztxo5I0RScoU1bG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082114; c=relaxed/simple;
	bh=IzcjVmVuBIS5G+lZmSs0a5GGbYPjcP4YaCwLUAG7tcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFSrRAFKHAJbiFdOr/Op2XLhDrtsSoDrmgCtkfk7Ajr+87tLLKqn+i3hoNiTp44yUYXhFWsycWwZ+TAk2l3Or3x4tGyGks0gGHTNNxkifa/czR0hTN/AW3mz7uF7yPM/GUBK5bzrcoE1yLtlo7GwkrnVStQLwRMNPZ+aCa8AhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD1PYUpH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD1PYUpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C93C4CEF1;
	Tue, 28 Jan 2025 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738082114;
	bh=IzcjVmVuBIS5G+lZmSs0a5GGbYPjcP4YaCwLUAG7tcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GD1PYUpHYnlAZu3zZ/6p+BZILmWYaepfLpRpIKfx8nX8dptXveZR7XoMs+ecIjCos
	 qKO4pt7udVedW1+j+yzidTTMfU4XB/i62ghejeHSp47cV723LHSSXUfkVyHGDc0ul3
	 uqCuk/KRuM5EX2P9Ss/jBQwkcfXrJ6/RZb9iCdrLPd/J3Gljfz74if4mquWKebijwd
	 lJWr9ayvSDuU+MO4CRgs3uZ/sK2yH2DJPIfYbvNd+Qi+SyRJeG7xyfm3+PSWJyK3Ac
	 YyxcaDwtR/QKUWUYhkY+ODss1J8BR3y5ShcUYEDQdmIiXeW+qQs0vkWv/lYxAgpZS0
	 Kk37shHCBcr+Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Jan 2025 17:34:48 +0100
Subject: [PATCH 3/3] blk-mq: fix wait condition for tagset wait completed
 check
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
In-Reply-To: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

blk_mq_tagset_count_completed_reqs returns the number of completed
requests. The only user of this function is
blk_mq_tagset_wait_completed_request which wants to know how many
request are not yet completed. Thus return the number of in flight
requests and terminate the wait loop when there is no inflight request.

Fixes: f9934a80f91d ("blk-mq: introduce blk_mq_tagset_wait_completed_request()")
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-tag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index b9f417d980b46d54b74dec8adcb5b04e6a78635c..3ce46afb65e3c3de9f11ca440bf0f335f21d0998 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -450,11 +450,11 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-static bool blk_mq_tagset_count_completed_rqs(struct request *rq, void *data)
+static bool blk_mq_tagset_count_inflight_rqs(struct request *rq, void *data)
 {
 	unsigned *count = data;
 
-	if (blk_mq_request_completed(rq))
+	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		(*count)++;
 	return true;
 }
@@ -472,7 +472,7 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 		unsigned count = 0;
 
 		blk_mq_tagset_busy_iter(tagset,
-				blk_mq_tagset_count_completed_rqs, &count);
+				blk_mq_tagset_count_inflight_rqs, &count);
 		if (!count)
 			break;
 		msleep(5);

-- 
2.48.1

