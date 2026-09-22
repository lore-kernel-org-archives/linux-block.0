Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6D1F1932;
	Tue, 22 Sep 2026 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082555; cv=none; b=Z1rJSpOyM26xCjHYWPB2e4D9Grqwl3OO6ieMzsDV6upFXsNRXZQOEkC9AFXcKbbr/8ySUgmMjQouBP2qPdkGDw5P6x5TaeJbWfRufJnyPh8OdM7PJBUWjghVIsuZem7pD0Pw8dGXNmgVjbsBV7e7ZkOfQr9eyUtkW36XTLcQzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082555; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evYOMd+zukjvdUj6G5N+50XVU42ATZzre6yCDyy8nrDt1N+FdBK7cRTF8Rof0y44RYfqYR13iux8ZD6u/cLn618h+uvUHiXTUwCni7GLgnrqYw9LHKh6I2DUMVNXhtsNtCjJcH92UOgtxoh1lqcCE5ezA3JO2p+J89gLmCU+1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AACB068C4E; Tue, 22 Sep 2026 15:09:01 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:09:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.garry@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
Message-ID: <20260922130901.GA29875@lst.de>
References: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu> <20260921-blkdev-fixes-v4-7-e2801f71ede9@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-blkdev-fixes-v4-7-e2801f71ede9@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

