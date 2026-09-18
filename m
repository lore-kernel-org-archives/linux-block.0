Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974704A0159;
	Fri, 18 Sep 2026 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716383; cv=none; b=jE4aC+fy+aQ/oCac5B9kYdIUV6XDwCSKv9Q/6WT3n1bFTqYPxsdOvwy/Sj0dokX5UZ73MKeqTqNENTYhY0AGV/P5LB/D6NUP/DQ/y+jruIRoiYo47vMj9TOU++loZ7vvJ68eqzbD/pHi4XXhCBO2guVVKrSVd0W9eUlJxMReAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716383; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjql7S0jtvX6kerO65mEwpq8ULGjUY20TtzEcHJRLnkPjteTW0Up1PTvakLEBGf0lw+fDb8/vMGUiPYURGkVD4r1UTozGFW+gTXXhzwYCBZe/zPZaS4C29Uy8KO1hkHdSwYtOS88bc5YaCgvZs6IZR1v9L966IjkWb8ukSR3nF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67E7E68C7B; Fri, 18 Sep 2026 09:25:49 +0200 (CEST)
Date: Fri, 18 Sep 2026 09:25:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] block: take i_rwsem for the splice read path
Message-ID: <20260918072548.GA11032@lst.de>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu> <20260909-blkdev-fixes-v3-3-1a5222c6e8ad@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-blkdev-fixes-v3-3-1a5222c6e8ad@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

