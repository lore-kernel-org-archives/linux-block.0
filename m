Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229B7468
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722991; cv=none; b=h++KfQAj4uqj7UQG7Sm6KNJ016nt0XxmUEXEzr+SdDvhGD0AxzbNC/TvfhiKntcHfogSsmJ2VRa97kORhVDJ5cWLtz/u1ZaLIEbL8yV6tdwdd6d1Dvrdjpm8c6T2D6y4uqXBqDHSfa30rtjMhh0IEosWR69gmQ59GbCM8sNSXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722991; c=relaxed/simple;
	bh=7uuo0XuVHcCspgDXsw6ckSTIl8/TaFHumaziJpDEsTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDWVCowf3BGrWp0cYTdpJHUQsrkSFIEiHvKDabuP29/6ZzH6eVHw28laGsV9sUe1bSDSZqLAThAbC+WCACINkFsnLKyRIC3fpIcS+mXvtYr32oY0sJBwxTV+ACEzc5njA1o26+HkE5du/ShkushDZx6H6yuN6Y0HK03+jY+AD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D4F8227A87; Mon, 12 Feb 2024 08:29:46 +0100 (CET)
Date: Mon, 12 Feb 2024 08:29:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue
 limits
Message-ID: <20240212072945.GA19939@lst.de>
References: <20240212064609.1327143-1-hch@lst.de> <20240212064609.1327143-5-hch@lst.de> <e1061d81-ca74-4b56-b87d-4f6660340093@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1061d81-ca74-4b56-b87d-4f6660340093@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 12, 2024 at 04:24:39PM +0900, Damien Le Moal wrote:
> 
> [...]
> 
> > +	/*
> > +	 * Random default for the maximum number of sectors.  Driver should not
> 
> s/sectors/segments ?

Yes.
