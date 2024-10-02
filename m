Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA146BA;
	Wed,  2 Oct 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858476; cv=none; b=WrVlTV11auiXkO+gstPLJ29R7KPdCArQfqPZpA1DpBhijZLV0I86GJEUFlKamm+XA4p5vE1NVc0PIAWQ9YJHGWty0/0HKqgggE+/3fqDLd1UGBDbU2RdQL7aa8wkoIkoLQbk+xmvm52FbjZk5vf6zYGNLOtijp3jMz2FQnBtLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858476; c=relaxed/simple;
	bh=JJTh9uKvlKeR3wglJ4TWBnNBtW8OnYbEYjC7ORTgNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1H8Ws4CoJEJu+SdDClCkWXGxgUBcw5WLw57tWxH845ifJxYqBZLUSZasW9cA0aRzj3aSxGEsqeJ+004VRWARfXTTA5Kr2zJF/PAKy/CS1iypfQy257n6lU6LCdlox/yF1zQ85wfWngQpel0MCQpxBStnEX65tvzksNYT0EjvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3PoBiHRg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3PoBiHRg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f3QAdK0DzTw5S4e+SAFo91dCIxqHJACA5sh+JZpsFfk=; b=3PoBiHRgLTMXjI5p587dMf8bZr
	C1wltrAkwGsyYGSp78mou98Zh44AB3V+YjX4XLsyrigGsIBJkLg9wS0Yp/Oer3uDWyt8R4WS1gWrc
	5ovi1Bo/MpsZypWNbzvhZ+Tljiy2P8p5jZFiJ9EMHBX/gmIy1bSRhUlnq5ii4VnaJLk/UzUjgnfIx
	r5m5m/xQjWrzr7QS4acf+oZekN51T2gfWoHc9gy904C06clZsU+unptw+gqC4iC2q6LtGTXw258P0
	A2k+fZo/2xsdTadDCS8MjTfyv7CybvRFVNf3lDcmMfIhOS3frJltIsqtkzowPftLLz8OG8cXmvUfX
	9UxCIt8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svuuo-00000005Bix-2TmR;
	Wed, 02 Oct 2024 08:40:58 +0000
Date: Wed, 2 Oct 2024 01:40:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <Zv0HGh0IjPCt3pYt@infradead.org>
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
 <20241001221931.9309-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001221931.9309-4-ansuelsmth@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks,

this looks much better.  A few minor nitpicks, though:

> -int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
> -				 const struct attribute_group **groups)
> +static int __device_add_disk(struct device *parent, struct gendisk *disk,
> +			     const struct attribute_group **groups,
> +			     struct fwnode_handle *fwnode)

I don't think we need a separate helper if device_add_disk simply
wraps the OF version by passing a NULL fwnode.

> +int __must_check device_add_of_disk(struct device *parent, struct gendisk *disk,
> +				    const struct attribute_group **groups,
> +				    struct fwnode_handle *fwnode)
> +{
> +	return __device_add_disk(parent, disk, groups, fwnode);
> +}

I'd name this as add_disk_fwnode as the of in device_add_of_disk
reads as in add the device of the disk, and the fwnode is what gets
passed.  The device_ is a bit redundant and just there for historic
reasons as the original add_disk predates the device model.

Can you also add a kerneldoc comment for the new helper?

> +EXPORT_SYMBOL(device_add_of_disk);

EXPORT_SYMBO_GPL, please.

