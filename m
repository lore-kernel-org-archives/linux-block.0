Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962735CB8C;
	Mon, 16 Mar 2026 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701043; cv=none; b=Z0BUnYT8D84N6zCc0765U4mnqTiYqVeT8m3gKyI55WG8AfFab5vD/31Q0GScEdDZtRHNf/jx6jPDUBLrrqhG+XiGtAnP45bRlsHy4mxX8SHQ6rRCXQqEZhoG2LtZnPneC7n729njj4Bf++c1mWk9KTScW6FynxRAoYC6dMpJyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701043; c=relaxed/simple;
	bh=sH5PzzfdUt96NHCn8efy973Ql+Lksj3d967tXyztZXU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GHrgK46qlY0dt2ljMv7NJ7V4IPaEzrP419mKbrrNQytMNTYPOg2rtii7+8gQlb9LWn2GHoblbhz/hZNwy0BSFwA4afV6YEDWPk2Kxe3BBTCYo+ACj9tkVV3+dfz51lbAUaReGThyh+I7J4UAIT+I0/j0Ghw9HybBlrP15w4m2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lXbwmqYS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lXbwmqYS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773701039;
	bh=sH5PzzfdUt96NHCn8efy973Ql+Lksj3d967tXyztZXU=;
	h=From:Subject:Date:To:Cc:From;
	b=lXbwmqYSixhKKmzUgrKLALdgpnvlsodD3XH442laQ0akPyePSbZE5wXMp2cc+IWSd
	 VQY7sp/OtG8UP8+zXAHfUAaTRol+I8PmweyDKF8Jcfbtv08F37+sSUywmyeRrFPylO
	 RHKhByz593GRGKg3q/Qh/ZbssLDmfWutD489D4Jk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] block: make some sysfs attribute instances const
Date: Mon, 16 Mar 2026 23:43:50 +0100
Message-Id: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7SS0VG25imFR2qk2GsBOJRrC3
 W1g4cbl+8l/bwGmFImhrRZINEeO41BAHCpwNztcCaMvDLKWx/okNfYK+cOB0Y0DZ7Q5J+wfo7u
 jcdY1ZyNkoz2U/5QoxPfmvnQ7J3q+SiLv46/QVptfiD/ycpuQjBLKaOmdCu0soVvXLzpw2ya7A
 AAA
X-Change-ID: 20250628-b4-sysfs-const-attr-block-9cac3791238d
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773701039; l=1398;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sH5PzzfdUt96NHCn8efy973Ql+Lksj3d967tXyztZXU=;
 b=G6V995yCb9BpvDE/wjrInskM0so1eGQwxEtOLFS4um9ifEKq+CQ9Pn+wQ5wxaWLVjUOGqEwzF
 BUnBJfrYaIDA1/7paonQzJo4my+9Wk3xLetT9Y5eDu751UOyPnL3s1c
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These attribute structures are never modified, mark them as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      block: make queue_sysfs_entry instances const
      block: ia-ranges: make blk_ia_range_sysfs_entry instances const
      blk-crypto: make blk_crypto_attr instances const
      blk-mq: make blk_mq_hw_ctx_sysfs_entry instances const

 block/blk-crypto-sysfs.c | 40 ++++++++++++++++++++--------------------
 block/blk-ia-ranges.c    |  6 +++---
 block/blk-mq-sysfs.c     | 10 +++++-----
 block/blk-sysfs.c        | 46 +++++++++++++++++++++++-----------------------
 4 files changed, 51 insertions(+), 51 deletions(-)
---
base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a
change-id: 20250628-b4-sysfs-const-attr-block-9cac3791238d
prerequisite-change-id: 20250114-sysfs-const-attr-prep-e9414982dc4f:v2
prerequisite-patch-id: e6bb942ab01bd8ea292bd728798170c9331fa3e7
prerequisite-patch-id: 233540a50b602b30a5a10bcaeb71127c416433b3
prerequisite-patch-id: 1a16da4318d82f598bc0b35932c9184f714e1c16
prerequisite-patch-id: 1b7ad00feff741bcb64df61a21af65f165927f8d
prerequisite-patch-id: 7a197a4d1524884a2c75a49f019f3b4535b2243c
prerequisite-patch-id: 9112b35d2ac7d0ae6f9f1cf5d2634884590507ab
prerequisite-patch-id: ab160b8b4f60f53923208365403102303f6390ff

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

