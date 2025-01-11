Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311E129A78
	for <linux-block@vger.kernel.org>; Sat, 11 Jan 2025 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736576882; cv=none; b=fEEkT7xHSWkldHAKVDVeYky2ZL2lQRms7NGMiU+U3R5Eb6KvB5pFs6G9qbIGtVOm4ND0bRR0xuJEIiX+Ie3CgqLU8YXh0yC7Acs4dO1sBk5QbYgv9LA8P+ncZ4KBsA0S43M35Msnh1j9SLsZV7xzNEm0GBLtwUOcBJmi3Tbppdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736576882; c=relaxed/simple;
	bh=Ex2plrUMn+L/qLKOHWGpC2CFFaV6KbU5qncHtiErq9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qmte5wQ0Xqvoym1+jP2ZvQXu9lxHwUPf5QZuF7c80yaAnk7GzRzOSAuYZdh8QKWY2duX7TpaeGpsZEEvMQWtk/GN/Irj8SWuYGSSCaoL8ItxMDtVb8/TeUe9wo7WdGcHiemVkNbaUR15yHZkLK0ZlSPEU4Blx5xDwI/Ss5PodTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qE6DyCzI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qE6DyCzI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=oR0J1yJ3iMDsAYZn016AHSObSP2Ip6FoC6wkatQksY8=; b=qE6DyCzI4YJEkaMceiNe0Hjgjd
	dGTXjlWYqRyESESuGPnIlfQL2rjC14HzXC8u27Wj98ATclSARGWMbqEY6E4kMsbKp7kC+jHFu4YOt
	ubAOhWCipsPhaR4Ob1Vu5WREVOkH9UQ9wNbniprnxsXQA+4Lri9vUezd+ceglVMVII+LeJtf/7DKF
	RoxZCZm2mL/VCToLeELnB4wj3Bxcf9ErjzFBDxwnoqw9Gh2N4fFusRl5OL/5e0hGfdpWoFSSx610m
	RpFkmhJgn/YJ9nySj9NCtjmcNEpLAwIawEhdRUrwNlfoXaBPfrJZq5tnrfmK/8haUXMZ8ezTsYmVX
	rLHN8sAg==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUyV-00000000H5q-1uMv;
	Sat, 11 Jan 2025 06:27:59 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-block@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Richard Russon (FlatCap)" <ldm@flatcap.org>,
	linux-ntfs-dev@lists.sourceforge.net,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] partitions: ldm: remove the initial kernel-doc notation
Date: Fri, 10 Jan 2025 22:27:58 -0800
Message-ID: <20250111062758.910458-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the file's first comment describing what the file is.
This comment is not in kernel-doc format so it causes a kernel-doc
warning.

ldm.h:13: warning: expecting prototype for ldm(). Prototype was for _FS_PT_LDM_H_() instead

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Richard Russon (FlatCap)" <ldm@flatcap.org>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/partitions/ldm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20250108.orig/block/partitions/ldm.h
+++ linux-next-20250108/block/partitions/ldm.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * ldm - Part of the Linux-NTFS project.
  *
  * Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
