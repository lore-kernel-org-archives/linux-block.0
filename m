Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245633F6;
	Fri, 27 Jun 2025 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008631; cv=none; b=YBJe1zEWCsn1rsN5896HvrhQFeC4sE0j6aS3+TGKHmRzkqLqZOztI7iMHESoQhT1v4rd9XDtfLFlVDuEB4OPy2ZNgbjZgGBDmbBsSBL3C6Sl/r8ez1Jold6E+T1b086otDjn4YOeqg4jQQ4RJqLsBeVcivNByDtlhwO+bDbgtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008631; c=relaxed/simple;
	bh=3Ft2BvbOQKbLB9bujrmN4jNXdd0var1HRFO7/iYI7J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfDpTG5U+r8h2NsAigeA4dA96vDiL9DYLgSgp4FLYpUrpKaCWwhnA1DdfoA/B2akiU1GFJfcnVZSOL03sAfqQQ2vB4i+gqqVGwwLpAUHUp4qzjbU0LY1SLirbniLgYZVr0Uo0cSlsA+Wu1fYtQXtnt1pBqFbWCCBPAKflOneEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8AFDA227A8E; Fri, 27 Jun 2025 09:17:03 +0200 (CEST)
Date: Fri, 27 Jun 2025 09:17:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix a deadlock related to modifying the
 readahead attribute
Message-ID: <20250627071702.GA992@lst.de>
References: <20250626203713.2258558-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626203713.2258558-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 26, 2025 at 01:37:13PM -0700, Bart Van Assche wrote:
> This deadlock happens because blk_mq_freeze_queue_nomemsave() waits for
> pending requests to finish. The pending requests do never complete because
> the dm-multipath queue_if_no_path option is enabled and the only path in
> the dm-multipath configuration is being removed.

Well, if there are queued never completed bios the freeze will obviously
fail.  I don't see how this freeze is special vs other freezes or other
attributes that freeze.

