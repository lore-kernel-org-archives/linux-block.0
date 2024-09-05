Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4F18A94F;
	Thu,  5 Sep 2024 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521991; cv=none; b=ou9hTSbGTpHBdcMoF6m9GMC97wJnIYc6nAI/ZEM4Fufa/GWIJdO8U6Yfu8FTL7+tXX0SusPC5HpV2OlpZ5npmRCkLAkY2PKzauxA0dLkJbEiwDGy9QJRmuH2lGgMis3HZRSeSPVnWAppltbwNhskUA4Zi9209E7/pSukwhPDlz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521991; c=relaxed/simple;
	bh=vLhiWZWY5LZRLML56ZzTM03yZLxh9KqKyaYHg0U82oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juz9Gc2bfMseJSsjTgF1Hh5iSid6tlR6Eu7mD+V/OKGBFQ9y+XOv/tXdvNCEjvIJsAjEMnBHusbVwND/sN4uDLC+J4TmxxY/1pOFojYrdvCMzfJwYnfODNzPKppB054U6J6jO/GwKI5sizzegd26ZaA8ZB2sa2Dl2vZ6WjqvmWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VnbmaUgB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VnbmaUgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59782C4CEC4;
	Thu,  5 Sep 2024 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725521990;
	bh=vLhiWZWY5LZRLML56ZzTM03yZLxh9KqKyaYHg0U82oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnbmaUgBJqXblFNo5y7gW+hByQBKXIJ58ic0ZNQumj1V11B4oxo5iZFbxEpXqWcbX
	 ki6wwadtf6pmtG6MVS93iqK2duH5WZoL5uTX+vwHPg9jbmpdpyV5RXYZwuwI4krcir
	 43/UEYnCaOTKImszv1FH3fy5hKLrRcy51Q9l7NeU=
Date: Thu, 5 Sep 2024 09:39:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivani Agarwal <shivani.agarwal@broadcom.com>
Cc: stable@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v4.19-v5.10] block: initialize integrity buffer to zero
 before writing it to media
Message-ID: <2024090540-afloat-unroll-d9fd@gregkh>
References: <20240902092459.5147-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902092459.5147-1-shivani.agarwal@broadcom.com>

On Mon, Sep 02, 2024 at 02:24:59AM -0700, Shivani Agarwal wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> [ Upstream commit 899ee2c3829c5ac14bfc7d3c4a5846c0b709b78f ]
> 
> Metadata added by bio_integrity_prep is using plain kmalloc, which leads
> to random kernel memory being written media.  For PI metadata this is
> limited to the app tag that isn't used by kernel generated metadata,
> but for non-PI metadata the entire buffer leaks kernel memory.
> 
> Fix this by adding the __GFP_ZERO flag to allocations for writes.
> 
> Fixes: 7ba1ba12eeef ("block: Block layer data integrity support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Link: https://lore.kernel.org/r/20240613084839.1044015-2-hch@lst.de
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
> ---
>  block/bio-integrity.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h
