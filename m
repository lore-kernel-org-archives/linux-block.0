Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44B1940BC;
	Wed,  2 Oct 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858601; cv=none; b=G1OXp73F5CcKSNHoeoaTreVizVUeQ++wDejGH3mkLLaQ0eIyRyKtOE5gp5kplopmVHrzpMmZeWcvpEeIUragCLj/2kt5POVnj7H6FJDvyNxZCwLIs8HVHAxeRZL7VISFBs8xudjBz/g7yfPcQzeR2C/rQtcAPlFzp2CTqqMuwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858601; c=relaxed/simple;
	bh=oR7poKQkS4ps7da71/gORSXX0ZMu3sXqJaASnGOW8u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO20EZuMF+xB4Id3OqBuXLJS6ruAiLO8QiR3npR6e0Sziv6xj8RdStcRIxfEHgX8kxoC7laVzgwWMJO3wWeqxxHo8sTutIcLVqIPV7TPrdAtXFwlSDH+nhv7+Gksw30dMEwsEl4tUmnbpFCFJBzPv7FjYmgRte/vIRN4fWLtzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=evp+CPym; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="evp+CPym"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zqTgHmGeTQIj5rCUjw3eJsZGjfP9Kf4g2n+yKtbQSII=; b=evp+CPymp4rfeaohFlPL3jsjkX
	lSDSdOW2fVKMjJ0btWQWUs27jPbzBmSpu5LItDShUlLn6wllFLRHTj4Qh7/YLPr+kYI6BpJmARZLy
	rGMeeQNupLBaOOTRNkKTzG8yGLLdK2HFuL9OxV6Sy5picrYh1PU1kNsyWF+QfU6xdBdFy2bpn9pQo
	FfY24hLadtrsvn70Pf9gOP+diollduXZVAVZTZ0zwq/Jox5ocbl5ww3ixm5REEtIkZTmwHnCB9PY5
	fUsxeYI3B48TO0L4/l/qwhj39YbsK5uPUhhCbC7M7vLLKwCKU7/SIgnpiy0Mb90qtHcKcOelBP6XR
	9wsBAKgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svux0-00000005CKu-0nQM;
	Wed, 02 Oct 2024 08:43:14 +0000
Date: Wed, 2 Oct 2024 01:43:14 -0700
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
Subject: Re: [PATCH v5 5/6] block: add support for partition table defined in
 OF
Message-ID: <Zv0HotHuCGDpmFp7@infradead.org>
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
 <20241001221931.9309-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001221931.9309-6-ansuelsmth@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 12:18:57AM +0200, Christian Marangi wrote:
> +static int validate_of_partition(struct device_node *np, int slot)
> +{
> +	int a_cells, s_cells;
> +	const __be32 *reg;
> +	u64 offset, size;
> +	int len;
> +
> +	reg = of_get_property(np, "reg", &len);
> +
> +	a_cells = of_n_addr_cells(np);
> +	s_cells = of_n_size_cells(np);

Just personal preference, but I find code easier to read if variables
are initialized at declaration time whenever possible:

	const __be32 *reg = of_get_property(np, "reg", &len);
	int a_cells = of_n_addr_cells(np);
	int s_cells = of_n_size_cells(np);

(same for a few other functions below)

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
