Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278646;
	b=LvQ48Xbda5ilaMl8viaAJSNpDi3fWYYx5rakqG4jEVvqtHPlc6zg9i7rSRXNZ0C4yoEe
	 rfGwHXzg2HVfoXx5AXPdCZyzMMxmrM17+U5J/2kmQKlOZiayyzfQ5E/f1B+8SU6DRFv7w
	 CNL+oSkCiGW4HL7xbALyO25ururiK9CyNz5/qoc0u/mydxIrNEA77gaRb/VVwLDC67G3q
	 T3Drgck44zD91cxG1bA0RLixGoNJiV4xlGz4ZC1Ie+0YU1BQ71k66TuRwjeDp5w1mgALh
	 n/AOLYFdNfDyM5B2RSHYrAhwCYd3fckg3T4dG5AYROVjfNup1Aqo32EFyttdfhEjZrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278646;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=Vg/nF/0aHeGYFK66oyOFr5fcKjfOvKLkGk7jrBZreYsldUh/LetbLD159Z1Zwci6wpW8
	 7XmBF5b2XGWuZ6tnmutpuskgPL0yhjiK4P4zCE94NShAy83pux0xztyV6MfYlt4YRx/wJ
	 XSh/oWzJm4FeyIjMZP3kOKammZwc+Hym1ypixPOECdIvzunK1K28RU2cL9v0qDV+HWx+4
	 5Nxm6tkhoJmLTXy2Zummz8GmVcDwpOuM3/iwgXjFbNVCgMSGJeNmRTbxtl52R2tLM+xUu
	 SWooegjrBEKflRYAMaaZ7uxTqDC0S6ZvMjyAlTR81+nkEgGSRfJn2ecOe9gL0GVEfGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bm6YsdPV;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD3606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73AD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bm6YsdPV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Bm6YsdPVo6IJO9UFoyO8tF10Kb
	hcU5nDNHmDBOw+rM7WrZCG5vBh3StYliwmEAH1uZsnku1PjLwp4asMBbZAhtFVE6AJeKkJpeWjpVH
	XyUnIqQB4UP/mRngIV2dLPzXw6C1sTOlq5B1vDWBf+7CbOpQZ8twNvMlCqAMfPDjNNtOiyltXrAtJ
	6C8Rf9lVk/69XII9T7XzA4qQaZv2lT/oPmGpkbKzyN34LIsvX8eRpJIbXiGcuby/2cI0/+RCAQ6xQ
	N7ykh02zjx70E/EoS2aTZiVqiGpDkjsUKBH9xbO1tBvQ5SBJSsSc/c0jv0AhGsZFGcWqKbHatFMDz
	g0Gb/T1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPh8-00000009GAe-04MO;
	Thu, 29 Oct 2026 12:57:26 +0000
Date: Thu, 29 Oct 2026 05:57:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 27/98] blk-mq: don't trust the cookie in blk_mq_poll()
Message-ID: <auNCtX8X1qX64Adb@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-28-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-28-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

