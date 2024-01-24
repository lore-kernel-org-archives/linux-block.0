Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93397E77E
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115600; cv=none; b=usS62ic2FO1py8SLwsw3SoaGPO9wKnHyvvb5MZVevYOoLA9HU0HsUxUoSl8fPgDANYSiREcmTCVsXWD+zL6EofjHW1gnJ2eUjUhqkZJkSlmLSK9/Bk8pbIMZBf6Mc1HEJ3UqrLUC9ZmGN9qoQrpgDSYOzg8kxD3aZItExrUK33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115600; c=relaxed/simple;
	bh=hXGzPTiwioKcSc96+KXT2D0Ks/c8ANCX1++Y+vUEniU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0dyWE0xVoVmba/uo6V7XwWHr2gPBB7TBlDaX7gsM2fSm8ZDgfsotLAL11vOGh2OR00xTarQ8hn5MU+Z8EgFJvMVOPyuestVTYiDEIO8sDky/UnmXqippFKaSgQbm2w1DiX5C46DP81mM655kmo9b+TDKKPsDpntUXGNyX2VrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpRWL51y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpRWL51y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1749AC43390;
	Wed, 24 Jan 2024 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115600;
	bh=hXGzPTiwioKcSc96+KXT2D0Ks/c8ANCX1++Y+vUEniU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpRWL51yr2yLTp71TPIP1Fop/jhdHpgPdcdrk6nJxIGc3touJb70eIylpeofIKiKn
	 30FtWhEG28HVB1QCvOzcma9X/ZGjPUfQ4xFb0jSn+R0xd/ke9BY/5xczlmlQljrmw+
	 92vWkOL2Z9vD6oulG4wt/tJNQV5/eqOhkqrMmmt0+xD6jVYl3sXoSVYYkYqGqKkFcj
	 1OBRy104EQZlH975QRWOC+CS6h73jtFq3pQUEQKf2UjF79JWZ4UHqu/yv8s/wYWHUW
	 OotF+7FKg9mppxwlnZQr0sspyvioRbL5f7LB1vz8ajloF5O0lUA9eYuRPWs5Kl1KY3
	 A13gSOA5kdJEw==
Date: Wed, 24 Jan 2024 09:59:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <ZbFCDQlFXIvpDHeX@kbusch-mbp.dhcp.thefacebook.com>
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
 <20240118072419.GA21315@lst.de>
 <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
 <20240123090506.GA31535@lst.de>
 <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
 <20240124090453.GB27760@lst.de>
 <d63f74b2-b455-4fd4-9b32-2657c6d81588@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d63f74b2-b455-4fd4-9b32-2657c6d81588@oracle.com>

On Wed, Jan 24, 2024 at 08:52:54AM -0800, alan.adamson@oracle.com wrote:
> 
> Thanks, I'll look at the block layer for this.  Do you think adding error
> injection to qemu-nvme makes sense?

I frequently added custom error injection to qemu, though it was always
pretty hacky so I never upstreamed anything. Klaus may be interested in
getting a feature like that integrated upstream if you're able to put
something together.
