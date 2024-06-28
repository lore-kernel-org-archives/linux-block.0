Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6D13E029;
	Fri, 28 Jun 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578532; cv=none; b=uRN61714HHt0I7dmuB6M493y8Xha0bl2UaiMZSu623xg6rZxjX3/GZOP9qeGERUYOmlLK6wPRZlPA+2ibUUb7Y4NfkdofxCxHZygI0XDz7zy9+n+0EjyJy/lhTwWSodtMbyAtUZi+hXp1nuE2rWjwih6+pulLw9ey1jVYFI4HJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578532; c=relaxed/simple;
	bh=C5ObWTNXLfzCZasTtKx8inESnd8H/PFX95IOQz3bASI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D18/qMoFraA5BvebzRl9W4oYnTjid+QNDBN4I7wPPHsVylEJ8zqttAcq4BX5KOxk78pmIBTc2xvf7/R5mJffMDagpQFKd0wKDy8qdXMoYQ/qz0LxvYpRgMWCqPsReY49wo3MTvSykORBBAtAgRdYDtVcTbtjyyIomIrFxIWnrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VrmM3xJo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VrmM3xJo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4oAc/X7cngP3Cawle+vTIhf1va3SXMhGGdRju0o8W1k=; b=VrmM3xJo5IOH3EcYcRTQBgkmvc
	uA7pP0AMsTqyT3ni2ImBU38XpclLVulClJ25GKrYNJlEaTuZvSvuZfXv22c7D0I+wFz0nSGK419Ya
	2XEJ4M+Lt6fzLv1vxMCXtULXcDdQjX7bRW4Kbr/4pqq0uxh3J+9PqlJnzvygyXYQHga1SOf4FY2t6
	YbKIdvXZcQnZVzEbIchBYkLSWM7sYc8RbdA0U9i4bG9IkMSuH0GVbVQtby9Hy1/8HUw+gm2ZUMjHS
	W+BQiGmWxShocMCqlXnpOg1wPPAKvUeU6ceHaWrT9sm/bd/dZCQZ4a94BDQs+l2eJJT6ZbAHR+uhv
	05fDjz2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNAvG-0000000Dijs-16qK;
	Fri, 28 Jun 2024 12:41:50 +0000
Date: Fri, 28 Jun 2024 05:41:50 -0700
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
Subject: Re: [PATCH v4 2/4] block: partitions: populate fwnode
Message-ID: <Zn6vjmNf4QjBkqh6@infradead.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
 <6acc459a392d562abc58f7e55c6f04dba8073257.1719520771.git.daniel@makrotopia.org>
 <Zn4_rMJVm6cpIEZV@infradead.org>
 <Zn6pje4DcAYEk6Kw@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn6pje4DcAYEk6Kw@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 28, 2024 at 01:16:13PM +0100, Daniel Golle wrote:
> > Overly long lines, which is really annyoing for block comments.
> 
> Should I use 80 chars as limit everywhere?

In my opinion that makes things easier.  The coding style allows to
exceed it for individual lines where it improves readability, which
is a bit of an odd case.

> > Can we please not use the crazy part_meta stuff for anything new?
> > We should never have merge it, and right now it is at least isolated
> > to the boot time root dev_t partsing, and I'd really prefer to keep it
> > in that corner.
> > 
> 
> At least up to my understanding there isn't any other to know a
> partitions UUID or volume name.
> 
> If there is another way to access this information I'd happily make
> use of it, but I couldn't find any.

That is true, but except for the early dev_t parsing we actually never
use these partition uuids in the kernel at all.  Also in all the
normal file system references either use the file system uuid,
or the device provided one for devices that support them.  Most of
that is handled entirely in userspace, though - the kernel largely
operates just on the dev_t.
