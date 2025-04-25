Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B91BD9D0
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606226; cv=none; b=r+9Fw+jRwUNoXxKmQJSqF8vUPEG9pDvxWpMT59Pm8LdHY1ySnqQD0qQcRAugJFT9Rlc42MbHo6YXSatw1pqZS9lfuNkb951e+8pIr8PWEHg/sZ/W+qa9mbc1UZEwgvEz8/8iafDgKZJzyEWsnRNecQ/om4HaYU+yMzwq2noHvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606226; c=relaxed/simple;
	bh=02arKBHRgLaxeImMWklnxNu4OZw2AxkxhhOM//rxf68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbLx+2rZX2V1aVPcBVQKYd20dya6e+HVRtcpVik9z6yA4CLyi1arSIqP0Er9bs0XFgXai1/nUOgurMlr/7GFE0Xmzw3yOKstcDhiduuze8mA6mbxw6tZEPCKMHZ89LZCvosb3KcW+cV/N9nYa2a+m6QVj7eeyITgkRSojQbEkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7F0368BEB; Fri, 25 Apr 2025 20:37:00 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:37:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 16/20] block: move elv_register[unregister]_queue
 out of elevator_lock
Message-ID: <20250425183700.GB26393@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-17-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-17-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:21:39PM +0800, Ming Lei wrote:
> -static void elevator_exit(struct request_queue *q)
> +static void __elevator_exit(struct request_queue *q)

Why does elevator_exit grow a spurious __ prefix?

