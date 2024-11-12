Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7C189B8A
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432128; cv=none; b=g9te92j7dihCJlKNP9x0+TlGy52UdfAHLzYyluU8iJDP+0r6jiviOhRyVPUHLZYX7vv64HvgNmqwyyAl0ubYlKW37NZqb1UmwMGD1TqaryoOg7DicISKayVzuiKIBcqCXh5QtzUvBbZQcTPe8JlZJssI2IHFUsPd3rfmkJb8qOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432128; c=relaxed/simple;
	bh=x44EuAHdjuDXD19oXv8VxkWaz/DXu/ji2E0Fo4v9BFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1t4ZWUNTC+L5mcDiV+2yTMqlgQ955Db9TVku1Gs/a5BowZ2tJbc1n4H2y+9c6PEP8gP186AWxmowU0ZZZTuzLdYLB1fbdpvaUoHr4JImColShRN9w0DF7HncmYNK0PA3TuWhg6SsD/GeOf3J5GnEuVa4KJLGj9p9ViLRczCtiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B75C568AFE; Tue, 12 Nov 2024 18:22:02 +0100 (CET)
Date: Tue, 12 Nov 2024 18:22:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Drop granularity check in
 queue_limit_discard_alignment()
Message-ID: <20241112172202.GA22259@lst.de>
References: <20241112092144.4059847-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112092144.4059847-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 12, 2024 at 09:21:44AM +0000, John Garry wrote:
> lim->discard_granularity is always at least SECTOR_SIZE, so drop the
> pointless check for granularity less than SECTOR_SIZE.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

