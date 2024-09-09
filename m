Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2E1B86E4;
	Mon,  9 Sep 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889841; cv=none; b=u1x+tJMvPzOaw69KcGXnCv2saYKcGGHjXLDfUauF7STar1EP04bnmXoTuCCxt9QeitMCe4qxOMaOzl4JPRz7sprhwtRyujsTT2mViFGAWwY/TD6g9yz2H83YhUuDb03iXbQMB8wQtymqpIxB2e00ToupWjvZHdtvKtj1Zzj7lRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889841; c=relaxed/simple;
	bh=2D7C10L9qGR1xYUVuRaUwP/lQVaj8GW63TvL3cfW5lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPJaymFPa1TkkUZBJLn9EAgwjMuw2a//B/TTQBAnrA7575IshHwHbjNSbUHZ/HaJOaA/JXSfUzoEVk0l/hK1xxLqJyo1a3YPS+tnsRsHVD7L2hbqdwVWs7Sd/OwLmVItxcDjdti7vU6Vdflefooqpavmul05cHV9nhSgbfTtvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=IMmCe9UO; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="IMmCe9UO"
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 8F129F90A07EC;
	Mon,  9 Sep 2024 16:40:41 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UKXrqmmBMBf4; Mon,  9 Sep 2024 16:40:41 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 65003F90A07ED;
	Mon,  9 Sep 2024 16:40:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 65003F90A07ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1725889241;
	bh=j0w10pqKqsCrw9p4jGmOYSKGwJAYnt8q1qKqtK5tU14=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=IMmCe9UOVK5OEKqqUmeRavJNTsDhR3XSBn+T95wfSCkAxcIEbX1Qxz8IrqscPG1QW
	 UBjvN4VeQ3Rp2xMIa0EO7LVnxxjDc5+yh2tgu+brpqpe6Du4bg/94KvgyBtFpFxXBY
	 OHrFn9bNsqrrarPwPtO6S/qBzFtMYJMB/AOhMd8RvCSYVfzb2uH1/t9zgL/L9U/2ZX
	 OCuic9PS9C+SWviPQqWBWN5Szhg5bf2F1Kbcv3+Yua3HFG6eEtLV495RynplbYh1o/
	 WujCae8+G0v39cGT9ey43xxd4U+aDa6Rz9nLeDHgvF01ejZ3MlW+iHalYSEZ7p7VLt
	 0f3mbo8+yYfjw==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DBj-TN5343t1; Mon,  9 Sep 2024 16:40:41 +0300 (MSK)
Received: from localhost.localdomain (unknown [89.169.48.235])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 27DCEF90A07EC;
	Mon,  9 Sep 2024 16:40:41 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drbd: Add NULL check for net_conf to prevent dereference in state validation
Date: Mon,  9 Sep 2024 09:37:36 -0400
Message-ID: <20240909133740.84297-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the net_conf pointer is NULL and the code attempts to access its=20
fields without a check, it will lead to a null pointer dereference.
Add a NULL check before dereferencing the pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 44ed167da748 ("drbd: rcu_read_lock() and rcu_dereference() for tco=
nn->net_conf")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index 287a8d1d3f70..87cf5883078f 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -876,7 +876,7 @@ is_valid_state(struct drbd_device *device, union drbd=
_state ns)
 		  ns.disk =3D=3D D_OUTDATED)
 		rv =3D SS_CONNECTED_OUTDATES;
=20
-	else if ((ns.conn =3D=3D C_VERIFY_S || ns.conn =3D=3D C_VERIFY_T) &&
+	else if (nc && (ns.conn =3D=3D C_VERIFY_S || ns.conn =3D=3D C_VERIFY_T)=
 &&
 		 (nc->verify_alg[0] =3D=3D 0))
 		rv =3D SS_NO_VERIFY_ALG;
=20
--=20
2.43.0

