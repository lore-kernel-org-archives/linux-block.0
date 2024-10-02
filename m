Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9031FA4;
	Wed,  2 Oct 2024 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855145; cv=none; b=PKNV717jn7lk2nw2YIsYsEAyNW1VG6x6/xy7w4x3SNenajVRlVh3vqz94oqImmcyrfIAxEY0du3fpYyOdyWv9zQ8h9FpLe5dD7PdeXStSTnR2Qu8hX9VLcrzuYEfkeBNVkjAg39nwbhSAWhkxUpJP5u8tWoA42kRfR5v86QAMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855145; c=relaxed/simple;
	bh=kMJLqEV9tqhVK4MaaTaIf2NqFonku/YMWeCm0UPMw+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcDOaNUJSgPqOpvVF2thnQyVdGxBct+Ec7f5SUSXFT9qOxd2b1LgwlUvBCCihWV9oVniqoR1E9UhzDV0ML/L4dUtS1P0rnd8EKlk1gKvmQ6Ra5rQonu4ZV2ngX/Jn3rWeaAnPfHR7n4mSbu/zRSRlcSrENzuTxqfcUR6Iuy6ImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jWhW7GU0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWhW7GU0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+DhPlvZlgWyskAxxSMsqdkfwqzEhNZOw6Hp35GCELxs=; b=jWhW7GU067oIFkt/MVbbr+n18I
	wGHnBAxyd6w8KVrImRRpeg0e8F9y2jHDIEVqUQPj0tMABOnVUHDgg3vzJV/cL7mqxIFVyGQW0k04R
	mG1/tE0hfZiTGC2OcXUAiomagy9LPxMJewGF+HXgqsdPBLHd1iZ3LNImSJDZCB+5/Y+Aiq2mg3ULJ
	ucLYzc7Zh6MzKOqZ4cIHtwFaZrcLqFDHtQE/pR16gQuQoANDxGhaHkj9iY48UC32IXqQR8lkRb5Ub
	+8b/Seys7fulUj0BxasEhk18bXdnehu6debe2cwDX2SIt8Rh6EVGlOAoPCbxiJ5/xZuncm8hB+cxE
	bYVueTUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svu3F-000000053lB-1BAr;
	Wed, 02 Oct 2024 07:45:37 +0000
Date: Wed, 2 Oct 2024 00:45:37 -0700
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
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RFC PATCH 3/4] block: add support for partition table defined
 in OF
Message-ID: <Zvz6ITaMKmo0U3c3@infradead.org>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
 <20240923105937.4374-4-ansuelsmth@gmail.com>
 <ZvJdjRpFaPUuFhIO@infradead.org>
 <66f291c5.5d0a0220.328e5a.2c9e@mx.google.com>
 <Zvu0sRreId59-lpH@infradead.org>
 <66fbc042.050a0220.3523ed.a6f9@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fbc042.050a0220.3523ed.a6f9@mx.google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 01, 2024 at 11:26:22AM +0200, Christian Marangi wrote:
> > No.  ->disk_name is in no way reliable, we can't hardcode that into
> > a partition parser.
> > 
> 
> Then any hint on this or alternative way?

The normal way would be to use eui/ngui/uuid provided by the storage
device.  We have a interface for that in the block layer support by
scsi and nvme, but I don't know how to wire that up for eMMC which
I suspect is what you care about.

