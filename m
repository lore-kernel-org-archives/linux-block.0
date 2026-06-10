Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678C40D579
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068795; cv=none; b=PYJ4ESC7J3njxIcwWKWsBdQ/riSU1VF+bE/eW0eG2pfbzupJHDGWfSOqNHwQOXqZJ3cxwqVNe9JrtVvU5SRKA1JggZs+w0lYbmPMTftXTMJ565VLoPUi5pljh+98Dc3Trzd3HDVmv3h8LaYe2XIouKCh7huYySY87D7EUy788Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068795; c=relaxed/simple;
	bh=RLJMjD9hljUXluiMaJSypJ3cLDO5keAIxxFeYpORtYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUUrQ1ZU+catiCTTJYfVxYeKSeIIcjp0K3ZIUBq0MdaQ1HeE8C4kNSxNOE7p1FCJFzN1HyP1KWkAdQa5XhIYZyXBZDTYQZZ1MAtjI0Lw7xeVwdoR/kz/qpvIhUEPk2uzgzG1SluwNSgYDhWGjsYqWaVgf3ju+03mcRsjAlTenZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DW0diSi8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DW0diSi8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RLJMjD9hljUXluiMaJSypJ3cLDO5keAIxxFeYpORtYc=; b=DW0diSi8XomSzqiCV1XjlLTkei
	2Gmpu14/XH7mBVcTjhorHDyeWKHgEy5N4W/9JHAAfgPr6mrvvKVnUdsoaiVsOWVOiU4xH4+Ek3v9K
	VBvt7A0/cGRx5LQZzDt2wCLNlF3DhXza06aDj6b8iUfHicDlB4E7Kz8xoRj6V67NGpwaFVYc887Y8
	JS2j6xyvCuwD7OilAyFbl3w0s2cgXRQBUrwPj3AIAWEf2O+PdE5no0MvnmbydAAG3OsLh0xwMz3tx
	wyoWU8UnI+5hyLKi2Vg1aAY1dhqyKbkQBXevMmrZEy97BV8JI8ztIXvJsQ2swVQC4Utw51yFcJdii
	Dt3+egww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBM1-00000006olI-3XbY;
	Wed, 10 Jun 2026 05:19:53 +0000
Date: Tue, 9 Jun 2026 22:19:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 05/27] drbd: Remove the 'local' lock context
Message-ID: <aijz-a6Ufn6H5qe-@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <0d220690717c802c4d2b684bf924d134dcd0a929.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d220690717c802c4d2b684bf924d134dcd0a929.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 03:04:52PM -0700, Bart Van Assche wrote:
> The 'local' lock context represents code sections between get_ldev() and
> put_ldev() calls. Between these two calls the device->ldev pointer is
> valid. Since there are multiple functions with unpaired get_ldev() /
> put_ldev() calls, remove this lock context.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

