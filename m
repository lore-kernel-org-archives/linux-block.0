Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAE36C9C0
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534420; cv=none; b=jL3GDnMQYydvcU49D0vrx/g2og9LNmGeIIjoZnLvnEw3FXoAU1KyhenuWclf3TzutUi2Ua25XsKzXtGuB3FXzUKgWo65T36dMotWa+0mt6bPJMRlumpuWiOds6bFE8PNsROiph1I6pEmbkw4Gbu0ocdBG8ig+NynGpDXkyU2VCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534420; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrvVX5RH6wcUdanS0SMyc39hrmbKzaVtKA2PjzdlvPDaXCk295jBIDFYimh/ltzm3NbrHaEzH8gPsryNweu5WckSVqeK3v85iMelnN3ivN390jCeKDaxh5TaFebyceiFJz4pkVQ2qv9OwfwnH+0xWKJX61n9f1a+WdmZKL3k9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 251B868AFE; Thu, 26 Mar 2026 15:13:34 +0100 (CET)
Date: Thu, 26 Mar 2026 15:13:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Justin Sanders <justin@coraid.com>
Subject: Re: [PATCH v2 14/26] aoe: Add a lock context annotation
Message-ID: <20260326141333.GA16166@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-15-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-15-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

