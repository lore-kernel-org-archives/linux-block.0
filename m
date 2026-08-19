Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1A25D53B
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787116999; cv=none; b=AFO5qY7SQTVbMmjh2Xqs+l5ZYaLaUCNIcQIzUQ4EABmsDD1T6V1yXFKhvyLq152DeOWSpvvHDFxj2kDtf7vRDM8ncYGFm5S3QU5OGvKJhi7YahTTJRL8MtVah9BpkIjf2rph40D6uiVH2j50ydEwhXez+0h7O/dKfZ0uw6Rl+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787116999; c=relaxed/simple;
	bh=QG471TA2+P6//MHVlB1P/L1lYGOs/aahz2Rf2O7MmiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDfwrWZSlElrrGl/+A0AMu3JpDBg+PPZTfgXtjz/UXi0qw7QyJ6X31RrYlG8qNCqKQ+4GfYGJuwJ7gSGwNQm645WWJMv1Z4JUCjclgGHf3ZGDzNBSBEqx/VZbIHXASZdoVKx9NJW2XwgV8/umHveSZqemG9eu5zW5+eH8Inc3vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E69368C7B; Wed, 19 Aug 2026 07:23:06 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:23:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Eric Auger <eauger@redhat.com>
Subject: Re: [PATCH] block: save page offset gaps in cloned bio
Message-ID: <20260819052306.GA32364@lst.de>
References: <20260817165908.137682-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817165908.137682-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 17, 2026 at 09:59:08AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The cloned bio needs to inherit the accumulated gaps between vectors so
> that we can know if this bio can subscribe to the iova coalescing
> optimization.

Makes sense.

> The split remainder meanwhile can reset its gaps to 0
> since it advanced beyond it and will start accounting from there.

I don't really understand this part, though.  As in I don't even
understand what you mean here..

