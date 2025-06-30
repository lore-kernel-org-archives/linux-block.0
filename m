Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE76BFC0
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264005; cv=none; b=APhF3fSmtXpiPunfi81fzGkPtz0IbG+Uekwy+G6GXnMK55HtasOcNO08//PdXoAxRpctzU3SyWzuXIte4bmYPb9Ck/ouDwdg3g2YnXm59VOEaS1ymbnHfclVm/2ZWYXPBVLt4XFJQDVy1fitZoXk17USdpYhL2/lkkhyNfPV4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264005; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6/xGgMhBHEHUwvI/C9lJUTP6YBXx+kiE0h/Tcgc7UVdeSABDa83IzcdV7MO9dU6Nsam+HBdtWeduy5CRIZLXLxqVd0SQzcXbsNHVhZ+S6dqK4zLEjttX5TWmyCmyLdNWuEyiI+f4PzuqqoWZVfMTN8AWwOn9gbXgRZQqMMMB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C64B968AA6; Mon, 30 Jun 2025 08:13:18 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:13:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk,
	sth@linux.ibm.com, lkp@intel.com, gjoyce@ibm.com
Subject: Re: [PATCHv6 1/3] block: move elevator queue allocation logic into
 blk_mq_init_sched
Message-ID: <20250630061318.GA29122@lst.de>
References: <20250630054756.54532-1-nilay@linux.ibm.com> <20250630054756.54532-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630054756.54532-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
