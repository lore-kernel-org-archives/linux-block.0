Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313DF2F43
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734065091; cv=none; b=lz6N0iY2YIkIbre5104V3JaeYjdXRMXn3tZp3b9nVWn+U97nJ0jJTFU1pD2clGXoYWw4oATzNRefCKk9YDUe/ze1p9Lvs/tGssfVy7ye6JTcLW0BBd+NgOF4itXcz6UpIJZ/Sz6P2bhp6MWPWR0TXCv5QENmKIFvkyflCZ/pSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734065091; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmWI0sEzqTquk826cVh5XNfu4OktOPonGvZI/NRTneZ1f21OTWAZGImAtXQF5wy4YrJozLLh0b2bo6qU0pKabnsJSFrynh+ghNk3y94z9rphm+n+ikmHzfQecysi7AGyJ8itO2dE5pSruvZtcpR7SkmNvLJpqsVMoraqMX2Fjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F27E768BEB; Fri, 13 Dec 2024 05:44:37 +0100 (CET)
Date: Fri, 13 Dec 2024 05:44:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/3] mq-deadline: Remove a local variable
Message-ID: <20241213044437.GA5281@lst.de>
References: <20241212212941.1268662-1-bvanassche@acm.org> <20241212212941.1268662-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212212941.1268662-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

