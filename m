Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946D320C
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538677; cv=none; b=mtBqLNmtfAgBAwwpVkC1AMqiGfh5l/4YVC3A6ZMWgsibWvQNehS+Xc0eHxVF3qmxNyogLtvyVaNp5wJVudjx1xsE4Etmts1302tpHHUDFuvXw1epuHYaUjqIkhWLyeC4oyE0yhAoopfp5mBzRkTWFfIlG3qnEe8WLrZ6cnFMo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538677; c=relaxed/simple;
	bh=7W+qky8MVS2uAHvkaOW6bnbOrao55M0ZAzc4TnGbmDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu+8FMUGojiSBZ/icOkY5B1FI1Sklg1hLlI+qlEDPaB3KWuNU7AfMxeZ1G8/oy2Pg9wPjwz7HduiPWfcuw+0P2AUogshotyMAnrHK7elDMazVPtKdUPEQsBJMNMeeDrQkLR/M/Jx4VdrlZCLftLOLpnfHwPDXkTMY9roYvJNDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AHRaSncy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AHRaSncy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hrc/JUBVjBsw4rJNm/fkPbBXyHx4mnZ1JoHJVHfCs5c=; b=AHRaSncyx+A7Bp0GNQZKM/a9RI
	RP5SSXMPLaV7xyo3Lh0RNogaXryo5ytiC1AQ1eUsLML9V4ulXgAqBJeS5XqYqz7xM7f5DqMgjeTfs
	7ml3+wos3t5ZUZkod2YT14LPKCb/SQybjinA8P+ZaRaTb0Qqx7hKL8APdZrFXmXYp34qgWE/RmxV7
	NMEdrplO7Z5c+SRFx9kqny3d89wrRSW9FhymwPE6mJ25abdUzebTJuhjYNOcQ6ZcV96VlLCp67ncD
	G0lBJLPxZ4IQAnPrqsJg1EfGwrBuIAOBFHWnR/HFV4sXpb8R0z5OUJHierKWRxg5HgNcqO5cvAqdG
	ZS0c/r9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEcGd-00ENCd-2t;
	Tue, 04 Jun 2024 22:04:32 +0000
Date: Tue, 4 Jun 2024 23:04:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] nbd: Remove __force casts
Message-ID: <20240604220431.GU1629371@ZenIV>
References: <20240604215227.321764-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604215227.321764-1-bvanassche@acm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 04, 2024 at 03:52:27PM -0600, Bart Van Assche wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Make it again possible for sparse to verify that blk_status_t and Unix
> error codes are used in the proper context by making nbd_send_cmd()
> return a struct instead of an integer.

Not in this version of patch:

> -static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
> +static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
> +				 int index)

include/linux/blk_types.h:93:typedef u8 __bitwise blk_status_t;
