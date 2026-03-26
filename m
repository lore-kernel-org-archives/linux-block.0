Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0C27713
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506227; cv=none; b=hIXp6zLF7uY/EtjrGrV3K+ihGzGo8OLIhBKgXjYRbGn4L6XNY2K40sTIOJubM7VIFbmsKiTKuzkV+Cj5ZOC+TETjhzzFTT9ZDJJuHwqIxVdFyqU6ySdZ+zk+gphW2AnQutVJ9vlvu33s/0nCEyRiQSp9Ck94W8psGHCd6ffvvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506227; c=relaxed/simple;
	bh=BRK4TmHkA2QwhhIIMAidTJtRRUemNf42MVv81OBWYCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofZqfavd5vCvifOEWd3clnNI6EPr7qicxcyro0T0fYZZMkONPekO4v4R/YT8SAOzheJ4UFR2SibzbAHPio0DQBq8Ucv8Eg2xwOinWjUzeQbgdeCCLiuZOYsoxjgBfcHNaUzp64If2bx4Ba5mZ+f4LLM3lKLbup+CMPrAq5e2C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92FF468B05; Thu, 26 Mar 2026 07:23:42 +0100 (CET)
Date: Thu, 26 Mar 2026 07:23:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/26] Enable lock context analysis
Message-ID: <20260326062342.GA24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Bart,

this is a huge series for very different things.  I'd suggest you
submit the core block annotations first, and after that you can handle
drivers indepdently, whіch reduces review load and the amount of spamming
of the list for repeated resends.  It should also help you to iterate
faster.

