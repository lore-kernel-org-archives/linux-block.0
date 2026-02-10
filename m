Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9B3EBF25
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738114; cv=none; b=DQz0vhiPcCp5Q/9TGF1aqhgvQ6x5mJEGo5J3qo8sNWAwxNiaKIO/gmszloU54vXg3HLFTl+9mR6EBlBdJ+U1ndH7UTq4fvQGArEgA8M1A7NA0QE70tXowrUSy8VQVexEFyOnsmfTQxwDobJxM4a/+0mUq8igTlvifWdHCeXGiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738114; c=relaxed/simple;
	bh=2zkeqanxlrb4TMJQZigAqzkJZDDSTE2t2sVst915WCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymaez/7LC8Tx1w8HPEHjFg1hOlpHv4ayftVaI25eaSMXtvhchYC0XbCFqAfhwYNks96r1XDl2bYa0aJ03RIO5V1fwUeG3SEe9a3euimtsFcBmBaT744McIvMEHMTfH8eg3KqC5SE/7YOHKUJoHeYX5Kpol+mkvtoVllGhcMbSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B92D168CFE; Tue, 10 Feb 2026 16:41:50 +0100 (CET)
Date: Tue, 10 Feb 2026 16:41:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai@fnnas.com>,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, sven@kernel.org,
	j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect
 debugfs file creation
Message-ID: <20260210154150.GA2844@lst.de>
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-5-yukuai@fnnas.com> <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org> <aYoaWwI-sl5hK6s_@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoaWwI-sl5hK6s_@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 09, 2026 at 10:33:15AM -0700, Keith Busch wrote:
> > This is not clear to me. Why are concurrent queue freezes not allowed
> > while debugfs attributes are created? I don't see any code in debugfs
> > that calls back into the block layer while creating debugfs attributes?
> > Did I perhaps overlook something?
> 
> I had to look up the original commit that introduced the WARN,
> 65d466b629847. The commit message says "Creating new debugfs entries can
> trigger fs reclaim", so that must be the path that enters back into the
> blaock layer request_queue.

Another way to solves this would be to scope all the debugs action
as NOIO context.
