Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42986C2E9;
	Sat,  8 Jun 2024 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717825337; cv=none; b=Mdg+ZUJP0B5KSrJSG1V+V23d1e7p4JBOHeY8NG2KUV8KC3of5tGDThEDDjS1ETEo+6Ec31OmVniz/bfxUhjk3r94eXubx6rJ3CYccY6cA0h68nVMhw4GV52ftxVIstKhx50ofHem+h9FsePV17tMOrOfWbRb2jlNsY6AcgchShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717825337; c=relaxed/simple;
	bh=4hZLDX84y6rUdaGV4YTTFMAB36MBUU9tn1i0d8P3GNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCFaI3LvIRdc48im8DHFgREH7uY0Wlc/0QR6EWtZut90lts5jzsuX1FCncLSNgiMz29vSvV3Z81kgN556Jw02PuDpOIDfvM6Z4rEOhfHqpC/cjdtBJQkhyeT9vmHCCJuUlHLhdMg5kzitpbUJyQGW56CYFWF2GZXafbzs05Y500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2xdvCeY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2xdvCeY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TBswNXyvYFpnWTGV+vD0o3O4nTKwlw2l+QDeEj0rPvw=; b=S2xdvCeYBC5J0JhBhRa+sDhx22
	j9qfk4aQ0KUHYVkQDYVWUxR5spJP000J8rbN40OkaewQhndezNApj044EB7MtY4WOJgdswdYgi/+f
	ghwBRf/jaAi6oklswC51s5Zzj5/GjWDkqgRjnJ+dHStSQlQ1DgnUbqlfkiT+7xNI/U3D8VgNcZ6Zc
	L6QJlCX6UctezQfxGJddG1s6TEVrrVf6iBPud65u/q26vsgr9C1dm1NC4EXF/ERRI9+oIsiKitqJQ
	9X9QmST1YzQfRCP5iosC54mnhPZluzN6Dn1EDN4AgXajMuS4qGuun73kV1hcMjAOAiwrov7FC3b1u
	JIK487Yg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFoqE-0000000Gg4d-195q;
	Sat, 08 Jun 2024 05:42:14 +0000
Date: Fri, 7 Jun 2024 22:42:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] loop: Disable fallocate() zero and discard if not
 supported
Message-ID: <ZmPvNu-YijbtJkeR@infradead.org>
References: <20240607091555.2504-1-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607091555.2504-1-chrubis@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 07, 2024 at 11:15:55AM +0200, Cyril Hrubis wrote:
> If fallcate is implemented but zero and discard operations are not
> supported by the filesystem the backing file is on we continue to fill
> dmesg with errors from the blk_mq_end_request() since each time we call
> fallocate() on the loop device the EOPNOTSUPP error from lo_fallocate()
> ends up propagated into the block layer. In the end syscall succeeds
> since the blkdev_issue_zeroout() falls back to writing zeroes which
> makes the errors even more misleading and confusing.
> 
> How to reproduce:
> 
> 1. make sure /tmp is mounted as tmpfs
> 2. dd if=/dev/zero of=/tmp/disk.img bs=1M count=100
> 3. losetup /dev/loop0 /tmp/disk.img
> 4. mkfs.ext2 /dev/loop0
> 5. dmesg |tail

Can you wire this up for blktests?

> +	if (ret == -EOPNOTSUPP) {
> +		struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
> +
> +		if (mode & FALLOC_FL_ZERO_RANGE)
> +			lim.max_write_zeroes_sectors = 0;
> +
> +		if (mode & FALLOC_FL_PUNCH_HOLE) {
> +			lim.max_hw_discard_sectors = 0;
> +			lim.discard_granularity = 0;
> +		}
> +
> +		queue_limits_commit_update(lo->lo_queue, &lim);

Please split this out into a separate helper to keep it out of the
main fast path I/O handling.  A little comment that we are
optimistically trying these if ->fallocate is support and might have
to paddle back here would also be useful.

(and maybe one day we figure out a way for the file system to
advertise what fallocate modes it actually supports..)

