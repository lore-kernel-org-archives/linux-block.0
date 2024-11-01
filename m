Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4AA1A2643;
	Fri,  1 Nov 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730501121; cv=none; b=kEGYEEDNduyAXj16q/N7fE7P3Hb8K1QFCSQOZ41LJgU3i6gvFOiLVdET1AhLcwPtFsyWWCWx/9n6fTH9IqncWdZ6bZYYevL/hp692NSpjCStDmjrmoOZGvrScngCUEYinmHgai+uNuSVCZkjRvqeZ2xEbELZ9mHb19aTeDh1DDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730501121; c=relaxed/simple;
	bh=SkEop5/7smK/MSZYAFqBhRctwlHKaIbrZmOShSAg2a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECbfJ4rD9e01UDhh7f7k2P6okRLulYWs/77ZOX2FEPL6Kve+YSTS68WKMUuMSAhZY8TNq+6Kf8u5FqP6GxBLMcM1im9+m3iaDhvtfNap47qFk0tmEcCA75y7ArvdVhk/MJ4TNOlwL2LSBSyUH/Fj/DStAwvwiH9Yu92gWpSKJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV+DKEI5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV+DKEI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF66C4CECD;
	Fri,  1 Nov 2024 22:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730501120;
	bh=SkEop5/7smK/MSZYAFqBhRctwlHKaIbrZmOShSAg2a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dV+DKEI59gzZ7vZ7g6rBWuQ1pBC9BQ08cUWOFgV3rDETROWtZj37bpVQ+IrFlJQdn
	 GS3Wv9smC4PbSHUvCy4oQiCvCiOBoIRoOlNDH7gSRHbDTKni9PPkfw2lBuLY6WOdqd
	 mN2K0Vkf0OWXAdqG+vOscXlNzoPwGGzbqJ1nSWffsAwzA6BrlvrUz+ymq/k9salvOR
	 waad78D/rW6fAjLj0KcvNxoDF4IWZJ6uJp31m3Qs4Bg1Rt22BggwfY7eeCCC5J3x7V
	 lRCqfH8VBEqLXOHDdy7kJplF5eqkVn/bX/KZjYHwqiD8GSSi5axArTyj3Va7whKyG1
	 ad1ZgyE9IsHhw==
Date: Fri, 1 Nov 2024 16:45:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>, dlemoal@kernel.org,
	cassel@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	wangyugui@e16-tech.com, martin.petersen@oracle.com, hare@suse.de,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
Message-ID: <ZyVZ_T4HtnqSWTm0@kbusch-mbp.dhcp.thefacebook.com>
References: <20241010123951.1226105-1-m@bjorling.me>
 <20241010123951.1226105-2-m@bjorling.me>
 <20241011081452.GA3337@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011081452.GA3337@lst.de>

On Fri, Oct 11, 2024 at 10:14:52AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 10, 2024 at 02:39:49PM +0200, Matias Bjørling wrote:
> > From: Matias Bjørling <matias.bjorling@wdc.com>
> > 
> > The NVMe 2.0 specification adds an independent identify namespace
> > data structure that contains generic attributes that apply to all
> > namespace types. Some attributes carry over from the NVM command set
> > identify namespace data structure, and others are new.
> > 
> > Currently, the data structure only considered when CRIMS is enabled or
> > when the namespace type is key-value.
> > 
> > However, the independent namespace data structure
> > is mandatory for devices that implement features from the 2.0+
> > specification. Therefore, we can check this data structure first. If
> > unavailable, retrieve the generic attributes from the NVM command set
> > identify namespace data structure.
> 
> FYI, I still disagree with this for the same reason as before.
> Assuming we're not really going to see hard drivers I'd be fine
> with using it by default for 2.0 (or better even 2.1) by default.

I've got the rest of the required logs and identifications implemented
in nvmet to support this. There's one more issue, though, if we do
restrict the identify to >= 2.0 or 2.1. nvmet reports 1.3, and I suspect
there's a bit more work than just changing the value of NVMET_DEFAULT_VS
in order to comply with claiming that version.
