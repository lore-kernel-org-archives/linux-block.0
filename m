Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B10443307
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586874; cv=none; b=Kov+FviJQKeNBn5WDWKSq3X5ciSqfLdQPXP+d5+owu7HGxTH0DyWujHZk/FjYrSYk3puoSOyEdTTtK64BAGuQFp7FtTZ5opbz8ZSEWoHW0ug0yIj4ZUFxxUgAA9Lkvp7EJwj9yQyRJ7VRFLy2haXtTwu3ZNsIVfcyG4ZSGvzcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586874; c=relaxed/simple;
	bh=hApaCMmqd0ZdsgU3Fzkd4F/2G7vnzlI2W1/8dub5qBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqQDCojjrvOAFN0x7KEh0RlTaAjTrqf2X1u8R/4eYK52MgVoZPsWWj0d/luY6RijLvs9wSzNxd5epZ9+LkzRDAvqtWmRlVYdY/iFGdXVX38GoOROy7/DNBf7z05Gz+izwPkoius4FCcvV570M/LkIwVYd+aO97E/ZxZCknHZxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3000168BEB; Mon, 28 Sep 2026 11:14:28 +0200 (CEST)
Date: Mon, 28 Sep 2026 11:14:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: John Garry <john.garry@linux.dev>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/4] fix NVMe multipath partition diskstats
Message-ID: <20260928091428.GA29876@lst.de>
References: <20260921083752.1154316-1-john.garry@linux.dev> <5fe0a938-aaf4-46cb-8fba-3524586ac5b4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe0a938-aaf4-46cb-8fba-3524586ac5b4@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 28, 2026 at 08:30:10AM +0100, John Garry wrote:
> On 21/09/2026 09:37, John Garry wrote:
>
> A reminder on this one ... or are we just going to leave this broken?

I find the amount of overhead and relatively invasive code very
offputting, and I still don't understand why we now have a strong
urge to address this after 10 years.
