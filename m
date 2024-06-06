Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF613AD22
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660699; cv=none; b=a53hWDB9ugHXoe8hLlDtrR1sPFRMyfBEvwxAs1pZc4/9BmcH+44eju4l3+jLn3/9KfsSyNCwIMlsQ9bbSl+uVORrQSQga90Xe7cAJllEsPXV0Lrpek9yYfX94Zn/O0d/1qfuEhC9VVgO9m3S7PYkntqBpXGHFcW5MMhteq+/MOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660699; c=relaxed/simple;
	bh=IKrA5mMVFYCcYocmF3wIqm+BNKjudP5FTaiihYIfZG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evYDh0g5omOjo27b+XOSVMU/2LxOtjoYMpTURIqkbJ9F+koLTbeSidr7bb+NjfAuxrz+pydEdqli9xu8ZQHL1hMIyanneXeIybx6twGLmYTyOqMgN2Hxl9NhDNAwSJPDIqeV+7Y1BWDYNWHNqjSAbnXMpm8qbXSNvwE70QG3CDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16AB168D05; Thu,  6 Jun 2024 09:58:14 +0200 (CEST)
Date: Thu, 6 Jun 2024 09:58:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v5 3/4] dm: Improve zone resource limits handling
Message-ID: <20240606075813.GB14059@lst.de>
References: <20240606073721.88621-1-dlemoal@kernel.org> <20240606073721.88621-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606073721.88621-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +static int dm_set_zone_resource_limits(struct mapped_device *md,
> +				struct dm_table *t, struct queue_limits *lim)

Is there much of a point in splitting this out of
dm_set_zones_restrictions when almost nothing is left in
dm_set_zone_resource_limits after this changes?

Either way the logic looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
