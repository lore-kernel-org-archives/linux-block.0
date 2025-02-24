Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458758F5E
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740358559; cv=none; b=cVJ56Rft9na8VRh7Dnf/9IkKyqLRms9srPi4rcGNOGfQhliB1DUDF2RO4GoyL6dKoUKKwrB99bOA8cHj7Nm4w6O7bp6sa4yUCi93RcVQnkgO7un6RchyYLjPtEyb83xB2Mu5IKI5pVfzf/UKiOI0rUZAkwF26gC4qJfUnM3NChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740358559; c=relaxed/simple;
	bh=hqTI1xD4KT/Z1glbPbHwpXv3E43dcjIGk0QYvjaA1dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G84iGFQ1Jae6gGfPyey/ORhdHwgLJfHUzQpFP2gy9bMZGrXM2CbEixGHwzOXpQMLoyxZmcv/eK2F2QqgZs2dFDqpvaXt8S43tb9Cs1ugyTBVi7lgj7qx8r9BaB7Ebj8/tp7Zx9hkKJj45J5wetgxS58X+hKoLrPH583HsHcHO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk2HrrmP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk2HrrmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFDEC4CEDD;
	Mon, 24 Feb 2025 00:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740358558;
	bh=hqTI1xD4KT/Z1glbPbHwpXv3E43dcjIGk0QYvjaA1dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sk2HrrmPtXwdskCbTa5GtAaRNUMFuGfBZWp+MKdzdyiIbzhiSSF8pAZP2/E4emZdS
	 mYpx7evCrxip+/uph5+h/ynGjqA9kMsg8FRywR0Foe/oRGJRrejPjRzyHUQyVsuSe9
	 fKz5vgzijd+Xali356vyp4Wne68ioS27V2ZOHKlVIvI6/wGi4yJVFAFJx1Byiwa7cn
	 miJUZR9ysF03/YeSeE9oPZpI06XJKccrEa8PFQMSBn7wBTYKsyIKQcOKZlQxQhYO9d
	 sldiw6mYsJK4xs6TjOrrmNuUmAwnRD5sVU7/9XUTRyD11IuRkkk1ODpVucWLAFhCRX
	 wrD8V4oj+Gv1A==
Date: Sun, 23 Feb 2025 16:55:56 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z7vDnAtt9K14pZMz@bombadil.infradead.org>
References: <20250219024409.901186-1-ming.lei@redhat.com>
 <Z7jeOpW882Old2Eh@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7jeOpW882Old2Eh@bombadil.infradead.org>

On Fri, Feb 21, 2025 at 12:12:44PM -0800, Luis Chamberlain wrote:
> WARNING: CPU: 2 PID: 397 at block/blk-settings.c:339 blk_validate_limits+0x364/0x3c0                                                                                           
> Modules linked in: mmc_block(+) rpmb_core crct10dif_ce ghash_ce sha2_ce dw_mmc_bluefield sha256_arm64 dw_mmc_pltfm sha1_ce dw_mmc mmc_core nfit i2c_mlxbf sbsa_gwdt gpio_mlxbf2
> f_tmfifo dm_mirror dm_region_hash dm_log dm_mod
> CPU: 2 UID: 0 PID: 397 Comm: (udev-worker) Not tainted 6.12.0-39.el10.aarch64+64k #1
> Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS BlueField:3.5.1-1-g4078432 Jan 28 2021
> ng pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)                                                                                                          
> pc : blk_validate_limits+0x364/0x3c0                                                                                                                                           
> p.service                                                                                                                                                                      
> lr : blk_set_default_limits+0x20/0x40                                                                                                                                      
> Setup...                                                                                                                                                                       
> sp : ffff80008688f2d0                                                                                                                                                          
> x29: ffff80008688f2d0 x28: ffff000082acb600 x27: ffff80007bef02a8                                                                                                              
> x26: ffff80007bef0000 x25: ffff80008688f58e x24: ffff80008688f450                                                                                                              
> x23: ffff80008301b000 x22: 00000000ffffffff x21: ffff800082c39950                                                                                                              
> x20: 0000000000000000 x19: ffff0000930169e0 x18: 0000000000000014                                                                                                              
> x17: 00000000767472b1 x16: 0000000005a697e6 x15: 0000000002f42ca4                                                                                                              
> x11: 00000000de7f0111 x10: 000000005285b53a x9 : ffff800080752908                                                                                                              
> x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000200                                                                                                              
> x5 : 0000000000000000 x4 : 000000000000ffff x3 : 0000000000004000                                                                                                              
> x2 : 0000000000000200 x1 : 0000000000001000 x0 : ffff80008688f450                                                                                                              
> Call trace:                                                                                                                                                                    
>  blk_validate_limits+0x364/0x3c0                                                                                                                                               
>  blk_set_default_limits+0x20/0x40                                                                                                                                              
>  blk_alloc_queue+0x84/0x240                                                                                                                                                    
>  blk_mq_alloc_queue+0x80/0x118                                                                                                                                                 
>  __blk_mq_alloc_disk+0x28/0x198                                                                                                                                                
>  mmc_alloc_disk+0xe0/0x260 [mmc_block]                                                                                                                                         
> ...                                                                                                                                                                                           
> mmcblk mmc0:0001: probe with driver mmcblk failed with error -22  

I'm left still a bit perplexed with one question still, this is a known
issue now with using large page systems with smaller DMA max segment
sized devices either eMMC and Exynos UFS, does your patch just fix the
probe issue on eMMC? What about functionality?  What aspsect of Bart's
series is now not needed?

Bart's series were NACK'd as the changes were deemed too intrusive to
maintain on the block layer, so I am curious what has changed here to
enable eMMC. Will 16k page size systems with Exynos UFS work now?

  Luis
