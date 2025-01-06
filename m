Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D61D86C0
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151911; cv=none; b=XxGYI+PwAACIPKQ6/KpaAmpodhSA5EccZ5Hs9KQrkTQu0/DXwrkfDgTL7wevkxuzBYNNuHmzvRJKi/T4ZM4T/TAutLRDbQ4+9W7GSTqxW8H+Wl6int8Lk9RlQpgcTjvE3Rr540c6PBRbDYMcsy2Z2UxKcqyFOzrKIkZLVYaBeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151911; c=relaxed/simple;
	bh=EDQsXm6H/m/b+U3WnWIoU03QXlhcKPC3Hmo72ckaZrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWFg2jHKaWyLQLwCpHstgL4y9JLLNaSTlbb8M8+CP+1miGL06xf8V+FZhNYFlZpZG2i4h1fc8nKpJeHQKfU9qsJBlsr1TgXMPhfYf8St0O3TMn9rzDXYtOdQD3Nqbc2HFovaLfRbCodXEfuxOFuSbn4q5FoQtzCn0l7axfeZs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55A3868CFE; Mon,  6 Jan 2025 09:25:01 +0100 (CET)
Date: Mon, 6 Jan 2025 09:25:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250106082500.GA18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104132522.247376-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Did you find an exploit on my development laptop to find what I'm
working on? :)

I've got the same patch sitting here locally together with a few other
cleanups from before the holidays.  But the problem I rant into and
why I didn't finish it, is that is that the lock order doesn't work
for __blk_mq_update_nr_hw_queues which freezes at a very high level
and then does a queue limits update.  Now the whole changing of the
poll flag there look a bit questionable anyway and I was going to
look into how we could fix this, probably by retiring that flag either
just for blk-mq devices where the information can be derived from the
tagset or entirely.  I'll try to get to it ASAP.

