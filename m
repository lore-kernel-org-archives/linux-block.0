Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1023B47E3;
	Fri, 18 Sep 2026 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741348; cv=none; b=eG6U7KoWsO+Tfn0Bt/Ir4PewMaxLaVEwPgw+SmbgyPE52DX+Jyr6261nRSfpHJBc7XPry++0sEElDUa66fDPeqtxVcRsaKDHRn842Kuh1HKoxhqtr72vDbEIgE3YxIsDYvzF3Hw/TqNe+He6KVSV9ovVu00pFZeXG2TUlaKkSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741348; c=relaxed/simple;
	bh=Ii+qkvDcAMwjEh7E9cdXkPI/TGXwRXFJcnVSL1932h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6/QvNlXmlAtkxiNq28Qz5o6Pu5bP8MVOxZ8zKkKHo+6uXV2x1cq1tkg4FKJ8cQelTNJ7cottQr9x6ayNWDhxIqOASEZBB9OMdqgiMz50n7I7XmVq5hh5NnA+wlRBfZP3Z0LnYMVzE8CrZrkkJysCmMqPkFYG4mcbdqe76Ijnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FDA668BEB; Fri, 18 Sep 2026 16:22:22 +0200 (CEST)
Date: Fri, 18 Sep 2026 16:22:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Haris Iqbal <haris.iqbal@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v2 for-next 2/3] block: allow error injection rules to delay
 bios
Message-ID: <20260918142222.GA19288@lst.de>
References: <20260830012002.80275-1-haris.iqbal@linux.dev> <20260830012002.80275-3-haris.iqbal@linux.dev> <20260915091146.GC15715@lst.de> <6bb6b89f-d71a-4c1b-b6a3-89e3f3c02e2b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb6b89f-d71a-4c1b-b6a3-89e3f3c02e2b@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 15, 2026 at 11:24:47PM +0200, Haris Iqbal wrote:
> We can do that, but that's only half of the feature, and the weaker half 
> IMHO. Only delay with a successful completion covers a more useful scenario 
> for testing in the upper layers.
>
> I am thinking about how else we can do this, but did not find a nice 
> approach.
>
> Maybe we can #ifdef the new flag on CONFIG_BLK_ERROR_INJECTION?

At least I'm not worried about the well-predicted flag, but about
using up the very limited flag space.  But if this is so important
we'll somehow have to live with it.  I'll take another closer look
to see if I can come up with a better idea.
