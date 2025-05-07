Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F12920BD
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626098; cv=none; b=DKLd8uoQ/wmT3t5/VqlRtIneebxtoABXHyOS7WqHtvU6hCExXUoHgkrda3iw/6M3SDIVgbb5qTAtW2N5AFyhtW1tvYc86bSb4CLeipQ5PK2SWpOm+7jDklwlGXGv5udnf3+IrexI1JB8G6TKUyoJhE04hfiexZAD+rNzNYocxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626098; c=relaxed/simple;
	bh=xKoGhF+cYoIlMqUF24OkD0Lm3VDMXBOsCv/6aFVkTy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap2oh5sdVAB1le9yXJAe8CDev5DeKIk3d8rq4XpHI62z1LgStJDYnAIPrTA/bxpfaxUTudC/OHSMqyFHN5G40gGcgHU9Ha4HkV4X3B3rF0AtpYdgS0YkJmW2NiqtAQ8vOtNlOoDYtie2ZFf756u+T/YTjnYe51p60IztPw6Aox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FD3668BFE; Wed,  7 May 2025 15:54:51 +0200 (CEST)
Date: Wed, 7 May 2025 15:54:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] block: avoid unnecessary queue freeze in
 elevator_set_none()
Message-ID: <20250507135450.GB1019@lst.de>
References: <20250507120406.3028670-1-ming.lei@redhat.com> <20250507120406.3028670-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507120406.3028670-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 07, 2025 at 08:04:03PM +0800, Ming Lei wrote:
> elevator_set_none() is called when deleting disk, in which queue has been
> un-registered, and elevator switch can't happen any more.
> 
> So if q->elevator is NULL, it is not necessary to freeze queue and drain
> IO any more.

Yes.  Also if the disk owns the queue there can't be any more I/O per
definition, so maybe check for that as well?

