Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D2207A06
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428939; cv=none; b=opQkOSAGkSVG61skaP2DlzRZmGBSlF3nnzx/jpCtcO/K61UPvxrRG+/CKEUjKZ3rjHIvfqWd5uGQlECjrldSxOv7n1RKC1HIFdu59Wyal61oKFu6/2/QdcR2TaF5WVqczttipTDsRCMieVBNVMFo+47QPzrw9yTN9p4Gkj210+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428939; c=relaxed/simple;
	bh=8GS4gcR6Q2K59iNlz5MrNLyw2F9gLUod7+7L2UiuWSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6aagAEm9b4cJc/bdtNVYtXCW7xj6crjkjCxW0mlB0E720/MQmSEbRQg/E3KRAkEcb/5x5Cgxoq1Z1geBUVqBxTEPuKFfLL5/VCL5WT04ywgOjCtns3Tc5U9l7nQ9UtgEG8gt8od+I/nkOPBXcDvswiCxwtAthSQJ8dpJwop71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B40C267373; Thu, 13 Feb 2025 07:42:12 +0100 (CET)
Date: Thu, 13 Feb 2025 07:42:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 2/7] block: remove hctx->sched_debugfs_dir
Message-ID: <20250213064212.GB20494@lst.de>
References: <20250209122035.1327325-1-ming.lei@redhat.com> <20250209122035.1327325-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209122035.1327325-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Feb 09, 2025 at 08:20:26PM +0800, Ming Lei wrote:
> For each hctx, its sched debugfs path is fixed, which can be queried from
> its parent dentry directly, so it isn't necessary to cache it in hctx
> instance because it isn't used in fast path.

Same comment as for the previous patch.

