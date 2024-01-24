Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F50171AF
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087105; cv=none; b=TTpTbged9iODC0c+JBNS+IYy6+Ee0MjATIbENkf4/W/LDNSLBIVxr+sz9CxhJEohvT9d0Oej7RFRwwOvThlD4dUkXr6K5Q5Dl1UUrAiyhQoPj+7B2s8Ru1U9ngEPuMfpnAF0iJ8Dcn2yIwsVlozGG9i/veKO74G6cTzGu4Ku7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087105; c=relaxed/simple;
	bh=7WPJveupLnAU6anzfENDpNC7fpYQBs5pLVwh/HyeeS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvTJw978j1AlmDcFHbKIXxzwcP8LNO2w4QeIrEwwnrzO2wSB6a0hBzY/EPMGOhyTqVqCjlvnq5WCcdJvkPmo/bMNlN2GzAwL3lloZzHOstYDRtvpRjeQlDuyq5FQS5/l8Zwdpw5yXJfyC6MN481z/mvZWT8Sr6KiXyYucfeHBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2CA7F68BFE; Wed, 24 Jan 2024 10:04:54 +0100 (CET)
Date: Wed, 24 Jan 2024 10:04:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <20240124090453.GB27760@lst.de>
References: <20240116232728.3392996-1-alan.adamson@oracle.com> <20240118072419.GA21315@lst.de> <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com> <20240123090506.GA31535@lst.de> <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 23, 2024 at 09:25:51AM -0800, alan.adamson@oracle.com wrote:
> I get it, but there is already an injection framework in place for nvme. Is 
> there no plan to improve it?

Injecting fake I/O error really isn't the driver job.  For block
I/O we could do it the block layer or DM, but that's not something
to add to random drivers.  Error injection makes sense for testing
the driver itself, not applications.
