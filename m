Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B130B51D
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069205; cv=none; b=DOhsTMdDP1sP0Ek6WGcUTxtAHS4Hi8RNERKxi8HBg8UhY2He2F+cjTwf8uAUV/MrwjplnFejpL8O7JTM5qtp2NnDtbg5hLi5B6Sy6dPiXfUUfvlTNiMw3wuGmnSUPUS34PTcdY+lNqt7T84RUfQyifBAvzlgULfCaRIDPybD+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069205; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr/pZ+jYwj2TVAp2i/Bu8KK87GrH6ITsQq7MxcghSjSf4EK2Xt4RcUv5IXF2oziI/NOyJ/yi7hz76sElK2rSfj/vvtCTgWGRccLHJTXhxC8K2eMx6mnfoqGOlwToaeSN4ID0wHKV5pnsjBVezYNsmTVim0HSptJlsOxu1pu1bWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ujcYrBbd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ujcYrBbd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ujcYrBbdI+ovOmv9Mh5wORlhnG
	4Hma1gewjCdlsd60bmiZ72vko16b0ALvtNMEaUuAfpQ4IFQrrkz837gs1kJMiOzP/Cn+zt1/RYzos
	u/MXhxaoJ+oTQv0zxX+2nwA2uUDBBG6H30V6H6+O/gLAZRHNAQjLJbBnDWejiKsvKItDq55+MPzu8
	cy34Xw4binRZv25sVv6FEMHMxpp6eeclqG/FblSWVR4IVrSf68bOsQy5uIwn+Q/hZ3tMyE0xH2SzQ
	lC/M7GMisZMLyZIcASQImWIPilNquYaf9F9tkvY7hnxmFDNTzaR4fTOuRlGeY1RqT+o9s29VEW2fZ
	MCSx/VzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBSe-00000006pBn-129e;
	Wed, 10 Jun 2026 05:26:44 +0000
Date: Tue, 9 Jun 2026 22:26:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 13/27] drbd: Annotate drbd_bm_{lock,unlock}()
Message-ID: <aij1lNJtFy7rcdpU@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <b5346ca2d22de25c6a03a7b6477d4110c263e5c6.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5346ca2d22de25c6a03a7b6477d4110c263e5c6.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

