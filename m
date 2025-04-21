Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29227B666
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239013; cv=none; b=r7QLlwOfUEZWisIY6USVQsebuWIKQiL/Sde56Ib+1KWcmR8GHQX/6IaJSs3W46kFkISqHfxJuz8QWUJYDqehsprUS6K3g5i9y0+XAvr/6JORN9jmr4N9dY+wjgh2JVOB6Gj0jOOq4/rmY5uSQ+U42CEjEklZUaRyb7Lueuf3xC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239013; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izaxqGXVWzFVf1GKrFxET43nAeXaPQpNmgnVme4VsUglEzDz4FqiG8LOPhK0zMz/L/vIyH/WajZR35tHCcdkZVvOXzsO+P3tC2N5ZD+OEcCLEpDUr//NO+Pei/pDt4s0+88MQAo+HgqDlXrxdz9fb4fPAZhDXZpvBMCSlPSACvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6695368BEB; Mon, 21 Apr 2025 14:36:46 +0200 (CEST)
Date: Mon, 21 Apr 2025 14:36:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 04/20] block: add two helpers for
 registering/un-registering sched debugfs
Message-ID: <20250421123646.GD24038@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-5-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418163708.442085-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

