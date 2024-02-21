Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30746A4
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708485393; cv=none; b=X/NW5aVSYPw91RmOOUN7RPCB+2tS5KRfhL4MDWOqmOxKJrtZ/N4oLaabr/UQCIYAngYz15fgX/4GPrFuSanxB0kBMF2LkqBdKjgXMBndw28BE4EtxXFoxJ0qZo4ATMQE76f0dlZhrXhOGuOo227gOq2mXj1dQzgRTTYAkKqIGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708485393; c=relaxed/simple;
	bh=cGu6eP5ShOl/b9RiOFzATJC8I4se+otyWHF+XVnf13c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCMxcMhXyYuOUzyupYJ/R3ALxnitJT2VkD8ZhebpzqjzeilBWVXoN7DWJV1TTZsY28RibnXvYn5Eofk75b8QmJSrHelyJOYCbJh/nti6VA3M0a0F4Pt2RDmGcctPVYF24zPM6XGahBYCNUwV5zjJa53BxtQVPq5SddIARjYy9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN0ohFtg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN0ohFtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5B1C433F1;
	Wed, 21 Feb 2024 03:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708485392;
	bh=cGu6eP5ShOl/b9RiOFzATJC8I4se+otyWHF+XVnf13c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pN0ohFtgGZCF+zF/MdsytGh4yJJD3Z6/zZmi/QZSmZeHTspEYwbUFeBUWiUXJiYu5
	 Hd/CT3txgN//eZ5VEC+4+sr3cIWROq2StfHKiSpPSe02uFgSPstSEwsGdeaUGVElpv
	 7zqR2AIQaPlIQUBWcCVbr1Zds4BIh96lg7DleNKc7tWhOed0EcIBcPn2apk9I1NXGN
	 cH8tiNB+PaWMPinoOTyAiCw9z02mq71KOcBkyhIi8veTqYmFyUA1hUOdd3Rc+oHt3B
	 gkNK0/1sDuWQ5K5Zlxd7qgLgJ+0XPAiu57kVnbOKK5DfvRby61ZV+YbX8r/yOBz12f
	 YUdW0kNazotNA==
Date: Tue, 20 Feb 2024 20:16:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.org" <axboe@kernel.org>
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
Message-ID: <ZdVrDbaQ2DbSKQtL@kbusch-mbp>
References: <20240220204127.1937085-1-kbusch@meta.com>
 <132449a7-634c-41b6-b14c-863cb198133e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132449a7-634c-41b6-b14c-863cb198133e@nvidia.com>

On Wed, Feb 21, 2024 at 03:05:30AM +0000, Chaitanya Kulkarni wrote:
> On 2/20/24 12:41, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > @@ -190,6 +190,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
> >   				break;
> >   		}
> >   		cond_resched();
> > +		if (fatal_signal_pending(current))
> > +			break;
> >   	}
> >   
> >   	*biop = bio;
> 
> We are exiting before completion of the whole I/O request, does it makes
> sense to return 0 == success if I/O is interrupted by the signal ?
> that means I/O not completed, hence it is actually an error, can we return
> the -EINTR when you are handling outstanding signal ?

I initially thought so too, but it doesn't matter. Once the process
returns to user space, the signal kills it and the exit status reflects
accordingly. That's true even before this patch, but it would just take
longer for the exit.
