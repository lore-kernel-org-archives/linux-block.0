Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698E26D5CA;
	Tue, 18 Feb 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896317; cv=none; b=NngXYE0pbsg5LVJeFZsKEJAiLKLkBGT3TNV2yS7hRLFYGfDV4o9FFIeuobieQQXvNtO+bzg9cYQ9h/ERLo6XB6EfP8y6faJaNcJYshOLFPTalumcYAg0vJQsCwnQCfIaRAYKb0ujVHRZBYdyU1jktwivsK5Dqjmyu3WWNDR1seU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896317; c=relaxed/simple;
	bh=O1WcDjlB4uYgZf8hrYXTcaBSbG3qW5jv7r+ScLddb9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhtJFAnShief694wPU+6k1cd02UpBiHeQgkYxVNdWN41vZZcLSQU3qrhGjeV2mjyQ6qT8W15HHTA9rvqSd9JpVdUT9srEnNhrfuFsUKoMJjfbRjHm519+yhXuCq9gOna7JOduEhmkEJDzDiEYiO1Pw7aJ56JFzzIUnHsKWL8GGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MUUJk25I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUUJk25I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DIGo/JNUq06ew0K8FogdXyJj75K+wZ/XtC8vHgqRE+I=; b=MUUJk25IITKibdWYLiOfwJTNHF
	jTYjZVF0QmUp8zd6mO646+shdzHM+236nm5n5810nL19RjB92XEBaeLj2KOVmo6/7jnEinXumlSeW
	3tY5oa5JILGbGc2/iSIrfxErQ3284MDTCqGQb3QmioR2zTB/6qz8ZmNOZSNZD6uy5fzS1GYpQ19nd
	2Aj8wymGQNblO/HLafe28admo3zzYBxSTXWcoJoMyC8X+XHvSvz0pNb1g4NS/OswGPyrkDnDxW/WD
	snhiObaj4iRIYvhIo24Gqq8tffJcBH5GoXteww5rCfQaNX5otmaYcHCPoGWCMl5nGxAK+H23ROvYt
	QdTjmYQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQVi-00000008ywd-3kxk;
	Tue, 18 Feb 2025 16:31:50 +0000
Date: Tue, 18 Feb 2025 08:31:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Dan Schatzberg <schatzberg.dan@gmail.com>,
	Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] Revert "driver: block: release the lo_work_lock before
 queue_work"
Message-ID: <Z7S19ulXMAs7qy1H@infradead.org>
References: <20250218065835.19503-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218065835.19503-1-zhaoyang.huang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 18, 2025 at 02:58:35PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> This reverts commit ad934fc1784802fd1408224474b25ee5289fadfc.
> 
> loop_queue_work should be strictly serialized to loop_process_work since
> the lo_worker could be freed without noticing new work has been queued
> again.

Btw, if you care about the lock contention you might want to split out
the trivial non-cgroup version into a separate helper or at least
branch and reduce the lock hold time there.

