Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2F34D391
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848943; cv=none; b=kBhzpQ9jT3n/PdwcIuf4YKUh+xoeW4oLqeoan9Pn6Y+ixZgb/Z/j6dmeRlOG4Sz0HcrWsy29SpHGaQgt1SlNCUV6y4dgZDcw88uFNwxwfRyfqN379qDOeBX361M2eN+ve+q1r9hjq1wx8lO5kzJEaZBsH2a8hm9bishNGDkYhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848943; c=relaxed/simple;
	bh=nPx7EK/DOElmMN9m3wfIuWOoTU//YRsIVEOOMC3+ppk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kj/eSzSD/Y0CjTL1j8ubKXri6u/OBy2/87GfDbzdEq1w1Mdd8KNviSL7+z6gxKn3hXpz8bEe3rsvgm2hN6FGmtsnG/bll6TQBypGmew7HqoSlMrCiaCadYOCahP6zUjG27Ih32DSsasd2gTPajT0Ubjj6otvhH21xtRmLTg9a1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=LmhxAnmJ; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="LmhxAnmJ"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1771848939; bh=nPx7EK/DOElmMN9m3wfIuWOoTU//YRsIVEOOMC3+ppk=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=LmhxAnmJm4BvWfwb3T1fUVqTX0TZIaQSu6J56Gu+wT+zU6ZtGJxyMhG5uTqO2gk13
	 4qo++kAzfdHLOA70yKcjrv4cHf7YcFS49j/69AChAPHwwtRbRNd9+HQqI0IZrKUAEX
	 qXmgkA2kNoAHsg0WkBuwLXJXFrQ0w07paAaedRlRn9R3/8rdTNoVmalpdSxW/uNfUy
	 +4uuo6kP2mwV0Grb/hiXam1VDXgMzgcGgsw26IplvCAb49cGpx2bBA/tHFZELqwz7c
	 GhVlUJW1vhWm2H3vP9M1ZDzQBXZaVlMSnZo+c58uIBjiuXo5th/3g1cFS9/6jDvwEw
	 vtBT6G/g/lbQ1oUEWdYfaaTJ11KjY2H2kPOkP1RCn6brLAemlz+FDUbwEJfxwW4O9Y
	 RNUbInODGr6W+EvLvLkt+2MHn0HZUDBenOwQFyuHg76PEgo8QHZmheNnmu/vDqlgtJ
	 tehhe2W6/rlcxENsb3sDuRtl7Xlm60z05bdgqDBCs/FPTbHPFI83JtVSDhYAZ24so4
	 tc9IUXcfujyNk4BBNNphy096EC/RnOw5kbXspT3Y4TA0lsTExIzeE77oUTC+uQYB4g
	 ofJ7gzwD129NpJOIJE6vtyu9IeWdzzjDgko//kjBWvzbD/Om4u4+WivDFu1ntVGceu
	 UIHu4b97sUTALotrS6ow1Nr4=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH 3/4] ublk: document partition flags, kublk and update external links
Date: Mon, 23 Feb 2026 12:15:13 +0000
Message-ID: <20260223121515.3296983-4-alex@zazolabs.com>
In-Reply-To: <20260223121515.3296983-1-alex@zazolabs.com>
References: <20260223121515.3296983-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add section about partition handling on ublk devices.
Document UBLK_F_PARTITIONS and UBLK_F_AUTO_PART_SCAN.

Add section for kublk to be used as reference.

Update extenal github links - repos have moved to ublk-org
and README is renamed to README.rst

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 Documentation/block/ublk.rst | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 6ad28039663d..168b61098d4a 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -88,6 +88,14 @@ Below is example of using ``ublksrv`` to provide ublk-based loop device.
 
 See usage details in README of ``ublksrv`` [#userspace_readme]_.
 
+Using kublk from ublk test suite
+================================
+
+ublk selftests contain utility(``kublk``) which can be used for reference
+and as a simple server. It is a stripped down  version of ublk.
+
+See ``tools/testing/selftests/ublk/kublk.c``
+
 Design
 ======
 
@@ -238,6 +246,14 @@ be provided in these commands' payload from ublk server. With this way,
 ublk device becomes container-ware, and device created in one container
 can be controlled/accessed just inside this container.
 
+Partitions
+----------
+
+By default partitions are disabled on ublk devices.
+
+They can be enabled *only on trusted* devices with ``UBLK_F_PARTITIONS`` flag.
+Automatic partition scan can be requested with ``UBLK_F_AUTO_PART_SCAN`` flag.
+
 Data plane
 ----------
 
@@ -488,10 +504,10 @@ Limitations
 References
 ==========
 
-.. [#userspace] https://github.com/ming1/ubdsrv
+.. [#userspace] https://github.com/ublk-org/ublksrv
 
-.. [#userspace_lib] https://github.com/ming1/ubdsrv/tree/master/lib
+.. [#userspace_lib] https://github.com/ublk-org/ublksrv/tree/master/lib
 
 .. [#userspace_nbdublk] https://gitlab.com/rwmjones/libnbd/-/tree/nbdublk
 
-.. [#userspace_readme] https://github.com/ming1/ubdsrv/blob/master/README
+.. [#userspace_readme] https://github.com/ublk-org/ublksrv/blob/master/README.rst
-- 
2.43.0

