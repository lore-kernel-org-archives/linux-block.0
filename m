Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DDE63D
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734065181; cv=none; b=QYvRZXyatWWFw7t5v7C1xXWfzmjL5aMKtbgSOc6Ei9Qjt7NdK+Yi2dXGZP+3pLboc5w3r4eaUfJ7XBukfgjUM62IF2/0E3UUm5tu4Sk/NkQCIFPUp8ccfkWNZKkSXzA/+m04ib0bNyabrc3yrx8NYshIfA/LgOC7wviKEnt9aAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734065181; c=relaxed/simple;
	bh=9r93977Na9DfKVVsdZHF9UzRrFQOGbMqJB8W6KqxSHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0fVQL9ffb3DKQTtHerO4cn9MaSAZWccr4L7pLN6BsNku7vqJV8tjS6Ck5BFqc7WyAvKzAU0QluZbrgEsUkLcnbQ1/YRHq3p/PU7MWrLnkfE2QfPdoLliQZY/sfZ4MP4E2zJqJuurl6Y1fMS2eSKz/2mYGj8pL46Bs4ZuIw+Bck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F78A68BEB; Fri, 13 Dec 2024 05:46:15 +0100 (CET)
Date: Fri, 13 Dec 2024 05:46:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] block: Fix queue_iostats_passthrough_show()
Message-ID: <20241213044615.GC5281@lst.de>
References: <20241212212941.1268662-1-bvanassche@acm.org> <20241212212941.1268662-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212212941.1268662-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 01:29:41PM -0800, Bart Van Assche wrote:
> Make queue_iostats_passthrough_show() report 0/1 in sysfs instead of 0/4.
> 
> This patch fixes the following sparse warning:
> block/blk-sysfs.c:266:31: warning: incorrect type in argument 1 (different base types)
> block/blk-sysfs.c:266:31:    expected unsigned long var
> block/blk-sysfs.c:266:31:    got restricted blk_flags_t

Maybe turn blk_queue_passthrough_stat into a an inline wrapper so
that it automatically does the bool propagation and callers don't
have to bother?

