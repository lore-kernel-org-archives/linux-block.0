Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6C3F7E6A
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534704; cv=none; b=pEtSRhJdlh/SY9i2k5eVYD31AoX/CzeS+MRscY0nLfsMmuR0DSnJNRWe89wOUKnKx5rE8+j5Qnx5bxFTzz16Ns8mxY0IjU8X17KICIabUWs0zfzsgMFubXxntRDgu7ec6wMHw785F92RdB/XMmrynBoNchBP9GBBfWtUVf9CIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534704; c=relaxed/simple;
	bh=ZFKm/gz4f9+enB6dyTlcjBXKxHt2WGr1hVTwwbUoXV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX1wbMOwafqra++aVAx4p1MLOb8hY8I03t5Ze5Au9XHSaXmdrzx1UyZqn8GwHhl1Rgjpgsgf0SAL+JyeIsr8vKnSS9uOQPw2AGfTdWT7RtuoLf92cX+EOjQUaA4+Cmn6jFcrX30HeQ0hLMTHvKRG71xv/RlqLrIbiej+F6iYFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72FCA68AFE; Thu, 26 Mar 2026 15:18:14 +0100 (CET)
Date: Thu, 26 Mar 2026 15:18:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 16/26] drbd: Make the lock context annotations
 compatible with Clang
Message-ID: <20260326141814.GC16166@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-17-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325214518.2854494-17-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:57PM -0700, Bart Van Assche wrote:
> Clang performs more strict checking of lock context annotations than
> sparse. This patch makes the DRBD lock context annotations compatible
> with Clang and enables lock context analysis in the Makefile.
> 
> Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/drbd/Makefile        |  3 +
>  drivers/block/drbd/drbd_bitmap.c   | 26 ++++++---
>  drivers/block/drbd/drbd_int.h      | 88 ++++++++++++++++++------------
>  drivers/block/drbd/drbd_main.c     | 40 ++++++++++----
>  drivers/block/drbd/drbd_nl.c       |  5 +-
>  drivers/block/drbd/drbd_receiver.c | 31 ++++++++---
>  drivers/block/drbd/drbd_req.c      |  3 +
>  drivers/block/drbd/drbd_state.c    |  2 +
>  drivers/block/drbd/drbd_state.h    |  4 --
>  drivers/block/drbd/drbd_worker.c   |  6 +-
>  10 files changed, 138 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
> index 67a8b352a1d5..8eaa83a7592b 100644
> --- a/drivers/block/drbd/Makefile
> +++ b/drivers/block/drbd/Makefile
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +CONTEXT_ANALYSIS := y
> +
>  drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
>  drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
>  drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
> diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
> index 65ea6ec66bfd..3c521f0dc9ad 100644
> --- a/drivers/block/drbd/drbd_bitmap.c
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -122,12 +122,16 @@ static void __bm_print_lock_info(struct drbd_device *device, const char *func)
>  }
>  
>  void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_flag flags)
> +	__acquires(&device->bitmap->bm_change)
>  {
>  	struct drbd_bitmap *b = device->bitmap;
>  	int trylock_failed;
>  
>  	if (!b) {
>  		drbd_err(device, "FIXME no bitmap in drbd_bm_lock!?\n");
> +		/* Fake __acquire() to keep the compiler happy. */
> +		__acquire(&b->bm_change);
> +		__acquire(drbd_bitmap_lock);
>  		return;

This looks like an impossible to hit case with cargo cult code.  I'd
suggest to remove it instead.

Similarly please kill the trylock_faiuled code, which has weird
debugging that is strictly inferior to what lockdep already provides.

>  void drbd_bm_unlock(struct drbd_device *device)
> +	__releases(&device->bitmap->bm_change)
>  {
>  	struct drbd_bitmap *b = device->bitmap;
>  	if (!b) {
>  		drbd_err(device, "FIXME no bitmap in drbd_bm_unlock!?\n");
> +		/* Fake __release() to keep the compiler happy. */
> +		__release(&b->bm_change);
> +		__release(drbd_bitmap_lock);
>  		return;
>  	}

Same comment as above.

> +extern void drbd_uuid_set(struct drbd_device *device, int idx, u64 val);
> +extern void _drbd_uuid_set(struct drbd_device *device, int idx, u64 val);
> +extern void drbd_uuid_new_current(struct drbd_device *device);
> +extern void drbd_uuid_set_bm(struct drbd_device *device, u64 val);
> +extern void drbd_uuid_move_history(struct drbd_device *device);
> +extern void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val);
> +extern void drbd_md_set_flag(struct drbd_device *device, int flags);
> +extern void drbd_md_clear_flag(struct drbd_device *device, int flags);

All these externs should go away.

In general this still mixes up way too many things.  Address one
lock/issue at a time, and write proper commit logs explain why a
given solution is taken.

