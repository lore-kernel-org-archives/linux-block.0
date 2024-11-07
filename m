Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA719539F
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964445; cv=none; b=T8f7nimrapqmFQcrdRKa61/oa5oXQ8/PfbTtdGrr8DoamrBoykzRjD5j0AmJB4adTwhohxsALhKSUDjLGFjdV/3y6YoAEw75fzFqII92aq6FetARF7fsXHP93Iy+bg4oeN+tp6rsqhZnghoAUM2TFkCdispt9g9WFN3TqJfGsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964445; c=relaxed/simple;
	bh=96EqRVWoMIdZ8lLFm3mRtk9RtTgG+n7P3uMJfghDSCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAC2h1WCBHWahV4bHJTlbXzUBeNdK58QXU+SaPSPkn8bOOL71g8bzfrbtV12+qwy6S5OXkU1InnWp8OZ4ZCHSVns4CqrGdRp8JyJ+uFA8CnlfE/P93485jnUsPnf/5IL61/wh09zO6aSkxqwWxFJdwx7BpuTCT0c4uT2zDkcppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF6A0227A87; Thu,  7 Nov 2024 08:27:19 +0100 (CET)
Date: Thu, 7 Nov 2024 08:27:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Switch to using refcount_t for zone write plugs
Message-ID: <20241107072719.GA4408@lst.de>
References: <20241107065438.236348-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107065438.236348-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 07, 2024 at 03:54:38PM +0900, Damien Le Moal wrote:
> Replace the raw atomic_t reference counting of zone write plugs with a
> refcount_t.  No functional changes.

I don't quite see the point, but if Jens wants to take it the code
changes look correct to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

