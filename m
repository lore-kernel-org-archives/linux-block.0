Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251118B462
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882382; cv=none; b=qJ1G2+JGJq5rhP+4Qa+IIUeg4+Jh59K2Fm6UG/JSFXZjEuvJVmEBceDu4z85BoOrXSrq+NUNkOA9iqJMYY0WjhWOgEAtO10MurZw95L6VSQwhfSnd1HVu2obBhORdODZ0v7Y/NCKkVCG04LAS6DeBACrjwQb/+gsPrKZOx8SC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882382; c=relaxed/simple;
	bh=nK+DKU8R/892Npv5VNoD6gVBT3X5jpjjNq8nhAMYveQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K99JwpM59XwhMvSN8jaEbYrVktniUp2QkDY4B2s3dGZPeB7Az02j9dP5Dsk3KEX8fbiEyD24F24EuzfaCuyV8kTh6+NHNklbhgELK5w8zoItqoDmP8aZc9b79szl6URf2bA/MNZdJ5KT29BQj+n8+qBRAAXOsyfXOiMDQMBF0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H79EBFqm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H79EBFqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D04C4CEC3;
	Fri, 25 Oct 2024 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729882382;
	bh=nK+DKU8R/892Npv5VNoD6gVBT3X5jpjjNq8nhAMYveQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H79EBFqmzkvZm7HqYnZs02qna7CZByoORFxPYZCFSD+v4N8xxe7sX6VDHTf0j7Rco
	 6wxvfhUEIs2y5LXJ0C2qgB0BmYjQfc7WT1iw/nnxZhZZRgqPTgjKZL+7btpSZBiiFu
	 YmYz+ZKWyTr6way0+hXyrvgbsHWyv8NkRdYtp5IZH++QV808Tk3CdnTRv27pZPcvp6
	 l3wPzL0WaHh+OMOJeDOPJTCIjWNJBLSixSUXM3SDfGS4vm1BVN/P0M2U5o7/CzTLt7
	 9YziHp8MuILQ9Y7AwRnyISUrJRdGPCqNhTW80XcB/mkS5DnQ1/U7BPCf+CUyooE3P4
	 XMFlCVd9dD1Gg==
Date: Fri, 25 Oct 2024 12:52:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, ushankar@purestorage.com, xizhang@purestorage.com,
	joshi.k@samsung.com, anuj20.g@samsung.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix queue limits checks in blk_rq_map_user_bvec
 for real
Message-ID: <ZxvpC4un8aTLgHPT@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025115818.54976-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025115818.54976-1-hch@lst.de>

On Fri, Oct 25, 2024 at 01:58:11PM +0200, Christoph Hellwig wrote:
> blk_rq_map_user_bvec currently only has ad-hoc checks for queue limits,
> and the last fix to it enabled valid NVMe I/O to pass, but also allowed
> invalid one for drivers that set a max_segment_size or seg_boundary
> limit.
> 
> Fix it once for all by using the bio_split_rw_at helper from the I/O
> path that indicates if and where a bio would be have to be split to
> adhere to the queue limits, and it it returns a positive value, turn
> that into -EREMOTEIO to retry using the copy path.

Nice cleanup.

Reviewed-by: Keith Busch <kbusch@kernel.org>
