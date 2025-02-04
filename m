Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAFC2153CD
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676874; cv=none; b=Ztmm8J85drdCSEZ6rMqtQwnkzAAdnkzJgrP9RSrqbvPAu0tWCjBIEHo9dl/dkY26rvmYfRPeBy/14An0YvQhCx/l4/9bht9hpELgJ2Egmz/F93g5du8IUb8T8SM9FF9aIj7UmAjgQzCRGhA5YjEp51JhvBn5sRe/Spi/8F0ynkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676874; c=relaxed/simple;
	bh=LvXLigVxju7GY0Jjj70BwLRrpX/ZTRGsH+1Rojsoyu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz+RlGlKTFo6EUTeJcOMITK1atYwA+p2NR0idZtTHk4RGsmw9S1y0yFUPkGL/6tCZcWyV//qunGorquLFzAQP5HSdztWPsZ8Wiv3AbhFWTu8aPB5q/Gj7bpAVvExu8VtDwgWqmVmxIlFJqCMQfQGdSWK6Syoheda2c3J/atoGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7EB8568D07; Tue,  4 Feb 2025 14:47:41 +0100 (CET)
Date: Tue, 4 Feb 2025 14:47:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [bug report] block: force noio scope in blk_mq_freeze_queue
Message-ID: <20250204134741.GA11882@lst.de>
References: <46e5676f-742e-4c18-8140-a3e249235a4f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e5676f-742e-4c18-8140-a3e249235a4f@stanley.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 04, 2025 at 02:15:37PM +0300, Dan Carpenter wrote:
> Hello Christoph Hellwig,
> 
> Commit 1e1a9cecfab3 ("block: force noio scope in
> blk_mq_freeze_queue") from Jan 31, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	include/linux/blk-mq.h:910 blk_mq_freeze_queue()
> 	warn: sleeping in atomic context

AFAIK this is a pre-existing (real) bug.  I'll take a look, but aoe
is a total mess unfortunately.

