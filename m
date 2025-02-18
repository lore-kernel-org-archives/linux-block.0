Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E51DD886
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868420; cv=none; b=LdYORghz0pIondVrRbWZC76Zw+WXckqjSHYozAindVFUH2s+veW0dAxInswvG7GWxZA5/Lt7qm5Z8055OnXcp+PLNt9qcDSvDATyARshMymbB78lP4Uh8gKaNwCMJwhryBcgfAn/aBr+HcSUK6frcEjc3xuAZyy2DqR+MKPv9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868420; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQNG8ac1EqSs7b2KKRRzm722PBvsMsql+qYeqIgeWVu6FI6AmBi89Sg9k6ROmOPSifuWl400B2RXn9lh6bov838k1EoMeqa8bGDf8sLYm4PZRfuArpjR2egNNLlhfvzUvlQVusRBdACQushZKuuIF3tYRiUQzr0yU0JJYcWw6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EEAA68CFE; Tue, 18 Feb 2025 09:46:55 +0100 (CET)
Date: Tue, 18 Feb 2025 09:46:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
	axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 2/6] blk-sysfs: acquire q->limits_lock while reading
 attributes
Message-ID: <20250218084654.GB11405@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com> <20250218082908.265283-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218082908.265283-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
