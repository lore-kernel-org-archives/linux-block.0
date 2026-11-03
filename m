Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683839;
	b=RuwJdIIavaoWwQJqcC0VrTZ/f4yxk7sZ5ZugPzHeqk5y8TyFOpQUoSwr3AHZeC4c8oFJ
	 kKpNnF5hyKAM78N/GuWKaz6HOTGLSUYMAf5kOuiPUs/leW15wC9UhpROHMGoQJITUb0WA
	 CNNTyvPudAYuCrCYhvXIiZm2u1CD1W5zqydNLByX0ITN4acvpqw3FkkMgxPqzFWlhTiZT
	 7MoX5iM+gEiNsKeptqfyZYFeWvnxfGXfrN3vgGCp5KlBO7GGy8P26yZcJpszeZv6VGWP7
	 U641aWdyOtSzwZeR9yade7SvbN+NDuyn1NHmm28zdaKc4RnpUA7XCF80JIG63MfP90A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683839;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=yJ0BhqeGlc1ecjs8z3wv/fI3uZcYkJ+hJvjYnwqc0Nuha20z/6FjpI59TosBBpBR/Ba2
	 xOUBu5NQj5rpsoIIYx5i4dUCdI6AbRC/TJu2He9zUJfTfPH7gqyglMFMMBaNWOT45gw6/
	 nGaVY2XyBgo3OY4sLysbCoCcK8YE/KhIvIWuJD5sz1Oekx/Onq9Un4AYCZkKZh0Uie+2G
	 1MdMf9T1kI76wwH784/m9xmlKRucekNcXeF0TqaVYQov2haQPy0UT30mUXkn2UKICSV9i
	 ZRmOkdfZ092uHI3zSojdbP9AIEGDmD3lhOL4gGUd5dC/8qisU58nN2Y9CSetvytMInA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383B606A324;
	Tue,  3 Nov 2026 05:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F383B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACC9368AFE; Tue,  3 Nov 2026 06:30:27 +0100 (CET)
Date: Tue, 3 Nov 2026 06:30:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zloop: reject mismatched conventional zone files on
 restore
Message-ID: <20261103053027.GA1184@lst.de>
References: <20261031221610676B5VoVcwMgkoDNVZH2bVDO@zte.com.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031221610676B5VoVcwMgkoDNVZH2bVDO@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

