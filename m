Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0643849B
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695039; cv=none; b=UKDujTkUtYCnoKsPFZc4pclbidn5xGVy274miL1q1/eBf0ciN87WwZY6jvaGndso1aJkZm2PCmq6IoCNpuX5N8C+ifNzXRUhw98yaF8T2lUT/0hoZI7yQ9ZeLw+85R5CRq1C29xr4dsMmW30OeLnjvSyAJDzCH+p9g5QBG3aHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695039; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkIiCJdxSCyadFsJ9s24oUY66iDzt2P9MFjpZ8Ii1pLp40K1tQezHrVBs4Qqavjt03W3h0+oq9hdwo3ckHAMS74GAbl6D+I1N73U7PY/F0DTsVqgQ9QWOtzu9LRmm5dIkZOE1VHVROp7aHhhcHol6d6WH8SN8mv1Es3iFizWVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4450568BFE; Fri, 14 Aug 2026 10:10:29 +0200 (CEST)
Date: Fri, 14 Aug 2026 10:10:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 12/13] block: simplify disk_zone_set_cond()
Message-ID: <20260814081028.GG12566@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-13-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-13-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

