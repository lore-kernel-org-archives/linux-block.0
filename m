Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1E25332E;
	Tue,  9 Jun 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991228; cv=none; b=TZfowaGNYsAgJrzoWSGatQqgBZciPLd6LUZVzlORoo/dIq4ckWsLysLCbJ2GtlRsg2dat0A9P+fsi5x4Uv0KJHiTEe87/9cmHdVvQcnzrMUfKqxOOwGPh7lEk2ep4oOJMBUksTEkDRH/Cl0yEtt7+7b6AFurqL0LqRKC03Bn1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991228; c=relaxed/simple;
	bh=Q1Ys9Oby1hLfAzd4AtYJhhtd7KsNm2Aeg6vMCG4nsoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUl699r1JjWu/0+BAcNDkbg8g9DXzGUWU5okQBemKCodAJVOGPfbOxj1dv1yUCskXhxNpOuetDE//N7kKOi6WSwYmmb37s3FcJM+WsAGnmi9FNjk8kwuN2UXGxlVtTjlUo3kaO8VORjSZ5dvEAvvYJzl86SkG5pYmF2wJy7XF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51AB368B05; Tue,  9 Jun 2026 09:47:04 +0200 (CEST)
Date: Tue, 9 Jun 2026 09:47:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 4/4] block: add configurable error injection
Message-ID: <20260609074702.GE6877@lst.de>
References: <20260608051416.1205282-1-hch@lst.de> <20260608051416.1205282-5-hch@lst.de> <3b276ff3-2065-4cd5-adcf-6664606d1eea@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b276ff3-2065-4cd5-adcf-6664606d1eea@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 08, 2026 at 03:08:47PM -0700, Bart Van Assche wrote:
> On 6/7/26 10:14 PM, Christoph Hellwig wrote:
>> +Configurable error injection allows injecting specific block layer status codes
>> +for ranges of a block device.  Errors can be injected unconditionally, or with a
>
> ranges -> sector ranges?
>
>> +static void error_inject_removall(struct gendisk *disk)
> > +{
>
> Is a letter "e" perhaps missing from the above function name? (remov -> 
> remove)

Sure, fixed.

