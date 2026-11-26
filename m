Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682142;
	b=ZUFf7vrfgJoX4s75YwBCKGD4piFAG5SyWKv3sIKCN2AfwxXxoJ2dIxG1FWL406/s7ya7
	 C8Ize64QwlrSoqyAZ+Zbml81yH3soQedg31U5/H6PrkGKhNUud92N+kR4to0NOSUOWJqI
	 ARZw3SYbqudd13imBKfmxKSGnhWSBfggnFZhOQCpg6UDt24JAHsRTIFfbp2EaIMN/qQxH
	 kXPvY8YG9A5ShtnocyyRPu56HoZ5qyI5HYed+tvaiGfYVwDXMPtXjIQorD2tN36Z/qH67
	 HxgL1ryouN2zrUoJeEuplNxd+HQzlJWYCNd88ZsdiYl3LBaUutwcED+pv9dxvUr0Zeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682142;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=cmfij/bd759EchGi/2WNrc+o366LiwkZl0bxkjbtXKg=;
	b=qEc3hfXfM9ZJ4M/uZdb02T78ugO12kJ22YH8pZNzdkaUrYFtTi5YjLBwuP8HtslcTRjh
	 g2A44ik16VyQfXqnbcE9eO+B5BGQZe1a5ytnmvPgzTglnQt3zJ+BWWY92qN1S9dbzu6HG
	 50RPijxoY5FQT7s4waj3D35lEK029NJNq8VDi1JFD0RI+6yLGIJanwmDZEDSkvmwsTqDD
	 egPX59yAICPImDsJN3pSmsBnSlXY3wakO+VxX3Yd0g/8Kuc5pyjD7JHSic8uA1ApIbDJj
	 hlkE9ruEZBYovpuyU5fQoJWUjdLF9n6F2mFz503okYglKlyaVz2jTAGt7KHU0JQKXRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFE606A31E
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 08:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83CFE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E2D968B05; Thu, 26 Nov 2026 09:35:37 +0100 (CET)
Date: Thu, 26 Nov 2026 09:35:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/5] blktrace: add ioprio field to struct blk_io_trace2
Message-ID: <20261126083537.GB7403@lst.de>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com> <20261124133553.152463-2-johannes.thumshirn@wdc.com> <20261125045820.GD19878@lst.de> <b046d41c-b585-4664-ae0c-cc49b59fde8e@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b046d41c-b585-4664-ae0c-cc49b59fde8e@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 26, 2026 at 07:26:08AM +0900, Damien Le Moal wrote:
> On 11/25/26 13:58, Christoph Hellwig wrote:
> > On Tue, Nov 24, 2026 at 02:35:49PM +0100, Johannes Thumshirn wrote:
> >> Add the UAPI definitions for passing I/O priorities, and with them SCSI
> >> command duration limit (CDL) hints, to user space:
> > 
> > Before we start encoding this too hard we really need to fix how CDL
> > is used in the kernel.  The whole idea of the user configures the
> > CDL descriptor and then the I/O issuers magically knows an I/O
> > priority maps to it is completely broken.
> 
> Well, that is what is out there now for users that use the drive directly, and
> it is in production already. So we cannot really change that.

But we have to.  The current interface is completely broken and can't
actually work properly except for weirdo passthrough cases.

And I've complained about this before, and there's still no work to fix
it.  So no, we should not encode this even further before it is fixed,
as that will make the situation worse.

