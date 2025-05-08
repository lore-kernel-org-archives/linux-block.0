Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346F24166F
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713077; cv=none; b=AYg0vJDD+3qQQ/w8dqbhBDaWOdby2RUd3lzXBc+RB3d+BJd2QwK8bAamW2iay6Nb5k2p42mLWsUAr9WODMtRbmF1C7qAGpdxbrQpnUHa8qu3FSVfITgg1qX2/+VL4p1pg/PKDvJZjvwXleM1H9XpbHkbN+jCnNeJ4rTP5u2gJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713077; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGa2UvH3F8nUvVfwEfRzPK8IKadsdUre57YQL2QSPI0lj/j8gdpdwBCZ8qf4yEJh5iJO1q0ln/r1BPTnaEvKmgic6NKm4smo7x0CNsSXOUROUVWttzVag2RSCUsAUN2nwX6ERVu6QucOnheT8y1/lfUqLVDMoTrMubaxSTsDDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8318E68BEB; Thu,  8 May 2025 16:04:31 +0200 (CEST)
Date: Thu, 8 May 2025 16:04:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] block: move removing elevator after deleting
 disk->queue_kobj
Message-ID: <20250508140430.GB31804@lst.de>
References: <20250508085807.3175112-1-ming.lei@redhat.com> <20250508085807.3175112-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508085807.3175112-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

