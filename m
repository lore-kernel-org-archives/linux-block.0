Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EF3A8F0;
	Mon,  7 Oct 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280249; cv=none; b=oxYhjqTOxdlnS3tXQ3cygOfIprX4c4gaVbrV7N+BUxZyRhBQxj/4Azc4DWpwqnzEhlAzWIaPtzWv/kRunnuxcU8+IAUNtpFyTY/NtD1MrjA9FaXquNVq6s0LnPMjCGxSC53EEJZXgem+UGrvYNs59g/8FiL5HofN/QicF3dAj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280249; c=relaxed/simple;
	bh=OmZt4CedTBXE3sNnqVjTWhPMe6PksKDx5RS5rZEolkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD/UpQNGSnzbIcuADrZuXTOnV0U/PqxffRWoe96jtHOXrIp9y6vh2Y1vj/fHMx1LUl9dXZxaSpG/DbkxSRnDVkee6MONI3IIZObvpnhN3fR0ztYX9B8dedglTHeitnc21VKrb3a4X5vCCCz9K+e7Jz9aVDH6q6LH9rn4Zy2EKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KFpPoEfK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFpPoEfK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=pGSkga9d0y2RjOrmr2KCMeLizj5bryBgdCESJ+95Cn0=; b=KFpPoEfKyYXGxzQ0HbIJ5/hNbo
	GbddqmKsMcBRY5BsDQBtnxgyfphNelXcMNGuMMw66O0ZNzb8OOKH4m5O5SHbu9YAyM5iPKLSB1E1O
	sNzuoormFPAnn1VLMHa89S1gs0aSMvP1k7hkWeTvOX/SUvIdHzvwYECTfwp460sfiL8/0y/r8IgqN
	FNvQzsdHkgjlw3WnWUg6D+yWZMl5NZSTP15y4I/P52JLDGMjXJoNgExBUjKsQa5F4GvZW7spOAhve
	Br98pRfJoSuGxxOwzrDfkAU0PdZ03+g+rp4PFUBavrz1HEN9d/zCkSKiOzfbFay9dniIAyoY8wsH/
	izj6iKNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxgds-00000001L9v-0JWC;
	Mon, 07 Oct 2024 05:50:48 +0000
Date: Sun, 6 Oct 2024 22:50:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, hch@infradead.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
Message-ID: <ZwN2uFsOxO3jL-EY@infradead.org>
References: <Zv_eFIjstVns-ebG@infradead.org>
 <20241004141037.43277-1-surajsonawane0215@gmail.com>
 <Zv_-DSM2NhuiX3o2@kbusch-mbp>
 <d4463564-7593-4956-a598-c7ec8fa8f851@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4463564-7593-4956-a598-c7ec8fa8f851@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Oct 06, 2024 at 12:33:58PM +0530, Suraj Sonawane wrote:
> > If it fails, then bio is initialized to NULL.
> You're correct, bio_alloc_clone returns NULL if it fails, so there’s no
> uninitialized bio after that. My initial explanation wasn’t fully accurate,
> but initializing bio to NULL is just a safety measure for any unexpected
> issues later on. Or i am just trying to solve this issue by smatch tool:
> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.

Please do this kind of research and clearly state it in the
commit log.

Now the actual useful cleanup here would be to:

 - move the bio_put to the bio_ctr error handling, which is the only
   case where it can happen
 - move the bio variable into the __rq_for_each_bio scope, which
   also removed the need to zero it at the end of the loop

That makes the easier to reason about, which should make whatever
static checker you have happy, and also allows humans to read it more
nicely.

