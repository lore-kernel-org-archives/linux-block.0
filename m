Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724E27B4E2
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720856; cv=none; b=kn/X1q4drLjw8jntyfpRoc5Pg/p7lm6qf1yR6DwQ+ztw6gNA2H9ETiQ43n47FLosBxrA7OZTW2vRdb7Ce0OpFOOuN/euHiykq8HaOFrFY8dPj57AV2Rrd8zLNQ9hwaeK7Gn3FpZ+ZrW5oSb/wV4PQ6BrZE/IkStlR5hR3aD3NbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720856; c=relaxed/simple;
	bh=MtFzcLugXYZj1qlG+xp9Qx0bVPoSmqXuvhOtHbpexEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp3ih4mz/xsyDShXa9/oc4pN7NdZvUSSpQTj+AwzKdJOxfHD2CTHOvK6qD94l7tV1oERCmt0KqoEwDo1gaL7cDRnjUftZPoJMkZfhTKbABe6221GoTDXoMx+ZUtHAWvZv+eICNXJ1L5gyr0LRBZ9lr5h1jmWFUXnwgbdeXjaIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOBWKKA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOBWKKA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42227C4CEE7;
	Thu,  8 May 2025 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746720855;
	bh=MtFzcLugXYZj1qlG+xp9Qx0bVPoSmqXuvhOtHbpexEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOBWKKA94rcufDELYCdIUo3YjCWatG80OkgzrT4EN21y4cw9MUOk/1xP2mVPSNMNR
	 mw8zfG/1rZVmNKloFLEQ6FOpPDY2Gjtp935DqVD/qbgQkP4tc0IWhMWGrbJX3KBbqv
	 wFjWc425maSGgGn2Q7C6IM4/h0lEu/MbZmfESXinBWUAeF6e8sZe7WDIFxAGTYIdWZ
	 3AuRa+Uw1keNt2kM4MOfexXfUaUGMZQZ7R7XpX5ZiemrOHgCwt3aoo+YS2wX1zUJcS
	 YQQcYKi3hegvRa6Mk/lT/3O270BkVVwQ/03vCjGLkjJSxWvwHFzIm70uqbH0TZPYNv
	 k7ts3i6LstiBA==
Date: Thu, 8 May 2025 10:14:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
Message-ID: <aBzYVf3qZkzgFAgy@kbusch-mbp>
References: <20250507191424.2436350-1-kbusch@meta.com>
 <20250508051233.GA27118@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508051233.GA27118@lst.de>

On Thu, May 08, 2025 at 07:12:33AM +0200, Christoph Hellwig wrote:
> > allocated and attached to the bio entirely. We only want to suppress the
> > protection checks on the device and host, but we still need the buffer.
> > 
> > Otherwise, reads and writes will just get IO errors and this nvme warning:
> 
> But to a point - the metadata buffer is only required for non-PI
> metadata.  I think from looking at the code that is exactly what
> this patch does, but the commit log sounds different.

Not exactly. If anyone's intention was to use this specifically to force
nvme pract for those special PI formats, then this patch would change
that. The driver would just get an unchecked metadata buffer instead.

This is more about just preventing the kernel from sending a request
that the driver is going to reject. Like if someone mistakenly messes
with these attributes on formats where PRACT doesn't work.

One use case is like when the kernel started supporting PI offsets
(~6.8?), and that broke the upgrade path since previously written data
wouldn't pass the newly enforced checksum on reads, so we need ways to
disable the checks.

But since you mention it, maybe someone does want to force PRACT on the
generic read/write path? I considered it a fallback when the kernel
doesn't have CONFIG_BLK_DEV_INTEGRITY, but we could control it at
runtime through these attributes too. It would just need a new flag in
the blk_integrity profile to say if format supports controller-side
strip/generation and use that to decide if we need to attach an
unchecked integrity payload or not.
