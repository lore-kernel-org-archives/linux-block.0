Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261083B295
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463184; cv=none; b=nBItRzwnPmMQJC/FVqjD36pTVBzZe9bPIQ1FR8h6gtxQHHpNzXP4skyohG/ElbxhPWqsYCsWamnH2vqLmE498dCsT8LPjdBifsA7sKaOKjqEaebs7FnIr3TwJyhsvrflUd4gUleJgbBE+U21x8iv3p6GfDBK1PPOuKau0nqHBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463184; c=relaxed/simple;
	bh=waqmWrW/dyyXW3e6bIQ9+nraTcG7McMly+EreYcFH0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeIjfD/jybo5mx3tXvVTilSxE3mBX9q5MPlKs8eRC4ny7iWZ0XFRjvAXhT8EIjY6vE3KisqnQRr1BI7qbWOD0sn7yNYag3rkXpnwc5NqXrNWUY0RntrjyaccLpHqTMgqdgGEfZokRU2PDJBz73BYLl8rnnCPZ0mK4dArdLPw1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQMw/56Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQMw/56Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C71C2BBFC;
	Tue, 30 Apr 2024 07:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714463183;
	bh=waqmWrW/dyyXW3e6bIQ9+nraTcG7McMly+EreYcFH0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQMw/56ZbKCfOC687Ek7MmV6nWVoPCuRNFBxin+1THqTdXcPRQKLyv2837Vn98OZ6
	 kWDgHiNUH3Bjen073dssjMDk0fzlKvz7DO+LbKOrVJVNnCtGbxlOYCTl0Fo+CAwN11
	 br1KXBsnadIgaIfFUENgcsQu2qJx50DHUaNNGdVWxoOIS381z1SCTqIlQVamBCGyJo
	 BI8m1vTahkifVDM9HsXW3MAHCH7Uyj77FDN1GbfDWuXcD4r7ojQQE/5cGnHh4NLCdK
	 gyE7nY/jLIdv7PRqNqbKXce1o50ms7aZV7tIf44J3B36+/zbW/EfbyaMWUG5zcBLAa
	 7WLjZFxye90YA==
Date: Tue, 30 Apr 2024 08:46:20 +0100
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] brd: implement discard support
Message-ID: <ZjChzFnFHIUZGd5D@kbusch-mbp.dhcp.thefacebook.com>
References: <20240429102308.147627-1-kbusch@meta.com>
 <c611759b-7d26-45c2-9655-33eb7bb69024@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c611759b-7d26-45c2-9655-33eb7bb69024@nvidia.com>

On Mon, Apr 29, 2024 at 07:54:05PM +0000, Chaitanya Kulkarni wrote:
> On 4/29/24 03:23, Keith Busch wrote:
> >   static void brd_submit_bio(struct bio *bio)
> >   {
> >   	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
> > @@ -247,6 +264,12 @@ static void brd_submit_bio(struct bio *bio)
> >   	struct bio_vec bvec;
> >   	struct bvec_iter iter;
> >   
> > +	if (unlikely(op_is_discard(bio->bi_opf))) {
> 
> I've been told that unlikely should not be used with discard as it is
> bad for discard workloads, if that is still true, then can you please
> remove unlikely ?

I don't think discard workloads are likely on a ramdisk.

> Also, if you are doing this can you please also add support for
> write-zeroes for the sake of completeness ? unless that support is
> not desired for brd ...

That is orthoganal to the goals here. I just need to temporarily reclaim
memory for other purposes when the disk is temporarily not being use; I
don't care about the zero'ing out part.

I found that previous attempts at supporting discard on brd didn't make
it, supposedly because of some kind of writeback deadlock. I have no
idea what that comment way back from 2.6.35 is referring to though: we
allocate pages with NOIO or NOWAIT, so either brd can get a new page
when its needed or it fails, and either is fine, but deadlock shouldn't
happen.
