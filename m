Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E0206F2A
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428912; cv=none; b=ZcrDGbZbnMdubIVanlHVtIilfQKgly9HtnEKl+S2LG7kAT69y0N9x4Yl4T/vwGreH100150mQaU6v9JNEuvpwjZM8rwdrmlYMFM1gaNk6Lq2XRjtwbhHyDA9XPwG9z8zUFR4+618KQ9JJi4j9Om4sxITZqt09JNQj836SDDnSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428912; c=relaxed/simple;
	bh=4IcMEMczKJMGwc/vbqddXDGC6uf4JN9rOQ47HtemY+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqVG7c1IH4n30MD9VWgSkgeXaNse2ADP/fHdpD8IQUR5zF90xoVu1fFPI4a1lw1i7XiWNz9m0BI+jYrdlZKkWEaG6FQ39gv/VLqI49YwxdEQ2MgQdihTe2r1ZzozMVN0JbcSJ8aeQX/TTbGzkkI5Jd1UPwQFuSkvc4tMgwlfAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDF5467373; Thu, 13 Feb 2025 07:41:46 +0100 (CET)
Date: Thu, 13 Feb 2025 07:41:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/7] block: remove hctx->debugfs_dir
Message-ID: <20250213064146.GA20494@lst.de>
References: <20250209122035.1327325-1-ming.lei@redhat.com> <20250209122035.1327325-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209122035.1327325-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Feb 09, 2025 at 08:20:25PM +0800, Ming Lei wrote:
> For each hctx, its debugfs path is fixed, which can be queried from
> its parent dentry and hctx queue num, so it isn't necessary to cache
> it in hctx structure because it isn't used in fast path.

It's not needed, but it's also kinda convenient.  What is the argument
that speaks for recalculating the path?

