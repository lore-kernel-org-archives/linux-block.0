Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F22143895
	for <linux-block@vger.kernel.org>; Mon, 26 May 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237090; cv=none; b=O/skPE5Thpx24sizkQA3cnZwaMQM6TuOX1e1zzMS975yDQXDaBiUTCIRi25Uhe5kb+TwerJ5wCPFBtR+dgHP2fM/bsB4UczurLvpSkMeIYB/wEXWcniXOpPTJGern1ffWvYRoT6a2nWBMp2x9opWTlIwcTTk6sxD/Uu3R3HCeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237090; c=relaxed/simple;
	bh=7WzBLZsW+QOWpB51qcxAL/vN9btnWfcTonr311OLv8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAzUgiZ+XZvBLrF00rohQq/4wXPVzyXL13rC62Ev+U3uloM0bujoGT8lehwthcxjgdAb49QI3JP7SPukq295WqHuu0OThbJirJybMRy6acDz3xrIuBYCL2BButOCjeVG7HvDRyAxKKewePf45BpcIPeB4LjBVL4weoo3Ug1IaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAAF868AFE; Mon, 26 May 2025 07:24:34 +0200 (CEST)
Date: Mon, 26 May 2025 07:24:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250526052434.GA11639@lst.de>
References: <20250516044754.GA12964@lst.de> <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de> <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de> <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org> <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org> <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org> <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org> <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 09:30:36AM -0700, Bart Van Assche wrote:
> It is the dm-default-key driver, a driver about which everyone
> (including the authors of that driver) agree that it should disappear.
> Unfortunately the functionality provided by that driver has not yet been
> integrated in the upstream kernel (encrypt filesystem metadata).
>
> How that driver (dm-default-key) works is very similar to how dm-crypt
> works. I think that the most important difference is that dm-crypt
> requests encryption for all bios while dm-default-key only sets an
> encryption key for a subset of the bios it processes.

Umm, Bart I really expected better from you.  You're ducking around
providing a reproducer for over a week and waste multiple peoples
time to tell us the only reproducer is your out of tree thingy
reject upstream before?  That's not really how Linux developement
works.
