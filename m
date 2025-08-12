Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493A1A9FA6;
	Tue, 12 Aug 2025 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983948; cv=none; b=UE4XFBN6s+H5V54zwh0ZL5FvQkn2imQn85y4P3/vEV5Akg1/BM/ijvMmw7wuWCMPiE9RYBApkCRvmLsUlFU31vdTY7yPD2JHmrFjD/Jus+DHYnJ6m80TZtHJr9idx0WEi7W4iIdXB0rRRborwGgnLg2C4OzdaQ+zGtwPu+VYcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983948; c=relaxed/simple;
	bh=AZ/oY/KvkfRoCBhJNzaxhzPts3cxjqP8EDlJrLC8eZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbNOjiWOfwiid0CY8ohMEu5VwvYgSTiNByDVgQhEpG5RJimFs98ZOUUIwM2Zrb8TiLAFB+z031x42jeyK6QTn8GENkUoyC4IILrnt9wMd5F3ENBlmf7e3uBYg13Lo2NbZY7kjsj0rGwE/IgkIF0Gq0a24P2dnTvYchsMYBcCDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vWA+OhBm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vWA+OhBm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2nTia5ts+VjOnB6KoRPEICX8cfIqCEHm8VoqRMMJHVw=; b=vWA+OhBmwsieByOdybHKj1jR8X
	B8uftFHEs/UuURKKK4pGRkm9G1XUtLiibtdrtoYkFkZNieGxYAmSJYjJ0An2Pg3g99rLGPAykba/w
	Yr7V6Nor4CW62aekr3V1/p8UerLCqCwI2GhWZkN71vpVUgT0bADtVPAdw9Bjn36tkjoonq/PMdDHU
	KJ4FhNQ8rJQBNmdYLbU/MkL2+JvafMVTZvEVG22gSPApuBkC1FRkc5dfle7yUxSR01HqQ/D/FUX3k
	YLsqaY7Whf6fbv28qTRrUMYa3uvexemuKv5+q8BWgNUR5En9pA346hDSxP4AiShOQnnrsFoZkdWKA
	2iuVRLcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljUg-0000000A7cu-01q7;
	Tue, 12 Aug 2025 07:32:26 +0000
Date: Tue, 12 Aug 2025 00:32:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: introduce flush_policy sysfs entry
Message-ID: <aJruCTOjcj1nEk-S@infradead.org>
References: <20250807034838.3829794-1-chao@kernel.org>
 <aJnLXmepVBD4V2QH@infradead.org>
 <c5195d5c-5f71-4057-9522-228b48e4cd90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5195d5c-5f71-4057-9522-228b48e4cd90@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 12, 2025 at 02:28:46PM +0800, Chao Yu wrote:
> BTW, I suffered extremely long latency of checkpoint which may block every
> update operations when testing generic/299 w/ mode=lfs mount option in qemu,
> then I propose to use PREFLUSH instead of FUA to resolve this issue.
> 
> "F2FS-fs (vdc): checkpoint was blocked for 24495 ms"
> 
> I just realize that using cache=directsync option in qemu can avoid FUA hang
> issue, anyway, let me test more w/ this option.

Well, for decent qemu performance you always want to use DIRECT I/O.
directsync is generally not a very good idea as it forces every write
to be synchronous and will give you very bad performance.

What did you use before?  At least for older qemu the default was
buffered I/O, which can lead to very expensive fua or flush calls.

