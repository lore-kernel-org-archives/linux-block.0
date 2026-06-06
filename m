Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25D3AA507;
	Sat,  6 Jun 2026 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777634; cv=none; b=Wnh1sE6k1FQvrye6U+za+aY+6nOTVFboYltEiRFDY1PeNteow3n74k4MwaGbRYCnWXbarNhYBXqrKtA9YO4+/vRJLNgPDQi4EnFn9CZMVP7r2D5R/tt2YThA7w2V2yI5LQqwp7K0bSK7VCHGrVwRUJoVCSMeNTIxQllID8mIGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777634; c=relaxed/simple;
	bh=R3H4Nm5GY6hOViTdz1W2dueMBBuEo57Z0FQZ8yTbK1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hGo9dR0BCwZzHDhXvaa4oBFpXdJRtBXYKTK3EcTtZG37enCOv/28FAf/+BQJWpefzjhZFSBM+gkntYQ9YGkzYwpkSZr5nnIyHNVKsYoRma3PoVBSA4VWSgKa3vQewGFv80GXBPEoEkVYCXMyOqtzi22mHfbgPlgH3Bi8P3E6I24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=OsavbeHr; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="OsavbeHr"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbq-007NPq-KB; Sat, 06 Jun 2026 22:27:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=VB6LGWBOBKZK7RdnDMyNXA0acdHX2HSe+usGRca51YI=; b=Osavbe
	HrnlFBrRqHuE+5Ofn+svghz5Lk0pLKOd9Xb57T9+9qPg6lpcq9L0PCHi7Th/FEyCfDYRTTPMIniqM
	ltsUn3cPZFacieJ2R6M8dZERbhqtP1hkZ4BXbzxSH2uclbdDylOLGqM6l8IllSeyddURDE8HleZm+
	ABhCXZ5zyGtEGugB6lx6GDRj8y5/clEZxlhG3AFck0/dRX2r6+qxhG4EfZZTCts+3yv1iYn/U/R9P
	Lzijg9M5Rzq6SqhBqj0IqlvT2bDluBpD1NtWtXRVjmrd2e2M+2EkTxFUoObm2BvS+3/7eUC5hXdwo
	4ojLJ47CE483QkeVTUr90+AQBnyA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbq-0000t0-6n; Sat, 06 Jun 2026 22:27:10 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbo-006V18-LQ;
	Sat, 06 Jun 2026 22:27:08 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] block/early-lookup: Replace strlen() strcpy() pair with strscpy()
Date: Sat,  6 Jun 2026 21:26:32 +0100
Message-Id: <20260606202633.5018-38-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Use the result of strscpy() for the overflow check.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 block/early-lookup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3fb57f7d2b12..18ab4a2da676 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -156,9 +156,8 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	char s[32];
 	char *p;
 
-	if (strlen(name) > 31)
+	if (strscpy(s, name) < 0)
 		return -EINVAL;
-	strcpy(s, name);
 	for (p = s; *p; p++) {
 		if (*p == '/')
 			*p = '!';
-- 
2.39.5

