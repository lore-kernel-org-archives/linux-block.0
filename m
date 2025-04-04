Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAE1A3BA1;
	Fri,  4 Apr 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758428; cv=none; b=d5z3Nb6aKf0gR3WKy3kiv3OF/fQo5GEPRzfalX58e80//fmn+jNTt6XHs4VZKtMJ1pQub5fdr+VrF9xkksR6zO2mDOCeBNaq8GLih1Mrsbv4+EDEL6TwI0sF6ZS0YAR7b+A+U1k/TDn3YB1yufQ+ooEmhK4TP5ZJZ9XNQ7AT1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758428; c=relaxed/simple;
	bh=ut9cSDbsDEKTYeR6bElefCMLv6ytlB7Y0CNMaxKsVAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqC4eZTwFb2AT2lQHs3ZLvoSY0C8UdSwqbvECTBBa+tPkf2U39xasX3KugDghJmJYPhc6klsRXYVu4WwoweoCAE0BmxWf3hE/tlJRVxL12IR7LcaC1pZ8z3SWHGYOb13u5d+KQtrVPWbNFbeWKIVwLoR6me4ibMOeUk0uIftGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37D8268BEB; Fri,  4 Apr 2025 11:20:20 +0200 (CEST)
Date: Fri, 4 Apr 2025 11:20:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chanho Min <chanho.min@lge.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sven <dm-devel@schwermer.no>,
	Neil Brown <neilb@suse.de>, hch@lst.de, dm-devel@lists.linux.dev,
	Gunho Lee <gunho.lee@lge.com>
Subject: Re: [PATCH] block: remove non-existent partition dev_t return from
 blk_lookup_devt
Message-ID: <20250404092019.GA13334@lst.de>
References: <20250403003532.412-1-chanho.min@lge.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403003532.412-1-chanho.min@lge.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

NAK.

Don't do this.  Md at least has a reason for doing this silly things
as in the code as written in the 1990s where people did not know better.

The dm-initwait code has no such excuse as it was written recently and
explicitly ignored the rules to not use this early dev_t lookup code that
is known to be broken.  You now have to live with the fallout because you
decided to you this broken code.  Stop using it if you care.

If there's one thing we need to do is to warn everyone in the Kconfig
and boot time dmesg that dm-initwait is broken.
