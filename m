Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AABEC2
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557588; cv=none; b=ZI1tCPWvTBwd/diGGu9AQ051SJa/A5cZEI7FrXsx5z6axzieaw2W41F2uRfH00FtpivnKVVmIJamqwuKcZkFyGs/IiZC6D4pOlUEgYaQQkEeoj2O6GHRzIQ5jJjFlb5PDqTCYZ5I6azjuT7cIIHNrJPhCYMoQTL2V3xbm6kz0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557588; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT154edo/b3CAN6smG9spt7m7I0IhPuhEbs1jwHnxFe9IziQKvDkZ5jGmXZhPjZ/te4/m5xL9KYAtQ3Eq/lMJ9ecj0FL9Zcbg87XneZKn7idWOmiuuqJbcrqZNsCHu0bASqmFfYqM3GqsiWi2sdNwe9VVezvKK3DvP+VIro2MeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACAC0227AAC; Tue, 15 Jul 2025 07:33:02 +0200 (CEST)
Date: Tue, 15 Jul 2025 07:33:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 2/5] block: split blk_zone_update_request_bio into
 two functions
Message-ID: <20250715053302.GA18074@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com> <20250714143825.3575-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714143825.3575-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
