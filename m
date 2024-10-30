Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4BB672
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299398; cv=none; b=Xd6f5LnU1CaAUciyeAeIl0W2EiKQGEQRzwQD47mxVGxIJn8pe8pq0Lp6pyIu5Zoee7/iBGlv6JHYv+6E2HaFY1pQOuRO1qKUOnX7mQOge8AhVGjg+NHjMJDTlMReJbiFMRx0771oFbtsuE8YLoRqhzrsxo8tgLckxzzKbmfpZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299398; c=relaxed/simple;
	bh=jvoyvvztfNSs0DLdpXxRU2eReo7m3xWCfO2QXaNzrrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Snafw0XWsMR9GHgGWJJ+izeREK7Ba4NHnMV5yee9qRneSUsrQ0dMC5UlXfXSrS76PelCKacLWHcZpSPv8VUAmyoEyoEL+yZvzrn5sDLGOP2ffgjg880t4iG77hdbnA2wTmCCcAiddrdKD7BIMo4/lO6NouX0RD7XohNu1cssaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98ADF227A8E; Wed, 30 Oct 2024 15:43:11 +0100 (CET)
Date: Wed, 30 Oct 2024 15:43:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] block: remove blk_freeze_queue()
Message-ID: <20241030144311.GA32043@lst.de>
References: <20241030124240.230610-1-ming.lei@redhat.com> <20241030124240.230610-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030124240.230610-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

At some point we should sort out the mq vs non-mq naming, which is
a bit nasty becuase the freeze functions work for non-mq disks, but
do so slightly differently..

For now this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

