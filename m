Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAEE157E94
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771434; cv=none; b=IkY9D461k2RFCGp8t2/fzUkoDAimcfuxK6q4JJixcPmtRsjPx16dwq/gGAuBNI+RipRUulA+b8nSECiEcM+c3+T3VWTWabAJrfTAWQy+GKhMF2DhrHVwZngjfZnZ9ZxxVuBKWJ37bGFfU6ogFqOgyiDCV1Pz7jVY0h+8wMXI7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771434; c=relaxed/simple;
	bh=7ThMcqxMWMFAzFSiypcx8eQwh6KrhQ8ur72LvKcKoHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyE+6GKuE0jzAJUt44W17nUbtDcZ6OrH6KFwOraGh6t2BN1iBpHdfy/15S5wu6b2b1SxCUMV3Iv5FHdRPXSxfZaKzda6RAzE8Px+kXRcDhjwS0gTsCT1kK4sTwf1mgfke+C+in/+YthQxaG5ECEuJh2HuAg/O2Ef1kHwe/2dG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC02968AFE; Thu,  1 Feb 2024 08:10:27 +0100 (CET)
Date: Thu, 1 Feb 2024 08:10:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
Message-ID: <20240201071027.GA17571@lst.de>
References: <20240131130400.625836-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131130400.625836-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

I don't want to spam the list with a full resend again, but I've
updated the branch here:

   git://git.infradead.org/users/hch/block.git blk-limits-base

   http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/blk-limits-base

with the bisection hazard found by Keith and the various review tags.
