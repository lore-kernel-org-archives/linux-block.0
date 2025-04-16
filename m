Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458411E5B7D
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779229; cv=none; b=DV9FiwDbHeg2EDhn8SmZkk8kYCfM1+pcZUhNeOpANKBezxB9E6tDaM+YlANvO0wWNM6k5Q5gsK2oV4TAenT2k+IQ80AkgIKiHLe3JfQqKC04tqI9hK0A/MaFJhed0K1KONJVBM9uaK7taFVfxbU2V4jS6H5Mfo7LdnSWPJ0xQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779229; c=relaxed/simple;
	bh=QlD8QmF51pCLx6FtYBTEcgs3NGVWsY0bCck9ANmfF9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FelFYFH67l7htBD8UExiwEzNvBj47tFvs8WKk8aEuK4X2qzdP8oReEPl1x6nbAl4S+20ebGvJxd/ZnvAvbw7QJl6gbBiwKEZA1f6W5CxebAKIAOGLlcaiU6MRItn2DnDK2kaNxKIalsIAWzrjlXiZhHSOR38DCQ4fzQLOz8hNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBB6968C4E; Wed, 16 Apr 2025 06:53:40 +0200 (CEST)
Date: Wed, 16 Apr 2025 06:53:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 10/15] block: pass elevator_queue to elv_register_queue
 & unregister_queue
Message-ID: <20250416045340.GA24278@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-11-ming.lei@redhat.com> <20250414062209.GC6673@lst.de> <Z_3E8mrvV_tTHZE1@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_3E8mrvV_tTHZE1@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 15, 2025 at 10:31:14AM +0800, Ming Lei wrote:
> Please see the following patch, especially elevator_change_done() in which
> the old elevator queue is retrieved from the context structure, then its
> unregistering can be moved out of queue freezing & elevator lock.
> 
> Same with registering of the new added elevator queue.
> 
> I will add more words in commit log for this motivation in next version.

Thanks.  When bisecting or using git-blame finding a following patch
for reference is really hard, so please make sure commit logs are useful
when standing alone.

