Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B14385D94
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299305; cv=none; b=subP0kNbNK6xotYMNRlR9HFLEpTT2dM347xpYe7BkKYq8/pIWSTgAzkUR/36nUJ68pW3qqn/sGhx5hw3n0tnMozGJFSBj8zm/bg2Jw09vHHokMESacKZBd6s5Gff2hopmLG7Uo4I8M+Br1UyUPHXU6VCRc7XvDnrts6LXX3Cod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299305; c=relaxed/simple;
	bh=i8h/6U6f8A0Ees+4p/Mp/PkkwGHzdhoItOtb6ISU3Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clUN2+u/pqm3urowXW3v10CRKII5o4Jsrhg0on1CorVXEZ07TmLGtiDw3fP64LGzhe6qf7DUGbrtrki+vUnaX9r5BjwN9q963eEtDAuvKFOoc94xj0csPYsq5aSg6jVvLEA54MficDiX9rXmcNvPZhB6cokaFC+8dM8JrQfI+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A5FE668B05; Mon,  1 Jun 2026 09:34:58 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:34:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v5 12/12] block: Enable lock context analysis
Message-ID: <20260601073458.GH7799@lst.de>
References: <cover.1779997063.git.bvanassche@acm.org> <e4d44af70627b83fedadd9501609a2eec5d21ec3.1779997063.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d44af70627b83fedadd9501609a2eec5d21ec3.1779997063.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 28, 2026 at 12:45:49PM -0700, Bart Van Assche wrote:
> Now that all block/*.c files have been annotated, enable lock context
> analysis for all these source files.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

