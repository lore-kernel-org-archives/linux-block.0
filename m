Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7616F8F5
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886677; cv=none; b=YWnWeF/Fn9HQrS6iW+RwHt0FOxcu2dwJNcbwzW9aCoYuJDtgYzPj3Ox9QqjJQPdXOhl2YyjoWbsyG99IhdhtjAzUtgMV0r6fTiF6o50f7rkmwqmYpeatdnYSEReFXlhv5Tw3nCGa0JtfdoBhxwXZuDUcJo9O7MAOXKEIisU+rxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886677; c=relaxed/simple;
	bh=XHc8hP7UkkJt+FVbl5awJXixpANuNTTImseQF2zYzvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq+MfD7mtGN8HAinDIzweDJwshzk4T7xFVj8IGHCJwxN8OAJofUsWGfE3OTMRAbxmUb/jsKIv0IuIjfwHmZttjO9xu+5lQJqqf6yIcyn5xhsBMPcZ36cA83KWlBqfjec9FGYmJkEVZt8XHR+vMZvFvM0aQ7YhM+XcM1G+bRVgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AFB8A68BFE; Fri,  3 Jan 2025 07:44:28 +0100 (CET)
Date: Fri, 3 Jan 2025 07:44:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v2] block: Use enum for blk-mq tagset flags
Message-ID: <20250103064427.GA27984@lst.de>
References: <20250102144426.24241-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102144426.24241-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 02, 2025 at 02:44:26PM +0000, John Garry wrote:
> Use an enum for tagset flags, so that they are automatically
> renumbered when modified and we don't potentially leave
> unused gaps. Some may find this neater.

Just as last time around I think this is a bad idea that just creates
more boilerplate.  I actually wrote a series before my vacation to
drop another unused flag, remove the weirdo policy indiretion and
add better max flag checking while removing code.  Let me rebase
that, finish writing commit log and send it out.

