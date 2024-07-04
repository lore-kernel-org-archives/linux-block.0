Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6351A01B5
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077841; cv=none; b=X69XoSN3BYpbP/mPx5R1+dJzG+0xsK4gjNRGpH1vnllZ6OngVqag0aZIGwbKfZ1OPdNBx6UxKTs2/jTgOWbWPNcUYCYl1RQlCuFBGc3Mop06wCB9zaOdCwVaC+IUnjIyRbC9WIAxBBz0FCJE5SyUayJ5wbHXLknw7jNHb908nE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077841; c=relaxed/simple;
	bh=q5brJWdFUSLflTzWeXPlJ4o6vhGX2whHtYQ2a3GuaVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3QRpiU9+hIu3I35or+dXreq2bFT2wh+hBXw+YC2BTyBn0KSHwiC0K47szpDHN7dSGR8dVvNncj8a/ClZdS9blu2495UKXv+lK3D9T35vIuTzA19uskC3unEwTzbuvICIKewu1DhhHFMf8+qC21gyiUBXgC+y/Bv1tytaaabxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8214D68AA6; Thu,  4 Jul 2024 09:23:55 +0200 (CEST)
Date: Thu, 4 Jul 2024 09:23:55 +0200
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/6] block: don't call bio_uninit from bio_endio
Message-ID: <20240704072355.GA25826@lst.de>
References: <20240702151047.1746127-1-hch@lst.de> <20240702151047.1746127-4-hch@lst.de> <58763b5f-712d-4c42-b5f4-4064e99a4e40@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58763b5f-712d-4c42-b5f4-4064e99a4e40@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 03, 2024 at 09:50:08AM +0000, Johannes Thumshirn wrote:
> Can we have sth. like this on top to avoid the duplication?:

I hope I can just get rid of it over the next merge window or two.
Right now the only two offenders I've found are bcache and bcachefs,
so it might not be that much work.

