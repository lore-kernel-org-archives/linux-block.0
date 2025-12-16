Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6F45948;
	Tue, 16 Dec 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882056; cv=none; b=u4//sREb6BL/eKK1T57R7qkMMovP6yPF23y7Mpq0KrkA+SsUXEwNgCGLU0alChfradt0V7PhQxcXZxxXBlZFdfHpwdKqsYgNIKHqn8o9/EWnzHl+DlVLVSDu4f6WhvzEelHOaGh4BS7yHoQRNZJnJLjtX6yNpuNTn0cIxvmYIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882056; c=relaxed/simple;
	bh=gdZiXTK5zTaqWcUxjJFYv6j9Fu7W6bWpPf8ttII6A/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFdRMDyWw2Tf9lR/JLC8O8Iwzfx9l8cfOcOvsOhspo5kptzP+PAJQ1iKiDNX3WMENzl3WE4NDmLF9RAWha0Yvk+kIdTlJf0Xu1v46z0BVKlAVD8MtD3V774YIe3FR+FrbACLNdt5o/F9eJjF4YQM3s+xOVekctzXmVURWSyLJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zx/We791; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zx/We791"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TPDbhAGdXsgsYwaQ2LCKhWmVirhM1Fc07pBE5e++ne8=; b=zx/We791PFCGm90Hafwt5ysUG3
	YYGJ2+QR4aBO+lD8qkAWjTjVSkfQbagmxhAhhyIGay70LqbnP/Q1yljd90XXW9hEQP2FqnoD8hFnY
	80SrwVAKUiENK3Q5fGEnFcnfovLPFJHAnaj0NC5K9P5ddm3PxBUI62ILJ4UewrhyqhpFDZeiwoHHx
	xNiM42Nf+gshmwKL24ITmNWQICcdeLjzrU1aed423jw9VsQlPS3tyFyytCtR2uFPuKlXndb7umQA6
	jCBM4MV4t3GNx487OmTP3kHUqcpSRjZF4UQP6PZ61BktnxXXTNgu/pfXOKeppPX5f68LIVeCLcGoQ
	lZ7+NxEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVSab-000000053mv-12lF;
	Tue, 16 Dec 2025 10:47:33 +0000
Date: Tue, 16 Dec 2025 02:47:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Luke Wang <ziniu.wang_1@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH v2 0/2] Optimize secure erase performance for
 certain Kingston eMMC devices
Message-ID: <aUE4xSnW1bHyRRoR@infradead.org>
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
 <CAPDyKFoLmo=qDru67rj63gQwMjLqVKS+wEQecukuC+3Pz_CjDA@mail.gmail.com>
 <DU2PR04MB8567C09C52C66C59C9CA6607EDAAA@DU2PR04MB8567.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB8567C09C52C66C59C9CA6607EDAAA@DU2PR04MB8567.eurprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 16, 2025 at 10:02:49AM +0000, Luke Wang wrote:
> In fact, secure erase does not guarantee that data is physically
> erased.

It can't.  Given how Flash storage works there is no way to actually
securely erase data on a per-LBA range basis. 

> And the eMMC 5.1 Spec:
> "NOTE Secure Erase is included for backwards compatibility. New system level implementations
> (based on v4.51 devices and beyond) should use Erase combined with Sanitize instead of secure erase."

And this is 100% correct.  Only a device-level Sanitize operation
can do meaningful erasure of data on Flash based media (or modern
HDDs with all the remapping they do for that matter).

