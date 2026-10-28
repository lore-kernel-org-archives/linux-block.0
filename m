Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214771;
	b=UVX9LuA4J2Ln4Nj6uElBoYReIfI1GpGi7E3rzznIXqWG2Nob2t3Dd7yNJpYPkKidjXBB
	 sF6T0LW7B0ZovS9iIpQeftsmWZm0bEc0YWjnZNxh2xGFJdQA6JB/5OXL8gWgf8ApClrUg
	 vuBzXN/jbrmEemsR42fXPn85BWswxaG90LS5/RWtNAA/oT9zl821JI+VQlhl2KPHGMooN
	 DxZmqhA50ng/kjfkBqSfPHGOn6uvVhWIlHLu/wwodENj9J4jcxTCsdSU0E+H9TB79Ya97
	 GFHZd8AoeGvAYxhzZVereP9f9cia8dTmYU4W/klxUdwU8n2IrMRH+0HnBGRTqPcz4eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214771;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B3gEUUfog8/BG3LLWJAiAImyKHgEOQB0h9D611qbYgs=;
	b=5jNG6SfCZ37zIKqRXGjOQl4c8a2IHxLh9+NhihHQKRG0BUAmSlP3NDYW6VUCeocT8ZoC
	 iLdZmGjKbWQgapkUNYq/ZKmL0c7YF/VgJRkDJd+JMPfizSVJJgiPD4SndHWY+bE97WzLc
	 R7oPzBqknYHTTFF3tVorIoFQUR9oRHO8u9p2HejB0I/f8n9bU4UtUHzNZVFC/kkFHVgQn
	 zG8ZUuvJacwiXOy45KOGjRd7jP3ymrAeasTNfn8KfZZ53oLt+BtY+Fus47FdCfO+Vmz/h
	 ZtKf8nZrcvMM8NKDC/jo7Jpy613gpNzxbz9+Q1We6AtJnjQwh7bHs3yaa6QJ4iI1zRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYoBw8u+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB057606A33F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYoBw8u+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB41F01828;
	Wed, 28 Oct 2026 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214770;
	bh=B3gEUUfog8/BG3LLWJAiAImyKHgEOQB0h9D611qbYgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aYoBw8u+k6MNHgFvIo4HUrENGG9lbVCLCYJPqrcFtHqAVItuu1oHBVLhImES6no2D
	 ceemRFI9TnSsbxtIpxmpjeH1ZWXZRIRbYKKqOnkWUoOVlreIFYvEA6Fy81mdBBpvhR
	 p0+XCgEYLykxGS0bqQsz6l0VGLHMhI/AKA/Ue+I/Bsx/9R6/WB/CuJm7MkXBj8XVmE
	 2yij/qfL++64nL77dUF6WV69F+9ctkaRYzHIHXQBzYQMkfBDyvZESbxyxkzR/W0Q9I
	 /X4zfvh+Dw2lnFxBJBh1ToR01QKLPB+v2hlLe6VKfjqmOQ14YDvgTYA/hN50O6ggtY
	 6ac592Tyt5tLA==
Date: Wed, 28 Oct 2026 13:12:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCHSET 0/98] Various block related fixes
Message-ID: <auJJMDwye-BadWjD@kbusch-mbp>
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

cc'ing nvme; original thread:

  https://lore.kernel.org/linux-block/20261028164415.1262013-1-axboe@kernel.dk/

I've picked a few of the obvious ones for nvme from Josef and Chris: 45,
65, 72, 73, 76, 78, 80, 88, 90, 95, and 98. The rest want a more careful
look.
