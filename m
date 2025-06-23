Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE827AC32
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693421; cv=none; b=gXDo4TCQuzsC1cfokn/MPYT3BZNb7X3iv+BQKhNC4EiKOwnpalWhFg0/zqldYzfmjhXG/ZsrrXXlYPXtaAbX+200fzrQdLBR+gx+zl1v2SUv6HufaWrrEg/lj1xJXbBjZkjUTDfG9RwwYyY32izlTcNjtM6Ic84NdV0gwkTABAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693421; c=relaxed/simple;
	bh=DgxHhxGSOqk7/F4ZYb7xhjpNoEwH1U0mLixQqgnCkPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfSBzA0GK2D/SDc9GVPPRFyWblfl5UVaou8rDv9kh9VRxR1r+ylK+FXv77NMa2KkyXCSdADXU2DPMVQ0dcWTS7eRv4dDIMvxI5wlVO5DKEYXKMBf8v7S2Uel1Rl16wAkVZwXgfYriLh+Lan9KP2ZfUQV6tWueFyisVgj/jqn+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzdrUO8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzdrUO8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6ADC4CEEA;
	Mon, 23 Jun 2025 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693421;
	bh=DgxHhxGSOqk7/F4ZYb7xhjpNoEwH1U0mLixQqgnCkPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzdrUO8ObmqmFHgl/QwuHHYxp0KwSPu/8D4bnAiH5r7BjuVDyceoxRQ6jviRJvPp+
	 yimXdrXJcNKbpwVrlMz5MozoCzfyb6P74DtNHzsJKSU4Uw4bVS1LjFXdk078lpUApI
	 d1yUIUDTqJe2dhZS2/NF1p5sVG9vnXo3nDu+vgEw9pzeUQ+ZDfH5JoWPmapdT3jAjm
	 A9DZsStfZtuv06tOPnv6wi+YRGL1tppXWYpoEAIF6Aqxac+nA4oDUogDVAsL7FZXxc
	 iGiZfUIRcyfTsooT1BHKG34Z0UjBbb7+F+6ylBCrukru98iQ5Nl5Q5ioI+yn5lYsbh
	 q0bPVT0XD4gdA==
Date: Mon, 23 Jun 2025 09:43:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/8] nvme-pci: merge the simple PRP and SGL setup into a
 common helper
Message-ID: <aFl2Ktb7gioMLEl_@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-5-hch@lst.de>

On Mon, Jun 23, 2025 at 04:12:26PM +0200, Christoph Hellwig wrote:
> nvme_setup_prp_simple and nvme_setup_sgl_simple share a lot of logic.
> Merge them into a single helper that makes use of the previously added
> use_sgl tristate.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
