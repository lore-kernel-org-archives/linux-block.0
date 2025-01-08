Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DC19B586
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736315085; cv=none; b=Q+S2tBJADFl9fH7K7fXyoddq13taZng5pSRVsBuPwmqK3ZvlS1LBiW3iI6ffiG/0CudbwnG/BXCKW1fUOKIScBX+rMuyIxnlcfRF6US26Un/KAwYkEkOJ9w3TQhF8+k4H6qipitaXYv/qVzG17tYfJdncls2q+FdcSbfQqOZPVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736315085; c=relaxed/simple;
	bh=/lxywidDzjzTzseS0D5yW2/p4trkUPm/8IkIHFtDLSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWvgB1TCxAixqT+Qk0SKoK1O61012bsVS/4/mw4OBVN53BOzA5xHhalhITCeypyo3InFMQIGaFjOrXIgXrI+CjsP34YDt1ewNxisZBAjyVW604HXz0azYbqE/PrObsnflHxDV3xsuu2bW7cDG4JARcXfRc+7q7gim0BKCZ9lStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B5BB68BEB; Wed,  8 Jan 2025 06:44:36 +0100 (CET)
Date: Wed, 8 Jan 2025 06:44:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250108054436.GA20178@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk> <20250106152118.GB27324@lst.de> <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk> <20250106153252.GA27739@lst.de> <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk> <20250106154433.GA28074@lst.de> <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk> <606367a7-9bb5-48e5-a7ef-466eefd833fb@kernel.org> <3a1314db-ed44-4c22-8fc1-0cf672003026@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1314db-ed44-4c22-8fc1-0cf672003026@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 07, 2025 at 02:08:20PM -0700, Jens Axboe wrote:
> > ublk backend driver to do the same as zloop in userspace would need a
> > lot more code to be efficient. And even then, as Christoph already
> > mentioned, we would still have performance suffer from the context
> > switches. But that performance point was not the primary stopper
> 
> I don't buy this context switch argument at all.

The zloop write goes straight from kblockd into the the filesystem.
ublk switches to userspace, which goes back to the kernel when the
file system writes.  Similar double context switch on the completion
side.


> Why would it mean more
> sleeping?

?

> There's absolutely zero reason why a ublk solution would be at
> least as performant as the kernel one.

Well, prove it.  From haing worked on similar schemes in the past
I highly doubt it.

> And why would it need "a lot more code to be efficient"?

Because we don't have all the nice locking and even infrastructure
in userspace that we have in the kernel.

