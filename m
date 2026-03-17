Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817B39448F
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737882; cv=none; b=IjjEbvNIg2E56g3cXCPg5Z4quoKVq2ghVhxFM6YY22BMfx8yhXPZi4NqiDCgXTnhSCntto9KM6s5aMMhVG86VlWDCV6TmQ5yZ44XjlvXeGLS74RrcjTSjf/uyJvtrFonzBG0WH9mEjJTm2P4EIbN3YniXc2PzIQ4HSDRU5n+xBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737882; c=relaxed/simple;
	bh=NzzIw6pVM26ig50A5pg2WMqMdwVWV3cTJOcEOV7eWFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJAvulJ6JLwGxXbro7EntB0AQRnUqgwCd/iMT1iyuXMalCIXlcNOeVjSOFDJcoGuE2CQipAag89Kqtbuh4T80ZZeBQqCFkow7T0S25qDDKC5INlOYQ5nDgceroJfKPZ3SPZ3cupZZ/64AH0ox8EaUI3EDr+wU2AVV7tIEV2Sw5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAXqw6QF7lponKsCg--.60705S2;
	Tue, 17 Mar 2026 16:57:53 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Cc: christoph.boehmwalder@linbit.com,
	axboe@kernel.dk,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drbd: remove unneeded semicolon
Date: Tue, 17 Mar 2026 16:56:42 +0800
Message-Id: <20260317085642.24744-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXqw6QF7lponKsCg--.60705S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DAr48XF43Wrg_yoW3JrX_Cw
	18G3Z7Xr1kCrn0kry5ZrWFvFyqkw47ZwsY9rWIqan3JayUAF47X34I9r1DZwn8X34UWr4k
	A3W5Xw4Fvrn7ZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjvD73UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index e88b5da15c1e..6d0f829ac3ad 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1437,7 +1437,7 @@ void __req_mod(struct drbd_request *req, enum drbd_req_event what,
 	case BARRIER_SENT:
 		mod_rq_state(req, m, peer_device, 0, RQ_NET_OK|RQ_NET_DONE);
 		break;
-	};
+	}
 }
 
 /* we may do a local read if:
-- 
2.25.1

