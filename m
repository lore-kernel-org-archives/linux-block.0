Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9435959
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754434334; cv=none; b=oh3J7ZLqaRg2KHw2W2Q+wLhhn7vfjbCdMou+Ct2Qsro2EoAnRzZvuGOzxfR36gPcqr/Y2xYoveBcViLoDup6S/1P/t2KsPNdkP0E4Ws0e6A9aKpvXDIrNEq93YDCApBY45wiNN0ERr0L6PKoXg7W8B1jVTLKUf81gryrGBRszJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754434334; c=relaxed/simple;
	bh=UXadAyFtTvjoHFaZZBoRwpIr7lKqKdukrW5AUWOJmYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+OyLPjqjAO99if6gyfAk0Xpm2Nh7VIo49/SzF7moJcWP2naSdFZApzMc8wspiCX26CMSY+an60eT2umz6dyifeFn7y6hf2Io+9FRMjAcmTd7gGxfS7COXpPeGhiXEz9yq2jkLq/ZXUOMiMoBm3aNe1WL/Aze4b7oNCkZsAispE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDMOMMcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDMOMMcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBECC4CEF0;
	Tue,  5 Aug 2025 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754434333;
	bh=UXadAyFtTvjoHFaZZBoRwpIr7lKqKdukrW5AUWOJmYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDMOMMcFK5OQFTfpUzpGSgJFxyqXibd6wd+xQUTanSx2nwFFvc5A+utDElfDPcAhl
	 nFkakD4urWVsFe7uTQpHXSMQgvUOPV0iFigM7gnwQEKDw2YOvn+IdilqbC+4v/U1PE
	 BSLKuf4b4UE/eKNJixGWMia5UY+60IVg1cIfxZ0mpnq2IJEZaITO9t5hwkszgv1SBG
	 ooLuX833aP+T9pVMEoo7FvXbAt7T3Ymhbl2TG2O0SeefsBTo6h8aQQXbvtSGZPh994
	 UVmAg7XNCLtRDys+ho1hguKxWNw0WWoaj1xl9c0V+S1m1Px7y7ZLgK0u6TGxHdSJ+y
	 pDgLOgdYLRB2Q==
Date: Tue, 5 Aug 2025 16:52:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJKLGy9UkVjJTIIQ@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805195608.2379107-1-kbusch@meta.com>

On Tue, Aug 05, 2025 at 12:56:07PM -0700, Keith Busch wrote:
> +	bv = next->bio->bi_io_vec[0];
> +	bvprv = req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];

Hm, commit 7bcd79ac50d9d8 suggests I missed something obvious about not
being allowed to use 'bi_vcnt - 1' for the tail bvec of the previous
bio. I guess it's some stacking thing.
