Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D817C200
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076249; cv=none; b=ZLTUxVX/ciIgMUa3YuAIj1Cmej7GUUN2CyalHEOZUUTNZlYjgT2JNk7cZWevgUdvuCcQwrKBTtqDOVben9SNvffmDzP363fJ4w3iHNF3MvZzsptEPciFr5w/T94qLWi+LYYWVxC5KI/QH2ERPIE+53kDh76pNSUUYL46Ockf7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076249; c=relaxed/simple;
	bh=oS2ix0+g3iy67WlG1fBaHv0vsaQ32p5UiTOSgfIES80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOM9MXh71AAo+wegygntsGIsrucqbruNDjXJc9HkGQfFNHRM8VmPrgNTfyOhzWkJUFKREOn7lMEyey/KJXz/LBWu80N5G92T0mnGPQqn/uz564oqgBFYf1P2Jkt7P7YH3Sr5domiZJ+XahCnrEPUHs4LiV4aeLmrXESjSXl2Qpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=2Fb1zSwl; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="2Fb1zSwl"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VqnNz2ySQz9sdm;
	Thu, 30 May 2024 15:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717076243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhSLUuVNqjiDmktdJWSfLXpp+bg7l6Q2pdgWhJT8hYY=;
	b=2Fb1zSwl1ifK9IHElUi0fyzMMIXiqi8+dUXDEONu6GzbWFdMX8snFLfdzQ3/XAKW57EsO+
	N4P+xzQGcad6EJRig2GUSXg4xzaXreZA6wxp3CjbQXAeKcDaQ24+kgaMcAvd7p6lwRi7Wo
	OKAE0VW5MA2Cqpw4Xkznp5CljgT6DwEd/9q14TuhoGP7XyOrGdfnaXTYkaRrxh111rXw3c
	D3k3fKqqzUT2gEsdru7kCeMM8u7Zm4L8EamtK87b6dPs3YqyT4kWtb511RpnVfE2zPLijC
	+5tPP71ca+TgfdToJUdu71u1IliAv/OpWbkJQ3/axoUxNmcA8ob9D3Y+oKCn+g==
Date: Thu, 30 May 2024 13:37:21 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] enable bs > ps for block devices
Message-ID: <20240530133721.jqbr7jkknnkxdsli@quentin>
References: <20240510102906.51844-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
X-Rspamd-Queue-Id: 4VqnNz2ySQz9sdm

On Fri, May 10, 2024 at 12:29:01PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Hi all,
> 
> based on the patch series from Pankaj '[PATCH v5 00/11] enable bs > ps in XFS'
> it's now quite simple to enable support for block devices with block sizes
> larger than page size even without having to disable CONFIG_BUFFER_HEAD.
> The patchset really is just two rather trivial patches to fs/mpage,
> and two patches to remove hardcoded restrictions on the block size.
> 
> As usual, comments and reviews are welcome.
> 
> Hannes Reinecke (4):
>   fs/mpage: use blocks_per_folio instead of blocks_per_page
>   fs/mpage: avoid negative shift for large blocksize
>   block/bdev: lift restrictions on supported blocksize
>   block/bdev: enable large folio support for large logical block sizes
> 
> Pankaj Raghav (1):
>   nvme: enable logical block size > PAGE_SIZE
> 
>  block/bdev.c             | 10 ++++++---
>  drivers/nvme/host/core.c |  7 +++----
>  fs/mpage.c               | 44 ++++++++++++++++++++--------------------

What about fs/buffer.c? Do we need some changes there?

One obvious place I see is:

diff --git a/fs/buffer.c b/fs/buffer.c
index 8c19e705b9c3..ae248a10a467 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1121,7 +1121,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 {
        /* Size must be multiple of hard sectorsize */
        if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
-                       (size < 512 || size > PAGE_SIZE))) {
+                       (size < 512))) {
                printk(KERN_ERR "getblk(): invalid block size %d requested\n",
                                        size);
                printk(KERN_ERR "logical block size: %d\n",

