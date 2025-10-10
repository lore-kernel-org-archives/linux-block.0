Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85BA1547F2
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074486; cv=none; b=rnYaFQDsB8reoys0IvNasakh0CZZIbkZFa7AKqpvg1Q862Nex66loIKiCHZUyszW4By+4pBVpRNM+zOzctOULarFrif24H1OY9R6yP1Iosb1O2upu3mPcKOOn8njfMwYVyfQWEKoiDsM/LTUDmr3xJoOrP+mt7fAsB39me0EUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074486; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5x2d0rDniHLoff0AKzrD4eRZmKEI+sU/fWJ/yE3MqO9wgNnEFSwIOO44TqmggFiDC7UeizIwO92FS1ujVOJXxuM9SL70qYf1bIFIzPRJju7bi9YuElQrsB80TTerC+CX7KqedFRZjiqkKrK+HeSTskWdVdpzU5N8DN20ebQQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B130227AAA; Fri, 10 Oct 2025 07:34:41 +0200 (CEST)
Date: Fri, 10 Oct 2025 07:34:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 2/2] nvme: remove virtual boundary for sgl capable
 devices
Message-ID: <20251010053441.GB16037@lst.de>
References: <20251007175245.3898972-1-kbusch@meta.com> <20251007175245.3898972-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007175245.3898972-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
