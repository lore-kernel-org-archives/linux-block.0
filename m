Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5118DF65
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770818; cv=none; b=ToG+eSuKeEfIKfEgbLO4sa79Xltv9WSI59mI4dBcK/85A5xcJZgwnS7DWoS4m1fJ6hxMBUT0WfXuh7fijQgnhdLaaxoZrYJbSi53OQrKIHD+8x33Df+QD1kAA8z+WnRenPyqXRubUFxUPfDEdk4LAWT+euOibZtVSv0a6FKS5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770818; c=relaxed/simple;
	bh=W1FdautvrDaArBZJxLReAXjdUYHglvfEc3eieP3ISR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm86e9o3pyTB9UD6LVoRsBEzebLfhsGNHTJhL2OvluDZf+Q6fdztO2PmEjSTpKP8zgUmdjyPYKBAEkKTbMRDroszRU+U2E4xT/ENJTfMIYekqGiiNEqtq9sq+bpnT0qJtRNi1ZpfaKrx4B6Dh648n1AVeaO/jFMQdz8uIzQvKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3FD468BFE; Wed,  5 Feb 2025 16:53:30 +0100 (CET)
Date: Wed, 5 Feb 2025 16:53:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCH 2/2] block: avoid acquiring q->sysfs_lock while
 accessing sysfs attributes
Message-ID: <20250205155330.GA14133@lst.de>
References: <20250205144506.663819-1-nilay@linux.ibm.com> <20250205144506.663819-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205144506.663819-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 05, 2025 at 08:14:48PM +0530, Nilay Shroff wrote:
> The sysfs attributes are already protected with sysfs/kernfs internal
> locking. So acquiring q->sysfs_lock is not needed while accessing sysfs
> attribute files. So this change helps avoid holding q->sysfs_lock while
> accessing sysfs attribute files.

the sysfs/kernfs locking only protects against other accesses using
sysfs.  But that's not really the most interesting part here.  We
also want to make sure nothing changes underneath in a way that
could cause crashes (and maybe even torn information).

We'll really need to audit what is accessed in each method and figure
out what protects it.  Chances are that sysfs_lock provides that
protection in some case right now, and chances are also very high
that a lot of this is pretty broken.

