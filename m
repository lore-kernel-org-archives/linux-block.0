Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5521D1730
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049763; cv=none; b=qOitndfKBBOF+WpS6aCWVMQlbCrl4Jc9XUvN/wsSseIgA/AZ4LC5FsXoHLNE5ljl9T1BxbGEWc9KOasLpUvN5YNPqzqh5qgfvJtp+9BIi9IYeNPNeDfUAnr2o8nordtDXrSiJtlrXIlDeazISRe6Xpsaj5DUyWJyfWVz/L4pYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049763; c=relaxed/simple;
	bh=dCl81mcWA14DTvOsqVdS+hVuW2HlC+FtUlF9T1wOKhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnbN8OU26Wo2MUedmR8U6Z/CRiEDrKVR3IN+WN5oLAr134wVohOkxPsG/rTuPk5j5i0bJESwp8vbtlEVLkSTadP1u99YeftQt4WdrmI5hRbeqA9cT4yzAkzSRione3ZORsOaiiucaZ7aQt4GFdZv4877ofUKTxJBLE8k/F2XE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 356B168AFE; Fri,  8 Nov 2024 08:09:18 +0100 (CET)
Date: Fri, 8 Nov 2024 08:09:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: max_hw_zone_append_sectos fixes
Message-ID: <20241108070918.GB9216@lst.de>
References: <20241105154817.459638-1-hch@lst.de> <bfc380c1-c198-4a41-97f7-f286e3692879@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc380c1-c198-4a41-97f7-f286e3692879@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 07, 2024 at 03:35:14PM -0700, Jens Axboe wrote:
> On 11/5/24 8:48 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series has a fix and a cleanup for the max_hw_zone_append_sectors
> > change.
> > 
> > Diffstat:
> >  block/blk-settings.c          |    2 +-
> >  drivers/nvme/host/multipath.c |    2 --
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> Given the recent revert, will you respin the parts that makes sense?

The first one should just be kept as-is.  But I can resend it separately
justto be clear.

