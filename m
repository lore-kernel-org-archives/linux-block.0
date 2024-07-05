Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71E6A039;
	Fri,  5 Jul 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183127; cv=none; b=NLB3H5O0MfEm1zbdeSa5X/xVZMk77m59ve4qDNnQKWxNtM3R1OpxBUH9UUajKeHYjdWFFYgOY5gf1bIsPvOzLG+oV/yCKcakM8GumFg2GzYcDvBgqlz7sGgkhcwbx5Mw1cjLubMbn4JbCOt1dBj5W6p1VGELOnYMAnpt8/LXmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183127; c=relaxed/simple;
	bh=fJWmofLgLjlJ9zvIj88KU79hilYpcd4wf59y6F0DPHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azg4FgUwXCrijpk6xZVeUmxBd06mShTAlL+Ic99cIEPOUA8HHHoRfhSpJh3vzJwhEFtHr/VN+X5gIHAH86VHv02R4CpeHDR+CXWo28PEh3z+weglgFcGZR25wOh1oDXYTgcTycqNVSvkrwpY/8yenK4lKvxk2Gt4NVee11wjVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C2EF68B05; Fri,  5 Jul 2024 14:38:42 +0200 (CEST)
Date: Fri, 5 Jul 2024 14:38:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	hare@suse.de, kbusch@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 2/5] block: Validate logical block size in
 blk_validate_limits()
Message-ID: <20240705123842.GA29995@lst.de>
References: <20240705115127.3417539-1-john.g.garry@oracle.com> <20240705115127.3417539-3-john.g.garry@oracle.com> <20240705121600.GB29559@lst.de> <d4f02398-977f-47ef-9868-d3b08313c126@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f02398-977f-47ef-9868-d3b08313c126@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 05, 2024 at 01:34:37PM +0100, John Garry wrote:
>> This should print a message.  Unfortunately we don't have the device
>> name here (for that we'd need to set it at disk/queue allocation time,
>> which will require a bit of work), but even without that it will be
>> very useful.
>
> Ok, I can print a message, like:
>
> 	pr_warn("Invalid logical block size (%d)\n", bsize);
>
> I am wary though that userspace could trigger this message from the various 
> ioctls to set the bsize.

As anything ending up here is a configuration interface, such a message
should be perfectly fine.
