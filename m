Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20024E4B0
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218629; cv=none; b=p4EtowhgiWpuagnYNZFFeQqe7XKIoFlKm9N2TY4ygB2lb4Pcr0HHzqtED/m5lM1S29vEXa9Ko/bF/+Lc7beKmUFelEJ7nTuDiRmDJuZZPVgRcKQzW2ubjBj4nxWaCI0htBHiuY5FS6AMRaaU+tykv460DSAsWzczlIUhadaUFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218629; c=relaxed/simple;
	bh=vNS7wWorwHE83g7jtOZau1P3Bd5cO3Zt19RcAolWVA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESoRRjCk2lnoMlHAbXo3imxoyEwqLVmep8fTvXvfof/vlc6HuDUUkbrSavJzKehM+RXM1h1YNHh2JrbZOAXHzqRHz5yjNBaFcV02dylX3P7yhkTeUREhCWyUYofHDpJdtm0CwTeEDVOaQ1Qa7ibBtXyRIK9I7i1JE4M3yXkQfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCuoL9m3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCuoL9m3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665A7C4CED1;
	Mon, 10 Feb 2025 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739218628;
	bh=vNS7wWorwHE83g7jtOZau1P3Bd5cO3Zt19RcAolWVA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCuoL9m37ff5LzqKrr+RFWSk2hkDTLEqiAFZJZ40FMdxWCxNp2i3rx3AFemN8d832
	 mITSxXASJC6Q0ZIbPeuiqL2/jmSo/3odmXNSlbBPTnqfGhQD0hVNOzAR/J+OUU+k1I
	 Wpi/qj5GGDt2u0yYSh/0StGdN/7ce6GrA2I0UZ/HqKlnzSbwqNeXjnr576rODHYkdo
	 RJUD37ajCysQ0U+1GBzCJRv0D6cfr5RLbXmcJM7UeRFoHwXFX1LwJ+YDGhGJn7SzWg
	 LjpRVVrBFsxlhyhx8USkqKdO789ZbArTgmNTmXN6hpFC9mH/0IUzdNKafbYNreqesy
	 F0XX2JhtlHUIg==
Date: Mon, 10 Feb 2025 12:17:07 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z6peww6d3EP5-B8n@bombadil.infradead.org>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210090319.1519778-1-ming.lei@redhat.com>

On Mon, Feb 10, 2025 at 05:03:19PM +0800, Ming Lei wrote:
> PAGE_SIZE is applied in some block device queue limits, this way is
> very fragile and is wrong:
> 
> - queue limits are read from hardware, which is often one readonly
> hardware property
> 
> - PAGE_SIZE is one config option which can be changed during build time.

This is true.

> In RH lab, it has been found that max segment size of some mmc card is
> less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.

This is true, but check the note on block/blk-merge.c blk_bvec_map_sg().
It would seem that this is a limitation of MMC/SD and that this should
ideally be fixed.

> Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> as 4K(minimized PAGE_SIZE).

But indeed if the block driver isn't yet fixed, then sure, we have to
deal with the issue, I am not convinced that the logic below addresses
this in a generic way, rather it seems to conflate the areas where we
do need the generic block layer min defined, and when we have a block
min segment limit.

> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Link: https://lore.kernel.org/linux-block/20250102015620.500754-1-ming.lei@redhat.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- cover bio_split_rw_at()
> 	- add BLK_MIN_SEGMENT_SIZE
> 
>  block/blk-merge.c      | 2 +-
>  block/blk-settings.c   | 6 +++---
>  block/blk.h            | 2 +-
>  include/linux/blkdev.h | 1 +
>  4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 15cd231d560c..b55c52a42303 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  
>  		if (nsegs < lim->max_segments &&
>  		    bytes + bv.bv_len <= max_bytes &&
> -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> +		    bv.bv_offset + bv.bv_len <= BLK_MIN_SEGMENT_SIZE) {
>  			nsegs++;
>  			bytes += bv.bv_len;

I'll note that the 64k BLK_MAX_SEGMENT_SIZE is an old "odd historic" default
value, ie, not a documented hard limit but some odd old thing which
blk_validate_limits() encourages block drivers to override, so a soft
max.

That said, if we validate this soft max and if you also validate the min
shouldn't value in the above instead be lim->max_segment_size instead,
provided that we also address the coment in blk_bvec_map_sg()?

More forward looking -- are you using BLK_MIN_SEGMENT_SIZE here due to
the same mmc/sd limitations ? Can we overcome the mmc/sd limitations by
only using this BLK_MIN_SEGMENT_SIZE only on block drivers which have the
scatterlists limitation?

The rest in your patch seem like sensible places to use a BLK_MIN_SEGMENT_SIZE
although I need to think more about bio_may_need_split() with larger segments
in mind some more.

  Luis
