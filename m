Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7832561AC;
	Fri, 25 Apr 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587725; cv=none; b=YEmAYAN5VwY7zjuoAmVaFcNcJVMMHVgkhVXmtlsQeM2MTdcV/KAxoOmKjHfhPKsyUUUE8Q3D7HiBL4wOm65o6YxxTK1qakSe5/czzQflcYgH5QGnsW33AfbrSGyxcyW0C/0oSyBzGI6fU550RF73AcLX3YjQaVLLYQJIalqXTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587725; c=relaxed/simple;
	bh=t7qSU/IIIuYq1lxN3qMcq4LPGAf2mcJQYiI6P44d0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCCfb5fD8URfBffrzs32OhOvgYZ8r4EUypDlmXLwgqgYGNyF3R0rtLBQHXAGPdM+9lD/eVJDT3DW1SEdraJfG5ySbxjw0u7wL14leLJZn/HWawyYXXFJ7QF6a8ipD4IsithWq5WwzQXIOyIOTnzj0BEKqbrGDEC9mfzaFxIcags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ovfAxpgz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ovfAxpgz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vlE74K0LimainSdnoFlqcyVYaVSQnmACb6u5i0CwKyc=; b=ovfAxpgz9/2ZldfFISlzn37R2N
	N8EFk71S4CItvdyyRRcm3DUc7bnLrjz7kCxW9NJ4Wc/jKXXd6vBuAfWML+ZPsLlXQgtkxDfB9cWJK
	ILm1XH9FdY32lrHLu5jWLz672KLYDgMmZYahFT4U+9oiHocTrGnn2SmOMkpgZpv0S7j9ajGqj1XlT
	d80P5yDGGBqnDIpozdUD+kwzp915To2IuE9HTw0uuMc7sq7U6ZnH2MAeYfdV2OaP5ajPOQwcEyMQp
	6W9djK5G4vVydr0L8ZDt+Qz1PGNc2wgYrkUe9LeYkhj6mVEX8gzLEdhZzSd0NPdBjSH2/H/jYXIRH
	PvUfCDMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8J6h-0000000HHN9-3OF8;
	Fri, 25 Apr 2025 13:28:43 +0000
Date: Fri, 25 Apr 2025 06:28:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] loop: Add sanity check for read/write_iter
Message-ID: <aAuOC8djgRrq-Gdj@infradead.org>
References: <CAFj5m9LVuekp_n6pEfs17n6QB3Q0yu-qRP67NOJb9ZXRNyhP3Q@mail.gmail.com>
 <20250425053803.3614260-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425053803.3614260-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 25, 2025 at 01:38:03PM +0800, Lizhi Xu wrote:
> Some file systems do not support read_iter or write_iter, such as selinuxfs
> in this issue.
> So before calling them, first confirm that the interface is supported and
> then call it.

Nit: commit messages should not have lines longer than 73 characters.

Please also add a:

Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffered I/O")

and maybe add a blurb that vfs_iter_read/write had this check.

Now the other interesting bit is why we did not hit this earlier with
direct I/O?  I guess it's because we basically have no instances
supporting direct I/O and not using the iter ops.

> @@ -603,6 +603,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	if (!file)
>  		return -EBADF;
>  
> +	if (unlikely(!file->f_op->read_iter))
> +		return -EINVAL;
> +
> +	if (file->f_mode & FMODE_WRITE && unlikely(!file->f_op->write_iter))
> +		return -EINVAL;

Can we have a common helper for change_fd and configure, please?

Please also drop the unlikelys - this is not a fast path and we don't
need to micro-optimize.

A bit unrelated, but loop-configure actually checks for write_iter
and forces read-only for that.  Do we need the same kind of check in
change_fd?
