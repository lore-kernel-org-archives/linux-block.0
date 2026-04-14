Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132B391505;
	Tue, 14 Apr 2026 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154742; cv=none; b=Vo5V2O0/v9xo+9gR50xYug3VJKgpCg30hJsUv3UIIYXfgVrU5YZdEJZ28XG8a/QdoHMBxwOP3KddAC/7tn5riid+wg58MOHUIMj9AhUkHTg9UvqpjJZ9M/uKDWkp/TXGJKJMPn1qluZGPGaQHFLzOhp6//gTY3VRNcWPgegxXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154742; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhnx7N/cSTumIE89U7BHxFzaiKlsSw8S1Z7bS49vN8uASNuFD/H9EDSq+vOn4CTfLWyYgG0nWSnaJ5J86E1go82O6NE40CE3cZiXShvHSi46v1Ril78eNhjlWBI79iSp7WFIqYoARZSUtXG6t/gTHfOHNRavuu9SFKkaN9ed6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DK3hB6K0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DK3hB6K0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DK3hB6K0HBC+OLWpmlt6lXbV1o
	3jltsObg9EvK2qu01B24Pt6v9nG5/rGyhaF0srP4s2AFdtJqfkWKp98cMxgQhVdZwM3Ywrg6RB48U
	IVEsryZFtZiYcVOxMWbjRZlzAbSUpnelbrrp4WPeqT6gEbHnD2gFQPdby6uj0KVvnEUBaKf8H6m2z
	ZJR4qEReemdWE0feU0CRlzHds4vXeXKxTl2qurfGUB14uBy9vPT1FCCVxl3rry/TxCV81S80yk+9y
	TnabUUcWPwpE1YstQ9GE5YzCxJi4WO5/9Y6BYPwlPomLjSu+xFx0EbQFmrZtAorre1jXSVX4kEUuN
	cw/80jaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYz5-0000000Gxn0-3zw9;
	Tue, 14 Apr 2026 08:18:59 +0000
Date: Tue, 14 Apr 2026 01:18:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iov_iter: use kmemdup_array for dup_iter to harden
 against overflow
Message-ID: <ad34c8N-Z3-51anE@infradead.org>
References: <20260413060655.1139141-1-haoranwangsec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413060655.1139141-1-haoranwangsec@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

