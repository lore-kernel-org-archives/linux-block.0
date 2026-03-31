Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A30282F15
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971534; cv=none; b=gL1SMLIIxblqevfgHdqhfw2WsO8m4s6aA8qLt5B22fZEgwpN64EILGDBUG7BkhFMqMnYpH2eujaJw8irlJsO0j8ctyAwDGUA79+evYE9Xjih5tZS7k9Ts5whFGaLIPnzJiRtAlsTFF3OVrfAmYtX8FuyVMFJ5sDaamPuzstLYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971534; c=relaxed/simple;
	bh=Zsyy+y5qyf6n8uRe9tWiNWKBuyGKcoso4JEMUlKUVgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzyqTb3rHmcfxe0oByYk2JA1Dk50w9LkX0bZjWvPwF1hg1Bjqp96RriOi+dImi8xb/0k485UECxF4fZ7p8tg1NajjD2bYC0QaJ68sXCUIT0QvnZ0VyMxyrKN8eACODnkMHGSxTqrV5a/ZDQAPkRaFfoFbCSLkz4yc4o1mxDouNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EF2068C7B; Tue, 31 Mar 2026 17:38:47 +0200 (CEST)
Date: Tue, 31 Mar 2026 17:38:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 2/6] block: Fix the max_user_sectors lower bound
Message-ID: <20260331153847.GA8470@lst.de>
References: <20260327211349.2239633-1-bvanassche@acm.org> <20260327211349.2239633-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327211349.2239633-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 27, 2026 at 02:13:42PM -0700, Bart Van Assche wrote:
> The lowest value that can be supported for lim->max_user_sectors is the
> logical block size. This patch prepares for reducing BLK_MIN_SEGMENT_SIZE
> to a value that may be less than the logical block size.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

