Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B13C0624
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091058; cv=none; b=T5AxxyOHwYPJqMlLVyiZ+mbAWFIzUp3nOvhUig0wyu1m/X7GVbylIdnLVT+kqFH+kXDzB72PAhvKrXimRsVsjOy2+aujcMR2QHY0JxhkY+b61RXAw62kskKDR0q84L658yOZGQrU79JfA7WMZuq3uJG3iYZvsTZJJQ+uaZZOb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091058; c=relaxed/simple;
	bh=Aa56S4Taa1J7Hz/Y8RiJ/JjeSZA75qQvMwBp2tsd3pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKOFFcfHFh3irc2ooL/vr/E177WHEZunS3pqzcUwfHEkAD7I2aaN5fPuIGTZMDBPzPhmPlXzhY+328liFlyxUbSyi6mmmhJ6x9Trv1VHagk7w8FN1sLuGKfQhdmU7SPr97VcaIXCB7BrInawMpcCmEKabvBgnzRWuBPYakJgq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LOBi0yDc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LOBi0yDc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Aa56S4Taa1J7Hz/Y8RiJ/JjeSZA75qQvMwBp2tsd3pU=; b=LOBi0yDcBc7XIqjN1/zlOhpQCs
	+UVuoJoRgO6mozz3ZbH1qCXzUVgO67BT2IqIDL6BkMthVcX3D6aR1jc86cj9A9blMRqCxRXqAH8S4
	wz0sZDdfjQGHPKIeZKmn6mnssrZHYMtYtutzDG95k9ab+wHwoRrO8/EvjfEcTgpguEUPXB2jeWqnX
	O95CCQ0LEV5St0GpxlyXD3+hA9VyYPFXQxPbpzcdMZt6TcJPfbzjpRu6BYrp3VENgDq1MqR0tg28p
	PkrTA3/BucEn3hJNj3uErhYoytc73EAV5M0Vc62uFTgI12PMTEh5CVzrmOoU9dcJ4N75683i4beY3
	Xm/9Ai3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXH8z-00000007Xrl-1QvG;
	Wed, 10 Jun 2026 11:30:49 +0000
Date: Wed, 10 Jun 2026 04:30:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 00/27] Enable lock context analysis in drivers/block/
Message-ID: <ailK6eqeWrwRLPkz@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <aij3e1WKFQunNUS2@infradead.org>
 <CANpmjNORsF2oExcOphnGgnTt3hJEWP0tB6zua0sTG=n7gJbEZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNORsF2oExcOphnGgnTt3hJEWP0tB6zua0sTG=n7gJbEZA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Cool, thanks!

Bart: maytbe for next version just enable it on a per-driver basis.
Once all are covered we can switch to directory-wide.
