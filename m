Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB71DDC1B;
	Wed,  2 Sep 2026 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357646; cv=none; b=fRQkmMmOEpgKO3cGpj/y6qoF4daHKxlR4PwO6AzRSEnV1M+T502gDAq9hos1FE2zvOCcPtAmHuQXY3BJ0gicAnFLS60Ql5kUQcmQWNSgAAti+gDc9z5pDFzgNGZjeF/YZ4y1XbYIuskTOixLMPXyLxkvtDia+ujjGt6Pm5Lsf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357646; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMmpPwijGrLv8j2JV03NZSi6Rbav4QX+Qg9uP1tvJAl2NlRx0ZG3ROUw4OXTzFiy/YfUE6pscqzerA1nYyDA7Pt+Oct9F/mwsssSg1+kOMFayNUas2SEouzBQXRSWy7dqksWXMs4Cc4nrHG5EY5fT/rCmg8JeOjOIaHnWRyNldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EAD368BEB; Wed,  2 Sep 2026 16:00:41 +0200 (CEST)
Date: Wed, 2 Sep 2026 16:00:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tao Cui <cui.tao@linux.dev>
Cc: bvanassche@acm.org, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 3/3] loop: drop the unused argument of lo_req_flush()
Message-ID: <20260902140040.GB23295@lst.de>
References: <20260831100305.695116-1-cui.tao@linux.dev> <20260831100305.695116-4-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831100305.695116-4-cui.tao@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

