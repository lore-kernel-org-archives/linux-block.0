Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B54C3BE;
	Fri, 28 Jun 2024 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579039; cv=none; b=m8+5plmRd3AbJMfpCSL5Ky/VvwFW0OiVRVJXaxsAXeKc3GaPJLVLsmjnuJdFk1aEu1ijk8pmogHA86XAT0K85XbyV6Zw4AZvFe1KakorPRzsDyvcWy87A5ljfMmwjb7yQ6rm5wUqkv5bdMlAh7Azh/f/SMlf77YlI1OOOr2VMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579039; c=relaxed/simple;
	bh=RzFen9JQSi644qnKFr/+16SgU8rM196DVKOyw4xfV+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpIyoFcW4Qjm9UulggrvEmUEdbaRC/BxZjqbGuIBmfkBGaG13IjoNDWgwM9HjbHhV58VQWnvmo+lf71TlAyCxNqgX17cCQxCbUgT5FfaDqQ4pBJq8vfoOKC9KNwLQWhwjDlj4ne+078AFPMIGR04khGX9KQrnfOJQC0f2m9IFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jjxBv5RZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jjxBv5RZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mnbrvixIDdkfJ/Y+2RZM5FtacFOILjP6fmsLKyS1/AQ=; b=jjxBv5RZOWAbmnUOGV+3KEzNKg
	eoW8zWsbdt2AbU8EWwKhlVBEiG0IMFFRD5HD8f+140PbY357uVg/aGT3eQttdQJ9nSIk7hcSuDZnI
	M8auMVuPmV1XDjyztJlO9zXRimFRuJerrdsxOQDFP5ORLAdf2+l6u8E/w7PzSxQunN104j/aKtn8I
	xBB7Vk7pQ1fERCywhGQl6x0ShbRjGU2a8dMpRaVclCbXC8Hox3w0iDsyogf1EYYDE3z2MmTaEOWSG
	6Jif0ko7zO/DGYg5zSi3cr1Dsu41LltGETThaQpfjzwqzOYtk2UCg2LAfkIjv5YRTTC0LG49Cd3on
	mE4Mow5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNB3U-0000000Dk7f-3qsS;
	Fri, 28 Jun 2024 12:50:20 +0000
Date: Fri, 28 Jun 2024 05:50:20 -0700
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
Message-ID: <Zn6xjP8eH470wWXC@infradead.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
 <4ebef78f07ff1ea4d553c481ffa9e130d65db772.1719520771.git.daniel@makrotopia.org>
 <Zn4_-alKtxuZ6zNt@infradead.org>
 <Zn6rU-mCYQcyCkGT@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn6rU-mCYQcyCkGT@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 28, 2024 at 01:23:47PM +0100, Daniel Golle wrote:
> So that's what I did consequently. Using the notification interface
> the NVMEM driver can live in drivers/nvmem/ and doesn't need to be
> using block internals.
> 
> > And not actually having a user for it is a complete no-go.
> > 
> 
> The user will be the nvmem provider, you can see the code in earlier
> versions of the patchset where I had included it:
> 
> https://patchwork.kernel.org/project/linux-block/patch/96554d6b4d9fa72f936c2c476eb0b023cdd60a64.1717031992.git.daniel@makrotopia.org/
> 
> Being another subsystem I thought it'd be better to deal with the
> block related things first, and once that has been sorted out I will
> move on to add the NVMEM driver and make the necessary changes for
> using it on eMMC.

It is rather hard to review an interface without the users.

I still dislike the idea of notifications from bdev discovery /
partition scanning into the users of them.  We have one such users
in the MD legacy autodetect code, but that has largely been considered
at bad idea and distros tend to use mdadm based assembly from initramfs
instead.  Which IMHO feels like the right thing for nvmem as well,
just have an nvmem provider that opens a file for a user provided
path and use kernel_read on it.  This can covered block devices,
character devices and even regular files.  It will require initramfs
support, but that is pretty much used everywhere for storage discovery
and setup anyway.
