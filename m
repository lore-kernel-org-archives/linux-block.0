Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FA483823
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637933; cv=none; b=hKoNukyfECcrDKGKJHcK5otGu0hGmMX6ZyTXZFglPs0QuhwesPN+cp/ctwGX6QrUR3k1I9euNMwzUX7KheYfWcETDiY2mE08B+MW907gp2c4wvMMDVsV8YtyMo2xTIajnYwbY9MY6OsE6IUy4b60zqvMNhb470bB2Fcy0dW7f1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637933; c=relaxed/simple;
	bh=OP3gXS/cKnDMuGwyN+dJxR9swX8DB+gmYxSNKdvG7AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olzmBB6kK9v9s0KLWGYyWytVpksBqLfuqk4qucv36sHOx61MoyJyiorbEyODUQ393D2d2CCsowz+dqgTYGLSflETxBFHQd7dE6lhZOV2gVWcdBGXmRfnssfH4+RUqyNLgaWgS0rwg2v01uA6uDNBHwYWUO6h/ePoL1ufOWOC3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgnKaL5i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgnKaL5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCD51F00A3A;
	Thu, 13 Aug 2026 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637930;
	bh=Cfc3oe/sp9rVQTF27wnsW90KK1EfpngfdeMHzTaG3+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DgnKaL5i5XMItHvCmJdL7qyxNd8ulj4bTA28ghELBHxVttZuuc1+pDi9Vyl6FFDoO
	 5ZzBOLAOc7XWsBn3tEa4RectZDQvt2fJ5mJU+Fm7SdZT2BhvmwkyX+rianrJmVsPDN
	 R60zRwjqhRMeqp+Mo8FZsxI5dkGpGAFxaGAaU2/CBj8KmB7rZoGjdmkDK6H6yTrusv
	 XUrAZi2EB+Cidq5WJHfX8qZvIHgXyhnPWCRpFDJy8BEHJQKxYAPIXrrqbxKYu/gFZh
	 OyxK21S4ZO1gI8V23jp5eOtJHxcMPzXRu8syO7XzyWJURjJ/yqY4xmAzlc4LHutRAp
	 cSYb3z1QUmECA==
Date: Thu, 13 Aug 2026 10:18:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	syzbot+cc0de396bac84da51919@syzkaller.appspotmail.com,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH] loop: Fix recently introduced lock inversion
Message-ID: <an3uafT_p6VOdP4V@kbusch-mbp>
References: <d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org>

On Thu, Aug 13, 2026 at 04:14:20PM +0000, Bart Van Assche wrote:
> All block driver code except loop_set_dio() calls
> queue_limits_start_update() before it freezes the request queue. Make
> loop_set_dio() follow this convention. This patch fixes the following
> lockdep complaint:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 7.2.0-rc5-dbg #11 Not tainted
> ------------------------------------------------------
> losetup/2924 is trying to acquire lock:
> ffff88816c76da68 (&q->limits_lock){+.+.}-{4:4}, at: loop_set_dio+0x318/0x720 [loop]
> 
> but task is already holding lock:
> ffff88816c76d430 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x1a/0x30
> 
> which lock already depends on the new lock.

Thanks, looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
