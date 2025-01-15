Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C022FDE0
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924380; cv=none; b=huDFTW2/IQlat8eh2rNCZ0sKMoi1yIJz+icHrVSpX8gc5wsVa/KSbrURGoYBwM7Dy7jaXmzdeOUQPFOuFwqf2Dsswesxr7FzubRLWfBKDdvKx1xV8NYlYdfir41tiGZkycUKoG+Qoc/Z3QSr01MNeL/9tRMBSEpqZllHAGSH7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924380; c=relaxed/simple;
	bh=f2A/iBncBVgajPoo6VBrs8sHBWdJl1xcMOvjZ0sFlJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c78euOb+npCf/aJo6aNWr5A7INz3YQ588sVq+k04GGjPxMBgedtF8V3UzIIOUqt8MjNdModPUkiEsc1k17zTr77J36qnmlWWVe92+MLmWn4c0KAo/6KJ3Tqj/ELJG6r7YCYVyKPmdYskTFxdEHhc9JIH+DEVSmr+4hNj1sij1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2MYoEfre; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2MYoEfre"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oudpRQdMc4Wp8wW/HtkogwE5oJZXmMe6VR085JA7fkY=; b=2MYoEfreU2JzzAcyUgQJ4Q6/1s
	e0JOkU1nvuqzimEYTJoJ9Of+EQcYxd2ntJvp59ftcoj+UNVw5aqMdhovn6AlXMtJ9dvOZqH99GLF4
	kPAjjArGTDhxsTEjSBoZZzxyngoN+BXHwcI2MCCAz0noj0VpIxIIgZnuejpZfQPtr/NBBShR0zCER
	BFEbnKIBW+7db7A29HLZvRxwytO/kW+Ira4bzlzLijtVrgc2PJvX8dtTSeMM0AWzzQ+R5vYLSYDqd
	qS5UrAoDjvZaYMbOzVYLeBJN+PlWitZICetQaE2QulO4rWPQMCABpRljPnUo/Sxv3Te8zT6f2kKWX
	ja/FKDvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXxNK-0000000AsPO-2tZJ;
	Wed, 15 Jan 2025 06:59:38 +0000
Date: Tue, 14 Jan 2025 22:59:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: move vfs_fsync() out of loop_update_dio()
Message-ID: <Z4dc2r5yRMb9pehA@infradead.org>
References: <20250113120644.811886-1-ming.lei@redhat.com>
 <Z4UaKmN551grXYMn@infradead.org>
 <Z4Urk9NvFqcVhgoS@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Urk9NvFqcVhgoS@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 13, 2025 at 11:04:51PM +0800, Ming Lei wrote:
> > instances, and we need to fsync with a frozen queue to ensure there
> > is no outstanding I/O.
> 
> loop_configure() is on unbound loop, so there isn't outstanding I/O.

Yeah.

> loop_change_fd() is switching to this new file, so no outstanding I/O
> on this new file before unfreeze.

True.

> The other two can only switch to buffered IO, which needn't the fsync.
> 
> So can you point out anything is wrong?
> 
> And this way is sort of simplification.

Yeah, I think this is fine in this version.  But please update the
comment away from the avoiding races to spell out that this is
writing out the page cache before starting to use direct I/O.
