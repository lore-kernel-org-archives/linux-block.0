Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1601714CC
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725655; cv=none; b=j4wZM21qtdck5Xs3EyLCe4kmiLW+W5vh9+4nsbJJBGHUVjxzUkVXZUm8ix12JdKGfJUbZRZoZyrP0t7ZDDH32nfW4X5ZMNKoTnKWjnJnXbM5o82goDqY3ZkrbhvedMEEDhaPgliFNUUe077CilzM0eQOYPBKtGn6uuoVFk24z3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725655; c=relaxed/simple;
	bh=fmhkjB1OIf2VtrX0fmI+2n4lJoOPTLFuoWSaCYuzZKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7KnlL8G2ugtCEtkhEduTvdQ/ToSqofWIuiJ/p5UorQ+q1zIH7Jms9nLhrDRYMDCR9ArZKTlKqjnOmmE1E/mcz4GDJOEuSrCKN/h6jSZZwZCTSEbNOVdy1Kg9Gk6x1eN5hFvRp9NX6XvqUsAxIPO9dFVNf9whf/U/yMV6xZzBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99637227A87; Thu, 15 Aug 2024 14:40:47 +0200 (CEST)
Date: Thu, 15 Aug 2024 14:40:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Message-ID: <20240815124047.GA7803@lst.de>
References: <20240815082755.105242-1-john.g.garry@oracle.com> <20240815082755.105242-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815082755.105242-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 15, 2024 at 08:27:54AM +0000, John Garry wrote:
> +/*
> + * Pass bio_write_zeroes_limit() return value in @limit, as the return
> + * value may change after a REQ_OP_WRITE_ZEROES is issued.
> + */

I don't think that really helps all that much to explain the issue,
which is about SCSI not having an ahead of time flag that reliably
works for write same support, which makes it clear the limit to 0 on
the first I/O completion.  Maybe you can actually spell this out?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
