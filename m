Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164F3955F6;
	Wed, 15 Jul 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127207; cv=none; b=Aa00V8NzyHcvDtmeD6OZLMcoeh3B/OkHIqVmT0a4LMkcF1u4a4AqsX45I426ZZyWViGUpOacl4KklTow0m6GCfy+fGLGk1XbvVosWzFDhKw/lty8S3dPk8ik2zKyM/PRo0O0yT+3y//+IUkFBiEdtg+wvX/5hc2bAxQNz4TYjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127207; c=relaxed/simple;
	bh=uA2WLeABKH8Ned3ZF94WB4w701YpTg8zYuqDqV2D+oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kStgLi0vtcRJS0W6u7N4Bes6q98eK0gcLpXKeI9HYhQNQOqPpvZWyYp9PBRm3+KFJCP3hQEzVixS0rmh9aUr9JZqlyqKnVdWxbiek9SjKpy0atoUOtsZVsqFUNJPyq39PKGSBNImUYCeVhnmKA1fSLBB9QEHxERDdSq4w2fDVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ME8PoYET; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ME8PoYET"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wZ9Z0+f5w0AYAB2osYI+EXEdqYuOgybMd9XAcfwXzMs=; b=ME8PoYETbFXYnbf91z5HvHNgxW
	IH+WCUPx8wytXlvbZgxlcqdVYMTBjreURg3JvGRvhS7JvbINHRyzjqjQ+6EKzpf6NfcTT56g81jR/
	nVsjAa2hW6usDRwjJHuIsap0+66Qdyg56zH5ML/KOAHAIvKPBWnERGtxX79+TA/JyYN6ASeJ2UlWM
	62SX3dZXXH5PDJsisXY/SFbTIajfhGBlsIx+qwveOurTadYKvr7eCh9yK5QVyWc2+k7Vu7qiUPm/K
	G27LLncNrToeve8VDz80ZgPOLHdGhaUwQl/F4BSSVHQtvtcLZDvfQClp1L/kb5ea6e/gbnEQUq/u5
	ugIJa0DQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk0zF-0000000FDhd-0L8Z;
	Wed, 15 Jul 2026 14:53:25 +0000
Date: Wed, 15 Jul 2026 07:53:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-next@vger.kernel.org, axboe@kernel.dk
Subject: Re: [linux-next:master] [loop] d908729e74:
 stress-ng.umount.ops_per_sec 100.0% regression
Message-ID: <alee5QMFtyPeqVKR@infradead.org>
References: <202607151655.9d74999d-lkp@intel.com>
 <aleZammRRSVN4dl0@infradead.org>
 <4ea4703c-7385-4f75-aee2-f21a6c8cce82@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea4703c-7385-4f75-aee2-f21a6c8cce82@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 15, 2026 at 11:45:41PM +0900, Tetsuo Handa wrote:
> On 2026/07/15 23:30, Christoph Hellwig wrote:
> > It's also a patch that has never been added to the maintainer
> > tree for goot reson. Tetsuo keeps doing this, so can we please
> > stop including their trees in linux-next as there seems to be
> > no other way to stop this?
> 
> Then, can we please keep discussion on
> https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 alive?
> I am asking Al Viro to reproduce xfs/259 problem, but it seems that
> Al is too busy to respond. I can drop this patch if somebody is
> interested in fixing this bug which became visible in 7.1. Current
> state is a result of insufficient interests/resources for debugging.

Not my business.  But adding random patches affecting other subsystems
without any buy in is a no-go.  Doing this repeatedly after beeing
reminded not to do it and for multiple subsystems is a red flag.

