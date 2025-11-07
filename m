Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5A225D6
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515648; cv=none; b=FVpSR0zc8lK07qGeLRApf5ZfS3p/NQT8Y79Wp7cs5z0+6g3eld3f0BBwfo4sMmp2omZmvUAlLH8pIbIviFIUOwJ2bVNgBZxHJziD7XKykS5uJX7Y2D1w94ynZceHDg6pqM9WSKAsuLQfwgzj/dOacDQAsTLHXsnBxw4tpFu2dAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515648; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuTe+u2ZZ6yR71MoE+oPUj7FOEv99G33bDBUvnxEaligHJr4xWrjwb+YNlGKREaaGjvEs/UiaWj7qXjA6D1OzQuVHzk3k8zEBGaW7yhI0X9iw0b1NrC9SmCxIK4IcpQyWmNUrffoimj54qteHOcpX4tlXYFFtk06EgKlax7w2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E134227AAF; Fri,  7 Nov 2025 12:40:42 +0100 (CET)
Date: Fri, 7 Nov 2025 12:40:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/3] block: refactor disk_zone_wplug_sync_wp_offset()
Message-ID: <20251107114041.GB29236@lst.de>
References: <20251107063844.151103-1-dlemoal@kernel.org> <20251107063844.151103-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107063844.151103-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

