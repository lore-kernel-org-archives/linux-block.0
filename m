Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9D157A72;
	Thu, 24 Oct 2024 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746063; cv=none; b=P+Qd1hofbBbd6FFIPmtATo/nT72FL+3l9tJcysEtMVp9vzboyrboY4OMWEXEYMIM0qjF60u0WBzJaXyFLyrujPnX1F0fHwUlYlhguCutyz/FMpLk33drAcyYU4IYvjH7X+HL6OqihfAtJQuV1m9nwMuNWAjKeXrvJDwDG+xtseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746063; c=relaxed/simple;
	bh=P8rOGQWO6qvw0nzMRpphJ77KDhxsEuy6SCn6E7Gc9KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJwWOC44PKYv1Gu38rla5d/9XnennLSe3W/8OgRPpIQLZpsgBLpXhGbTuj+ybinWQWYlkQqtToHi1KhxmEHkrniZ521YFNaEqLK9kxy0zKD0LTFmhOSExwQy5jIDnrWEFXxVPpFtxvPnXCVFO2YoVGiUxeKQ/GG897ZKFKt+n/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA562227A87; Thu, 24 Oct 2024 07:00:53 +0200 (CEST)
Date: Thu, 24 Oct 2024 07:00:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/3] nvme: core: switch to non_owner variant of
 start_freeze/unfreeze queue
Message-ID: <20241024050053.GA30659@lst.de>
References: <20241023095438.3451156-1-ming.lei@redhat.com> <20241023095438.3451156-3-ming.lei@redhat.com> <20241023122115.GB28777@lst.de> <ZxmmPKFksWc5LLlc@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxmmPKFksWc5LLlc@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 24, 2024 at 09:43:24AM +0800, Ming Lei wrote:
> > so that it's clear why the non_owner version is used here.
> 
> There are one more such usage: 
> 
> - freeze in nvme_dev_disable()/apple_nvme_disable() from timeout work, but
> unfreeze in nvme_reset_work()

Then add it to the comment :)

