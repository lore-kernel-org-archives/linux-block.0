Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8878286;
	Wed, 19 Jun 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785644; cv=none; b=o9clX2b+syZx2ccNYOQrkXZBn5GIkL4QI26Xwi4HWdkweqVyQ109MOhYJYLR2DjMWZbfd9Wb/AqWo+gT09ju5K5pkLROlHSyI5EAieyGvTi/ZkiLxGn1oqYz2XekT0POH7OTU9fzYQGTrznLaV6C9tQrFF9Sx8wS3f3BS4P/ykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785644; c=relaxed/simple;
	bh=HcKnbgCi4hLpOl0YpLIpOvB7FlpujelaZwgYAxrNWKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsvBTKDxM7QlbrMRdKpuDS4MKFldky4vxgQOL8jZkB2tYgPYHTCtBZ6484xNXNRhMzZq2yAklXPoPge9PcId+YSdKJybbWcXOk0Mqaow0sghzkP9QpU5gnpPo+HOwn6DB2Rbn2jWgv8l/FHoElp9h+PEdj3mm38ri7H4KKCv4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA1B468AFE; Wed, 19 Jun 2024 10:27:18 +0200 (CEST)
Date: Wed, 19 Jun 2024 10:27:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240619082718.GA6210@lst.de>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com> <20240619081601.GA5434@lst.de> <IA1PR10MB7240896628D86A86E91DE9E798CF2@IA1PR10MB7240.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR10MB7240896628D86A86E91DE9E798CF2@IA1PR10MB7240.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 19, 2024 at 08:21:35AM +0000, Gulam Mohamed wrote:
> > To: Gulam Mohamed <gulam.mohamed@oracle.com>
> > Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> > yukuai1@huaweicloud.com; hch@lst.de; axboe@kernel.dk
> > Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
> > and loop open
> > 
> > Do we need the re-addition of the open method to fix the ltp test case?  I
> > kinda hate it, but if that is what it takes:
> > 
> I don't think its needed but I kept it because your following comment in the suggested change says " switch the state to roundown here to prevent new openers from coming in":

Let's keep it.  I meant to say new I/O coming in, but letting a new
opener come in and then fail I/O isn't really nice behavior.

