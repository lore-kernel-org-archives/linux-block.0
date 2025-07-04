Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A32B2D7;
	Fri,  4 Jul 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633204; cv=none; b=ST2jyEKFk++sMWOnJjaTaXlG1IWGBvc652VrKgkEdY6V2+xKXaesBebpIDrYIVcizFRcENRz3lgDV2eD8QGQwdENAd5fWWde17MZ3dgQIpPwHpMUABxgMGfOq/w7KYb3QNtgYDq1h/kK9eiH8mNIaUWMx0q1KV4XXyD+AnIYvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633204; c=relaxed/simple;
	bh=4Pu92B6lpbTmckJ+MmB/ZpaNgGcv3vWVWNh1ntoWxMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcyG0FXNPUCe46Jfcos2X7Nz+MdjTLoN4MH3qraiHDT5UKhbWEh6mLmjdxgp9lakmUIgny09Ob97v1nDKR9T/g6OW4JI9ClPDboOCWD85TSBsvwEQfo2tRCAn4T7u717o+Bs+O0HAjxNkZfGQptMUy3WjbQz0x7M8/CTleMb9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RwXO/tky; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RwXO/tky"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Py09PS0goR57Q8IzGRVOpcGP5L1ywGuQ5MECM60a0k=; b=RwXO/tky26ImrUfVr0Vho9fAxe
	BG8dROXIjLOLo98q6wjKDzOEQYg3JU4TCOHYLnUTZowN4xUVwLsW4hhAxSDnBGyE+w00/WLyDmIpC
	SO5yqlf4ojCXMqwBCnybvf1iSf0Ts5hKWqHcFGG+8o99wcrrSqq6+oEgtJbEyGvydayrSjtFdt1Fc
	oWWDWqpEKAWKwu+JdwScKWI2bPJal57/VhhKrigzSuqihWH+P/k0dQRHh5V2CDqaLJY9hxa2c0a/p
	eOfJdVCtEWCbn0aznAjT74DXU37O4i8AUtvKGqnR+2cswswoHKi7BXJh6nDo5KwLosvfybHQT82Z9
	xDqSaFbg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXfoG-0000000GvW9-2FqX;
	Fri, 04 Jul 2025 12:46:32 +0000
Date: Fri, 4 Jul 2025 13:46:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Hannes Reinecke <hare@suse.de>, mcgrof@kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	kernel@pankajraghav.com, hch@lst.de,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] block: reject bs > ps block devices when THP is disabled
Message-ID: <aGfNKGBz9lhuK1AF@casper.infradead.org>
References: <20250704092134.289491-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704092134.289491-1-p.raghav@samsung.com>

On Fri, Jul 04, 2025 at 11:21:34AM +0200, Pankaj Raghav wrote:
> As large folio support depends on THP, only allow bs > ps block devices
> if THP is enabled.

I mean, it's a quick fix, so sure.  But really we should remove that
dependency.  Particularly for bs>PS as there's no need for any of the
splitting code.
