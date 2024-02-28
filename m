Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023B1E493
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126658; cv=none; b=sk95WAnJc97KvRfpuexE7wj1yg+y/XViQZ1wdWMeIEPBChpcRhTMy7VhTqLXcmauSDYHp2241tgGLFxDKEvLPYs2WipQUNlGFATWRiGoRhFfKnsCN4UWWp/5zBi5Xb1AU56i1yYqpa8POQ2Vo/ttKUq0ZzR2yoynCtd0mNnQz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126658; c=relaxed/simple;
	bh=qBCVAO/wTUmaxl8RF4eulplhO1Reo4sEQp4BEjJpAqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2tMeT++Z8aYqSwKf7nrcGh63pJXmiw00XIXUbRgR+5nW5kYjWsYHLd8tHTLZltJ9eqDExZ15G6r8FiCtPKjzMuAoQMCCaYjNO5n4I4iRJn4rSQb816bqKeXM4KgVzObDTs5aM3QVEZ2UKbOi8PyIlRnKkz586q7ZyWZ4HCS6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A15268D05; Wed, 28 Feb 2024 14:24:11 +0100 (CET)
Date: Wed, 28 Feb 2024 14:24:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH] blk-mq: don't change nr_hw_queues and nr_maps for
 kdump kernel
Message-ID: <20240228132411.GA11497@lst.de>
References: <20240228040857.306483-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228040857.306483-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 28, 2024 at 12:08:57PM +0800, Ming Lei wrote:
> For most of ARCHs, 'nr_cpus=1' is passed for kdump kernel, so
> nr_hw_queues for each mapping is supposed to be 1 already.
> 
> More importantly, this way may cause trouble for driver, because blk-mq and
> driver see different queue mapping since driver should setup hardware
> queue setting before calling into allocating blk-mq tagset.
> 
> So not overriding nr_hw_queues and nr_maps for kdump kernel.

Great to see this hack retired.

Reviewed-by: Christoph Hellwig <hch@lst.de>
