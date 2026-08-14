Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41341A92A
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694746; cv=none; b=Bw8jadTAYXuwRC5ccFJBjYWzhmWnDl+fXhRCM91d3qmf4CIlDdrdwR4TQH4lX8mXiP6cwFCycfz4o5G6QnaOHnjqBYY2fbtp4qqyW5rxzQ+8ijsL+B1I4BNFkWel/DOO3QNeOCOnYlI1y7Ca1bFD1HjXZDAzQvH10KBP+irxKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694746; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjR5U5dTRK5yWRW+BrrRVChXdgpHl1frTepjxKLdWEwO7Sm80QP6+TQrnC1tVL/a2zRxWJqJwOt0uthNMewlvvIgqp9y+GhPCU9UBxWvxCZLdQ/LQVf4IhPFxLsLaBnN+u+6aQJg97ipQ0G8GQfsInm81gXBN+vmSIZBA9LvPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE53E68BFE; Fri, 14 Aug 2026 10:05:41 +0200 (CEST)
Date: Fri, 14 Aug 2026 10:05:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 08/13] block: propagate readonly and offline
 conditions to zone write plugs
Message-ID: <20260814080541.GC12566@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-9-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

