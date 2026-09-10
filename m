Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228830D3ED
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017618; cv=none; b=DxzF2cH7t5L0S/FgRbzVFq3KhC3FvPxGXvJI1lWcgbXXIChm4/tIDDdscu/6Vto50TZnDf0qjQqnWTzQ9Yy6InoTDld4EeHFKdX+1rl+rzRuU6H4DsABmAojcXwC2rXjauMAJ6D5+nW/5mBuvidOW+GFFH01raljYXQz10A7hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017618; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0KeUXC8aCUuFjQNjRojY3zRKn7H7fEotutrnBP993RS4RqQzoDUHlhI9HBPvly1b7MlEdDVhwsElBfSJP6xnknu+kNB9lpswuZLas1qrpgwaW6S32UW1IZbCLhx5hDxKwQ7qENltfbEH7XGz5ZNh6IZ/6NtxtJ4f/uw5lijPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0AE7968BFE; Thu, 10 Sep 2026 07:20:13 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:20:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v7 02/16] block: improve capacity handling during zone
 revalidation
Message-ID: <20260910052012.GA27013@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org> <20260908085745.1082697-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908085745.1082697-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

