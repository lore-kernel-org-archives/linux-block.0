Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED343932F9
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138523; cv=none; b=T6n9KSsF1DFRXGYMXHPzHmMg97KJ/wxRmsrR89l3t8+GGnoSV4N3Zu+BAqvs9o+pRCpvehMMIK5UFIAXrIRjISrjLN94gA56jsEXhXhC5HGdxmgKa0tqrqRYWrk9TfBDVkWD6PGGv95XSPKkVj0fJx55DrxcWNsW6axVlF9/Gjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138523; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmb3b3y/K6eM0h6r3yTcWbQ+zFjeygMarzfMGo/4O9VnrdmkL7EzKGy0UYTPAbitJJ4a4Y2hGBK4c0+9I5DAdy1Lw6EeDhm1MOjaItJIsecgWmCInB9YarXRyvY1zeic7Cs3fsCKirerdYxMRWvkzu/XTuEyrjd/jz1G0rRPV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC7BA68C4E; Wed, 23 Sep 2026 06:41:57 +0200 (CEST)
Date: Wed, 23 Sep 2026 06:41:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hare@kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] blk-mq: allow cached requests to be used for
 flush operations
Message-ID: <20260923044157.GB26178@lst.de>
References: <20260922172711.1573186-1-kbusch@meta.com> <20260922172711.1573186-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922172711.1573186-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

