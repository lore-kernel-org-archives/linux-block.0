Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491602;
	b=Y22Qx8XWFi4YYD8/N/CwISeXcSPob+43mCa9amr5v0u+qSkEdbBdDASvRUFWMxgNokaw
	 wJvSZV/D0WfDhk3RIUvi0Di5mB4FlDIAaD5BKrUbQdIq0E6i9QSdfNBpXLEyJ+khwVDPu
	 3H1sDawdFjKDobROeIpcGg/rzjZHuPtZnyX3XiJ3DBpetGD6KIB6aEYXLuUSQWVqml13e
	 +/+pYjZ0zIZjJc1qmvHvEqow2ff6n8pNarxIJ32Lw+WHl7fWtSjylCbzqfsPIrcXTEB7a
	 IC3jwfVTJyplcKpX9zArb/thhkL8YUzBd84QzMeXisFWkQ+08wVmhQFqSN/r8mChIlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491602;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=svpVGKFXbZHxztUDb044ZTl/Jsl3BtLQiD2cKxtrBFf3bquFpVZyIhaqTxhaWsmgSLVm
	 5KqNZnNk4BfgOkFwujRLaCauyk6kASTooq2546T4D3wlpoR9bir22mtwQ3KedggTyczqy
	 xBik8Gg9BnM5aop4xaOE3vJl4k2z7VMTja3gdI5L3nMFTCsBL9JzN4GsGLB9ugwgRSrMg
	 Z7EXwcDD8bdVi+0+beTj5UVt+Spjh6740+6rOprTU2volhj0W8maXLuShNjsQGxd71CzR
	 h4L/u1nnBhuv2YEafSYLLK5nTp9Z+8C5dH6QzBXzgATQ+kFjF7oUHHXNxLdVVjIXZnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE58606A31C;
	Thu, 12 Nov 2026 13:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E525F68D05; Thu, 12 Nov 2026 14:53:16 +0100 (CET)
Date: Thu, 12 Nov 2026 14:53:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v4 1/3] block: Reject unknown status tags in error injection
 rules
Message-ID: <20261112135316.GA24065@lst.de>
References: <20261111215838.103356-1-haris.iqbal@linux.dev> <20261111215838.103356-2-haris.iqbal@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111215838.103356-2-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

