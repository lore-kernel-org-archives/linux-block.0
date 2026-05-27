Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88B2C3259;
	Wed, 27 May 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891063; cv=none; b=ksl6hOeEqaj6GLVocejmNc812Mv90qzuZjBb5xLGYrBONSzLzbDh+fYU8zrJOyBZNrrFfnrmimrwdab998aHmjlCUbgPJTO9qbmSBvjDT94W+RkWVXDyANz8oQ4rEm7u42AJD7lYIx4A1FYDRz8Yyb8KBo/ujW01If9gPnbx4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891063; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeCeEvKRv4tXZSOPc/SmJ5qR0P5LeHIBXLGXTFg381iGKzZRm0JbtuVp3TKe4XfGTyMPdFMTnRWeh7BfapLBHMw7YujfpyHWyB9zhGdFWULPqU3jg0pa9LT2Dge/no0dQ1JVJ8UZdRuTb1b4N162GjZncvsv2i66jA09/x/6e6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 293B668BEB; Wed, 27 May 2026 16:10:58 +0200 (CEST)
Date: Wed, 27 May 2026 16:10:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, yukuai@fnnas.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: Re: [PATCH v7] block: propagate in_flight to whole disk on
 partition I/O
Message-ID: <20260527141057.GA13345@lst.de>
References: <20260526021555.359500-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526021555.359500-1-yizhou.tang@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

