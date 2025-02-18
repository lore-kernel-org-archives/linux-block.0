Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0D22DFE5
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868389; cv=none; b=l5w2ED3oVVHjR23OtdrBdsFn1eYjwfP1xHaaPCJ0R0LP65/ioDik/iverMMC4t+qrnW6qaEn9u8PSTVHov6HqnapVacMoP3Lsfc7D2aJvSwZaIadKzG0+wC0C/LMNIb8EhNQsaTtyXMQEMXYuQ9HZNIXMj1y0QkK87vYhIfQ638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868389; c=relaxed/simple;
	bh=ZahU/w/Gaw+6w5FztYiDAS7FtVrTwrnltAERQYKEngY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCz3T+QnUF16AOKjoTffDs8wlDyrak3pnLooXbngYFrVp7TDnBYcXQG3oiPG88RsdKP+/BnxxXI2qD76PHtKW93/iXk6n0QPfF2XlFCNx4nNFY2dVhLGTOquNRHYk7hJK0XiadA9NGzfpzz16KknbRsMz1TQRgmNTIu2F173Eww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CE4C68C7B; Tue, 18 Feb 2025 09:46:22 +0100 (CET)
Date: Tue, 18 Feb 2025 09:46:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <20250218084622.GA11405@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com> <20250218082908.265283-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218082908.265283-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
> There're few sysfs attributes in block layer which don't really need
> acquiring q->sysfs_lock while accessing it. The reason being, writing
> a value to such attributes are either atomic or could be easily
> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
> are inherently protected with sysfs/kernfs internal locking.
> 
> So this change help segregate all existing sysfs attributes for which 
> we could avoid acquiring q->sysfs_lock. We group all such attributes,
> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store 
> method (show_nolock/store_nolock) is assigned to attributes using these 
> new macros. The show_nolock/store_nolock run without holding q->sysfs_
> lock.

Can you add the analys why they don't need sysfs_lock to this commit
message please?

With that:

Reviewed-by: Christoph Hellwig <hch@lst.de>

