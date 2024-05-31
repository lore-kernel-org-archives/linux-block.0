Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF25588D;
	Fri, 31 May 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140768; cv=none; b=egL+BsB3UobsZQOFGQ8GEQMAhuQSm6fFLTwORRERo0P4BI1lxBfcjwIXNo5HDzS3sNzNChfVcj+RxPXsW8I9Hcl2YuJYOK20KoIICwSh/QwefqPAkBhgLVbctUAX3p9gmUYW1Rv0gsgq1YHq4vEdLFAuvYrrVXipTYzyO35vzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140768; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJtkVC4wMKMTILhXCh0ypXjIz7327eAe47pDSD5MHPZN5bGNBxScnN5jFxPNHwf6roSnghh99RReD1OJdEv+1MotZBsMWGvbqiRQMBFT4Blm2hJ+B5XDBygOa9+jU+abJ85J4eokA1NnzDKacBCH7bbdJWPhAf3xmcu1SpJAZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 199EC68C4E; Fri, 31 May 2024 09:32:44 +0200 (CEST)
Date: Fri, 31 May 2024 09:32:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ofir Gal <ofir.gal@volumez.com>
Cc: davem@davemloft.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org, dhowells@redhat.com,
	edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2 2/4] nvme-tcp: use sendpages_ok() instead of
 sendpage_ok()
Message-ID: <20240531073243.GC19108@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com> <20240530142417.146696-3-ofir.gal@volumez.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530142417.146696-3-ofir.gal@volumez.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
