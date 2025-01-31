Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5285260;
	Fri, 31 Jan 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738313649; cv=none; b=ZYx3lym58+XhiUt8RGv54MUqbB4taOjWCY4smjef9T2yFz68Ab+Dzd5xofk9LsAn5efMIOK7ZIkMulAF1ZxtHKU0z2KCGBSPnPrwkLGgv0exy65eRPMgYC+3WWbrJSPrTk3mxuwLFwT8NxsOvFrNeloFoiSS3tgrhFZyWKa/C8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738313649; c=relaxed/simple;
	bh=QqG4CxDWBvBBn3RpBg4y57WRbrobiMNRXA59zwyxECA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhLu/uInze7FkVpQ3AWemrLBXiPeqeviLu94CFM5dcKPTDGFiGkQk6K7kmrFsHUPtCZvfpA1DSV3w6dG95YXbYFA5g3Q8e5nJxR6Gi8JgO4e5mltfX5UoGJsnNh5upggjniV8Q0/BMaXnlhoP9A6CybaM1GQQL479cP+D0Tgpnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C83E568B05; Fri, 31 Jan 2025 09:54:01 +0100 (CET)
Date: Fri, 31 Jan 2025 09:54:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-mq: fix wait condition for tagset wait
 completed check
Message-ID: <20250131085401.GA17935@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org> <b53dad99-6a8e-402e-9330-597289ecd8fd@grimberg.me> <04ca03dd-d240-458a-a049-8cf0ea7f9dcc@flourine.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ca03dd-d240-458a-a049-8cf0ea7f9dcc@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 31, 2025 at 09:46:46AM +0100, Daniel Wagner wrote:
> The problem I am running into with my wip tp4129 patchset is that
> requests are pending an newly introduce requeue_list queue and never get
> canceled because these requests stay in the COMPLETE state at the
> moment. This blocked the shutdown path.

I'd recomend to not bother impemebting 4129 as it's a fucked up mess.

