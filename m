Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C05579C
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948744; cv=none; b=CTgxybP8+TLnANVHugd+auC9gKIeBIHCn4McZARU9/9/CCNObZGxwx9OW0sPV67UcWT8IfyFDszFmjLmA8new+0Wy9el5V4qvnaUTXMMqXzPgrBeR8JcgQBq9jrBRWpNxm7HwqQrZT5yc9AvHSFsp75gkgvVYfIUew00GukYt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948744; c=relaxed/simple;
	bh=i/YDlbcyzr4Rzg3JKSSHWy5C1G7kD5upXX0RihVPkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsbTp8/qlePOTSypMsKvAadu/CML6bf1KU390N58Io0AWZheDbHA60xNZXx22cP3y0oZ2eY+eFQ+eAG2/dT7XpgMNOq6q3jwQny2Lw1qNC89HyNq0lUvHcFlsLkcQn+dF1TCYPhDtcJwlsF0w01qxRp3UqUG4RxbK8UIpj0UdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3F4F68BEB; Mon, 22 Jan 2024 19:38:57 +0100 (CET)
Date: Mon, 22 Jan 2024 19:38:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
Message-ID: <20240122183857.GA7029@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-6-hch@lst.de> <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 22, 2024 at 11:27:15AM -0700, Keith Busch wrote:
> > +	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> > +	q->limits.max_discard_sectors =
> > +		min_not_zero(q->limits.max_hw_discard_sectors,
> > +			     q->limits.max_user_discard_sectors);
> 
> Shouldn't writing 0 disable discards?

I mirror the max_user_sectors behavior here, where 0 disables the
user limiting.  But yes, that would be a behavior change.
