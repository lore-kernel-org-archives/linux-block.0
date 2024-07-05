Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B111494BA;
	Fri,  5 Jul 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183864; cv=none; b=WqpdhqMQS33zi0iNX2ehnBJqGJtzQu0XdqUQN0Xzyca68/kyUBcTf93RMYvEmezOkdp8yCeZQdH0kPxaH+OJCkbWahhZg4f/h2R24sBhyss7hYDuPWoyuX6/+w28aKrY+TiAKcHL+C6xh0k98sjAt0YnqCpODLS9zj+isdzx5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183864; c=relaxed/simple;
	bh=vqcwLqVppRivNG9d58H2sbjIO2fXjQX8Aleb/qnFdn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JYwlqW0+g/9AgfOS7b91+KPaDocdIsuFLmgoGrk7oHXkindDwlhM8t6fWTb13oaS9htt0KEnY3N3ZX2M2RsVlg+UqZHnyL15FrY4xiIeld1QHuWJWAUTrmKwOok6Qnk4MaMHCKxnAcakLQClkIx1pYegX7sUseRhZm9jjExed+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jyD83IjX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8UIfu5V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jyD83IjX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8UIfu5V"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720183860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LN3ffcMa+ufsjTIDpcIMpCJTf5ZZVSlO79qg6mbrhvo=;
	b=jyD83IjXJLHtd29C2tdwQe7YbCTyhCU6fvKBhIiNKhgBvRSsMdglk1g//FDv4CHpxvNnH7
	N4RKD3vjG0NRdEvR7Fl4g25nFV08GXvLrcYSmK4WST8v4d9cI8FP0rqrE2v7bVL2YGSgOJ
	g1xK/5ZnR8oOr99IZJnBr8dqV67LZ2Mxw1AJ7+JGkoUEN8B5qgWLo3f7IvylW5avZSXxSA
	961M0C6ovRIMPf853JKomGUh7g12888UcqMVf+cKb92vgN79GB4ClrCsDlpvj4sXCWOY/q
	E+rnTxR0XD3pdaVpaypoD4hfKT0PtH/iz+XzXF/vLdpjbUCMyfRtvtyW6gB2mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720183860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LN3ffcMa+ufsjTIDpcIMpCJTf5ZZVSlO79qg6mbrhvo=;
	b=s8UIfu5VVjsX4H3pzNVXxgqXKQ161INgFj93C8UwMUl184UvJd1HZvaP+V9/RYxq9Gxvf5
	PDV4BBMn92ftS3DQ==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v3 0/3] zram: Replace bit spinlocks with a spinlock_t.
Date: Fri,  5 Jul 2024 14:49:13 +0200
Message-ID: <20240705125058.1564001-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

this is follow up to the previous posting, making the lock
unconditionally. The original problem with bit spinlock is that it
disabled preemption and the following operations (within the atomic
section) perform operations that may sleep on PREEMPT_RT. Mike expressed
that he would like to keep using zram on PREEMPT_RT.

v2=E2=80=A6v3 https://lore.kernel.org/all/20240620153556.777272-1-bigeasy@l=
inutronix.de/
  - Do "size_t index" within the for loop.

v1=E2=80=A6v2: https://lore.kernel.org/all/20240619150814.BRAvaziM@linutron=
ix.de/:
  - Add the spinlock_t unconditionally
  - Remove ZRAM_LOCK since it has no user after the lock has been added.
  - Make zram_table_entry::flags an integer so struct zram_table_entry
    does not gain additional weight.

Sebastian

