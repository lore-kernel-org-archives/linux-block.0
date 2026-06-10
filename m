Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E340D579
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068769; cv=none; b=WJmHbwuhdCmAMFiyVLHnbqtIDAuZmZFESZtDcHPYSL7g8mBAQKFWRb3tENovPnOWz2mRbBjpYvKCLiKrjulq7zcBd8r8VtoDumfOyXUbMHsuiGJp2VLjY/m4CSUOy3kOYu9zZlQXyP7ePILxIlQQfHOQ335M2DpIf6T8Z3XBO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068769; c=relaxed/simple;
	bh=4bFWlHEqg1i34F1zCidVQCyvdMZtwPpuGc3Sq8CaGiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcgKmoCihFf6LFYHC1cmRMVHvB6v87Iv71s/XhS7G8nBYE95a1vSx7aeKt/vHrY+bRGQUowGegUOG4WiQOo5ZTGB7wRcO3q0rKG4h9aXMWmsp+iW8fVI5MJC2jMtzrLUWu9TZHveBupV15BzbiK3V/brRmN2nOp4dV7/vxeyRUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q1i6K7AC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q1i6K7AC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EyD70MGkGx0tV5tM49LoBKzAgcyzb2sdMIFgge5W7jU=; b=Q1i6K7AC904bkIaAU2Gscxjldx
	d6UNVpCbr9yvBMjQ/NiB3fj+d/+vFPDSh23Wd3CkCNIo1tFbUVX2i3JMkhtPFIZWI4XlzSyaqugIe
	ApkSR4Ky1YYazgGfuTrjK3Fa4R8LvmjtIhTiF45N1jHagOGH8p+w7iSXfq8wBp6wDif3Qf//2oOaP
	do9pI1QIKmc9jTu3moomaazjUegptcWDEnM2fpIZN+AjOm84Q6FzezJ2mcsUwemFQQQiLJHKEdK4b
	fAVMITfHUF9GPj1nI/tP6+GazV0sJjxTF1qvZf/FGyNZwLyAvH5qN1tt3Y6o/y/71Wjk/OsL9mOyy
	4mKlF+Zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBLc-00000006okp-0mQv;
	Wed, 10 Jun 2026 05:19:28 +0000
Date: Tue, 9 Jun 2026 22:19:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 04/27] drbd: Remove the get_ldev_if_state() macro
Message-ID: <aijz4EPMKtN1oc7e@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <0f1141908524e2361a6c4921c668190c8f9a5831.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1141908524e2361a6c4921c668190c8f9a5831.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> -	 ({ __acquire(x); true; }) : false)
>  #define get_ldev(_device) get_ldev_if_state(_device, D_INCONSISTENT)
>  
>  static inline void put_ldev(struct drbd_device *device)
> @@ -2033,8 +2030,8 @@ static inline void put_ldev(struct drbd_device *device)
>  	}
>  }
>  
> -static inline int _get_ldev_if_state(struct drbd_device *device,
> -				     enum drbd_disk_state mins)
> +static inline int get_ldev_if_state(struct drbd_device *device,
> +				    enum drbd_disk_state mins)
>  {
>  	int io_allowed;
>  
---end quoted text---
