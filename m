Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF871DF98F;
	Wed, 14 May 2025 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205809; cv=none; b=CqePQvj5EjXkTO2rGquyNEXwLKOoeHCIWtftuUVE6MUU1TaXVSxat1fMW1xFbughem46X2/J/6oyHX9YJUfOrGY/ZZnViOuWjV1y6gq50M12ewIpvDkP+O8NODkM3SfUXdWk31ZV9lcvckWAjSC7gedJ/g0LmjhNwopiWKFMoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205809; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzwl3Y4M9AGBGZ8m3IRYpZmC04fsO9OuHpxt35Ln1+EyaXH1neIAXUAFultBoG97dsEu9DRlImYj5uM5eQTbyuAy9Z1kx4LgqUmuQ2+kf29JUMFh0s0VRfN7cVXWIpkT0f2L9DV7GboYi0565agZlsNnfWsIAnztKztOWrfndco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F2B468AA6; Wed, 14 May 2025 08:56:42 +0200 (CEST)
Date: Wed, 14 May 2025 08:56:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <wagi@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] block: Remove obsolete configs BLK_MQ_{PCI,VIRTIO}
Message-ID: <20250514065642.GA26631@lst.de>
References: <20250514065513.463941-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514065513.463941-1-lukas.bulwahn@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

