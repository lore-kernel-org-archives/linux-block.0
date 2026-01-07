Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5925259C84;
	Wed,  7 Jan 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772496; cv=none; b=mFlgKm8mdWXUFxBB2wJ0XmD33a5RCKmyNf6037QaKkBE/k3dEvZi9qNYfsfxEAvXnpjor3kzWpc9gLK7JosDkPK4GSwLPgbaPNUCEZJ3NeBJvOXsCys8CNn0kcoJlvkqD6gmA6fAeN7ks9/MXx/rEvbpeduwqi8Kzb7GZiVbG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772496; c=relaxed/simple;
	bh=WU9BYosDgytSGFm7ugxaTC6PwVTLaeQgkXlafkxHXxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENtYxrFDuxv2m4hrtZxoqfMZOz6xCyfJw0IedcJ/jcpiN7Pj2MoLELkBgk7jON+N0cy9nO5q7oqa5fG/2mOSQVRYXnaZjDDpwC5Sp42KYL/Qr63qhdbJ3bi/d6/lgfMQ6q6DuOYwR0vrLB7riooBB85i22e3p8nRFdIO9gqyh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWX7k91r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWX7k91r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BD9C4CEF7;
	Wed,  7 Jan 2026 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767772496;
	bh=WU9BYosDgytSGFm7ugxaTC6PwVTLaeQgkXlafkxHXxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWX7k91r5EsQAB87qtbAZypQwDX0sEi6XAeCSrLfQFPos//pxQh2SX8BEmcWe8hG4
	 AMDkoj5SgHzz4WQ5DtKjpdQZjXUe1khZPvMeoPDuE6svQJS82YUtCt7qT2rLFgn4xp
	 WVCzmjeBK7x7Q0pLQ/7F1FXTBIQENMTH5Fzk+B/XpHUwo73KKuZzCh52rvaLLzAF2G
	 Dd9JhwlZ7fzsWz9Gk9MoeCp+tZo8QzZAVwEAokSQm7wxHy6MItUNBEuS1BZZ7aGdIF
	 fx56kc45HmhxfJZVfW3qJsCDWb6C8ACDDFlo4sto1ocbdWhGo5EtBdvcX3awoDLORn
	 fueO8cx/tbCdg==
Date: Wed, 7 Jan 2026 09:54:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260107075453.GB11783@unreal>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
 <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
 <8f839d6a-02a2-47f2-97af-f77cb10c5790@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f839d6a-02a2-47f2-97af-f77cb10c5790@kernel.dk>

On Tue, Jan 06, 2026 at 07:13:41PM -0700, Jens Axboe wrote:
> On 1/6/26 5:46 AM, Jens Axboe wrote:
> > On 1/4/26 8:15 AM, Leon Romanovsky wrote:
> >> On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
> >>> Jens,
> >>>
> >>> I would like to ask you to put these patches on some shared branch based
> >>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> >>> and DMABUF code.
> >>
> >> Jens,
> >>
> >> Can we please progress with this simple series?
> > 
> > If Keith/Christoph are happy with it?
> 
> It's here:
> 
> for-7.0/blk-pvec

Thanks a lot.

> 
> now.
> 
> -- 
> Jens Axboe
> 
