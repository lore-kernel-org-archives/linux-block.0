Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514322339
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264193; cv=none; b=shYjnGbjlCbc9Pr+DvRPHexaYTJACfWYmZ+sP3vX7iKjCmajY8OZ8Fuc2NlYSebttpdEXKyU/8Lh0y9/oGJSLa6mfC0va3v00uc/z1IJkI2ZT+l3pC/9lnHbHHVJrd+sJMTOrh8Jh1cx9bKCTG/h1aMWtbug+xFVsf3srLgbVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264193; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsdKzZ/0SztBhzp/va7afXBD+Z/Xdz6HJxJyad6146bUD3kE+LUA06bjcAklbq2dWTgZna4/y5qN2ATtowCKHsQ2u2Owz67dSV4cw7Jw7zsqkx+mnCtzoHQtD2cj+z/Pjy7a1dU7y1arZrTnM9V2CxcFXBdWyQTJp7RJtP/kzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9002E68AFE; Mon, 30 Jun 2025 08:16:27 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:16:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	axboe@kernel.dk, sth@linux.ibm.com, lkp@intel.com, gjoyce@ibm.com
Subject: Re: [PATCHv6 3/3] block: fix potential deadlock while running
 nr_hw_queue update
Message-ID: <20250630061627.GC29122@lst.de>
References: <20250630054756.54532-1-nilay@linux.ibm.com> <20250630054756.54532-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630054756.54532-4-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

