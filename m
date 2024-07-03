Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69926178CEE;
	Wed,  3 Jul 2024 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012776; cv=none; b=GBhgPtoWjgCftWf5JBKRLHEmC6vIuRjPR4ybL+CAUogN4l6Zl3Afb1RqrGV/q0j0Q1Ba13vcmJDDPu4q5sMYalQN/fFrsPk2ee6tvGOmyfWJ6tk1mV/Ik2+nZJSEht8Si7ql4XPU7qoEPbk6Fft+tcuBBgTWQims+e8pTE2cTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012776; c=relaxed/simple;
	bh=dhUbszQYZ16St23VHIu0tFLExWMcJ5jU50lppUTa+9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlcUfGMqP1psTI1Pq0xOx1D1QO+g2SLc0wCZIjUse21dvitB+Uvze1j2pi3tHMzw72uojZw8PxQUfCEAs5ylW35cKZ+qOK/eooBOkTE/u+MF09x7ZuYv6q4q7CGseFWmo2G1IchpCdgGmjQHVm3wKJsOnigwAXQ9lusvbuw4Sng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fNOUDqhM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fNOUDqhM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5rDjlZZEKG84QDIShgonwEJOVJtAmB4KTYil0+eurmE=; b=fNOUDqhMhUE1oGfgA946jOjNnD
	r1QUfk55VVHMOqmfs0WfbosbGFGz+9JFdoychdws8+ogUtyAeXzUE7l0b/0S8FAXtRM4N6jlFBpZZ
	zohXLFwrWHJwwhaYQICIT9AAnlPK5czeKdzDXkKRLNNfubW1gYhx/yJkdYuR/+agWPWCsBb0WgtKV
	Ulbs8jmium7Y/XXl1WxK7vrA3Ct84ibb5Z/NVtGCtSFExF7FD5QAdJaKadmIu90O2S/SMtQcgqIxD
	WzeKVRv2SSgZ8ZD8ay4H2rRLvQT4Cgf9vrZL8GOPZ6GXZq2DAouvORipjna4//oQGOv/PCqw8wYCg
	3GQM0q6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOztU-0000000AHbZ-1Zzj;
	Wed, 03 Jul 2024 13:19:32 +0000
Date: Wed, 3 Jul 2024 06:19:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: blk_validate_limits validation of block size (was Re: [PATCH v2]
 null_blk: fix validation of block size)
Message-ID: <ZoVP5NZhCmMH6qBp@infradead.org>
References: <20240603192645.977968-1-nmi@metaspace.dk>
 <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
 <Zl6cHI48ye7Tp1-C@infradead.org>
 <8f8f8f78-fcd4-4e71-8dd5-bae03a627a34@oracle.com>
 <Zn-Wpq2AzBo6rcgd@infradead.org>
 <43aab70c-8521-4dfa-847a-1175d31a55d1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43aab70c-8521-4dfa-847a-1175d31a55d1@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 01:20:26PM +0100, John Garry wrote:
> So if we stop validating the limits in a., there is a user-visible change in
> behaviour (as we stop rejecting invalid limits from the NBD_SET_BLKSIZE
> ioctl).
> 
> We could add a "dryrun" option to queue_limits_commit_update() (and call
> that instead of blk_validate_block_size(), which is effectively the same as
> calling blk_validate_block_size()). Or we can keep
> nbd as the only blk_validate_limits() user (outside the block layer).

I'd just keep the extra external blk_validate_block_size call in nbd.c.

Maybe add a comment to the blk_validate_block_size declaration that
drivers should not bother with it as it's already done by
blk_validate_limits.
