Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31171F30CC;
	Tue, 22 Apr 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314147; cv=none; b=Ief0DVGFLFbmNiZU1485aRJU0NRxfVyId15QvgfmYp4RmYgFvez4SFrPNHi1v/LnLDw+tBTTolDnvVxynd/2X1++0fY7+rHWUNx3vUF54TLifB20yeyBu6dT/r8VY6Ktt2vWIzQtsmHHWpSDi92qXd+3ZX50+Rk+tZ7CIuaG4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314147; c=relaxed/simple;
	bh=NEX2z9kU4Vi8WmZ63Y0Gc55AKQh+cgsP9ewt+J6eGSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGyr/YGG9VYGLX+4IVhT2oydPDmsawKCaiVCo33/pqv+jPj6OykQYF6lojlwInAFj5WSuvxJHfCxnWsSDTUQCaAp5+PkrHmYWFqPPWu1odoWpW1/MkHLP7/xE2ZeTmu8h04JTS2kVwHZevnjuH0qwLYTgtxY5d73CePPxGhzArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArfsoAdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArfsoAdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2187EC4CEE9;
	Tue, 22 Apr 2025 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745314147;
	bh=NEX2z9kU4Vi8WmZ63Y0Gc55AKQh+cgsP9ewt+J6eGSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArfsoAdSA130xPl3M2aPlw+EBNPJy+wINPcpW7hHDbXqyrounzaoILrNOT1p4GMkq
	 rIgmql3DAJZCXkyIt4suIv69liZ0Ib1sshx9M7yva9OwRT2ccgAmGrmEYf3ionWKnA
	 GU2UbI5MQHVlLxNbkvGBsan4QXHW9KYKraH56jXULTccQq6zjnazgnEj1n5Nuytowt
	 A12H2P4bdXPEB09yowrXVsPHxEXQnLl/WayP0k5YKfgXteWqogMyCpiZAIvYUpouk1
	 MsXXkkwL1ZaXz6vi45rPu0Tp6VPVk9Q8ZobqHQoqZAc4VsWMd8XX7pI+n0KIHophMc
	 PN727xA+WU/GQ==
Date: Tue, 22 Apr 2025 11:29:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: hch <hch@lst.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"djwong@kernel.org" <djwong@kernel.org>, "ebiggers@google.com" <ebiggers@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422-gehofft-erdwall-a387c8909e42@brauner>
References: <20250417064042.712140-1-hch@lst.de>
 <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
 <20250422055149.GB29356@lst.de>
 <20250422-angepackt-reisen-bc24fbec2702@brauner>
 <20250422081736.GA674@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422081736.GA674@lst.de>

On Tue, Apr 22, 2025 at 10:17:36AM +0200, hch wrote:
> On Tue, Apr 22, 2025 at 10:15:48AM +0200, Christian Brauner wrote:
> > > -	bdev = blkdev_get_no_open(backing_inode->i_rdev);
> > > +	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
> > > +		return;
> > 
> > This leaks the block device reference if blkdev_get_no_open() succeeds.
> > 
> > > +
> > > +	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);
> 
> The one removed by the patch above, or the one added after the check
> below? :)

Ah, I got confused by the inline diff.
