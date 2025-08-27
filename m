Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E98319842
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280322; cv=none; b=Da+SZF6BtvnGh8VOTkHFI3fPQNAzLF7ZChi8XEHeQxCXAaPsTvHRoYXs7ZLVggIEsZLon7TdVL3MQVBTiSyR/NZKheozD1u4elZA+vEu6Cn0XiqZhTeT4+WLhGeMssW7KyqIGeQU8qzlv+F8GrcY7fXi7w5DH8ySDrXBTd2rLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280322; c=relaxed/simple;
	bh=aUCy5SLtyql1aubfpup1J2WRXVd9fIcOm4Fq88lBTTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOt+p+vpKHaGOYO3NkcyUsuR+KV0D8EukT1DcR/hqc9P09FPRF8xDxdUfNjG4A22MEPwGcc40glUsc5gZOg9jvTJoajtHOIMgHo2HBBwY4vjqIUb/SSDVZug5Xfa98X4JKMjC5/mxQYJM2ckY0GDiGvtJnxcsdu9TYmswcmVwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD8A868AA6; Wed, 27 Aug 2025 09:38:36 +0200 (CEST)
Date: Wed, 27 Aug 2025 09:38:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <20250827073836.GA25169@lst.de>
References: <20250618060045.37593-1-dlemoal@kernel.org> <175078375641.82625.9467584315092336312.b4-ty@kernel.dk> <20250827070705.4iWhHGPE@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827070705.4iWhHGPE@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 27, 2025 at 09:07:05AM +0200, Sebastian Andrzej Siewior wrote:
> 
> I have here a PowerEdge R6525 which exposes a "DELLBOSS VD" device with
> firmware MV.R00-0. I updated firmware left and right of the components I
> could find but started with this commit I get:

...

> Did I forget to update firmware somewhere or is this "normal" and this
> device requires a quirk?

Looks like it needs a quirk.  Note that if the above commit triggered
this for you, you could also reproduce it before by say doing a large
direct I/O read.

