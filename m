Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65731D89F1
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152148; cv=none; b=Vql4kWmYCcblEdFpxYXHfL0UQSKH+sm7RvSmYW3D2Cu7roKcktmw8VddAGruy0tIgcq06AqGART9WbB5sgM3Gfz0T0Wi45OZNOhWWkFaSEEyg4aphKvqxH56Ht7g1z9SEY28LCpykroCOfZMLOXtSkfltzK7YyUjJ5KGFpIRmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152148; c=relaxed/simple;
	bh=oEmuGXxkflolDRJbHhsJp966A6ItYiOlp+ez8YTN3M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYjF/3Jdxm7WJYYT3mMqnC8yHl8OLYZnIeXld1OyNT1r3yvG0xPRFYt51SwqB8Tr768fG3YxBpt6UEau3x6NqERo0qiYCYoWieYloPFqcJFSpSNsjUUpsnLJNo8SkX1XgNenvYPFOOy/YV+vUboFq9vB5oRlLDHtIi4AhKfY5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE4A668BFE; Mon,  6 Jan 2025 09:29:02 +0100 (CET)
Date: Mon, 6 Jan 2025 09:29:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250106082902.GC18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org> <Z3tOn4C5i096owJc@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3tOn4C5i096owJc@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 11:31:43AM +0800, Ming Lei wrote:
> As I mentioned in another thread, freezing queue may not be needed in
> ->store(), so let's discuss and confirm if it is needed here first.
> 
> https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/

We do need the freezing.  What you're proposing is playing fast and loose
which is going to get us in trouble.  While most (all?) limits are simple
scalars, you often can't update just one without the others without
having coherent state.  Having coherent state was the entire point of
the atomic queue limit updates.

