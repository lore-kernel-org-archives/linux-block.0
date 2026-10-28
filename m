Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207487;
	b=kqh6cUrFwN5MhU2+cgIhqom+LbtJQdb9BiG1DjUGqPmCYS4FvYLniB1KImRukEyQfWLa
	 cL1g2ONwJJMJxJfQl8luSwD6CzwZpRUC+VqJ5HUtW76ZgbxkpE/tcS8EtMIL1cqbTOqOw
	 graJLb9CVlJWSlTVfoUecFYQcvd8Dyu24Fuus2ixn98kh0kYqldDq9McLWVLQ6H6mqty0
	 wuxwhU6ox+fhyAI0GJS0lwjEo/gVKSG24j2T/j+vE98omPL004fWleVpKqDk6qYivSyir
	 0N0iGLVmwK/8WFO0W2DBaEjbAkIW3AxwAF7mQ0xaIMQmWkVjC87OiE9Gb86zfL41QSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207487;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qzMUKSYsbcfXgTX8K+fCn11HEhfkvTxGnMtfNLNX2YA=;
	b=T2H1F4XZq5/id2b8OnuJbxxBypKd7uFfWFOsPO3Cx5nfO3vtcFn18314EDGiRW3KL2Cj
	 XXnM+dvmkRcsD6VwwOlWHWNsOLdGdfbRLsYbaS6+i89/yzv+FIQNMQHzepIM10QlC1GCr
	 fw1N1axac7VMpgmGEJnabySK+FW+3AEe49yHvE/cjognzhBJ/B+U89J0RD1VUQY+x6U7O
	 zzWYbka6hVqmY48m1f/miLVYVNSAjnnExxYtIH/F+FzirAL/fSQpzc19XPzuyr1W+AKfC
	 DVtKxykhbn3HyfMzVkctvjYd1aS/a6sVjGYUdHuUY60hwA39g3ZXp4zFPuC2zDXjhug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ5Tg3qa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C900606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ5Tg3qa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A271F031E3;
	Wed, 28 Oct 2026 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207487;
	bh=qzMUKSYsbcfXgTX8K+fCn11HEhfkvTxGnMtfNLNX2YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VZ5Tg3qaRucKJTjZSTkNeCxihXBEq9abRJ/+Y6IsQ7BmgOtw/6WgCh0jJoroOmfjr
	 awD2jF30QAX0HSdsuAr0y3PMwE3L6O+8I8JCp8S8dJHRtAPrtuVhAvrYgipar9RAJB
	 zPJHBgwdYXIiv9ToOEYHbXC+hCAjTn20ur6aq9YJL/LrdplIM7OON2iS6Tfq6qUada
	 GIL6eOoyXWh/VuechoobMYj+lSiXbI7zWWMZfPAShiLXsftoFcL8R9GhXrNhe5X5zU
	 mTDlcetIHQI3B/0QJh0Da4wgtsfyGlvSMDwwchyG9UCyFX6Lewh2piCTRqfip3CXQX
	 SpPKt1ehTnDnw==
Date: Wed, 28 Oct 2026 11:11:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCHSET 0/98] Various block related fixes
Message-ID: <auIsvfMs114ndVjT@kbusch-mbp>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>

On Wed, Oct 28, 2026 at 10:41:03AM -0600, Jens Axboe wrote:
> Got a giant pile of stuff dumped on me, and went through and did some
> vetting and, particularly, commit message rewriting to get it to a
> somewhat comprehensible shape. If you're CC'ed on a patch, please
> review it. Feel free to queue it up, or reply back why the particular
> patch is garbage, if it is garbage.
> 
> Thanks!

Neat! This looks like it is tackling my top complaint about sashiko: it
flags pre-existing issues only when a patch is submitted touching code
in the general area instead of proactively identifying and proposing
fixes to those pre-existing bugs.

Patches 66 and 93 have identical commits from other contributors that I
have already staged in the nvme tree, and patch 54 is fixed differently
than proposed here. Pull request coming this afternoon.

For the rest, lacking any block layer dependencies, I'd prefer splitting
the nvme subsystem specific patches into their own series and they go
through our nvme tree.
