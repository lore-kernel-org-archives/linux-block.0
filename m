Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870926658F
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968634; cv=none; b=UU19r/LYw7quU5y6+iJIlufQnJj0u7c9w8zg/PPE5fB+OTB2uTBJWuOPN2gFHbo0QwNZgvq6H51TfEBr1bOoPrT/p7EdKKg2OSE5CmsycgRebazQE5eHvJe/b23HGzEyuAEAh4yVcHT6Tu1ONciiOBccNx5usE6VpKn78HK2aBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968634; c=relaxed/simple;
	bh=4sE+QwU/TWUPE/612hVEaxSJaNYRIXzAZThqbhoXABo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiZwCSuLkNHJipMAlIG62i+p7gyPaPLiYm4hhux3D+PUygfmEbcrr7E6by8JQApp7FFBfw0Mj2t7OSo6pGJzdFlKW+8Eke2rD0Oy+cdu5sPaRsqODibnt4s8ymu+n8dTaANqAP6s5NmQy5suGLT0hcIOhdGQ5xk/U9cLFco87vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E2DD68C4E; Tue,  8 Jul 2025 11:57:08 +0200 (CEST)
Date: Tue, 8 Jul 2025 11:57:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue
 attributes
Message-ID: <20250708095707.GA28737@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org> <20250703090906.GG4757@lst.de> <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 07, 2025 at 11:35:32AM -0700, Bart Van Assche wrote:
> On 7/3/25 2:09 AM, Christoph Hellwig wrote:
>> I'm still very doubtful on this whole approach, and I think you are
>> ignoring the root cause, which is dm-multipath keeping a q_usage_count
>> reference for an unbounded time.  It is only supposed to be held over
>> I/O, and I/O is expected to time out.
>
> No. Since queue_if_no_path was introduced, it can queue I/O
> indefinitely. The oldest reference I could find to the queue_if_no_path
> implementation is from 20 years ago:

Thank you ѕo much Bart, without your help I would not be able to
git-blame.

That still doesn't make it sensible to keep the q usage counter
elevator for unlimited time.  See nvme multipath for how we can keep
bios around forever without elevating the usage counter which is
supposed to be transient.  Note that dm-multipath should in fact
already be doing the right thing in bio based mode as well.

