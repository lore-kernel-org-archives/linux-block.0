Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09618EFCC
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886879; cv=none; b=Gvwcx7utb13iwS7R/T41S3fhyGhq08IC6VNR1e+mT+mZIAxf+oeBl+Z0vYDBGqH99kleaJwrwReLyNAVy9ttg81i53rq3OyscFkrTw/XPXZ0WuC6ctSR27J6//6zZ4ZTCgst4shj9ofXfjnrXbLd/oiSSlzwH6XhWofnrqnaaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886879; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKGZjb1UYAJSirmOANqKwW9TAxA+SN7Di1n3A6TQ9LwIKZnokp1zc4I2MqCkuvRwK5VhDqGFdIul7+qXlcD+FB1FkwvZgG2xcyIgPThGADYMV7M3mjvgGKCRnNIqq3XhY3Xfhd+pmce8rQrxNju+Jh2Es5Mj9595jyO4Xr8BtyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 38BA568BEB; Fri,  3 Jan 2025 07:41:27 +0100 (CET)
Date: Fri, 3 Jan 2025 07:41:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	yangerkun@huawei.com
Subject: Re: [PATCH v2] block: retry call probe after request_module in
 blk_request_module
Message-ID: <20250103064126.GA27788@lst.de>
References: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

