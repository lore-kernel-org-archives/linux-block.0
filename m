Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00537DA68
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618876; cv=none; b=pLBkVSg0aaRyjBbLf37YG8i4VtwYchyAIX2XkViNbGvDkj7yGPZXRcYMpq+48+kIwE+/JlffsdBtDjVsG7bzJJMXyoM/DAF38+9R7S82J1gdsTv5NOP0QsqSaDKJ8EtweD4WuYBWgq1s10rgpNhRv4xtmH+psifAlyVx0lQvLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618876; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icdJnDogG8w/Fid9LD2uG5NI4sZXe/gunm0fSgqX2wys9HALaINL/MSPB5c42hprHt7YUvjUoYy8JuotwsBQAK/8eIYF1Vs1vIFuZBl5rd9r4f7bMc8w10NZPQpqLRhdmtYK7/APCVHg0x+fSWVJqskPR23ZlcWtBtCXcIm2WEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A2AA68D81; Tue, 26 Nov 2024 12:01:11 +0100 (CET)
Date: Tue, 26 Nov 2024 12:01:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] block: Prevent potential deadlock in
 blk_revalidate_disk_zones()
Message-ID: <20241126110111.GA19006@lst.de>
References: <20241126104705.183996-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126104705.183996-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

