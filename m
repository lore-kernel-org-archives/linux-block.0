Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1A197A83;
	Wed,  2 Oct 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859865; cv=none; b=mmZTzEfVwx5FJOQXcfjybbFycofTBrx/W+ZX1CIy5vcP6rUQc3GAofp+RMOlc4Sp+WXqSEMoRrxfD/SUfsRMayXmQPIpaFYoN15tsDHgVPYLsQcOA/+BfGLDciJQgp4FEy9Vm2Tv8mSjX6uTqfHL6rYzz0xsY+gpMFG9xh1kudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859865; c=relaxed/simple;
	bh=jxLDslYuOD+YznuDFJUnZ5M44gOE/KRsomvPe3DU65g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR4zw5krImGY6rlBx+xLRUPx2WJ4yC2I96PWY8UyaqT6QDSSkOZzf+k3TZvXVEkGXiXncN7+uYgDuKbQMiZXymYhq0CqPRgkWIAvlKtxJE/YXFefR4jkhiCgP8v4bcaFGgoByrvfdeHzKNB1T+b9yYUXf6GojBLFs02vG4kRmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J3kpGnbd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3kpGnbd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2aHze20+7LQImPVoQ/MWOAXeRu7EL6uT/pNqwZ1azQg=; b=J3kpGnbdLiUyM289edkjhaf+Gz
	x5m/ffPQqO38JaZ7nuBysJPGIPTBgfdr4aHvv/8NGWDHjOD+gJAy88ZHQUWZW24VTPq49LMoSxmGI
	hF1TMtV9DC4jJC5NFjXEor1Cteg5byBHje3wsnrF5q6kAKgl7Fiv+db5bMoQFBrZWXPFxZfHIR2ps
	VKe+E2NwnUgB1nu+AI9LXd90Ow5NhU8FY5/079f6tkaqN5vQPOAauQ2Om1UQ5yUa0q8Pe/cajkekT
	iAodD+hKKKsb7wCpHpDpn5WcwZllReOFnMeMsC9hqng8l8CCBGMCDPQHG1gzcByT440y0avqaO9In
	td+cnqyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svvHM-00000005G8U-0Iuo;
	Wed, 02 Oct 2024 09:04:16 +0000
Date: Wed, 2 Oct 2024 02:04:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.cz>, Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com
Subject: Re: [PATCH v5 3/6] block: introduce device_add_of_disk()
Message-ID: <Zv0MkM1R4tglpWwY@infradead.org>
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
 <20241001221931.9309-4-ansuelsmth@gmail.com>
 <Zv0HGh0IjPCt3pYt@infradead.org>
 <66fd087c.050a0220.3b87ae.3666@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fd087c.050a0220.3b87ae.3666@mx.google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 10:46:46AM +0200, Christian Marangi wrote:
> Very happy you like it, yes I wasn't sure what was the correct way to
> introduce the helper. If you notice in the blkdev.h we have also add_disk()
> that is a static inline wrapper for device_add_disk().
> 
> Wonder if device_add_disk() should have the same treatement? No idea if
> it would cause problem with symbol with external modules, that is why I
> used the wrapper.

We could make it an inline wrapper, but it's not in a high performance
path so there isn't really much of a point in doing so.  I don't
remember why it was done for add_disk.

