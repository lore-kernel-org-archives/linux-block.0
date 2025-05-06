Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28921B9DB
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506467; cv=none; b=Es7OvpiC14yU5AQu5tcQ4Dhwj2eoHkMghoXRumrwi2u5UMPVGiGmeKN0+9dZc6tUMDhKEN9c3MlwFVPWIwguMM0Q10QWaW/uQoUmLZc2gjkeJc61RwbCCocQWRiQngboFIMfPtIqk10gDatdUN6T4QTMwwdOkNjKWZpEYtu3yIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506467; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsbQ7JuRa6UNzQ3/1zOQ0YrUUtgw9AXNRS5AXD4arEUAdiLznyEQdcQGe5TLsZ55Lv5M5uXFSHWkkMEFzKbtw/hUr8EWOuoOKZgLp2j44Pk+2StWotoWu3HGLjQrhTq4lVtGGlZCG861EipBFk4nShRKhha32mvmsqOeJomoXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2ED5768BFE; Tue,  6 May 2025 06:41:01 +0200 (CEST)
Date: Tue, 6 May 2025 06:41:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 09/25] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
Message-ID: <20250506044100.GC27061@lst.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com> <20250505141805.2751237-10-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505141805.2751237-10-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

