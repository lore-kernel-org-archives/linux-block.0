Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1015D5B3;
	Tue,  2 Jul 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935426; cv=none; b=JHEADEAcGyUgXMwQi30f+4jJiKHEygfAzKnrU71ikKBM7DZH4tcF/OYVQURTiyGpvtYeCXziZVUPN/FcRZsTYUUtZoYaHz5D3pn0XJYbKURWXb+/BxA0fhAz3qOlJTJTV3G+XFASciHA8482YcGHB0/T1ZS6zJEg2uwE37H5bGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935426; c=relaxed/simple;
	bh=E6hdHuxMh6fsOTHnFHY4x/3TGR9k9iUx9/lV9US18w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9YJAUHT3UZG1SErguN0KPtjBbPqOJLPj7vYCQ1cqkCMsqJ8J86wGYVlzWTiM8mgsqAomdKtzDTJa1WINGBkdUEyelkAi+zu91oz8rpgcJxPBDsnrsuYlJ1r9HGvftDZiwAkth/Ar0c4ZSWZ1ON0H+Gl8yg4n2cu2Lke3YIaTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 10E0568AA6; Tue,  2 Jul 2024 17:50:21 +0200 (CEST)
Date: Tue, 2 Jul 2024 17:50:20 +0200
From: "hch@lst.de" <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240702155020.GB1037@lst.de>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com> <202406281350.b7298127-oliver.sang@intel.com> <IA1PR10MB7240DE46976A3B027DE5484998D22@IA1PR10MB7240.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR10MB7240DE46976A3B027DE5484998D22@IA1PR10MB7240.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Gulam,

On Sun, Jun 30, 2024 at 10:11:14PM +0000, Gulam Mohamed wrote:
> With our latest version of the patch V6, the "kernel robot test" failed
> in the ioctl_loop06 test (LTP tests) as in below mail.
> the reason for the failure is, the deferring of the "detach" loop
> device to release function. The test opens the loop device, sends
> LOOP_SET_BLOCK_SIZE and LOOP_CONFIGURE commands and in between that,
> it will also detach the loop device. At the end of the test, while
> cleanup, it will close the loop device. As we deferred the detach to
> last close, the detach will be at the end only but before that we are
> setting the lo_state to Lo_rundown. This setting of Lo_rundown we are
> doing in the beginning because, there was another LTP test case failed
> earlier due to the same reason.
> 
> So, when the LOOP_CONFIGURE was sent, the loop device was still in
> Lo_rundown state (Lo_unbound will be set after detach in
> __loop_clr_fd()) due to which kernel returned the EBUSY error causing
> the test to fail.

Before we'd end up in Lo_unbound toward the end of __loop_clr_fd
if there was a single opener. 

> I have noticed that a good number of test cases are having a behaviour
> that it will send different loop commands and in between the detach
> command also, with only a single open. And close happens at the end.
> Due to this, I think a couple  of test cases needs to be modified.
> 
> Now, as per my understanding, we have two options here:
> 
> 1. Continue with this kernel patch and modify few test cases to
> accommodate this new kernel behaviour

That would be my preference.  Any code that is doing a clear_fd
and then tries to configure it again is prone to races vs other
openers.  It also does not seem very useful outside of test code.
But if we end up breaking real code and not test cases we might have
to go and bring it back.

