Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654617;
	b=pI2z+WEnlh3+hseDBejxuGT3xOo9jPOArUqMQRJIFW703z+BBmZ/bT8s/sES03CNkl1D
	 aPuVHkBSP+VSYJmKOQbmcRXmGoDzNyO1qZJNYS1D8qCqXXN3NU66+P2q4xR8cWQVbh+55
	 dcY4YazoMWnYVBjOE0MusFAuvBC9D1/INCymiyh+cEwfB3Avu5dofhi3jeer/+hnlaWrh
	 LNAa5WhDeQUuYaWYL2bd9xyHDtODZjMJyxa8oR2NB0GrfqKG6UwilaeNq7Uggcv4qCsEF
	 eegptifowwcwIGAd36sR2b0M23yaf6+pZ7/34Ki6ljHHjKyOlRIv6gZskVCJJuiGiog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654617;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c/0MB9v0rUdNDr6wBNp9QY7vFRWPe6q0AGEA/lmEGTY=;
	b=A8UFXOuVw05PiVmVx3Tq9bwUqJgtzixjxKy2Dl08RtVsZ5X99qHMsfOvRq1JUZp96IYh
	 P8soA1CPukv47Blj2f6bcYaFjC0RV2W6FKSa55D4SvQ5Bhh5KXmphmkMkXUSkfUSG4FTK
	 YA13coYMpsX7C+UwC6Xu0V3cZr6ANSk4VwYPjUza28m3l4XGox2r44k0B9Hp0fPBuDaXU
	 M/Ljq//Y3qqWoOE7RNGjYbc/EGsU6ZQVT68YxU0NZW+STnTmG1TP9widad/R1GiN+Stiy
	 OTTmqWIvNmfszFz1VQFD9zi1xHrt/Uy+GxeIS3hYuvCEukLnkApJWq5tkdCCKMiYkeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuXK6TAj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7CA606A319
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuXK6TAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDCB1F000C1;
	Thu, 22 Oct 2026 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792654617;
	bh=c/0MB9v0rUdNDr6wBNp9QY7vFRWPe6q0AGEA/lmEGTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JuXK6TAjGTys/C4vNDMOJrL3bRUqn8E1x/Gh4uNEhPsy1vAeW/rc/vb1OFcPIfPIz
	 OUM6X+n1D1AL2mCHCEijivKM9qT78YRtAftJTNld3YGqTND19Ov/d4TmMJGTTxLPFK
	 ueOZwHMiEw9983doMbUN7waqlHB+ZV56ohr92aobRnmehEYMYJ+aF4vdnDCd6Nm9Jw
	 Rs6r2bnS+HmVC4r3mk/PRnXL587JPrNk2H3usTTIfxBzsezkYYCs89U0ipKAgge2NP
	 zaSagkbaFrujhQtpbs8ViKM9Pt+fqt9EDYXFnRGIEkI8M/vjo+4TQs4qFShnjNAt8q
	 OVBP03vrG8WAQ==
Date: Thu, 22 Oct 2026 09:36:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] null_blk: don't finish zones to set them read-only
 or offline
Message-ID: <atm9FQQIkyEp-RBp@ryzen>
References: <20261021202100.2017938-4-cassel@kernel.org>
 <20261021202100.2017938-6-cassel@kernel.org>
 <3222f1e8-07a8-4948-bd95-3d816fd1d71e@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3222f1e8-07a8-4948-bd95-3d816fd1d71e@kernel.org>

On Thu, Oct 22, 2026 at 09:15:32AM +0200, Damien Le Moal wrote:
> On 2026/10/21 22:21, Niklas Cassel wrote:
> > null_set_zone_cond() calls null_finish_zone() to release the zone
> > resources held by a zone before setting it read-only or offline.
> > 
> > For an empty or closed zone, null_finish_zone() first runs the zone
> > resource checks, which can close an unrelated implicitly open zone, or
> > fail. As the error is ignored, a failure for a closed zone leaks
> > nr_zones_closed, permanently lowering the effective active zone limit.
> > 
> > Setting a zone read-only or offline requires no zone resources, so
> > release the zone resources held by the zone directly instead, using a
> > new helper, null_release_zone_resources().
> > 
> > Fixes: d3a5738849e0 ("null_blk: support read-only and offline zone conditions")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Looks good, modulo one nit below.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

(snip)

> > @@ -768,9 +795,7 @@ static void null_set_zone_cond(struct nullb_device *dev,
> 
> This function is called only from zone_cond_store() with cond either
> BLK_ZONE_COND_READONLY or BLK_ZONE_COND_OFFLINE. Since your change is valid only
> for these 2 conditions, we really should check that cond is either of the
> already used values and add a comment, to avoid invalid use of
> null_set_zone_cond() in the future (without tweaking it).

Could you clarify with code what you mean?


For a comment, there is one already:
https://github.com/torvalds/linux/blob/v7.3/drivers/block/null_blk/zoned.c#L746

For a check that cond is either read-only or offline, there such a check
already:
https://github.com/torvalds/linux/blob/v7.3/drivers/block/null_blk/zoned.c#L751-L752


Kind regards,
Niklas
