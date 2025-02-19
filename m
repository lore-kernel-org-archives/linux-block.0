Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D425760
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943729; cv=none; b=fIipqYE1WcKNmlqix0/1RBmHdqYhF4AZD/9DMAug6hbpIOO0ZK1DopgEUljqon4ATx2kp2WrNuETxci/f83k6t9Q8It16fB1Enhr9mJriq3If1U7Ww68pXK8YZYvjMP6mMOxBDtzSMyseCOvL28xgX/6MBec+DTqaDlE2cAp8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943729; c=relaxed/simple;
	bh=q/qG8vxYgJzmOohaLoN2Iap+hQaMmpOLIth8MheXkAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9qSUEpsR7UOomCg0brIEHg2S4fudL05Q/owyCOWzJ2OtS5akLeHKqyOUG7exLzXHU5GX8mNB7C7oDqD38oZGg+3lS71n2xryh3koBHUATTH5HFJwMuaJhnnHH9MMhr6SGJh7dxnR8rZoGwIRr2lgKrvC/0C/MsngWvrymyAKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07CB967373; Wed, 19 Feb 2025 06:42:03 +0100 (CET)
Date: Wed, 19 Feb 2025 06:42:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org, dlemoal@kernel.org, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <20250219054202.GA10395@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com> <20250218082908.265283-2-nilay@linux.ibm.com> <Z7R4sBoVnCMIFYsu@fedora> <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com> <Z7SO3lPfTWdqneqA@fedora> <20250218162953.GA16439@lst.de> <Z7VO-z1cZfFLYaMt@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7VO-z1cZfFLYaMt@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 19, 2025 at 11:24:43AM +0800, Ming Lei wrote:
> On Tue, Feb 18, 2025 at 05:29:53PM +0100, Christoph Hellwig wrote:
> > On Tue, Feb 18, 2025 at 09:45:02PM +0800, Ming Lei wrote:
> > > IMO, this RO attributes needn't protection from q->limits_lock:
> > > 
> > > - no lifetime issue
> > > 
> > > - in-tree code needn't limits_lock.
> > > 
> > > - all are scalar variable, so the attribute itself is updated atomically
> > 
> > Except in the memory model they aren't without READ_ONCE/WRITE_ONCE.
> 
> RW_ONCE is supposed for avoiding compiler optimization, and scalar
> variable atomic update should be decided by hardware.

Nothing force the compiler to update atomically without that.  Yes,
it is very unlikely to get thing wrong, but I'd rather be explicit.
And make sure static and dynamic analysis knows what we are doing here.
