Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5A2836B0
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157313; cv=none; b=YlwOM82XjwXoB/8Umn045kiSR479WV2v9cbBNlhB0zlyrnTOWv7LBm+s1oJ9tmE2n8oNenc0aoyoOoJLIzSxoGOKT/bmXe7CCXe5CevAIIKJ43wKPDyAV+c2cp1tuTMyRjEJqwKC+OC0LfkMjPpEYsIK1CFRT7sbJloG2YuIlPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157313; c=relaxed/simple;
	bh=FokXQSpn/ALpnesxUYr5dJVjQzELagCScsbNsPrRoz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A46SM53N3eJb4umQ3xujEPwmvcBxDOmg9pSFnYDsdpiWUvno7ijCwFxizq5BneB5la99hJ/Fx6UzFuctdkisKXj4GC7s+wXflGFeVTEVhEJO+jbjatpxM/+dwHJ+5cHB2ptecsdNSgl32yOv1tc/8O2JPQ06vEuzMNxqHyqa2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsRlOoB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsRlOoB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BF1C116C6;
	Fri, 27 Feb 2026 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157312;
	bh=FokXQSpn/ALpnesxUYr5dJVjQzELagCScsbNsPrRoz8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AsRlOoB2wDkUG0KPemoDE7hnaaihoFeaQIBE5HofSf2GSyZQ2TRf9VA8613gauJuG
	 w7O7I8gSBZLLwvDYpE0gFJ3fX/jRsnF5HDfg/78/Iu6Cru/Zf9lkcd3hOGw4Q+Kgff
	 6FuMP2E1xaG3zbHC/lQUbODS7tG7m4ZZc2oYOqY94LLrZ7onNEqJAuJZ1HXdoRaJM+
	 BJf9wa1dVfa9BuKAtQdKUMdb5tSnZsikic0cIVnAFxkjLmGrnBS9540dKSz4ikduMv
	 34T9R7PETVZXdZZMlmeK/RKHNTLk1S4V3deYbLP00Jhu6UDNF5DV1CyVo+DSdf+Wv5
	 vlY2nZF1WdNhg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v3 8/8] Documentation: ABI: stable: document the zoned_qd1_writes attribute
Date: Fri, 27 Feb 2026 10:49:51 +0900
Message-ID: <20260227014951.2327711-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227014951.2327711-1-dlemoal@kernel.org>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation file Documentation/ABI/stable/sysfs-block to
describe the zoned_qd1_writes sysfs queue attribute file.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/ABI/stable/sysfs-block | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 09a9d4aca0fd..bc3056af5eb2 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -886,6 +886,21 @@ Description:
 		zone commands, they will be treated as regular block devices and
 		zoned will report "none".
 
+What:		/sys/block/<disk>/queue/zoned_qd1_writes
+Date:		January 2026
+Contact:	Damien Le Moal <dlemoal@kernel.org>
+Description:
+		[RW] zoned_qd1_writes indicates if write operations to a zoned
+		block device are being handled using a single issuer context (a
+		kernel thread) operating at a maximum queue depth of 1. A value
+		of 0 is always reported for regular block devices and for zoned
+		block devices that are not rotational devices (e.g. ZNS SSDs or
+		zoned UFS devices). For rotational zoned block devices (e.g. SMR
+		HDDs) the default value is 1. Since this default may not be
+		appropriate for some devices, e.g. remotely connected devices
+		over high latency networks, the user can disable this feature by
+		setting this attribute to 0.
+
 
 What:		/sys/block/<disk>/hidden
 Date:		March 2023
-- 
2.53.0

