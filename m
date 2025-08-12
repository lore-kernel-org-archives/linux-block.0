Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F52E283A;
	Tue, 12 Aug 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987862; cv=none; b=otc7RwfZ/tA0VriJgCuxyYrKZitz6JhinDHl3YRxanMZx4g3q7YeVkxHFVLJcBgbDorG2zdZRTZt++m5bj6MPlNTAvHEAqkI5BmwPBCVE8yfC81xQiNWx8rw9sItTJ7CnIlPy6rAFhbgovcfeQ+lomqgmUHzCwHwCQWbepMvaho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987862; c=relaxed/simple;
	bh=khzytgg98sJq7yGzv/9DTi+KLfewTFT2CI/dMo5erWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AACOaBhK/WbkXyy6AuqBkH23DzYIrKkj5U4w3PzxceQYT7j0sByUuFdQChtNUfoghOUFsucQOHI+V57Ebik0IlMzcOoTCuVJduM21Lm4zEb5JgEGtFISLD+OUD+S4QkGOUEX32mht9j6/uvOm+wKvjNTetEmH7+nKlybaLrzoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NFcM65D3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NFcM65D3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2S2oLnDkbY8/3PpsV+wkExCSZ2+MFwOhe0etJ5SKIhU=; b=NFcM65D3g2v1bV6PF1oz1m8gg7
	Fn8CKRNKAIia2D6weSlIGjladmIA/5CC4Fri6WOJ3OajlfOHGutmkRpyVs1LnVYBNEiu3Z9TctCv2
	C9+1zNCZNxaulXxPa8AvtX+QDVRwy/he/baKmyYYFnGlMKQD7TdlVNA2i6foUBRmssBZMYM+iAd4j
	ymsZmynXrlhDM8HI2lA4lMpHct2ASozgVrzd3TWA2Cs0GJ3n31ZnXIOyLg13QuV/zPM63xN2fTC03
	L45J/GJ9ctB4M9V1kgvs1cXoo+Lcf6Jlius/uUBrwbel/GrAuVNIZrIpa8UZJL6wMbbOEUiE6gK6N
	5KXrwOnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulkVk-0000000AGNT-0wwf;
	Tue, 12 Aug 2025 08:37:36 +0000
Date: Tue, 12 Aug 2025 01:37:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Rajeev Mishra <rajeevm@hpe.com>,
	axboe@kernel.dk, yukuai1@huaweicloud.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
Message-ID: <aJr9UKtIJ74XExf-@infradead.org>
References: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
 <20250812033201.225425-1-rajeevm@hpe.com>
 <34624336-331d-4047-822f-8091098eeebc@kernel.org>
 <20250812042826.GU222315@ZenIV>
 <a7cb5d59-8af5-47b2-8549-05c9322971e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7cb5d59-8af5-47b2-8549-05c9322971e5@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 12, 2025 at 02:17:01PM +0900, Damien Le Moal wrote:
> And indeed, that:
> 
> 	/* size of the new backing store needs to be the same */
>         if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
>                 goto out_err;
> 
> Will need some massaging.

Why?  get_loop_size just derives the first arguments to get_size
from the passed in loop device in the same way the only other caller
to get_size does.  So we can just:

  1) convert loop_set_status to use get_loop_size
  2) Fold get_size into get_loop_size
  3) Maye rename get_size to lo_calculate_size to have a descriptive
     name while we're touching it?
  4) switch to vfs_getattr

