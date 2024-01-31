Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129154F87
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685373; cv=none; b=pf/I2sJeRsWUDKercV1b8TrllkG+2rbquB3rtlIKscPEFqeJPPeCDYHSjUWSMSxeHlF06neg5EiLFxYSlnv486E/XuM18obkC4NyCmA078U+YUEDT6WLyPBdVrDcJPr8qYNIgOhf1tPj4W7CaUJzpDLKDScPWAziMdYHVj4rKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685373; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvT23ArnHFUqAZPitxpj4v6WgawJdZ66+bYCuhyZhENTLCBIvTNLacO/Z8zssCKWCre1DV1QEI0c/TjcDVDiBMIRYsJ9e8Y2kxmELbcJJQ4kTRIZsjpKlq065Sc1lrTvmFE/X4f+h8iNMolO781dBHsfUNu+ZlL2277Q04DGQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A40C68C4E; Wed, 31 Jan 2024 08:16:08 +0100 (CET)
Date: Wed, 31 Jan 2024 08:16:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 1/3] block: refactor guard helpers
Message-ID: <20240131071607.GA17498@lst.de>
References: <20240130171206.4845-1-joshi.k@samsung.com> <CGME20240130171923epcas5p4610296779861b362ef98f3b6f819a060@epcas5p4.samsung.com> <20240130171206.4845-2-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130171206.4845-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
