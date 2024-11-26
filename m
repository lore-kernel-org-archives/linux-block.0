Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB310192B96
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617237; cv=none; b=AXvSHhkeNnS+iI1rO/RMdp4Wm7/paqkopbLr0hx7Hw8IF0QjdLYv1i0ot3MFAu/i5MVZ95Seht//HfiiuckY/z891ujjnfq3Tfz4P/qpbhOaiyhSpNr1GDJVJrxaYnZtRNTlwcxqYgz48AKRUxwgLFl6pPlgJbaBuVr3QMfg+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617237; c=relaxed/simple;
	bh=nfcs6IkK4Z/uLUDPbiUhNhp9EzSIGmUPS1Qeevj35e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7EuTBCZnaU/16FmPQuWKHhTarITmB6aiBZmO2rSGtGa66ejQKiwfdP9zkq7xHXHe8ixRlbf80p4aEk2KA+lm6mOQ033j2kptslwr+O9Y2ISxLIu8b97MWtC7JuoSoYVZnnR6EG0cSSnXTrs1rFcPcjYfKG29knJYt7tH3uCO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0716968D80; Tue, 26 Nov 2024 11:33:52 +0100 (CET)
Date: Tue, 26 Nov 2024 11:33:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Prevent potential deadlock in
 blk_revalidate_disk_zones()
Message-ID: <20241126103351.GA16537@lst.de>
References: <20241126085342.173158-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126085342.173158-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 26, 2024 at 05:53:42PM +0900, Damien Le Moal wrote:
> in disk_update_zone_resources(). disk_free_zone_resources() is also
> modified to operate with the queue frozen as before by adding calls to
> blk_mq_freeze_queue() and blk_mq_unfreeze_queue().

This now adds a queue freeze to disk_release for zoned device, which
previously didn't have it.  Given that at this point no I/O on the
disk is possible, and the freezes are quite expensive that's probably
not a good idea.

> -	blk_mq_freeze_queue(q);
>  	if (ret > 0)
>  		ret = disk_update_zone_resources(disk, &args);
>  	else
>  		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
>  	if (ret)
>  		disk_free_zone_resources(disk);
> -	blk_mq_unfreeze_queue(q);

So for a minimal version you could keep the freezing here.

