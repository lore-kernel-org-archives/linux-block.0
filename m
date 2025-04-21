Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730E13C918
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236343; cv=none; b=sKuSos5b1/+wgQE22faebAExAz5AxeVlChBugAfCC85x2Mz+Nl/Eh21QuuvAqhqdVi5I8u7HgNcpjmaO5ocUPm7WwstIUhPPRt3bdA96QTML/QWnpQi/7kN/Pzo8p6Uk+XEh4TRbZz0Kg4YL4eaIoN3u493vee8kboHIf9ZPz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236343; c=relaxed/simple;
	bh=U6x8tYibyUkC4rUaFqLxxR2iXMsSuqiHECyf2wpWHMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ5mu33WOj/mK03sM0LH8tLVu7WpLAwlO1nEGpmp1/IwCZHoeDqRE86rDiRtSsEtyx1WpfwWugx96AkRfpI8D2Nn1f9vT/TjUlCAbwJAvQa3EELJTQIKTPwjjCNCKRYfXTiYifP2nHakcQbE3vqx2yOG0FfoFtGA6kgOItgIMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=elNRQhis; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="elNRQhis"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U6x8tYibyUkC4rUaFqLxxR2iXMsSuqiHECyf2wpWHMg=; b=elNRQhisTh3bRv7Rbj2/BKFT3N
	ThLMY+ZuPsrPsQP1mTQoTtire7DSO0QnbB/c6wOT3mIbm5jz4d8b/yvbT5cHSXcDXokXqxmKQVlRk
	AoMdJDdPR5n4ESqu/XaUB+u53K9cUAXGHdQVzDVU38XjFpMudI2KsT8UurHpc/++hsPQhr7vEvBjY
	rcaLWowtLcdFJ/VFi+xGTwtMQee52M/Neb7nd5qKseiMYaaZRKNLA+wQO9Hwv89nZZ3kl1sbrv5Qa
	YY4rVYkYamg5IDHRSJn6zZMDv1Z9Ds+cE0YBNnVioEuwH8bIo6GSZayqrWdg2iYj8ry4uCoAWpv1/
	7PFd2O7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6phF-00000004ECw-0wrT;
	Mon, 21 Apr 2025 11:52:21 +0000
Date: Mon, 21 Apr 2025 04:52:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, arnd@arndb.de,
	ojeda@kernel.org, nathan@kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2 1/1] block: prevent calls to should_fail_bio()
 optimized by gcc
Message-ID: <aAYxdQl-tWjGHK8N@infradead.org>
References: <20250417231523.1371083-1-prasad.singamsetty@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417231523.1371083-1-prasad.singamsetty@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

NAK for the same reason as v1.

