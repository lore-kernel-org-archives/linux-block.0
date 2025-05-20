Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1624337B;
	Tue, 20 May 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749397; cv=none; b=f8uRJoTJSrlkOXWEVNhPxhyMjZyrVE+ELnXEpMzDYpRSDuovZGhseu3rAoXvkWiGIYru/F3Zy5esOLBF0E8FbJPbxRmjvO4if66OpKeYejqMoU4g+RaIlUba0t7xgIhTsPmgfvdoZHD19RMOojS749aZM+spr4z4tIY/it49Pro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749397; c=relaxed/simple;
	bh=/SnFxEggPrMHhZV+lvWHFraJzLQk//GQalx4/R76d2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnNo7pGn7abhk1Vkb8bSnLEa53+XsKFpAT7hNkj3QSxY+DkXVS8Mq7UQVLPz+rBl4fqdhYvhyNh/X9iIjHxfBcOTZdFxfWKGOEHc+ycJ7uRy9fWF2pE5OII1Jfs7HDmUdh7c/4NytGf8NYGlEnKjo0dBT44geCnz/w9doQvgDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25E4968D1C; Tue, 20 May 2025 15:56:25 +0200 (CEST)
Date: Tue, 20 May 2025 15:56:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250520135624.GA8472@lst.de>
References: <20250514202937.2058598-1-bvanassche@acm.org> <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de> <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 19, 2025 at 03:12:11PM -0700, Bart Van Assche wrote:
> This new patch should address the concerns brought up in your latest
> email:

No, we should never need to do a sort, as mentioned we need to fix
how stackable drivers split the I/O.  Or maybe even get them out of
all the splits that aren't required.

