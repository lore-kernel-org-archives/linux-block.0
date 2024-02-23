Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2983CBD
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703928; cv=none; b=aDpK6TDbqU5VWJYsweTFpON2wBTjuwGc4wqE0Xpkg3bsNEggcNXE1zrffuK2zN3Xi8dMwROhgQAkkWEKKMp+pgDCFuW2LGDFM2f8zev7EqLUI6yea8+h+WVn7qq0TtgNxuGZOcnQ4bA9+EkG5oon9ixZ3wsLCXFRMbnRijH+H7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703928; c=relaxed/simple;
	bh=90ZD0EQUhD6fJgwU8WdGRjCLu+3FSFgOAkRfqTl+t1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWRQBDGMCM+MRVK2N/mk7tYh1PLO6Im5dDAG7tqZ1Dzp0YZNYrT/Qt+AcNwMdHUvP1aeYvFgrsxeFwNhSy1MsDQRhPE3/ymPAWP9JI44r2FLvf8zSYKKg10bkUG2vbCmnI4Up+arYbvaY+pR0wwMMHLJBL83Z4YshT5G0Z7lCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reWjiXNp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reWjiXNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E0EC433F1;
	Fri, 23 Feb 2024 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703928;
	bh=90ZD0EQUhD6fJgwU8WdGRjCLu+3FSFgOAkRfqTl+t1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reWjiXNpX+8lOIv/vE5DR7NFgab1x7fKwo9VuFLGqBZOvOtSw2WRe4S+VAjvosJk+
	 LKpD4BsX0t+s0PWyaSpjVcFZ7qRa+NAA2v4QdH1fYJoe+wIkBccPQw1Aqnv6rN43pI
	 V43DgvxBEa0kJkhV5WacB2Ocs45Y2viyzMOnUqnmz4+CVftzQ0umM8fhK4LGcn9uIJ
	 2S1JqfGWX6l8Rbfz2arQvr8uomy+94x+yUTSKNxOF5fjnhE4HSMHifd2K+YX9zQT6x
	 MM5ig4cqPuCMyWwCpOftwQmFtAwKkgRc+PxZFSX7YM3oLEThKa363G2kABdKp6dZx5
	 Yu2P66Dp7kg3Q==
Date: Fri, 23 Feb 2024 08:58:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.org, ming.lei@redhat.com, chaitanyak@nvidia.com,
	Conrad Meyer <conradmeyer@meta.com>
Subject: Re: [PATCHv3 4/4] blk-lib: check for kill signal
Message-ID: <ZdjAtdut9Pkgq_79@kbusch-mbp>
References: <20240222191922.2130580-1-kbusch@meta.com>
 <20240222191922.2130580-5-kbusch@meta.com>
 <50f7c805-d562-4084-8f4f-4bf0e223ddde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f7c805-d562-4084-8f4f-4bf0e223ddde@linux.ibm.com>

On Fri, Feb 23, 2024 at 04:30:14PM +0530, Nilay Shroff wrote:
> I think if fatal signal is intercepted while running __blkdev_issue_write_zeroes() then we 
> shouldn't need to re-enter the __blkdev_issue_zero_pages(). We may want to add following code:
> 
> @@ -280,7 +306,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>                 bio_put(bio);
>         }
>         blk_finish_plug(&plug);
> -       if (ret && try_write_zeroes) {
> +       if (ret && ret != -EINTR && try_write_zeroes) {
>                 if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
>                         try_write_zeroes = false;
>                         goto retry;

Good point, I'll fold this in.
