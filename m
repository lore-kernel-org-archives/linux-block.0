Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435F1A3BD8;
	Wed,  9 Oct 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485795; cv=none; b=p+Pow0xMMstfaUZAK2ghEI0vzX7uY17eNeY5CKhiumP8KG9BVtGUsDF61CgiITOMcPK4VEKRDCrxWsxhX1cx3uBiwVPYIVfh5qIjeDHk7U9gs1WVPkQFT0QXnQxSlhuUoXw/o74EuoY4n4W3F+Ppjw3mGsXpV3SdqhFXFd8PPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485795; c=relaxed/simple;
	bh=VRU+FuIHtHFwHpslUJLbxF3s4z/fvcd2THOG7jtM6Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr2WnoM7z0OeONe5Cq+GfM5FRQtp2d7OZkwsKon5qMoc1cmiVl6pkd23s9TjNTqGKUHwgIIQQ7VH5EwdbAShPOkXhrRPk2O7XylnQQ6htZdByI+LqSaWuLHchLRtBy3QBoAEXHwvOp+VgiW+Mk5YuTU3Ut9qpxXdW4VDiwssc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBQPSSQu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBQPSSQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06566C4CECD;
	Wed,  9 Oct 2024 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728485795;
	bh=VRU+FuIHtHFwHpslUJLbxF3s4z/fvcd2THOG7jtM6Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBQPSSQuGXnhNouT2yHeXSNQ3z68kVKRH7uuaFD7KzOyLBYx9UqO8lsAest8Y2QpK
	 q6yK271Lq2I/K58I1REoRaY8fagwLLh/RVPmS3DAEbgHswUmwK4R6v9ov/58EY8Tyh
	 eqf+lzmJftOlPwNuGsrdsRp+2Ln/LvvJbWIKHAQBZ6Ex6Fc3yA6uhXbc03USVuqy1Y
	 ST70OEqKJAItLvKjJ8ArrpfaAjbaJMx7LgiHTBxXClAWwgscZsnT1NM3OqIEgla6KR
	 W1xZLPCWfUsVbXoCy5d2+UeTzC7TNpxTyJmi9k0y9JUY8TxY2tO/UXroAoXjHFRD58
	 CR8TiTGtLvCHA==
Date: Wed, 9 Oct 2024 08:56:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>, dlemoal@kernel.org,
	cassel@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
Message-ID: <ZwaZoJayzu6XZom1@kbusch-mbp>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me>
 <20241009074611.GB16181@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009074611.GB16181@lst.de>

On Wed, Oct 09, 2024 at 09:46:11AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
> > However, the independent namespace data structure
> > is mandatory for devices that implement features from the 2.0+
> > specification. Therefore, we can check this data structure first. If
> > unavailable, retrieve the generic attributes from the NVM command set
> > identify namespace data structure.
> 
> I'm not a huge fan of this.  For pre-2.0 controllers this means
> we'll now send a command that will fail most of them time.  And for
> all the cheap low-end consumer device I'm actually worried that they'll
> get it wrong and break something.

We already send identify commands that we expect may break on pre-2.0
controllers: the Identify NS Descriptor List.

We have other quirks for disabling specific identifications (ex:
nvme_ctrl_limited_cns, NVME_QUIRK_NO_NS_DESC_LIST) in case something
really break certain identifies. But I think anything >= 1.3 should be
fine: the CNS handling is well defined from that point onward, so we
shouldn't make anything harder than necessary from assuming someone got
identication this wrong.

The only pain I can think of is that some controllers increment their
error log count, and SMART tools creates unnecessary alerts for that.
