Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1131EB39
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970694; cv=none; b=j7oQUuPwlLQpRoE8EnmLBzKNoPOyc0QI7NVPXl8dIwVV3F2KgAy94x3d0x7wX9ypodKmYZxXNr8yQnEjF5OR7FZ64rjXi54Plj4ycjy49kug2y6+atsg5hO4/Mp0YWGaAzPM20m+wzAEXuMWIMWymYNRcp3N/gAtDvfVmHPV0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970694; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU1E5cI+ouk87w6PMEM/aZJhhpGAXZDb+o/EHyX0ZU/4fKTVS/V2my8JrzURdgffyWYImsqhwtedsWBWL74/QH7jzguWArGB0CltWy03fo1CjP14/W9TOz5iFi6xAAIsSKcckm7htGdbiYeBUOcTmOTUMuj01BzCX0X9taq+h/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A61168AA6; Thu, 31 Jul 2025 16:04:45 +0200 (CEST)
Date: Thu, 31 Jul 2025 16:04:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] zloop: fix KASAN use-after-free of tag set
Message-ID: <20250731140445.GA32216@lst.de>
References: <20250731110745.165751-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731110745.165751-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

