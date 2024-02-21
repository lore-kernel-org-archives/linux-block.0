Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D12E3FE
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708485719; cv=none; b=i9SKpDFF6ei/kfSutghrSpICs4N2KzhUB3DSQy7DQjYUWEF28s3ASYzEPCbCNwc+Q9nWgMzedWYO0fYDTL/NbPvnacgyjfElV7wpGPSKOm1y7CoRehsB1Iqxu0mdoNj0UQCLTo5pKvMqi6f6FTBNs2ZtxuP4EeJRripjl6q6Auo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708485719; c=relaxed/simple;
	bh=WJxA8oZrA6hTz5UdwpNQUd0fjIlhv5sh182Qa3MoA84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSYAUZRil9+CyoK42pwS7RH2384r7sarKMKpogc+Bj75ULycIZh9pABEWfK9P7cdA5zyb7l6tooOYRgsn7sbGa+vsOWA1VYzpaU6O6b41eT2Az+j9swu3Rva7HqEhaliQ+7UAMpNVrT7v8g4Rdzdut7+JkADRgOmwBV5CYtm/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SELMv65L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SELMv65L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D53C433F1;
	Wed, 21 Feb 2024 03:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708485718;
	bh=WJxA8oZrA6hTz5UdwpNQUd0fjIlhv5sh182Qa3MoA84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SELMv65LRYKztS08tfQ6+hmX+LR55AmARhOnpLC1wvS086lI6lGxPJAh6wozv/eM4
	 n02vbpzQtzS4gSL45SevAGqEBhqChabHpAhiY0PcJWeLQQkPLtVR5HShXT1XJ7DeZE
	 LiUFHurO2pcciBtnbPKnXfm4PMJKM76kKj5AGvRrJF6yYurU5G6+fuNjt/XIBcZ5GV
	 Cl+d7OU861nud3DuP2FQH9Z601iwMwCth7EpaN979UNf68qVw9P7z6nQxkaPubpxCD
	 KezAKJnq/X3Z5+AROxM9lMqmwKf8aNk2hibtK1PxrKW8oUdcOFMatmbgd1OwDmHiu1
	 wbo1WFkolf49Q==
Date: Tue, 20 Feb 2024 20:21:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.org" <axboe@kernel.org>
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
Message-ID: <ZdVsVFQk38v7-zaz@kbusch-mbp>
References: <20240220204127.1937085-1-kbusch@meta.com>
 <132449a7-634c-41b6-b14c-863cb198133e@nvidia.com>
 <ZdVrDbaQ2DbSKQtL@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdVrDbaQ2DbSKQtL@kbusch-mbp>

On Tue, Feb 20, 2024 at 08:16:29PM -0700, Keith Busch wrote:
> On Wed, Feb 21, 2024 at 03:05:30AM +0000, Chaitanya Kulkarni wrote:
> > On 2/20/24 12:41, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > @@ -190,6 +190,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
> > >   				break;
> > >   		}
> > >   		cond_resched();
> > > +		if (fatal_signal_pending(current))
> > > +			break;
> > >   	}
> > >   
> > >   	*biop = bio;
> > 
> > We are exiting before completion of the whole I/O request, does it makes
> > sense to return 0 == success if I/O is interrupted by the signal ?
> > that means I/O not completed, hence it is actually an error, can we return
> > the -EINTR when you are handling outstanding signal ?
> 
> I initially thought so too, but it doesn't matter. Once the process
> returns to user space, the signal kills it and the exit status reflects
> accordingly. That's true even before this patch, but it would just take
> longer for the exit.

Also consider that we have bio's in flight here, and an error return
will skip waiting for them. The kill signal handling here doesn't abort
inflight requests (that's too hard); it just prevents creating and
waiting for the rest of them, which could be millions.
