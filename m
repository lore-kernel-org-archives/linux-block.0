Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660061D5178
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750658182; cv=none; b=YORMC666oGM5P6V/9DkpRr9ibp47G4SHt3RohrCb0TctLbLR13EfwbX9f3IC/B3q7U7URCwPpdr3Bx/Y19enAq6lDqE72iCWjwMZSxdWxya6CPgL25NUkmSxtSXxw0nBNe4lfHsW/5v6xS3+h4h4f9CUs+PDAc1BCTyVSy8WOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750658182; c=relaxed/simple;
	bh=kjXDQkdh2UxcE2jZi9lN3oM15ewDS1M0o5tyqxnnXR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmrMey6Jgfw4LKWwby+cV6MxkpQPZYhmpl2nEfOX2w7UHX5gS+aixYPrYKBzw6MbKu5Wb/PF3V0JcdC0/OzeOlsymKBdu+9UFk9Aqf2srrSYYEI1ijyw0dbFczglQXGSXl8caLHYgFeGux8bsA+qX72aj1HvxYI7rmQmxk53Dj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCB0068AFE; Mon, 23 Jun 2025 07:56:13 +0200 (CEST)
Date: Mon, 23 Jun 2025 07:56:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de,
	axboe@kernel.dk, sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv3 1/2] block: move elevator queue allocation logic into
 blk_mq_init_sched
Message-ID: <20250623055613.GA30194@lst.de>
References: <20250616173233.3803824-1-nilay@linux.ibm.com> <20250616173233.3803824-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616173233.3803824-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

With this elevator_alloc can be unexported now.

