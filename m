Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4582566F7
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776720; cv=none; b=DN6ofk9toGpux9vDTKXYeAE8tfs5UyG9IRybAXAyXAnBU/XJTwqoYT1+zV3h7MxkY6WrpPOte4zC7iCzIYNv19J1xiYaNIui4/5ktfCQRGpMiMTg2KVer/6pixstP0dx1hGjYvD+opI4FRfo7maPmEkZYolFaP1kTS0V0/cpFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776720; c=relaxed/simple;
	bh=UJy7qWoScTjSsk5KG6oCEWuqZozMswGuhlRmmAeJh48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG11HJZoCMdoCMfg2P7sfCKl9wqfmhzBVVXe8lxy16fFZRR28/BiNhkxEZ4sLUWWMlc8/pQiqAfG/l/ceX7aa2I05Xz1na5xWz2oMyj6XGWLNp23foOzN4AdQ5WU/1CS7Eb28k11lXR//Dn8b1fqxa53jouLwDIkkOSHHum8kUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E00C2227A87; Mon, 15 Dec 2025 06:31:53 +0100 (CET)
Date: Mon, 15 Dec 2025 06:31:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: Re: [PATCH v2 1/1] zloop: ensure atomicity of state checks in
 zloop_queue_rq
Message-ID: <20251215053153.GA30599@lst.de>
References: <20251213134545.207014-3-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213134545.207014-3-yangyongpeng.storage@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Dec 13, 2025 at 09:45:46PM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> The state check of zlo->state in zloop_queue_rq() fails to guarantee
> atomicity. This patch changes zlo->state to an atomic_t type variable,
> avoiding the use of the zloop_ctl_mutex lock for protection.

Err, no.  atomic_t for states is rarely a good idea.  And unless I'm
missing something this state check is just an optimization, so a
data_race() should be enough.  Either way this should probably first
be done and discussed for the loop code that has a lot more reviewers
and then ported to zloop.

