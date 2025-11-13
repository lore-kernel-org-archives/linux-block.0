Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC02586C8
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045176; cv=none; b=bGQLlS1Zu7PMCE3o0a2k6I7gntBsUSjCudmYPbdEln7Ji3XtRmXpAojHOCfAhjgyxgy57see2P7t0N86yIewmvVum4ggERFN0fhQQSMRG/FAVz7mYoXN1wKJ7tu1lZLVDInVxTZXyBpWSaoIrrYZtjcCJnyEXVUvnBs8DLCjTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045176; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcStiaDj6kYSlYGIdOOIGcFS8RunztBZ5DDR71GFNTYIgCGbhyBsPg22ppCV4LTf+7trbdTR42B6MCaOqIu99N++EL3u5LF/fFrPkxVdAh3vYBPZRXNoWCL7pn6ioHXOk/8zkgirUfu2CaxGMUA8c9zxdbkGv918ornKgZeG7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 477E2227AAA; Thu, 13 Nov 2025 15:46:11 +0100 (CET)
Date: Thu, 13 Nov 2025 15:46:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/3] dm: fix zone reset all operation processing
Message-ID: <20251113144610.GC30779@lst.de>
References: <20251113134028.890166-1-dlemoal@kernel.org> <20251113134028.890166-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113134028.890166-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
