Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856B1DFD84;
	Tue,  8 Oct 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400432; cv=none; b=dNhIXqVY61PPGJ3gxFDAdWXV6cOyakhl9ljKQI0CmToESaIMbScjafR4Tkt5fB1fxS8vaWjcs3vK+p+83Ze4ZCzqsIskHHsK/GlybJkDUkglVFrwD2TcYo7GnO4t7Kb/ItqX6wBkcsXLHgB2YOeBxjou/SDHSuhfhysiu0F84fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400432; c=relaxed/simple;
	bh=RaxqMyiV7n8pTDKGMindcS0hrojM1IZNbUWaYp1cp34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBFR+OSaze9q9J0nrQdDLjBaXEAz/GHbsFXBTXOhA746ohxHqXfa+1lmyGjftIFKkeEs/N752PSQ3xgfnxYsIrCnjhS66E3kaCASQaCpsSaQvnshjWTyGJzAKQyPCueePmTgcmv3bSAeJ84MmYBcHGKebw1DgU/pK2uEpEXjIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOB8vn8M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOB8vn8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A53C4FE96;
	Tue,  8 Oct 2024 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728400431;
	bh=RaxqMyiV7n8pTDKGMindcS0hrojM1IZNbUWaYp1cp34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOB8vn8MM0fQ1Yzw42fQ815SS4enmVBSTs86VzkBAAni1P2iuDRI1CvTw7nF7QUK5
	 0O9mzE9PF+eaPoCBBQjElsETSjUw6oVjRGU5ccQgEGfMdGj0+B/73/UpYIsXpVRSSC
	 wUNSIxUcjS+fYha7TJCyfR+3Xj3UOIKuPKwqGQgBuhaOa7L5FjO1Nm0Vp6u49J2o4k
	 P72wyCFqo/Lvc44GxClzEtAc5I+bHg+0+R3dYYfCJp1tNqCPFrvd3Rv93ErfksK+3n
	 Vzir4FMATlL3IdtrgZKKuQhDWheeD6ghAGToGRjF49JZZ85ljHpoHrEpuEL9RSkSqi
	 2fFsDTD2TYtKQ==
Date: Tue, 8 Oct 2024 09:13:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
Message-ID: <ZwVMLIt4iFX9MUjV@kbusch-mbp>
References: <20241008145503.987195-1-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008145503.987195-1-m@bjorling.me>

On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> Enable support for NVMe devices that identifies as rotational.

Thanks, this looks good to me.

I still hope to see nvmet report this. It would be great to test this
with HDD backed nvme-loop target.
