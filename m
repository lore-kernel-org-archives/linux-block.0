Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E3363089
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017648; cv=none; b=vC+a/8hLF3z2Qexjo+0y9veNJX+TLxr2Erwdvi4Hl9pBgn0ek9WR9RNHnr5tLK4ysZ5zQ0VVjFYuaS2TN02T5M+19sryChBYuIdjtRyE75skadnORRxEQ0AJcZ8bB7lpbSeDGT/Po8x86a4469OJJ7dMTiOrUXRloHTaPw3AvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017648; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3NuvnXuo+2DDuSINu/qiB9Dbc0JbEnaoTpSIDnD5jRJqQvH0gy1vDY/CiqDsMASos98LeuAPK+VdqPTAztZvXRDEfyzeelLRJzcVbZzUo3weMXAoDTkAqR5qt5mE3mblGQothfs/CR6c+y32WC411jPCUttkLEY+GqjtN2OY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0640768BFE; Thu, 10 Sep 2026 07:20:44 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:20:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/16] block: refactor disk_update_zone_resources()
Message-ID: <20260910052043.GB27013@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org> <20260908085745.1082697-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908085745.1082697-5-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
