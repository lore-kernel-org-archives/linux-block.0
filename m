Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386E21C9E7
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022407; cv=none; b=BW6L9b5mK19QMs7O19ToFYLRzMvlc9jb47UZTd/deDUvR3JLQDY/hZrxv020JrQfiiJyTQA+yeR+rUcSQnoA097isRxXBQHXv6PS5tG0YlaqOHAmdRGBnInwgJlgvSuUUCWSCVgbwwGlLnhHh1ZE7hO72mDYBnbMrhbyIKU2y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022407; c=relaxed/simple;
	bh=KWE50NZK5MdVhsk6UZo7AvwkG679r8J+ajIKdE9Y+GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxZCZZeu2iscU6tUlCRFc9UvOftpNldMVfv9dB9M1uSnJQ2Q4A9cNtXjHU63UViubtRFl6AVS6mGW316GydVB+GxMpznQTI7QpxIaijovbuafzxxL0/Nchy+VkNb02rL/DEGaM0wWwA7ZrEb/1dxDKwB1yTel7LTGJ/p9YIm1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2853068CFE; Wed, 30 Apr 2025 16:13:20 +0200 (CEST)
Date: Wed, 30 Apr 2025 16:13:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4 13/24] block: move queue freezing & elevator_lock
 into elevator_change()
Message-ID: <20250430141319.GC6702@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com> <20250430043529.1950194-14-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430043529.1950194-14-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

FYI, this is the patch that fails to apply for me.

