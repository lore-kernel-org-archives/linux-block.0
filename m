Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080833B71B2
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953881; cv=none; b=jAnTRcyoqT4LAhurRbh2Miy35xwRHPzNcCY4GeExM+LHVaWRoxswF9efiTxdThQ3mHO3gZI8mM/0tNs/sgTYDXZHpcOMor3Ufxn0B2nYUtfp0fT9ZZ0/yOA7FkG6C8t/NjdRcthe/uRuW70lccRE3Xl6RKNWmXsV5kLzq9FiTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953881; c=relaxed/simple;
	bh=nto1cll+9hBrTjB9udVUBLiBqRR4zod28EbDE/j8Hz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx73EZe8YKC+eDecpg3OCiaJGMAYqnMPbVip3E9HuY0tA3GqNdoQj+AbG+yyjKmZxWiz5N5lQuoi+hG7h/FPQptMNd+5pliI+k+VTJGLK3yyREgvlhJseHomZARwo9S07asOKLC6S/mCxhbp3TZoaev8Qhn6j7FZjr/UNYxtCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91D6968CFE; Mon, 17 Aug 2026 10:04:35 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:04:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/4] nvme: factor namespace-head queue-limit update
Message-ID: <20260817080435.GA21461@lst.de>
References: <20260806024658.4193386-1-sangyao@kylinos.cn> <20260806024658.4193386-2-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806024658.4193386-2-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	/*
> +	 * queue_limits mixes values that are the hardware limitations
> +	 * for bio splitting with what is the device configuration.
> +	 *

A little nitpick despite already having reviewed this: we can reflow
this comments to use up all 80 characters now that the indentation
was reduced.

