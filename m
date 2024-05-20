Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC250275;
	Mon, 20 May 2024 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208911; cv=none; b=Ex5DtzRFgVOkdxnHpbB9LLs86y/WQZXsDNiZYsZDSxRHftt4F4SD9g3tYjAorR1/A5lt37TsEkwnpWan9EGF7qtKjTwWNUy+/XyHvqWuCkxMKy6Zb4bxD/fD+nnjH1hzvHQnck737LrilhfUkz14NKwLzqerK8wiGCEM2zH29fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208911; c=relaxed/simple;
	bh=NNnqm8KV6ZbwfxiwXZmSFuRXn2PRBLa/5gn5RtnDIDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwGQRf9m+VfdAdZKldPyVL8BEE2rP0+IdaMn2ktqueCJcLLkMUXntcCQ0FzFbTeojedjY6porykkrQqJyuXd0MIcCnlqJWL6frJoioQke/jto6AeLApNH/SSqFkc0cSb/9lYsVJdD/ot3wRRvkvPX/8tVLDjXJYVBkKFFqu3xq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9862F68AFE; Mon, 20 May 2024 14:41:37 +0200 (CEST)
Date: Mon, 20 May 2024 14:41:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Josef Bacik <jbacik@fb.com>,
	Yu Kuai <yukuai3@huawei.com>, Markus Pargmann <mpa@pengutronix.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] nbd: Fix signal handling
Message-ID: <20240520124137.GA30199@lst.de>
References: <20240510202313.25209-1-bvanassche@acm.org> <20240510202313.25209-6-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510202313.25209-6-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 10, 2024 at 01:23:13PM -0700, Bart Van Assche wrote:
> Both nbd_send_cmd() and nbd_handle_cmd() return either a negative error
> number or a positive blk_status_t value.

Eww.  Please split these into separate values instead.  There is a reason
why blk_status_t is a separate type with sparse checks, and drivers
really shouldn't do avoid with that for a tiny micro-optimization of
the calling convention (if this even is one and not just the driver
being sloppy).

