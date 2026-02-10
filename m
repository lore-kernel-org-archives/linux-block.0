Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20312FD665
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738073; cv=none; b=L6iEY/zJ9p1Lhs1hqXoFbeoTFUjllghFcbCI9JUA5G1Ye6MSIVKiGPA9QXCB2VdChIgt8jkBlTqoXdAcUtn3tvrlJjf9aIBOjjyUf4Q1W7uqsjY7YZlGvXlSvXEjSUQ+l8+lU3Fn27QJ6OTr2t3ERRaxsDMzzJVsT12FI9G7HnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738073; c=relaxed/simple;
	bh=8piujjumgiPklCiYYgLaRuhHH7eiq9oHd/YV6rmAyQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItUvemuSEAQOxFZ9K/vvcf1Pzpwo2dOesyvA4T07uEdKuUTVyUGKx05NW6Psq9FBrnc3jjkOqbYqIWO7eXot4IYiFIKXelxFMio8CpZTlwmVqjmnKmEfGJTmXmT3UdZB9SOhPxQRhorMQhS/bOdLbaN4bDr63wMSl6pAM0V28Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2779868CFE; Tue, 10 Feb 2026 16:41:09 +0100 (CET)
Date: Tue, 10 Feb 2026 16:41:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Yu Kuai <yukuai@fnnas.com>, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, sagi@grimberg.me, sven@kernel.org, j@jannau.net,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com,
	neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <20260210154108.GB2484@lst.de>
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-4-yukuai@fnnas.com> <20260209145832.GC18315@lst.de> <aYn-xwFHCpd7sITJ@kbusch-mbp> <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com> <aYtKFNm-wRKn6l66@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYtKFNm-wRKn6l66@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 10, 2026 at 08:09:08AM -0700, Keith Busch wrote:
> If you leave the queue quiesced, pending IO will form requests that are
> entered and waiting in the block layer. You can't freeze a queue with
> entered requests.
> 
> We unquiesce first to flush any pending IO that had entered during the
> prior reset. It's not the best way to handle this situation. It would be
> smarter to steal the bio's from all the entered requests, then end those
> requests, then resubmit the bios after the hw queues are initialized. We
> don't do that because no one's really complained, probably because the
> queue counts don't usually change after a reset.

FYI, Daniel Wagner had been thinking about doing this reinsert for
something (I forgot what exactly), and this kind of reinserting from
kblockd would also finally make REQ_NOWAIT practically useful for
file system initiated writes.  So I hope we can eventually get to it,
and it should help to sort out various problems.

