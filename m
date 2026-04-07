Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2810F2;
	Tue,  7 Apr 2026 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540925; cv=none; b=YOrFjHv2uMK2ar/pXw9qsyZohVHWnbT/3EVd4hmwSqUlPoFiD20cUHi53OHhUJgXv7GLUKXcMdrbHmtIcvjfubizauaqqkV4AXJEkV1M0gkxt9VNL34CxYLK9VPafuRS5Hb1I0H7ORNipwZVMNxPdaqSfjBFcaAWHn1hX+paYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540925; c=relaxed/simple;
	bh=ZY1rw9LCc984sh2T29EclwJprGzSmuGQ51BsnW6rizM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7DkanpDmdAeBbZ8CGihOMFl9i1q8987TkYf83N7z7YwGZ6QTjYslAWA/nqBN1DkqBGSq4Q0T7CP7c8A3H1ISVOLCNbl+MyZO0kpshNnGej/Cdb6s13139FPfr5PHFT9BQlsDH5YdvasTsqxZErw1FiW9ynXRwkPx6e5JVtAjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O2dMGcv/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2dMGcv/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t8su3zMZjRWFsSvEI4ErubNyYtWvKgmIMbExWOsxFQA=; b=O2dMGcv/PcDbiL60tWb34wrcgL
	B2ZsEHsl1qB5izkA9gNwHqj3pIRV/g/sc8rjv5wQC364AFCtjbGjb4yS6yayzePS13BxATHuaflDe
	lFru+9Sm8XVDze3uU4mZlJjereoPyziBvIhdsXG8ZkA4jBh1WEKL3hu9VJBsUbd+DkzweaxjY2CcP
	8/7RpKGm7HKFKs+mj1HWYjuqxtc5VOg93daHUnRE7Ky888BYx2r6vbvyuGU0lFPkiEdH9y7lCXl3Z
	u0aBKx6hxYuFdfB2oeSxsjpYnWQ7vz3NfHPLebT+A2UCLrSnUN1idzIJcdcx+5qdSJXDyhgpOGDMT
	LRbspDGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zIp-00000005wl4-3sjd;
	Tue, 07 Apr 2026 05:48:43 +0000
Date: Mon, 6 Apr 2026 22:48:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Esteban Cerutti <esteban.cerutti@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [RFC] block/nvme: exploring asynchronous durability notification
 semantics
Message-ID: <adSau_eHqy0LxP5e@infradead.org>
References: <ac7eHEnFQlLN-vDy@yanara>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7eHEnFQlLN-vDy@yanara>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 02, 2026 at 06:22:36PM -0300, Esteban Cerutti wrote:
> Today, a successful write completion indicates command execution,
> but not necessarily physical persistence to non-volatile media unless
> FUA or Flush is used. This forces the kernel and filesystems to assume
> worst-case durability behavior and rely on synchronous flushes and
> barriers for safety.

Nothing relies on synchronous flushes, and we killed barriers a long
time ago.  FUA does as you say provide persistence notifications and
is heavily used for the (relatively rare) case where it matters.

>    - Normal completion continues to signal execution.
>    - The device assigns a persistence token ID.
>    - When the data is physically committed to non-volatile media,
>      the device emits an asynchronous durability confirmation
>      referencing that token.
> 
> This would decouple execution throughput from durability
> confirmation and potentially allow filesystems to close journal
> transactions only upon confirmed persistence, without forcing
> synchronous flush fences.

This is so complex that it's not going to work in practice.

You've also failed to explain where you think your model is actually
helping to improve clearly identifiable workloads.  Note that all of
this would be limited to consumer hardware anyway, as volatile write
caches aren't really a thing for higher end hardware.

