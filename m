Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479D252905
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195412; cv=none; b=AiNm2IT9qsZzssMM7ku9QLhEBZc9U6Xk4HICaprXyZKNioUYPNPgo9lnH3lBgB66LE5kiBH4HDeHzreXh0a/bOMen8PS7RYSx6KI9Cw4JXahMD9oUNwDQlFvsx5/F2WzWW69x/jiJdL69aBlKNZRh/gwJhrcncSsu6lfcpu0rvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195412; c=relaxed/simple;
	bh=NQOcCxqskyP1ipRjtNb0ugpxJwqaem9utR6aCV6GCUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdY/60ljruAX5XR+4/vaZ+gxfSh0N8R5KbmP3rGToqqaeZkjWAjUt/oC13VRamSY8xUcRE1YnfgTFgg83uHdSgy5dYuH/RFh3BgxqPviTdS9dIdpOTAvxRQPwUGe9nsASmhCtu+G3Ycy2z01/lu0xOc5+/SHzmiTq73eVCFXaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56BBB68AA6; Wed,  9 Apr 2025 12:43:26 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:43:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, hare@suse.de,
	sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250409104326.GA5359@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-2-nilay@linux.ibm.com> <20250407144413.GA12216@lst.de> <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 08, 2025 at 07:37:48PM +0530, Nilay Shroff wrote:
> >> +	 * For non-fabric controllers we support delayed removal of head disk
> >> +	 * node. If we reached up to here then it means that head disk is still
> >> +	 * alive and so we assume here that even if there's no path available
> >> +	 * maybe due to the transient link failure, we could queue up the IO
> >> +	 * and later when path becomes ready we re-submit queued IO.
> >> +	 */
> >> +	if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
> >> +		return true;
> > 
> > Why is this conditional on fabrics or not?  The same rationale should
> > apply as much if not more for fabrics controllers.
> > 
> For fabrics we already have options like "reconnect_delay" and 
> "max_reconnects". So in case of fabric link failures, we delay 
> the removal of the head disk node based on those options.

Yes.  But having entirely different behavior for creating a multipath
node and removing it still seems like a rather bad idea.

