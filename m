Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233992253EF
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506575; cv=none; b=B5bYsxV2nEt9m5SeM1cWYgZpd+93w2j3ObUUlr+yoQ7uc/ksuM5eADlLD4lEnDm5I6Twr7L5PIooCUDKRY8tB3s8qRH47YXTyMN/DaGTiKjQWkDBkDopHqMiwftdZ+utzQ9LTZM7eF+s89R41hCxYL5L23gcYJXWHpqLM3LiwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506575; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdaOh9CDbme8dUMRhTVTjwB2TJIvMhhMWqU89HJh7JuWFoK8qpoLoHWcCg1n6V4i/8vAoDcfp46eclpZYZuPlBMHBxnImo93oCqb4Ttpu+gptnIcLPbSwBMJIjmL/07dvdetZac0YchWjArA/t8QecJRgONe7VotWqdWMVqLIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9851067373; Tue,  6 May 2025 06:42:50 +0200 (CEST)
Date: Tue, 6 May 2025 06:42:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 15/25] block: add `struct elv_change_ctx` for
 unifying elevator change
Message-ID: <20250506044250.GE27061@lst.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com> <20250505141805.2751237-16-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505141805.2751237-16-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

