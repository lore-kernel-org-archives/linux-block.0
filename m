Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0418A95A
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504099; cv=none; b=uksBiys98myr6Yne2yW4SD3wNC/+lcBGovQhM+eJTm7x1Jq4+bIo8o0VhGXAwzhEqMYZEjxR00DYB3O0TtPbUU40K/FURq1GU8NVoMEMTcGod9ekq7KoNECnJgqubWFjFl7pv/AXDqqf6RA0lL+vAbSkbXiOHzq06a0cSBdUp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504099; c=relaxed/simple;
	bh=iBEh4NkVZzyfbEDEDylfB6sGfJWkPJrHXVMblUtMKIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyxjNOqa10aK6cc/0TtKFQyphTQmvJfg8q9xCLfMThNUky9KZMPNHgtGimpn9LTto1Ab5oBQbFnwoVGKGUQkl3BRor5Q3G41p6xbgRa+y6uoMGjm8H0peKryO+QSUsVQdf+lfy8KHI3hAViordeqQpTCruMxjRzEkgdRnJkVLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D4BE68D07; Fri, 10 Jan 2025 11:14:52 +0100 (CET)
Date: Fri, 10 Jan 2025 11:14:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
Message-ID: <20250110101451.GA12633@lst.de>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellström wrote:
> Ming, Others
> 
> On 6.13-rc6 I'm seeing a couple of lockdep splats which appear
> introduced by the commit
> 
> f1be1788a32e ("block: model freeze & enter queue as lock for supporting
> lockdep")
> 
> The first one happens when swap-outs start to a scsi disc,
> Simple reproducer is to start a couple of parallel "gitk" on the kernel
> repo and watch them exhaust available memory.
> 
> the second is easily triggered by entering a debugfs trace directory,
> apparently triggering automount:
> cd /sys/kernel/debug/tracing/events
> 
> Are you aware of these?

Yes, this series fixes it:

https://lore.kernel.org/linux-block/20250110054726.1499538-1-hch@lst.de/

should be ready now that the nitpicking has settled down.

