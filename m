Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD214A622
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186634; cv=none; b=kI7MlJxBOkJrmSnE6ZZm848JvhlLhB25+8R7bfcht6Rt7+jzLwF0NHbBE/IZnIiP7qb5ah19AjeVbkQTvqUAt30aLAt5zrrFG500qokxM+BtqyYO14s7g9tLHOM/yG72CgTFD7CQT62BpQfNbLEXGnztiWQtO8EiIYJZ4LjH6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186634; c=relaxed/simple;
	bh=6u1tPVSkFoKWQ01SaIoJRzRHHYE9qJ6CYwDQu8Bz9j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQYMDw+y+TIGKZ0S4hB4AcGN3TBcoSkkGKtoqInf4/4Ylu79jYLMMCvvCr2zOJB3XpYAPmWTpVS8iVmd4lTr8gSw42hZM0+WR9FPgKruwpfczBvgEX4RtIk0OmI7q0de4vnYWX+L48gOfM4hnsCIbf77MvgY62m/zVjIH6hYkC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5DFA168B05; Fri,  5 Jul 2024 15:37:09 +0200 (CEST)
Date: Fri, 5 Jul 2024 15:37:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also check bio alignment for bio based
 drivers
Message-ID: <20240705133709.GB30748@lst.de>
References: <20240705125700.2174367-1-hch@lst.de> <20240705125700.2174367-2-hch@lst.de> <85d7971d-f682-4b9e-8c0a-0366075471de@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d7971d-f682-4b9e-8c0a-0366075471de@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 05, 2024 at 02:25:59PM +0100, John Garry wrote:
> On 05/07/2024 13:56, Christoph Hellwig wrote:
>> Extend the checks added in 0676c434a99b ("block: check bio alignment
>> in blk_mq_submit_bio") for blk-mq drivers to bio based drivers as
>> all the same reasons apply for them as well.
>
> So do we now still need blkdev_dio_invalid() -> bdev_logical_block_size() 
> pos checks for simple and async paths in fops?
>
> They are not doing harm and messy to remove, I suppose (if strictly not 
> required).

Going all the way down into the block layer vs just doing the trivial
check ahead of time does not sound like a winning proposition..

