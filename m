Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE101A28D;
	Mon,  1 Jul 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813317; cv=none; b=KZk8ya0yu3vitM8NehP4GJrNaFiHe/u4tnGYAHblGLPnlg3w1Jw00oj3d1xj9SIh6kkYfDAmrrdxNCrmRX9JYxmojAB76NWuVTkFW9AkRxSJTQl+R60lU9XBsl5D/QJUHZ8VhmycgfAUqTrkbD+haaOeFSTyftUtyTxk6+E54PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813317; c=relaxed/simple;
	bh=I9y8ddRqhdUx1UxdeXM+d4YZ6+2pkJVM9N5xOnFwtkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsHbpDOHLTVZXrI/iftbxHF8f9miCQNgC2bGdFaBrZA5SKSCyaOxLrQz0ccqqxbN1g/+caPGD79Vfv9aS/vLmPTloLEaqV+SLB1x2h1DfFDC+/vIZ1VcYFY0uC7w050TyNLUVFYQRXzPkCA1mgQWUc4lwitDHdG3VbLMESsbf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gkioHEak; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gkioHEak"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I9y8ddRqhdUx1UxdeXM+d4YZ6+2pkJVM9N5xOnFwtkQ=; b=gkioHEakysPSaTdk6cWE53uKmL
	tlKQl8qKXhaIUSVUlppKUD8byhlWLgWaaYaYeQZdG1WNm4eulKPHGcUaV9BJCHsxAJ7inSf41Wj5D
	WKgUy08Bx1RdXajfXMmktWWr6Od/Ojm+PktBVJwHt63Qati4EzUQpdMB1GmVZQMWIKmlZe9jpdHl3
	PsRGr9VXb3gb4w4hzVqDorr1q161+Xau9fYYTmfBx16NgsTRJNeBKMqKT1Cyic0bSFQU/Nt4MY1Lf
	W7G0jciV5pXBzRomsqRMwMC999Ag5dizbszqVuzjWmoaFf6yBx5Jdn6qg1PqaBdnCT8hOLncQaWLg
	rJc/Yknw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOA04-00000001nLo-1UfL;
	Mon, 01 Jul 2024 05:54:52 +0000
Date: Sun, 30 Jun 2024 22:54:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 3/4] block: add support for notifications
Message-ID: <ZoJErCQnDnkyKFRr@infradead.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
 <4ebef78f07ff1ea4d553c481ffa9e130d65db772.1719520771.git.daniel@makrotopia.org>
 <Zn4_-alKtxuZ6zNt@infradead.org>
 <Zn6rU-mCYQcyCkGT@makrotopia.org>
 <Zn6xjP8eH470wWXC@infradead.org>
 <Zn7B5adt82suLrRq@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7B5adt82suLrRq@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 28, 2024 at 03:00:05PM +0100, Daniel Golle wrote:
> The problem there is that then we cannot use Device Tree to device the
> NVMEM layouts, and reference NVMEM bits to the dirvers which need them.
> Hence also the definition of the NVMEM layout would have to happen in
> userspace, inside an initramfs. I know that having an initramfs is
> common for classic desktop or server distributions, but the same is not
> true on more simple embedded devices such as router/firewall or WiFi
> access point appliances running OpenWrt.

Maybe it needs to become more common so that we don't need crazy
kernel workarounds for something that can be trivially done with
a few lines of userspace code?

