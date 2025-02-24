Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9E1632D3
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414845; cv=none; b=RdUxAR1U9BqKKWW/68boGLYqpACMVLbPP5CuY4Z7fr/J4WkKJX/CVTcW4yPvTzfNmJ1w3TO4iPluwrsSAyMwt63DyfoFOjG07+cYe5OkIK3gEVdabM3FEdH+LmUazFN0P5/hKtSrRa7mqC854krRZ/Fgt/Vn/bwz5Gmmou0SpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414845; c=relaxed/simple;
	bh=NzJS5XWjVt055cUFQB+DbnYXEgUJFpqOAtPhBvRjN1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slbWouRnTCPijgwnb6rymFsaXmp03j/WOtWyafBuVVTlA1+j4QW45jfMzYSijfqLvEABDARvFiKAbvbNtcCTS9pfcl7Kh9/QArFZPalw8mKnIh5FBZ9Dj8ytFQ2V7zqW7y/KxbsNXHspAerO0AYuiPd/Voo505H1AqAfeHfR+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7AE7B68BFE; Mon, 24 Feb 2025 17:33:57 +0100 (CET)
Date: Mon, 24 Feb 2025 17:33:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv3 4/7] block: Introduce a dedicated lock for protecting
 queue elevator updates
Message-ID: <20250224163356.GB5560@lst.de>
References: <20250224133102.1240146-1-nilay@linux.ibm.com> <20250224133102.1240146-5-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224133102.1240146-5-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

There's weird upper case for the first character after block.  I know
some subsystems like this, but in general try to at least be consistent
for the series.

> +	/*
> +	 * attributes which require some form of locking
> +	 * other than q->sysfs_lock

Make that a proper sentence:

	 * Attributes which require some form of locking
	 * other than q->sysfs_lock.

> +	/*
> +	 * protects elevator switch/update
> +	 */

Also make this a full sentence, and mention which fields this protects.

Otherwise looks good.
