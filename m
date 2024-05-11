Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7624B23
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468991; cv=none; b=iJ/0js696yf9z9/SOaPqdye1VsW4P4Dr0vQ1c3aECVhvbCTPtoVzd+Nml0P6X9erOkfYbvHuMsCutDV1kXsb+C50h9TXIZaXf754MRwzSPXyfd6BMAyrlxxSmnIMh8hkiIG+bmZjh3386NJRPbF6IlKMsjuwi9JiqANp1yX7yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468991; c=relaxed/simple;
	bh=AWi0gx3lToIxqbbIFbP1FedZRy8oVc7kx3Xb66lvgcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY6TdgILJ0VepQzHD63+hNto685QgoNLzZFxHyFeI+JIaJpD5zg4HnWjd41aJiwb8euy0R1nv8RHSsCDQLeBfEkozEFLE00qSXmH1bNa0EVi+wEaxDsmyD8hgA4XBYFyK/wEBaaMh+rTlgga0tiGVKhC/rRtyCTjusjRRaaZuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iKtCj+rK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKtCj+rK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jxEj842KuniYKu8LNoiseYurt1UDs9Im0HmbnN7/hxc=; b=iKtCj+rK99ZoyuSQNFvbiX6FuF
	rwrIea6SIlfDuChqw+ObQW0a4Gu9sG9AL2/FawdkpM3c5Sb1mc6er4RLFr5XJ3Ii5sIaQrf3PWkVQ
	Pm2g+z5dsliLsYGg5b7m8x8BFD1qN/H/J6GObzCUFzoEkh/C73MJn//O1JzCeus5BnqyCw3g3uJ3N
	Eh98c25ANl2u4eAjvhhmpIrbOfUKvz4ONLWA1o2e16tCxsG0qNFiYIoghWU5W35O67KZ6RfBcKGlu
	pzJOwHbkXvuQ0GYxozgYtQEQH+ipjlmF21V38+gRUNqVuRx5TKxxSLDTrf59CdxZw1qtfLWbCLFKW
	BtB1zzlQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vqe-00000008tFZ-2KPB;
	Sat, 11 May 2024 23:09:48 +0000
Date: Sat, 11 May 2024 16:09:48 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-6-hare@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, May 10, 2024 at 12:29:06PM +0200, hare@kernel.org wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Don't set the capacity to zero for when logical block size > PAGE_SIZE
> as the block device with iomap aops support allocating block cache with
> a minimum folio order.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 828c77fa13b7..5f1308daa74f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1963,11 +1963,10 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
>  	bool valid = true;
>  
>  	/*
> -	 * The block layer can't support LBA sizes larger than the page size
> -	 * or smaller than a sector size yet, so catch this early and don't
> -	 * allow block I/O.
> +	 * The block layer can't support LBA sizes smaller than a sector size,
> +	 * so catch this early and don't allow block I/O.
>  	 */
> -	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
> +	if (head->lba_shift < SECTOR_SHIFT) {

We can't just do this, we need to consider the actual nvme cap (test it,
and if it crashes and below what the page cache supports, then we have
to go below) and so to make the enablment easier. So we could just move
this to helper [0]. Then when the bdev cache patch goes through the
check for CONFIG_BUFFER_HEAD can be removed, if this goes first.

We crash if we go above 1 MiB today, we should be able to go up to 2
MiB but that requires some review to see what stupid thing is getting
in the way.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240408-lbs-scsi-kludge&id=1f7f4dce548cc11872e977939a872b107c68ad53

  Luis
