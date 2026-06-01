Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC032B10A
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298918; cv=none; b=jLESdiPK1hpVOvl6IQYZ89tmniB6QmnIj/fXCMB2y4MdNozmeM3wXL3r4gYveiy/BSZJhv1A2VmJOg68gJoKDdThpDOiw1kQ6/q62VTo2NqtkSY2qjvAxQdzMi5cC8qfoAkSqeS3g5hxureAqMi+xR1AUXiQyxAlpTXoa08yRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298918; c=relaxed/simple;
	bh=nbH5gWiA3/J9KoLf2ikmlrdSqVcfC8nE0KhGdG6L1TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJPmuCYPq4tGA1ImA1kHit1Kgxc7NKN6Bu385PmCJlJlm6vU1f2I+h8RnUjUTs6bbFwfpS6RcTB2QRf646VLnHW9Y/U11Mcogj/2Tt5MK/oQ4H54S2sKncGJevqyCAWOX0GCydC3q1HayNQHmDfVwH2lZNaM4+k4HlaceZgE3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A84DF68B05; Mon,  1 Jun 2026 09:28:34 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:28:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v5 05/12] block/cgroup: Improve lock context annotations
Message-ID: <20260601072834.GB7799@lst.de>
References: <cover.1779997063.git.bvanassche@acm.org> <a30486e2e9695614e4407d5ad8c75d637f5b31db.1779997063.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30486e2e9695614e4407d5ad8c75d637f5b31db.1779997063.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 28, 2026 at 12:45:42PM -0700, Bart Van Assche wrote:
> Add lock context annotations where these are missing. Move the
> blkg_conf_prep() annotation into block/blk-cgroup.h to make it visible
> to all blkg_conf_prep() callers.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

