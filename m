Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4442E014
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204294; cv=none; b=cV990T6YhX/1FAl4ke8ajen6J3AbKln10iJ1ww7w5qNr6HasiXfjqkV5jpgTFH+O7U7VrvMW4SZutvQL8NgXzeFBq4cNV/gDlJn65oA5oHS4ZM0BWIo3emJM0vanWEfkCmhr/dQo/23/SNgyIoIH7TMwWmyc2bzq9X86YOa9Yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204294; c=relaxed/simple;
	bh=OkQmPHkGq8QlUgzZh6ugkSwq0QZcfuiW/QTtOjX2EG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcYhwxiskQEzB7Ta+oKq25invKQskwHUxe8M8a271oks1xkITMGsoHmg7Tr5RyKXpkBRtpRUdBwckTG5DbFZVFK/3ZyFbzxSVje9EQFAgGJCDgtnnbKEwdIGCMOMmzaAkSjB58OkBnOhVNrzxcv65vDVqjGb7hYr9Ocz/mZ6hvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=Oq8ZqDID; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="Oq8ZqDID"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1772204289; bh=OkQmPHkGq8QlUgzZh6ugkSwq0QZcfuiW/QTtOjX2EG8=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=Oq8ZqDIDcmHN+btj2JV25axws53UF9b2ySp/Ib3AvTQ/xhh95KlMbSVz+KemXWcqK
	 Xh+SX2p6LUnt/6jiLGQV83ZK/AhcI3qVpH9manzTKY6pHhpI03TXLr7YwH1Tzwg5Sq
	 9iOrhBuaNulcEPXGicG6nXYPfN665YRd81UecJFZgMgcRB7Cw3BwppTN5en2oDS0vR
	 7n9NN5WhQxeIqQaYvYMupz+8TILYPuvgaQDrVf7zLPm8pzf7H8PLTCMiCuwbLGMgDr
	 nt/4J+bTOl004QjnpQ3uxVNHo/kpqCcruGipMn1Tsgek98PJSxDnpUDd4XhDcycVrv
	 vKNDCbYYxD4XKZWVkPRQJFb8p1TwWCLGnAH2q7Zt9hr1QxFEmfcYxh0t4ZgKa0qjxg
	 yeVrmLI7xvmrzOYhfprP2ySpxprwJEMplAdxCK7xm61Oj8pQNigoklTOvEJTFarncC
	 SxX/LT9RlEcVVqNhj873t+KcfKEWH8j9sqQcOeBy1Sasroo+ZBoOQgtE+Sz9QAwibx
	 xSn4R72/PLG/8yEt5IqgWFXuafaCZ2hnv0JnUwg5+4Z/vQILHu3G531g++Na/XPTYb
	 JB6w+l4FbrVsW3C0WwYvOKWW2smwDMjpj3HwK7KfwoCZ++4zGKjb3mRKHUUxze3o/8
	 oV/88dPEcpf15/k+TEPJofv4=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH v2 3/4] ublk: document partition flags, kublk and update external links
Date: Fri, 27 Feb 2026 14:57:55 +0000
Message-ID: <20260227145756.3877069-4-alex@zazolabs.com>
In-Reply-To: <20260227145756.3877069-1-alex@zazolabs.com>
References: <20260227145756.3877069-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add section about partition handling on ublk devices.
Document UBLK_F_NO_PARTITIONS and UBLK_F_NO_AUTO_PART_SCAN.

Add section for kublk to be used as reference.

Update extenal github links - repos have moved to ublk-org
and README is renamed to README.rst

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 Documentation/block/ublk.rst | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

v1->v2:
   - switch fromn opt-in to opt-out flags

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 6ad28039663d..4219b6f51260 100644
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
 
@@ -238,6 +246,15 @@ be provided in these commands' payload from ublk server. With this way,
 ublk device becomes container-ware, and device created in one container
 can be controlled/accessed just inside this container.
 
+Partitions
+----------
+
+Partitions are enabled on ublk trusted devices and disabled on
+unprivileged devices by default.
+
+They can be disabled *only on trusted* devices with ``UBLK_F_NO_PARTITIONS`` flag.
+Automatic partition scan can be disabled with ``UBLK_F_NO_AUTO_PART_SCAN`` flag.
+
 Data plane
 ----------
 
@@ -488,10 +505,10 @@ Limitations
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

