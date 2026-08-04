Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F6471406;
	Tue,  4 Aug 2026 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852291; cv=none; b=GGHglx19yUKPQzg9B80g4QrKBFeY2zib8Kg7IgpZJ2YL6jkEspF0hAV8FiMl6VY98AIAgaEboaKVZuAsKAvJN0CxpRtYUIJ6XiBNuAPt5sMBXrQFnghT8LrBN5nQ+4ZsrD+UIrPw3SQZ+D8JbiWAcVDoJkL+pgwSByRcU2nBxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852291; c=relaxed/simple;
	bh=CVpXY1C0KS5HchdV1IDwAP6GCqkQdQYt54DHYH/0YEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jpfdxv1/olnUZA75lT4L1ppxHqeRJc76ReVSiz20ro6Gg0oHyQLyVk8vOFGOKC+Y1WqVf3YjglOTBE80+3BBoCx8Vr7eucXNIYwtgnK1q8SKlLHbebN4gzUUQ6qffQ2kRAsjRUj1M34QuNtnDBMNY6SaYpS/OL8poJiDVIKk50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5E3296732A; Tue,  4 Aug 2026 16:04:45 +0200 (CEST)
Date: Tue, 4 Aug 2026 16:04:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/2] block: take i_rwsem for the direct I/O write
 fallback
Message-ID: <20260804140445.GB8894@lst.de>
References: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu> <20260802-blkdev-fixes-v1-2-a82fc549fd74@columbia.edu> <d30b6c9f-e479-4cca-8dfa-576d7562d2fc@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30b6c9f-e479-4cca-8dfa-576d7562d2fc@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Aug 02, 2026 at 08:11:41PM +0300, Tal Zussman wrote:
> >  	} else {
> >  		/*
> >  		 * Take i_rwsem and invalidate_lock to avoid racing with
> > 
> 
> I seem to have stumbled into a Sashiko rabbit hole of issues with IOCB_NOWAIT
> and IOCB_ATOMIC here... [1].
> I'll wait a day or two and send an update along with some additional fixes
> I've spotted.

I think IOCB_ATOMIC vs fallback to buffered I/O is a generally
unsolved issue.  I know ext4 just has a warning, but I'm not
sure how to avoid creating the problem in the first place.

