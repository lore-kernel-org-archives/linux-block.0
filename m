Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90A233D91
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506651; cv=none; b=cjBG0HaXdtxUvBWsT+Qo9Vxj9YjYnVl+UhMbMQTI7gW2VllKQjeCOT/h+1McDgkoY+NKWnYOSQ9SswYzTQzP1krDtLx7ET5m6WpdIZmkCs5WiL6RqOtT42NwL2xn5ts7rlugS7Q3N3aTfZ2hV3Hn5fHHgj759dEXsqYz6RRaKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506651; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCIhyKmHQdequSmDGxfbPIvXfoHC+ZC8/A5qbltocOi13QQP6CBVLInGCGRcRkzqV5sLef6SSzGx/sek6fD8tiR7056YqkjU3jXnvSOCT/5Dp6+mUiBdZxEq0W7kcK2r8z6tjTwHkOTffo+CI+AKMvVeDJTjE7OZ5ukkjU6fHkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17A1967373; Tue,  6 May 2025 06:44:06 +0200 (CEST)
Date: Tue, 6 May 2025 06:44:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 23/25] block: don't acquire ->elevator_lock in
 blk_mq_map_swqueue and blk_mq_realloc_hw_ctxs
Message-ID: <20250506044405.GG27061@lst.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com> <20250505141805.2751237-24-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505141805.2751237-24-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
