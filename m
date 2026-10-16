Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB0446BEA
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142981; cv=none; b=FRX8IxzREnGTVz1ap7EQVyLnf0Kg9gXfN4vLfUgvqh4cLL/z4EZ5eZkjnDQ9DNRBwmlu9Vj8Zk1ZRgqI7c/ygzuxfndNt8O6gLjvRwUA6sLBsb17BY0wSi0m8QqIXA3Fx0nb31RZjL/+W2mDbvHMHVAoT/LCfa6KD3NcmiXRL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142981; c=relaxed/simple;
	bh=2xqWCIQ9k8GzFpVTf0fFsEgURPLQMcG48YcfPQdRECQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFy0tOYzWEQ47N8L7R26u4+aXDP5Tb5b2dRxCwNMCki9OEbgBev+aTShMCvsmmoIz+4K99zDCcwIBNWmIVsxzsyQ9CWV//SRobNnHq4KOVZ7JW7quthswuB4xqDIa0SkDMvu+a+C/aYN68Dj/8HZt9S6GqLzM1vVuWeMG8vYTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D22D68C7B; Fri, 16 Oct 2026 11:29:33 +0200 (CEST)
Date: Fri, 16 Oct 2026 11:29:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix indention for dma-buf checks
Message-ID: <20261016092933.GE23141@lst.de>
References: <de91f480f8507d44ddf99c193ef63dec0f02c749.1792142187.git.asml.silence@gmail.com> <be2b6881-75bd-4113-bfcf-c3ac9ed2b80c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2b6881-75bd-4113-bfcf-c3ac9ed2b80c@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 16, 2026 at 10:22:37AM +0100, Pavel Begunkov wrote:
> On 10/16/26 10:20, Pavel Begunkov wrote:
>> There is a weird indention I botched while rebasing, fix it.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>
> Can be squashed into the following commit, if that's preferred.

Either way looks fine, but I guess Jens doesn't really want to rebase
this late in the cycle..

