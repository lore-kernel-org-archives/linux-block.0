Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582603;
	b=dh4DPNKFjm+IlWtxesP3iPgOgAHp8cCx7MORK/VJZRwKVkwRw/7LKqP0bnTDvCiWySXN
	 lBPYsuSOwJSHqvH+k6yg9cgUwnKHzIo85tc4de3+KonXSM3e4smMYIKI748s3SZGHODH3
	 6iWyMwpaUp159eXPxe0wsadbD31/fWrXadiTH+xc2AhY3hl0vcxcy8L+jMJYYZJsVIhSJ
	 x0lkon5Zjl5IhEexh3KzUv5xCmd+M1gwl7D54MlcMZjnnBmJSfmTwI6h89bfgZk5BOJD3
	 PtS1Og6x7OQhETwDdsuyl9GczFSeQfIc4TzwZ4CbUPXIR29oUOeEE5723bIySW8lJ2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582603;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=LsMCEWdLMRQPN/Uiw0DDwLrJ0Si2ZeHPuwPiQTKgJJHhAppn1vjZ48ZYRNkeUAscA9Re
	 UPMFR6s0Cl7y1sAt1uyltbNMGBMYb82t4QZAASkzQgOk8ZlG0E+FyLztWv9V+pKV2SViA
	 IXwRYb+knm+wJ+d1aRTZFxPcAo7UhVQqgUxscDmRz8+rhgPiuxJIwEb2VWWVe0rcjaaHJ
	 4vrWGRKwMvUzTfWsJY9z8D3pgN41IGjKnA86csUcJCm48O/NzgJ8qW2PM+Dt1ny5YVJAC
	 06lrphfpc61AnrP9cjjyo2LmbCltRPuDSrsDXPq8R3qBQ0MAwMIa+38U+wQQn9quzRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A5606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 04:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4A5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3037D68AFE; Wed, 25 Nov 2026 05:56:39 +0100 (CET)
Date: Wed, 25 Nov 2026 05:56:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] blktrace: fix ftrace record generation for v2 format
Message-ID: <20261125045639.GC19878@lst.de>
References: <20261124124239.146858-1-johannes.thumshirn@wdc.com>
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
In-Reply-To: <20261124124239.146858-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

