Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1E54919
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366592; cv=none; b=DHqiyPxEitpGxvOuAgpzZU/ptum2sJT6a2iACFQ1JedQqChYmC3gJUrNd8miRqrTAsKCGMacLhbhpQaYX6KYIhir96aJOp3xzMyhX0DmvdMB14rcYyn6EhMSgZDlmIqOfVUTd6g4RJRufiqN8aIT9djr0+tN84EpFjJpaYojxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366592; c=relaxed/simple;
	bh=vjS/XOunIYT8DV2VBNmMM68F5wQtLWYTo3Mrq5AaulY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd+Z0f7iT5FMhSztFs3XBBfWQgHBxrH0JPcHJMR6+x7ql80i/Iw+a9A2N1gLNP8G0X2bguOv3s7yA7qYrdtYSWoPDz8vA+q+1W0eDKtTA+CH7vHu3M2TYR5bQO/v5YupOjea5Srz1bZXDyLYWACoImoWgPqjo0PG/3HKessPj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sqbdzTDv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqbdzTDv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bcz8wX6ZmPPxzyepYvU5AC1XJTCZKSHiUBqofkHaOnE=; b=sqbdzTDvZVaBK+DGptBAeINcYy
	vYtfk5r2POSff13omEbijFQ8YbWaWXPd6Eg0nzhu3dU+MFwFE4sw2+bxKsugq8Qve7BFGjm8TAujw
	gXSssLIvtiKR6fQU2KLUrwcIkqyvHI2ELe7LQCYbFyZCS/JvUyHiey5telE9BNFUgJugKQwn1e6N8
	ZLvzCl5aN/plVdGFVT4qOkk5HAuDyvMIkzIhwRE5AF9oSAHlbLq8w7tAbrMHweNiyRmAiDAR+lvt8
	7UHWcMVnLiRbCVgV0HnPQa5Waqo8X2vlSI1MVGMKmMr+6xgQevuqknXj6fNpBY0kDumuIgAI3Z4/u
	l5QAI+Yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkWTq-0000000C1gT-2nd7;
	Wed, 13 Mar 2024 21:49:46 +0000
Date: Wed, 13 Mar 2024 14:49:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhengxu Zhang <zhengxu.zhang@unisoc.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
	hongyu.jin.cn@gmail.com, zhiguo.niu@unisoc.com,
	niuzhiguo84@gmail.com, hongyu.jin@unisoc.com,
	yunlongxing23@gmail.com, char.zzx@gmail.com, ke.wang@unisoc.com
Subject: Re: [PATCH] block: Minimize the number of requests in Direct I/O
 when bio get pages.
Message-ID: <ZfIfejdNTL8oassd@infradead.org>
References: <20240313092346.1304889-1-zhengxu.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313092346.1304889-1-zhengxu.zhang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +		request_max_size = queue_max_bytes(bdev_get_queue(bio->bi_bdev));

Besides all the coding style problems this is simply not how the bio
interface works.  queue_max_bytes is a limit only available to the
splitting routines and not to the upper layers submitting I/O.

Please try to debug your scenarious a little more - just because a bio
get split off it should not just turn into a request of it's own,
but be merged with the next bio due to the plug.  If that doesn't happen
we do have a problem somewhere.

