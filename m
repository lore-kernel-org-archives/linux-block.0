Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C049CF2D;
	Wed,  2 Sep 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357602; cv=none; b=f9nkEXtuGSpNNFj8dyB3VG1gb4pdshp0gavww5s8gN5DX6EcNdN8WGmhrsP+bsM1m7spKR702aEkCdapJUZF4ThD83Qzo1jnMcbQNoKAigZfy5fUdDxVJw3pFuSO2xvqHHlVPeeMomy3/dYCdwh7S1mPWA1fA96BxxGVQ+QKRcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357602; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmZMftq0eXb7D0I16xtJYjSjkQj2kD/HjXEcbdCPgfJxoaNb3w95KWxHw+JksXxG+UfAbgCNwl6SYjV5N1we30T7DQtA5FwVyadG2tIIXokjCFF+QGLECF0BvEB0kYXPfVn5NIgXgoob+U+kvh4A4AGTtfx1YvULBLrLBPmDLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6001D6732A; Wed,  2 Sep 2026 15:59:53 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:59:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tao Cui <cui.tao@linux.dev>
Cc: bvanassche@acm.org, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 1/3] loop: drop a stale reference to
 loop_validate_size()
Message-ID: <20260902135953.GA23295@lst.de>
References: <20260831100305.695116-1-cui.tao@linux.dev> <20260831100305.695116-2-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831100305.695116-2-cui.tao@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

