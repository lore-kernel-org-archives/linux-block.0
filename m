Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063213A3ED;
	Fri, 31 Jan 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308596; cv=none; b=tEKMHjmChYXAZ7XZRMsaKR60uoSodzH1EgzLHt4FrYKl2Gb2EhBko48hifkXq1e2r8yIW+UH0tfltX3fUMy62paCLFtkoPv0AHHakJEhWdv2ky7KF/O0Y/l1EG/ha0epb62t4aVZyT48WWwcGdiJG6rU2fFh5nW4fRwOTV0G3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308596; c=relaxed/simple;
	bh=5uu/bb9+cmSh28wdRtBdVhiFq95GFW7KguaApgrYugI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqWe0oZE3qaRPED9pskfT/FMN2RXarYPsaB+99NdSBTJd07z5CSxxx3Ftao0wbx70nohTtMu2x6SRKnj/O2ziw0tpSzo/6pts3GfDnoaAMTVYB2OJ/VD2nDJYpIlBXEh2mJXBf/ecPQvkp+Yap40QbLM2JV6Dp77dgO7Z/yFpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F3BF68C4E; Fri, 31 Jan 2025 08:29:48 +0100 (CET)
Date: Fri, 31 Jan 2025 08:29:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
Message-ID: <20250131072947.GB16012@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org> <20250129060534.GA29266@lst.de> <216ab5ef-1c8b-4f3e-8a1a-f11e28994620@flourine.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216ab5ef-1c8b-4f3e-8a1a-f11e28994620@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 30, 2025 at 04:25:35PM +0100, Daniel Wagner wrote:
> On Wed, Jan 29, 2025 at 07:05:34AM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 28, 2025 at 05:34:46PM +0100, Daniel Wagner wrote:
> > > If a lot of request are in the queue, this message is spamming the logs,
> > > thus rate limit it.
> > 
> > Are in the queue when what happens?  Not that I'm against this,
> > but if we have a known condition where this error is printed a lot
> > we should probably skip it entirely for that?
> 
> The condition is that all the elements in the queue->send_list could fail as a
> batch. I had a bug in my patches which re-queued all the failed command
> immediately and semd them out again, thus spamming the log.
> 
> This behavior doesn't exist in upstream. I just thought it might make
> sense to rate limit as precaution. I don't know if it is worth the code
> churn.

I'm fine with the rate limiting.  I was just wondering if there is
a case where we'd easily hit it and could do even better.
