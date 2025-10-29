Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AB3161AD
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772170; cv=none; b=KBu6iMA6dxh9lRsJUklx/EzNTh5EjzRBwVPXBhVju0c35A+vAolTDG6rzG63OMRusrRm7f3iA2TV9xADg5PtSj1ZjkKo3Q3HVJweEooHXtq6gFnQvCzL/H3g+yDNzt66ywbrY0pc1cDU1NJ4U7gakK9n9dCBCZ8sxk+c7n7iPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772170; c=relaxed/simple;
	bh=R8wu6PNYbyPeWP9Y9WjW+p6BF9zybWm6yzcnXWSLh6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pupLOi15wNc7ZVRp7ZLdS0hMMNcnyJJMHgPI5NV4tW4CTzxb7tJttooefH28XSTvZu0J5W8VuGOVV3AXWUFtbQcblB/KuVtjpEf0wsjBMHg5b/MAwgVEC8yDwyV7TEtNYbX5QXSRCCF2miv8rPW3HjtNbrzNt74RQPYm2ZmSENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=F/UEgSZQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="F/UEgSZQ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so52894a12.1
        for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761772167; x=1762376967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQd5WnTIHuwOTKOc3/5nF1ZAvZxVbQqd8kUZmHhqZSI=;
        b=F/UEgSZQL7MDxLVo2KDQQQ9RujfNlWNjwy7RaaNVqJ3SShv0czRzBZgAvFniytDFeA
         z+6/FWQCslH0Bi8l4JLMq9opHDYA3xfbvTB8MbnIhUdAxBK+Zkx/aVgpLrQfK/C7TNGF
         VsLNW/Gux50vEdKuliTpHfYBBQMRC1kHfc1XtPOCnl/qzj+vqSY5byfvsUd8lDeVLcQN
         hcSsn7SJHhoUU2r1ORD/5CNLnuhVqjO88LbKp9Jh0eiqfmm2+p39nOCA8utlbngLa/MQ
         hoR6zBn7CyTR/9ONxnxMMLQQQfr92f/cKpz0Dc3NVkdiBskOBlSY/y4uyoS7J5MxPkgS
         0l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772167; x=1762376967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQd5WnTIHuwOTKOc3/5nF1ZAvZxVbQqd8kUZmHhqZSI=;
        b=HaJF//vLADXTz1pCd4K6037D5dPtyE03vLFEqr8aGIeG+HuYv04HSSrqvBHu4mw4cF
         iZKZS5kQIP1cubPeRYUJFNN0zB+YcpSwx5GOzc3XuvwbPfdCrwok6fT1z8vgRQpGXArv
         jDvOnPxU7v4X4U6UVNPSrsseC9unNsVG0EhYziEc64z78qkVLHrHXcmBJ2xspxKLDR4k
         ZiiD00KPjagFQ0Cr9ntXI/t+qmejXO/U9kM+GizKBgOoFFli4lVFh3ueKbJzcQT05N4b
         RAeKHXTVpe2XwHABI21mUFT6iXyOCyT99jr6Lbb6e2Go4m1hIgJtgq0Fw/EohIu2U85Y
         jQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRrOE5ZySQasjM9WDbkq360QtLUZ7OFafpv0fX17Ri1Xb1yGGxbOahgMnb3j6b5IqEXGpp3YbzGUSfcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBrdnhuo9v1cf+elzcNuQP2OL3k9jsu8+VMNuDzqKgPmIT4kV
	kTIaU4egt2pLz6hQqhgDZiraelvBKb8lcyl9Z7TJcKuB1V7wy7DlfvJO4G+/YYK7jUk=
X-Gm-Gg: ASbGnctK0ErFUIccZT4TL8bweppaTUZzSSwfdvfb0gaLMfZo9818/VYQuakg53a1wxw
	cQ4eLgJwZz3J/myOAfi4Il5cFTbXrzvli+gCfqL1ZozKmnPMmF7ZyGFkUaUgFjS55VHITObvFqe
	AGFiTBMlBEY8Owo3fGM0XNSezoQbhB8J/55HDDU4O9KBEM6lh4JVNyNXNpzEfbXf/bNiW1ALpZr
	SL3ziXeUX4ImAZiHjbp4mQHy0tDe7BpRybCmvfI+khYo7JHHaXch5BgmseKfG0JZlHUSXoyds9q
	0rDtW2VRGr7WMhDk4bMM7McNSF95rd2cup6fZsRjeEhsp5mEczBDB1ZsDam0QQNSMygKajcnq0R
	RV8JQ858t0/0rHPYi6TgPxfEKKg76wpV0sSQsNV8bk86bP/otDjd9WqVvdHtAu3XwCMkqIhLMrQ
	c/gVWBGsgYulRdh43SmA==
X-Google-Smtp-Source: AGHT+IEqPZ1jbtVsBO4M/wJE1BB4Qc7COpExc4FmA/ky44z0r1TMOAvss0Flq1oWWxe/RE/PkWKKOw==
X-Received: by 2002:a05:6402:3590:b0:637:e361:f449 with SMTP id 4fb4d7f45d1cf-640441b9c80mr1972963a12.1.1761772166823;
        Wed, 29 Oct 2025 14:09:26 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([2620:125:9007:640:ffff::9190])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82907sm12966917a12.12.2025.10.29.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:09:25 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: yzhong@purestorage.com,
	sconnor@purestorage.com,
	axboe@kernel.dk,
	mkhalfella@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale pointer
Date: Wed, 29 Oct 2025 15:08:53 -0600
Message-ID: <20251029210853.20768-2-cachen@purestorage.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251029210853.20768-1-cachen@purestorage.com>
References: <20251029210853.20768-1-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuanyuan Zhong <yzhong@purestorage.com>

When a controller is deleted (e.g., via sysfs delete_controller), the
admin queue is freed while userspace may still have open fd to the
namespace block device. Userspace can issue IOCTLs on the open fd
that access the freed admin queue through the stale ns->ctrl->admin_q
pointer, causing a use-after-free.

Fix this by taking an additional reference on the admin queue during
namespace allocation and releasing it during namespace cleanup.

Signed-off-by: Casey Chen <cachen@purestorage.com>
Signed-off-by: Seamus Connor <sconnor@purestorage.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8d8af58e79d1..184a6096a2be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -687,6 +687,7 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	blk_put_queue(ns->ctrl->admin_q);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -3903,9 +3904,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	struct gendisk *disk;
 	int node = ctrl->numa_node;
 
+	if (!blk_get_queue(ctrl->admin_q)) {
+		dev_err(ctrl->device, "failed to get admin_q %p\n", ctrl->admin_q);
+		return;
+	}
+
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return;
+		goto out_put_admin_q;
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		lim.features |= BLK_FEAT_STABLE_WRITES;
@@ -4002,6 +4008,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	put_disk(disk);
  out_free_ns:
 	kfree(ns);
+ out_put_admin_q:
+	blk_put_queue(ctrl->admin_q);
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
-- 
2.49.0

