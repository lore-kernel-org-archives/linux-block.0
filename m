Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C621B134755
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128299; cv=none; b=F7hFqppn56/Z8/JBdV4bjzvEjFOJuMbbKtocd0dw7rjglm+Tk3FWOFM8tkIVAzZYUS/pWk/yXMKNb+HIv7kOCFDhwgsKGkXeccZLvh3Jn7qCPVxUT7by9RBLt4OZpgc0kAK1CWn7vJ5b6JfYUTKjY5yVgc/rFUjdqwjnlpxnKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128299; c=relaxed/simple;
	bh=1AsPQSfa+CCZVmt1pAN6tP/NM8Q6Th81vvhoOPHTPqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgUVqIEInPTC8uM0I23Yb2PIUYNorQVUETZ+pfkCACoYF6NvpxDLtaj1AAe+v3Lw8vBGXOP9BUnl8kxfFsYxV3eyLRl3/dzFbRBkzVHqIkYwe5KpQBP3B+DlE+uoomhebGdJa+bulXvZbjbWDgdQPUY2wTqVI9DNqS6qwk4yZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=MJrUW4Q1; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="MJrUW4Q1"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TKwbM4wKHz9scK;
	Wed, 24 Jan 2024 21:31:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1706128287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYFwhjCgnw7txyJ6ecIbAsz0+8QuwPq2uRdEIVv6meE=;
	b=MJrUW4Q13qPWknif7MAsWA7JglMVKlBHZSiACrr7W5hKlTWxGs9OQ15M6YIHcHAe0TcbuL
	lX5DVwVlWGFP8s2BDblKs4Jb5wlDOavaAW/zn4FwzFPioWK5IcXF1KnbuD6+iH8hi6kpfQ
	0Pyfhkfr8J86F3UFobhLleAzVuSRLtbMUHT5Vy1Zl+bD6c2a3OT2G/fhhrD6jQzgNCp0/M
	bkI3fFchLSG3GuBfQS2AeitMV3qWKCWxjVH/J8lDV8HA0epFPAXwubJF2+++s6EKkZQeqd
	BcOZzWIB90EmmaCL/FJOjKO6sB5eAJ2gDO7/8Jz8l67Eyfg8FAByr/9x0VN2bQ==
Date: Wed, 24 Jan 2024 21:31:25 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, p.raghav@samsung.com
Subject: Re: can we drop the bio based path in null_blk
Message-ID: <znc7pqdsqkznoszbzhvxyyphmpqbesjh56ygn5xt5fjej4glvc@mcccy2dky5eg>
References: <20240123084942.GA29949@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123084942.GA29949@lst.de>

On Tue, Jan 23, 2024 at 09:49:42AM +0100, Christoph Hellwig wrote:
> As we found out recently null_blk never splits bios in bio mode, thus
> ignoring a lot of it's paramters and having buggy zoned device
> handling.
> 
> Is there any good reason to keep this mode around given that all relevant
> hardware drivers use blk-mq, and the non-so-relevant ones not using
> blk-mq probably should?

The subject says removing the bio mode in null_blk but here you are
asking an open question about the non-so-relevant ones should move to
blk-mq. My input is for the latter part, FWIW.

I tried to convert brd from bio to using blk-mq last year. One of the
conclusion we reached was that we will see a performance hit when we use
blk-mq for RAM backed devices because having tag management, etc was
adding overhead to these drivers[1](You were also part of this
discussion, so you probably remember it!).

Unless there is a mode in blk-mq that can provide a real fast path for
these drivers, moving to blk-mq might not be possible?

[1] https://lore.kernel.org/linux-block/db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk/

-- 
Pankaj Raghav
