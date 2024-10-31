Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296791BD9E4
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379544; cv=none; b=ZJ8OUSgatx69kp0SstWzt4nhNco/cT6ML8Xj1RAzNrFEdeuyfpYaLa3vKNNXU4hzE0vkYynKJzMYNBe5H1k4mNihplFSkYrdtDH2LXKdYTbfSPRAxVP7dge5j4rlgPirtxbkFh2eI5Lg/O1zJTFz0BWsg5/8d3f4Eh9o5xh1oaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379544; c=relaxed/simple;
	bh=pMDnqOT9jURegdfJnhDfvqdjmMnKEHAuDqwQKKNF4jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOKbnO+xDpdx6lDzOpJ2531Y3wVqG3kSM58QoNnz4m9X64BVDf9nYm2ueIIyqQ8vmew+3DtgKQ8iksxb1yyZqrBfJ4wb/yJdgBSRULnx8xUikMl219lQO9waFvXlXKw0pSrjAlOio4psrMI/L7UhjGFR/brrxkIoU+w3xI1WjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A69668AA6; Thu, 31 Oct 2024 13:58:57 +0100 (CET)
Date: Thu, 31 Oct 2024 13:58:57 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kundan Kumar <kundan.kumar@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: drop some broken zone append support code
Message-ID: <20241031125857.GA17841@lst.de>
References: <20241030051859.280923-1-hch@lst.de> <8b043769-d733-418b-a418-f558d0a21c2a@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b043769-d733-418b-a418-f558d0a21c2a@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 06:47:26PM +0000, Johannes Thumshirn wrote:
> IIRC this code was once used by the zone-append code we where using in 
> zonefs, but that code has been ripped out, so.

Yes, I already had a chat with Damien how that can be done the same way
as in btrfs and zoned xfs.

