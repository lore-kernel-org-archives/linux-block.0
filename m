Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017C2147F6
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730372; cv=none; b=Yhw7ABzDihrwhPYKF4MICL5S4Oza93i+aZMcQhtBFzA0ypmRIjT4TSW+93acxuN5pubREclhfEE5/lWZBFzDf4Vvs0AA//8fHUHjk8x8xF9crRVfxTCfKbP80qDYubA97UEhExkqO/tcwuN/NIpzUtxQ7/SOQ0M2UCvC2XLg9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730372; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDCI23zvAUsR6btQ6uEmZYdRcf3aJReNsjYpcY+o5GcJnQSh+UfMvBfv+6IvQRDxxjKeeJt0zDmkmkxOHL6rjop69Kkfi6uiiD+/VEyq3geqjB1Yhyo7gZ55qv33tom92CR1hmKYwfPUpeEU2fedKHTlx2bVxKKq869MGOFWIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 38B7468D0E; Mon,  9 Dec 2024 08:46:07 +0100 (CET)
Date: Mon, 9 Dec 2024 08:46:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 2/4] block: Ignore REQ_NOWAIT for zone reset and
 zone finish operations
Message-ID: <20241209074606.GC24323@lst.de>
References: <20241208225758.219228-1-dlemoal@kernel.org> <20241208225758.219228-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208225758.219228-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

