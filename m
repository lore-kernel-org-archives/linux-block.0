Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC02F39C1
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809504; cv=none; b=bTMWkEzka0GAveLcOUmPk6ufWxIDnY3+FAs8ngC+FVgKs0gWSIYwXnIMyqFnCIGQmV8YOJAWwmUtirfezlZiCyVFlX0Y+61FaMtu/rNKMbp2FN2fPTUu1eXr7n91Ve9rn+0CrehI7OIA8RXQw54UHIjmrJNlge3en5uaPUNLyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809504; c=relaxed/simple;
	bh=rdsqrm2AlVX9MVKLtAdw/TswyHD5Y5Zi9ibkoFtfPYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk8Tyvlvs0clSQTpJV0x0HiJ7FfoEGOuOwYj2cOnmSH5SOeeM4MQUkfS4UgtukCPudY4UegFgNbQuaPRj1uR19qI4f+25a+5PaSbF3x/4uEuw3/zz22KUO6QDQEIQE9K/b1+UzHKRXEzLU1iZw8KDfuYjatOsC/CKu18i1IALN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6844227A88; Mon, 15 Dec 2025 15:38:15 +0100 (CET)
Date: Mon, 15 Dec 2025 15:38:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: Re: [PATCH v3 1/2] loop: use READ_ONCE() to read lo->lo_state
 without locking
Message-ID: <20251215143815.GA30633@lst.de>
References: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 15, 2025 at 05:45:22PM +0800, Yongpeng Yang wrote:
>  	idr_for_each_entry(&loop_index_idr, lo, id) {
>  		/* Hitting a race results in creating a new loop device which is harmless. */
> -		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
> +		if (lo->idr_visible && data_race(READ_ONCE(lo->lo_state)) == Lo_unbound)

Please avoid the overly long line here (and maybe fix the one above).

