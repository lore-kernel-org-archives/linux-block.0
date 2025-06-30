Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAF13AD26
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264136; cv=none; b=Lelc9tPGI2eJ4zDMcqX0Tuk8x79TighQsRPkX9eYsoZQjNez4ZM7vxB/DK1hE6mWYNoTY60EU2J9TKUG7dGrNBqJDBkNFkJF4aY/HjDclOR5LwIn/DFpF5nobQn1mGZkFWRHNZN3tKPmY2I08Y4GMTd6OJfoOR6hh7su3qkyJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264136; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0YwCCot9LBGJJMf6bxA63CEdS3NWuFG7+Ym8MVVmIWG74tcn0TWsKJZDHiiYotfGm3rRhaXXFDiqxkyvTxAYWszRTCOG04DILk4Yx72HHFK5npas+bPqIFvRziRJHVjSFGOnA5KOUfJudhkJI49gIovfkMY8j4T61te7MfH2NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8878768C4E; Mon, 30 Jun 2025 08:15:29 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:15:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk,
	sth@linux.ibm.com, lkp@intel.com, gjoyce@ibm.com
Subject: Re: [PATCHv6 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
Message-ID: <20250630061529.GB29122@lst.de>
References: <20250630054756.54532-1-nilay@linux.ibm.com> <20250630054756.54532-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630054756.54532-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
