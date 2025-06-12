Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A31361
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705799; cv=none; b=LCYpwZ8c1BWEMAkLxfHm4KpQ6vDPtskLZae8mB9c+wzWRbZA+Gc6zoCB9usqLr5M5Qj5e7sf+93YitxwVJovkvmJkbK4k7a0DjN8GkcrCuA79GagMYF36+3My0Yr7A5Em7ITyXS18zExMOm8jfGwrG2rVrfkcwsyAHUR3dhAPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705799; c=relaxed/simple;
	bh=VI7f9i+bnhXKxDTiWRv0kZeAbOygUdbkEghq1+O2yp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyCdGEUz70oN9U3QFws77K6JJZM/m6mj/nsz4srp2GvggqDhO40KI3hNVTFEiXB6FvDhgh69SCq8/EAXO66aqxbKjujEZ1pIgEP8xE5jVWujXqjtW7PTMfYzIUwndghYoXAG8o1YPYudhnoUGR0kMMSolKFGTiJYUb+qVi9hQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pw1kEJLy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pw1kEJLy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VpkAbcQCnZQYXhX/zEAKUvWxviO7otMsczakR+S5DqQ=; b=pw1kEJLy8x1PAqZTXrNIwfYuOJ
	7ZfdtDkYqSBBtxyl63ZyjQfK3xTuk0KHCPX8Y3PiCmdswI7rYKRcyq/qMzta8EHg9XxKelA92+/oq
	6Y1JE7Af8oAjR066tyEGRXahZkHw4iWCDoj0kKBRhoHCq0kSgR3FEzKilYMAybf1etHXOP6pNmFIv
	c2rNSnxS/SPljCnxR68mwHL7YgXcVy7Jetw7MYWCxo5L8TxVMJR+HCIK3sAedgSVa7WLyyCTQaYH4
	s8fVvGoCOPQEr0WMvuO+bsuj9aizknLcTKLZOrh3WNhRO4miJTQmE8g+FtbzumoK1h4iOWn59GvDZ
	evqvtc8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPaPG-0000000CDqd-16LZ;
	Thu, 12 Jun 2025 05:23:18 +0000
Date: Wed, 11 Jun 2025 22:23:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
Message-ID: <aEpkRgLRQdAhNwUP@infradead.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEpkIxvuTWgY5BnO@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 10:22:43PM -0700, Christoph Hellwig wrote:
> Maybe byte the bullet and just make the request lists doubly linked?
> Unlike the bio memory usage for request should not be quite as
> critical.  Right now in my config the las cacheline in struct request
> only has a single 8 byte field anyway, so in practive we won't even
> bloat it.

Oh, and we actualy union rq_next with a list_head anyway..

