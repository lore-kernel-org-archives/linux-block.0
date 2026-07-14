Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EF2E414;
	Tue, 14 Jul 2026 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038394; cv=none; b=cNHECoUQhmxjcDrT59dPhnHpSKonVFdeIHANelnib8fANTQxrM1wUHJy3u2qUouAkLaxOohMnT9wOkwG0PhHfk6TINsn819xijNIMi987gU0eGdlqsR2Dx2AMIC4SVtR6TwFAXByKDuzafohO8FsDv9dfdGs2yCTyffGjL03Cs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038394; c=relaxed/simple;
	bh=itz8NZebyCxW+9WAjAbrXu6cnvXyQHBitp2JqN63+TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7Ftits2/fQbyXVpMZZ5RoyFtglYruzweLlZ3OH7DqaYd21nihStgRTPbe244zlzBKetsBNxXpBcPcetpf8AEJl1Q6YcQmJzeicmAdV7OHKuXIn9zgAxJH7iRwQcV5kXhb1oPo26am1Za6KJEIJ4nmgsR9YpfvyPbKiFZWzkEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=quWLUj11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HYfYMxv8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="quWLUj11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HYfYMxv8"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784038389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T2DXny51Nh1rgEsSJgEqCUm/I9JDn2RiZBU3zQu58Rk=;
	b=quWLUj11OcInwxwtGmPegpcRHSjq53X/sLIDS9i4KcJhYBN5ENuOM+lWrZsKFjfWU3t4fX
	Rn2mJ2xOmtDQ7sm83ZdZVTxMxSJ+o3c36FWufAtB8Evn+Hxnfkdzm6i7k+T7UHpGNbogSM
	eAkhCZpmh9rCiAbv1zmWYAF9q/oaGoFkY26yEJryV1pQUm/JhLE9wxOMTzPp7ih4qd335F
	TQ8lIiGAbkoIxIV6tvTaAnmgdt6JgUepx6Iq+ZPXBcA8MsHUMNSH12DEJg2m1+ByfpiDHS
	yhahwSixw4GIsm1cJlExXpfdd7a/nICVfqwPk8Tn/zsnYKz3dc9L+tuPLCAijg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784038389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T2DXny51Nh1rgEsSJgEqCUm/I9JDn2RiZBU3zQu58Rk=;
	b=HYfYMxv828hvoA0XI0BbsqGBAoCLwsPH62gWF3qv7OTRLq5esWJBuNRFq9vmmnktP4Jfnf
	GCXfnATXMw/sYBBQ==
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/2] zram: lockmap tweaks
Date: Tue, 14 Jul 2026 16:12:58 +0200
Message-ID: <20260714141300.3945672-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sergey, this should be a follow up on=20
	https://lore.kernel.org/all/akza1qtgHm7zbjMW@google.com/

Could you try if this does what I claimed it does?

Sebastian Andrzej Siewior (2):
  zram: Move lockmap to be per-zram instead per table
  zram: Use a custom key for each zram object.

 drivers/block/zram/zram_drv.c | 26 +++++++++-----------------
 drivers/block/zram/zram_drv.h |  3 ++-
 2 files changed, 11 insertions(+), 18 deletions(-)

--=20
2.53.0

