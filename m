Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE491ADFEB
	for <linux-block@vger.kernel.org>; Mon, 17 Feb 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783588; cv=none; b=E0ZbqeQQM+u5MFvxX2IOpr5bqc2G37MdwJBL4j2Cd47lRxRZMKbyZfWPOxHzQKct+ReLaPrRD61VCZbCfW+FNaB7poeucvRenOhhf+pWL4d1FyOkQMObnOb8fJF9c1hUrIIFKNrcHFrpLyjJQ5OcfFXzhsfRfwfFEQ2uhvnH1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783588; c=relaxed/simple;
	bh=Gen9cqDG2tKuwpBGasxjlc5CFqqizC5P5D4UtlHmdpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo5LIbvGjVE1XzjOE9E3jZj/gpvsUS3g5niQIvcgkQYHn+/NzWyTBEk4z03qu9CI4zPCjG4ZJemTNR0WCiJVlhD8zOpxUMZzlAHwizNqiGaM6SvoI39AJPJkFQGAqe0z7nZii9r395tK60MQdgOthcslN/K4N5vjV2uu/yLi0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F087768BEB; Mon, 17 Feb 2025 10:12:59 +0100 (CET)
Date: Mon, 17 Feb 2025 10:12:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/7] block: remove hctx->debugfs_dir
Message-ID: <20250217091259.GA28866@lst.de>
References: <20250209122035.1327325-1-ming.lei@redhat.com> <20250209122035.1327325-2-ming.lei@redhat.com> <20250213064146.GA20494@lst.de> <Z66lWy5Yf4T_4mlg@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z66lWy5Yf4T_4mlg@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 14, 2025 at 10:07:23AM +0800, Ming Lei wrote:
> On Thu, Feb 13, 2025 at 07:41:46AM +0100, Christoph Hellwig wrote:
> > On Sun, Feb 09, 2025 at 08:20:25PM +0800, Ming Lei wrote:
> > > For each hctx, its debugfs path is fixed, which can be queried from
> > > its parent dentry and hctx queue num, so it isn't necessary to cache
> > > it in hctx structure because it isn't used in fast path.
> > 
> > It's not needed, but it's also kinda convenient.  What is the argument
> > that speaks for recalculating the path?
> 
> q->debugfs_lock will be not necessary if these cached entries are removed,
> please see the last patch.

Please document the reasoning (and tradeoff if there are any) in the
commit log.  No one will see your cover letter when bisecting a bug
down to this commit in the future.

