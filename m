Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199584;
	b=OK1lYWIBw6JSwAuilrT4qYklYG1DzJEjgvnhbXnaSqd/fkkgM/HPuT9sFb1CSJjvhL1R
	 lf8m/LRghb57CLos0eoliApNSr8OgKKg7vXv3Serqjgub8ilFOzi59DZcvpujcTOS6yCi
	 va+7fDjRGPLTy7ThGQ8ikqViS2Gk192YXLuDdyZQOPOyQLkXqEqOW8Not8efpJ1X5WcVr
	 6vvtWV6a+FyG6ClvX29v9rdkQwxjWPhXjKSFWlNxLb3TYGfnZKSGRoPp5FM9ZkYnlodeW
	 JWBosycQO8P9kaTx+E29UoIXVCQpbW8EBSYOOdHnkncwiZuTYgN+7BBHkpkEtlohPpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199584;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=7f/Q3Ubg6FLd/TGz1QjLEPKUZ62q3rotuIdvwu7p0cA=;
	b=3JHqXI3B3tamvs2LhF66mUOF3x1FmXzWjayNVsN08EHHtwTGMfP0LsU9q9rTAGLzLRch
	 50KR0qjBQaarAzZMlKP+7SNvw5x9gvNPb2YB8O7BGUc+XadTG8U5aADsI4zBJBYwGKqfG
	 ykwLTCoXmYVPGhGX6Ly6s1Mf4Y3RWUTJFPimKRtmXigFT381H/rPa46hOfNBD9jfxBIyo
	 xkR+hnc5v92j3GLC8Jx37dzrM071LnfuJYCUlE2XhslF+lvDGz7gfPgbbpgKK7wtToTmY
	 o2LbwNpw1/RDC6faimeCHck8dQJCGmpvEr4LtxmoqrBJ9y3xUeqywkftxHEPu/O+blw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA44606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 14:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA44606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B35268AFE; Wed, 28 Oct 2026 15:59:40 +0100 (CET)
Date: Wed, 28 Oct 2026 15:59:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 0/4] nvme: add nvmet zone report and FC
 regression tests
Message-ID: <20261028145939.GD15112@lst.de>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Still not an expert at reviewing the actual blktests scripts,
but the test contents looks sane to me, thanks!

