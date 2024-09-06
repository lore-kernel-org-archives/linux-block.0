Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF41D555;
	Fri,  6 Sep 2024 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632128; cv=none; b=iio/hcAKAXzc9cd0jXfR88fkJEYaM+hvum111KqEwb3nAW8qa7WNzrkzvicGdB1xfAIyrjyTjwWPpdjGxp1emM/Oy27nWE7O/n/5y+mMA5s6DNfSuJhMl0d+GsPpNBZRLKfkNYsruWXIWcOwFUKucQA0khCqYhxYynqMqKTS35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632128; c=relaxed/simple;
	bh=5/009keQ+OSK+mhfdXTK4s/Va9Gcr7VoXgKpMZahAg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lCc3vuxnrOafGsQuxGcLDCkxP5HD9Ugn5+8zVI+jt7Mf9o58v9o6TGUpFaiTepQBVIC3nePwaKMASWy47osDQC4PXjw82qi7WNwzSgKBYRQTHS/Ddsnf78HbkF6irszGKWqa7w6zk0QBhNXHgxII5VnzniDewtcyZ0mtC3CvzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbtT8Glp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FLRZkBxo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbtT8Glp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FLRZkBxo"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oLjDdNiTD7emvN20ub37HRS5DMVqv5ryOW8f9nOtuAc=;
	b=AbtT8GlpFpMFyPzO2BoraJKOa3lJeBJGJ4dy2g5nW8veU14KyINPCw482kAG6w3Lkqsx55
	U/k+RwhOdHNN2q6lbU/pNZ10Nq0DGXT6+82tOQE/zSDSdq2ZjDb3tzD2UwDxg3RoKt5mub
	rXZeNwWyLRQZ21uedC+0GFLZAZZ2O9Df+Q5prSZ1EQBm2a8A7pmaKOZtYSAeFO42w0oOc/
	R0GpZcwWcy+3S1pn1m0VXIIQVx+7wkWdsSNET6f2Rgr55f0lmRG6KTAd4nve+mgkFPkI4A
	pj0J+oOjA1A8SFC/+72zbE7qsk4cKn8fUFPqeUDUVUvE9wp5NBaUVdFvT2qvtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oLjDdNiTD7emvN20ub37HRS5DMVqv5ryOW8f9nOtuAc=;
	b=FLRZkBxo6UkdtD61Wopk9SUSjnAWWOmW1h1GOCKg5WqM4evVyOWXJChygc7/r/sFjcHNfR
	ePMoqQs4WWp3OxCQ==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v4 0/3] zram: Replace bit spinlocks with a spinlock_t.
Date: Fri,  6 Sep 2024 16:14:42 +0200
Message-ID: <20240906141520.730009-1-bigeasy@linutronix.de>
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

v3=E2=80=A6v4: https://lore.kernel.org/linux-block/20240705125058.1564001-1=
-bigeasy@linutronix.de
  - Inline lock init into zram_meta_alloc().

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

