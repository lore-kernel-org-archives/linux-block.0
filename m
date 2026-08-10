Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF853FC5BE
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373529; cv=none; b=BJdVpGlhODUk0TENgcj5aXoYGWikIHK6QKBuzg+ePJGwLKY7ME8FkBrQ+6YPEry9NnO4jN8C1crDSZRKOxklaQKsSlGXqt7dPxOAeThGObfPSlHjg4UcVzmDuFekidoEiVbhf75sTtyhud/S49RwMDRJ0s5Qpxp/7BoKWIgvVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373529; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDo3makens4QvH2GyH9Rkj1X16bfx27t3dfTdhGBN/LetGZ7HltI0Vq6vonULWbwuKBZnjlbqVPchZiPsJ/Of/urvfosG3a+99R4WS8gc2q4Vvm2xXIa0R6l9X2DTXhaGu4k0fAQitcl9jv6jwUWJzpDa5/vhgHnWKwvLN4Zqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D648668BFE; Mon, 10 Aug 2026 16:52:01 +0200 (CEST)
Date: Mon, 10 Aug 2026 16:52:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 04/13] block: remember a zone type regardless of its
 condition
Message-ID: <20260810145200.GD16182@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org> <20260806160445.848337-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806160445.848337-5-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

