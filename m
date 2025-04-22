Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6ED1E5716
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307419; cv=none; b=Qb8+fCD+ZZnUms6NKS9Y9HpcLZzMt3rIrxrONj5Um0DZFUHpHnyiBdVlwOJKFhcx5qox9PXChqeAH7UP7EqkBeR+Bw2TdKMnDtbFTY/rBcXim/7swPQEkods5xNNPaacEDls7p1GDm0JX0V7qLnuUFV1KHFg/RUdkdvRotf2RRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307419; c=relaxed/simple;
	bh=iNihTPx0YQ94AQJ814kSF6wonckzKRuRjqkzps1QNFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btWw0cs4R7bBhayboLTRSR+StonxJFeojqqBIZAsqCTmIItSitEILYxYku9lxwjpWSeBTk+hqcBJM3oL9dT3xowE34QtW5k2FYMV7GK30JSHilAl7v8v5arpor2xi+uWzD0bFH/ksXGXFCSKINLx6Gq40BqB7HiINNo3Zl8gYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2CD9268AA6; Tue, 22 Apr 2025 09:36:54 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:36:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, hare@suse.de,
	sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
Message-ID: <20250422073654.GB31849@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-3-nilay@linux.ibm.com> <20250407144555.GB12216@lst.de> <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com> <20250409104515.GB5359@lst.de> <e50e568c-9a9b-4306-a2f4-e108791e83d2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e50e568c-9a9b-4306-a2f4-e108791e83d2@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 18, 2025 at 07:52:06PM +0530, Nilay Shroff wrote:
> I don't know how to make this option per-controller as you know the 
> head node, typically, refers to namespace paths and each path then 
> refers to different controller. So if we were to make this option
> per controller then how could we handle it in case one controller has
> this option set but then the another controller doesn't set this 
> option. It could be confusing. 
>  
> How about module option "nvme_core.multipath_head_always"? The default is
> set to false. So now it becomes two step process:
> 1. modprobe nvme_core multipath_head_always=Y && modprobe nvme
> 2. echo "<val>" > /sys/block/nvme0XnY/delayed_shutdown_sec     

That's probably the best we can do.

