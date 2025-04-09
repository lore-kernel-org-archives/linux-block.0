Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F3253F1F
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195522; cv=none; b=O1bCvqULGBnvNbEyZIRIDKjxkhCIzZxH3VgXzBwwDx7DIj0f55Ln4fza9Dg7ZQcRP4yJBTbkUXCiqeYtLkYz3Mjtr8+mzGFDJZvpnDag+8FfJt9avIvvNzddaAFSRSJARlqAScGzKhq+ID8cvl5otgtLVw+YMXJRSlctzTXI0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195522; c=relaxed/simple;
	bh=nzlseSK/ibV4lYU3AaA19AxSCGqpWV1eYJCQeFuP2sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMEEUmSVpN3HwAYvWJHxi1JilzMKEDZTzA2XazM3+iGw6Q0LoZQGdIMU2WBMqUrz77rxjwDSrIhiaibIWlCBtkaH6mePWX2cmjnIcQzAvMHYs4bo7I6M77mF1O+bNmRzRjEeK+TL3CN+Q2ut3oKQw7UlwNhcHiu9YwfbXIiOlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73F6B68AA6; Wed,  9 Apr 2025 12:45:15 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:45:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, hare@suse.de,
	sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
Message-ID: <20250409104515.GB5359@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-3-nilay@linux.ibm.com> <20250407144555.GB12216@lst.de> <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 08, 2025 at 08:05:20PM +0530, Nilay Shroff wrote:
> Okay, we can add an option to avoid making this behavior "the default".
> So do you recommend adding a module option for opting in this behavior 
> change or something else?

I guess a module option as default makes sense.  I'd still love to figure
out a way to have per-controller options of some kind as e.g. this
option make very little sense for thunderbolt-attached external devices.

But unfortunately I'm a bit lost what a good interface for that would be.

