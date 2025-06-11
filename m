Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4D19A
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675961; cv=none; b=kZjCnrGUb2M1rPhPN+moUZ/8XK3L+vUA8nB+R2cwSsmVEFngJxZ+joK6lzOo3REj3ZZQk3YgPPu+6OGYk5SSIUlVY/pUJRHrdI37X9n/5F0f5JTRYD4RlKv9yGzqAah7OR5UvUcJzlHe3/JJSd5n8eHYfC/8Vnelht41McKQ3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675961; c=relaxed/simple;
	bh=8tO6qxmsRUkIIBT9ozmrJ7IvNbFTzhbOE1w9t3tNNAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ima5+VgT+jlsJmWePbcegYV0A+3C/ChhJGIIOU/LptwaTFk8x9Y93kuz0iW76wxEC2U29uZv6nZkCDB730mk51VnaxPntlHDTREkKOS8ZfaPBbkw0E08AvaQnP+ZHOa+rLk67PO32LGI3PGH4IqBTLloeGrljpU9SBZD78cQsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkNksXF6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkNksXF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93411C4CEEA;
	Wed, 11 Jun 2025 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675961;
	bh=8tO6qxmsRUkIIBT9ozmrJ7IvNbFTzhbOE1w9t3tNNAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkNksXF6NYQCPrIQvTLXt70JWzKtKoGMt+UTOqYzA06pMtc/9xyXdDtblh6x5lNLy
	 piewtEMfmiZ0JLsb2qm+UEJJIuq9IWVa6xXVltO9o4hiSbDls52ov6hWaIYZDV5QL7
	 mStx7VTvDqkifpSjXVRn/5djR9nVDtVUYdaq3KKiq8fw2X+Sp7qyAf47QxWBDuJMYj
	 HjN9iCsAQYuHTIDAYx0jPRnb8CebMezUfmEKYkODr9h7VwKIN8HJEZH2tasZjkwq+x
	 V581RDCt+JvzhF6DEyRWnrUKh3VgPG9rIoQL/XWk1awq8EzkvyxCqVBj45OLUhieSe
	 IF0AWyRBnX6vQ==
Date: Wed, 11 Jun 2025 15:05:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-pci: remove superfluous arguments
Message-ID: <aEnvttB7jcH8lrCe@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-7-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:44AM +0200, Christoph Hellwig wrote:
> The call chain in the prep_rq and completion paths passes around a lot
> of nvme_dev, nvme_queue and nvme_command arguments that can be trivially
> derived from the passed in struct request.  Remove them.

Looks good

Reviewed-by: Keith Busch <kbusch@kernel.org>
