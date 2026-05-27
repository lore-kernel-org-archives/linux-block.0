Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36613EAC83
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888435; cv=none; b=WY9L1zCVJCZpVPytEsWQcIu1qrex4fX+0Wf4dw8MrrU3D3MkatpIb2s0ISr9bvfwzckLbHODRdiX7BfAD6el9SvOSYoIxSMzprdscDkk/ExbJ94VxM2Kg/TdZQz3dFCvTdvIKuOCsXxzKeoqy+3KCGjYw8xHXfp7VuaDo5d7bGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888435; c=relaxed/simple;
	bh=aKVdClkVAAIcNWBgFanae1AaXYbQeCnBUy0UDcxO8kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywojlxc/CPP+7eTOUfL9azvK+m11Ld3y2J9a/5D/MhOev8cpXscEDFoepCnOn7tQ0Vz8HcbWU6i4D9Z2raFvdhFCEmiGxTrzG2IXHmCkFVR4fKYmUHKCpTLDJ4zaeIo6uYTbG9JMsqZBHCzblfG4OYn75onGuFDCyQOtbFjKTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPahrZwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPahrZwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E53E1F000E9;
	Wed, 27 May 2026 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888434;
	bh=RHD5j7gB5Xdgd7LW+ZrE6dndSyx+q5rwokvar81A2+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JPahrZwHShfjyDuQ2aMEjQHzzAu9cGToVWE9W2m3NtAu4FaMFlzZCAWaejtw7LxCv
	 LdQt2SYsGWBWZKdF/1x9dX0KXQKqOvul1bMOQvFIdhTTUXQYRcGYKOGedTGg7imAoA
	 P1D3xLzTyWsId7NR3AFdZteKB0SAk1kZAohlOyYwPe9vHqwFxFMnjidPTCAF53MfOn
	 UzC1sNHhWEi5Ey7y7a43pE47KIhxEDxXEnwo7SFLDRCjInNdqSrdQBmLuNEh8qA9w6
	 bCiOBEHg517GfHqGIAHO6NZzQT5KnKFQO9JOqb5+X3bahIIqNhB1nye7NUxUpjtRGZ
	 bdjx1vmDRNtnA==
Date: Wed, 27 May 2026 07:27:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	nilay@linux.ibm.com
Subject: Re: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
Message-ID: <ahbxMLlLH1KlrD1P@kbusch-mbp>
References: <20260526153921.2402015-1-kbusch@meta.com>
 <20260526153921.2402015-3-kbusch@meta.com>
 <20260527131657.GB10351@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527131657.GB10351@lst.de>

On Wed, May 27, 2026 at 03:16:57PM +0200, Christoph Hellwig wrote:
> On Tue, May 26, 2026 at 08:39:21AM -0700, Keith Busch wrote:
> > +	struct nvme_ns *ns = q->queuedata;
> >  	struct request *req;
> >  
> > +	if (ns && nvme_ns_head_multipath(ns->head))
> > +		rq_flags |= REQ_NVME_MPATH;
> 
> I just wanted to come with reasons why it this is wrong, but it actually
> seems already - we only have a ns for multipath nodes if multipathing
> is enabled.  Maybe throw a little comment in on that?

Yes. An added subtlety here is that we unconditionally set
REQ_FAILFAST_DRIVER for passthrough requests, so it does not get
failover consideration. You can't steal bio's from a REQ_DRV_IN/OUT
request because all the necessary driver info is attached to the
original request, which doesn't follow the bio.
