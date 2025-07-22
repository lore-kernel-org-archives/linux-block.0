Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59A7482
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173956; cv=none; b=qb64vUGspGMx3zMzsmv+x05LUeiWcveHFQozUx0Z4CldAMMeEiQuq3gMLgc+ryKailcfEsVhoZIMEk4U5DxFt9tJBqG7AztnMDyLTwwsV2Q20U1LO0nYOOtCsQCI117PWWm3j7SbnJtEyS13y1fC/XlrBpj5qgRaEflneVYk4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173956; c=relaxed/simple;
	bh=393vD2dW3ii0fxMDxboU0pU0nOCnUK/w/KnqojhJSLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uytsBN+Dqhsa4uB4fJc9xyxZAzvs21TaeFY0DK1jPWyz1Fr1A86q4+xSpII6Nt3OS7wwLkLaQYpbw28gyw+SQgp4sOovLsAMuCwdQTycPGpaxz8Wp30PL97A4/lArpdObf3fgBZwD7BVX0Ys7w9zsgAYe2A121PdkoRRhPbfgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0keRiI+g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0keRiI+g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=40kprHRmI0zM3g/zk2SdOVMODyDHptLhrz6yWK/cmq0=; b=0keRiI+gRqCMasvFYAUlGjP93L
	CJrKJjmXMPC/U6Wi8stp5PxRuRTeywUe4RFW3G+8l7eU4i/wMgHt332dAySrUt0IXsYppI5pZQ4cH
	1qbMMRz4v9Ao6i2/y6CGbxytQw35MFjM058WPVGl+qQSRBpc00LsFbuoM1JAHLKb0w2rEfluG0905
	4GLmWtq6TJvp2jrnVMzXxA11/olbAl71YVOVVUqp80Hka2UDrObpkYbvxTK7dDbzPcoHEOlWd+8R6
	hES+HKbMFZM1728O6vzve+DZMyvQHndOZRGGFX0YRrPuZZooIWu1pmtvRfxJ4u59KV3m852tczWQt
	uthKcLGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue8dF-00000001s9F-1TUv;
	Tue, 22 Jul 2025 08:45:53 +0000
Date: Tue, 22 Jul 2025 01:45:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
Message-ID: <aH9PwbpvMhTMUNl4@infradead.org>
References: <CGME20250722081938epcas5p12a1ee45419754afa2f1c1c9040d519d6@epcas5p1.samsung.com>
 <20250722081911.78327-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722081911.78327-1-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 22, 2025 at 01:49:11PM +0530, Anuj Gupta wrote:
> +	switch (bi->csum_type) {
> +	case BLK_INTEGRITY_CSUM_NONE:
> +		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_NONE;
> +		break;
> +	case BLK_INTEGRITY_CSUM_IP:
> +		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_IP;
> +		break;
> +	case BLK_INTEGRITY_CSUM_CRC:
> +		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC16_T10DIF;
> +		break;
> +	case BLK_INTEGRITY_CSUM_CRC64:
> +		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC64_NVME;
> +		break;
> +	default:
> +		break;

This should catch and reject invalid values.  Otherwise the patch looks
fine.

