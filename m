Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2841F0995;
	Sat,  5 Jul 2025 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751679210; cv=none; b=jhoYDd4C1fXPg1H7dMQfMMJBP5gH+wY5y9ybctSV2p3OPRFn7Ga+89IUWEDOKhdoOzA+53LMfZjclldvUNy72UbTp17gPf3qKZxwkSKudvhJ662SX1td5w3QToa/Ge2obbUcfvliD3V7bciZp0fnYc9rmrMz5gjPcYo48yMjJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751679210; c=relaxed/simple;
	bh=Mt7nBG61m28mg1SmjDJBIU0VSnjB5SNnAUT6Jhbbl60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh8apkAe410PEhi4uCE5FOd2+rcGfF9fvheAIXp7xks99W/k6JM4UNM4GFV1vvTM6teI5m5jc7QtTD0DtcQsM6364PVpough5kFwM7lFaFL3+037zjlK3psitMngTDmgDo9zSQOrzCDNDqg8aq5O18H+v6lhiUqlFfRheFAYA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnnvYafJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnnvYafJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D969C4CEEF;
	Sat,  5 Jul 2025 01:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751679209;
	bh=Mt7nBG61m28mg1SmjDJBIU0VSnjB5SNnAUT6Jhbbl60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnnvYafJ1FqL3kk/niuTAHCn1JLzZdjtxcscpJ7d3XKB5PLc9QYOuH5mrqyVz6CAx
	 vZC7eAp/H753aUcrOt0O2knMuCDOUOZLlIwCJJpA+b8X03aX+qPVD6hUg53Zre7uL7
	 c2p3AcwfRCFqddiHWKGQXHCMWDqhwfZ6auHambPZtHCdsWPm9jvIjxNkq87yn6KgYf
	 VGNvLIjgHzUZHvTJTKja4ArFFoASvs3fJg/1HjjwJl3rSFbcb331pKr2e/4UPuyaaZ
	 YTmMmsQzh9UPX3fbSXihDptsOeAJuoXWXubkBNJDuuEMTmCQ211aK4ym+EIngAkyYa
	 ffOQDW/so2NMA==
Date: Fri, 4 Jul 2025 18:33:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	kernel@pankajraghav.com, hch@lst.de,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] block: reject bs > ps block devices when THP is disabled
Message-ID: <aGiA5yayJwnGdp6i@bombadil.infradead.org>
References: <20250704092134.289491-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704092134.289491-1-p.raghav@samsung.com>

On Fri, Jul 04, 2025 at 11:21:34AM +0200, Pankaj Raghav wrote:
> If THP is disabled and when a block device with logical block size >
> page size is present, the following null ptr deref panic happens during
> boot:
> 
> [   [13.2 mK  AOSAN: null-ptr-deref in range [0x0000000000000000-0x0000000000K0 0 0[07]
> [   13.017749] RIP: 0010:create_empty_buffers+0x3b/0x380
> <snip>
> [   13.025448] Call Trace:
> [   13.025692]  <TASK>
> [   13.025895]  block_read_full_folio+0x610/0x780
> [   13.026379]  ? __pfx_blkdev_get_block+0x10/0x10
> [   13.027008]  ? __folio_batch_add_and_move+0x1fa/0x2b0
> [   13.027548]  ? __pfx_blkdev_read_folio+0x10/0x10
> [   13.028080]  filemap_read_folio+0x9b/0x200
> [   13.028526]  ? __pfx_filemap_read_folio+0x10/0x10
> [   13.029030]  ? __filemap_get_folio+0x43/0x620
> [   13.029497]  do_read_cache_folio+0x155/0x3b0
> [   13.029962]  ? __pfx_blkdev_read_folio+0x10/0x10
> [   13.030381]  read_part_sector+0xb7/0x2a0
> [   13.030805]  read_lba+0x174/0x2c0
> <snip>
> [   13.045348]  nvme_scan_ns+0x684/0x850 [nvme_core]
> [   13.045858]  ? __pfx_nvme_scan_ns+0x10/0x10 [nvme_core]
> [   13.046414]  ? _raw_spin_unlock+0x15/0x40
> [   13.046843]  ? __switch_to+0x523/0x10a0
> [   13.047253]  ? kvm_clock_get_cycles+0x14/0x30
> [   13.047742]  ? __pfx_nvme_scan_ns_async+0x10/0x10 [nvme_core]
> [   13.048353]  async_run_entry_fn+0x96/0x4f0
> [   13.048787]  process_one_work+0x667/0x10a0
> [   13.049219]  worker_thread+0x63c/0xf60
> 
> As large folio support depends on THP, only allow bs > ps block devices
> if THP is enabled.
> 
> Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

I guess 0-day and syzbot doesn't test non-THP kernels, or they just
hand't tried a block device with a larger sector size yet. I know LTP
had their code updated to use the new limit so that'll take a while to
propagate.

  Luis
