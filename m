Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8F3AE6ED
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506239; cv=none; b=eTUtmmnsea3rUjl0xWHLirjfCCB3pYAUPg05746up/aSEeyAR5ktLE2oG+M+f/yUDVeIyqppze6GqUoMYKNmFhMdv+X/I4sP86IVOkxXPY+Csa7OlEpNjWJKA5DVJ85iLyMd1AJuCXlP4niGypSRyFU/1uLcd5+CHfymOUEhNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506239; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEz8yWb5q7eDKZgHu5qsOidG6/OEFRumzdZcRz4dKLRs+WzqE3NRqiGjo0qb5LAHMN6a17rcryPFhc4Oi+XBUDWswn2Fn7w4tPcl9RR3XHj5GC3CrUx2q/y8B833tFO/36doZ2ftcrxQylQcJlzgfGgQ0YYfwgirudEpoBtSy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7DD668C4E; Thu, 26 Mar 2026 07:23:54 +0100 (CET)
Date: Thu, 26 Mar 2026 07:23:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 01/26] block: Annotate the queue limits functions
Message-ID: <20260326062354.GB24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

