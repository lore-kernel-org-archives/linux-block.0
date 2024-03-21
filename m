Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD66135A50
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058951; cv=none; b=iQW6Y0u1a49A/FaFG+iZsA2oI9cLmUiv/MyalHA++pbS9b+N9/qqWT8iy0lkVmrBfcS4vZzdLCOi+WR+fMU/o74oVX9Rc8L+JhhFDxuU6q4IHMsuM3QfMA9ecd9TgVOZM3pfMyGlinrxropH86TF4jiee6zzN5C1lxS8HxCAjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058951; c=relaxed/simple;
	bh=Io+FJsLuMTVvLogQ1AHhbq+YW23G5AzwbzXZI+jHGlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjqofITlaK7LWtrXnqFmB5JphEK0pBu6rWlsrdF2x70tijDMzpccAxkof5VughJiSRJKk+hHdHyoag5gil1R++Lo8bjF12SSJf04Gs/vDiWtb3OdUlcTQtU9zBs9SpGvn98g7B+e5P9z4I5F6aYCrglddM6HqMyew2zZIcWcKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yEbT6nNM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yEbT6nNM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UIM9liPvzBI23yDCXC31VMUwPMENTLGClkvMLjlIiXc=; b=yEbT6nNMb5MMRvJWAPxOwohYnv
	fL5gUn/ZuTUxOFotwmbTBygBG8eT5XoVuuWZXCzG7EeZV0vKk176zdfb/wxllsf4yb+sNya0vBxVo
	uBepI9jO3vpbeO0XYCw+9FJBasbMf5Jli5J8K4cufVWpdgz4XDdCVR8MdrTU7IqI3H9cQTRt+hY9T
	cEjuZKOGmmlApj7bL13rcH6St2O9Y5eyfqZEfTuIXSpzJj5ee6GjJq1Xe3WNsRp4RfZcWAsMFudIo
	Rts2U2/QS19tieBnsudOcHrSKNDV3RBS9BNgpKGhr/mLyIc2RMKfLW3uXC2vY5LxCQzc5L5pPeNKm
	44HFru0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnQaz-00000004qyo-0d5r;
	Thu, 21 Mar 2024 22:09:09 +0000
Date: Thu, 21 Mar 2024 15:09:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZfywBU9IRHGdqVqo@infradead.org>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
 <979af2db-7482-4123-8a8b-e0354eb0bd45@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979af2db-7482-4123-8a8b-e0354eb0bd45@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 21, 2024 at 11:09:25AM -0600, Jens Axboe wrote:
> Where is this IO coming from? The normal block level dio has checks. And
> in fact they are expensive...

How is this expensive when we need the bio cache lines all the time
during I/O submission which follows instantly?

> If we add this one, then we should be able
> to kill the block/fops.c checks, no?

That would mean we'd only get an async error back, and it would be past
say page cache invalidation.  Not sure that's a good way to handle
failed alignment from userspace.

