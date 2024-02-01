Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C7C157E80
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771052; cv=none; b=WdpDQippqS51K5cksZ/f8bVahn35Aa92mXqkWFx3mIM4yCcpam0qJKJxW/MpN+gNotwQl3X8fwrdyGuolsEeImbGwlFyeqZS9DoOSSAB5hnbmbxKdSMF4KAZN4A6381lwvru9L86ufXuIl3DMuEBXQ9U5jkA73EgfUwBwIJn+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771052; c=relaxed/simple;
	bh=NReHrCxnEObsR8kjXt1VLycYyw5s1+VRYfIlVlsRyt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbDXOnvZNztpjXRsVpRPzSP7NQYb1K1x96a1cvwVyHOmJMZ05nKhcIUorKKq3OSX7oxQvpnAQYPH9CkN/JSM9fHBi/dVmPdFTsgcB6hh2jl2tWLVjWmtqaa/ghRb3J8wUDXQEPbolEHUq4yjoSU2AKNY/YcReb27sHvHtgj/3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E0C168AFE; Thu,  1 Feb 2024 08:04:03 +0100 (CET)
Date: Thu, 1 Feb 2024 08:04:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
Message-ID: <20240201070402.GA17262@lst.de>
References: <20240131130400.625836-1-hch@lst.de> <yq1o7d1qeax.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o7d1qeax.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 31, 2024 at 06:26:49PM -0500, Martin K. Petersen wrote:
> Looks nice in general and avoids the annoyances I had with my discovery
> series wrt. discard. I'm in the process of rebasing that series to fit
> on top of your changes and things get cleaned up nicely. We'll probably
> have to coordinate the sd changes a bit.

FYI, I haven't really started on SCSI for a bit of protoyping, and it
will take a while to get to it.

