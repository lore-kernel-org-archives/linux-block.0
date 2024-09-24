Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF317BA5;
	Tue, 24 Sep 2024 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159698; cv=none; b=SxECvoP6JeQqQmkUDu2GOzGi8tZL/Ruyy8JZGNjIvEAeE5N4cjCWTvOPwN0es3aID8PPvuyP9+/73BDlywVyYQRHNrb97ASLbWV0J2ZI2C8hPqGJuqHpaTUXa9QSTQRch4qd+r7o+czudp4s/1LcSyqDvi+K/YstNGeYSGo4E2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159698; c=relaxed/simple;
	bh=QOvSlOdCncMCq+hOBcqWjYcq11XmuqUYP7cVzCFbvqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8v2mP0LG0nxAcO7edVveYYsD7BTpCKHlrW33lmhlwfs90UkH6WFJTXdxYMcb59yxaWRCuTVWk6gIt7s1ggrA1p4GzQqPW8/ANdDQKJ/e3dIWGKhcE8rOcu2zqwrfVdNQ6mOE15VCDWdSozk/8ItblMgY17W/Il13zjXuRJicoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BUQHy/bC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BUQHy/bC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z10AX5pmivHLvyFDh9AxOjuKLhBjfi9gRjwNCchoGfk=; b=BUQHy/bC0q6M3+20hgp9JjpCkK
	EaHw20cr944PM22BIpd4SUVux3pYJJzrYN0NRlpAK1nTPEncZpylwD4uVRu2hkdb5EaMrXschkM+J
	LaCmEpdgcn+ru8vE2DMUw6Pll6UnPVcUeqgfFpjisW7USVZRtE5Zd2ImBERJISIS4EizP1vBm1tI0
	plYcVfOFyJe9Vkx8nt4v++ZSq+8Ajq1TCi2uxQNrxQ6qZ76RFHd29tuiLuFZFEyx3CAiUxgdnCA3X
	NG5H43kvjCWY65V2uym2ALRy4nwLIcZKQYifXoHseZGM5HSl5XnfQrhudXpsaS4wYkogJtXpLfF8k
	8EaYdNkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssz8P-00000001GoR-18Dy;
	Tue, 24 Sep 2024 06:34:53 +0000
Date: Mon, 23 Sep 2024 23:34:53 -0700
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
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RFC PATCH 3/4] block: add support for partition table defined
 in OF
Message-ID: <ZvJdjRpFaPUuFhIO@infradead.org>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
 <20240923105937.4374-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923105937.4374-4-ansuelsmth@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 23, 2024 at 12:59:32PM +0200, Christian Marangi wrote:
> +#define BOOT0_STR	"boot0"
> +#define BOOT1_STR	"boot1"
> +

This boot0/1 stuff looks like black magic, so it should probably be
documented at very least.

> +	partitions_np = get_partitions_node(disk_np,
> +					    state->disk->disk_name);

disk->disk_name is not a stable identifier and can change from boot to
boot due to async probing.  You'll need to check a uuid or label instead.
