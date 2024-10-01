Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CE199FD2;
	Tue,  1 Oct 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771834; cv=none; b=ESqY+R2+WzfnLd9CblIGECFciDq4VBydZ5V51OP7VJDc9ed8YKrviHO95u/clba4fr1hS02IniF8hfXBCzGE+zGhqAQA3zfdfaFqD0Qqzmu8xwtQ6vorwkkjMjDJpFZpfC85tcDCITXmYTnLrpP/JpF4PlsvHV7ZddGbn1LSvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771834; c=relaxed/simple;
	bh=Wyz6L/uee6wtNuAB9IKVhYOH/8bbdo8uB5yaNEHuYSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQdpjKjpU0IBPVFRhgy1rFvNJG5URHDS+/rW9QdVwMBF5W6WZ7SfnqrYQJI4JuOJThddKkDsxTxo/sgSyI4DcWFnyxigDJdgwE+SH+Bhik/9iowDoU5PiFDJgALGZyPDgi1i7Ef7a53EKvTAuBH72d2A46Rbc/UHXlzjCkb20s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y0Kr2nYh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y0Kr2nYh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Kat6Fcu7pmBOqwT+ncj7lu6MgI5uB1XonT1BFmLaeI=; b=y0Kr2nYhf6hfL4N11Kbt5OdIJm
	fqjsMInO05EDfBuYxnTwZKsxXN5fk58Bqps4zlhmhcMyfNuGi9mksGXoFZ9aaF7SF6K2kNEsXIeXz
	rAsHPjteqeOsXu1rtlnwQRTAwDUfvIf0SwONwUZsxXYnK6ZbJJiOlSxSGaBzcqIeK+V/DxqAkokXf
	ZFHLHm6QJBDw5nH2krlledg+u9b0Kb6tkh+mxEd9tUrNPQVcTzWUHU5tinKwz/ooJ/Q/ROBbn8GFa
	7IX0QhD6F/lhuqB2nCRv+CKQGSQSHv8kxJq/jDWJcvHqe2L/trTb5JTvwChaTqgCu/fgNwUIPXtMA
	/0qUpflw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svYNV-000000024cV-3L16;
	Tue, 01 Oct 2024 08:37:05 +0000
Date: Tue, 1 Oct 2024 01:37:05 -0700
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
Message-ID: <Zvu0sRreId59-lpH@infradead.org>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
 <20240923105937.4374-4-ansuelsmth@gmail.com>
 <ZvJdjRpFaPUuFhIO@infradead.org>
 <66f291c5.5d0a0220.328e5a.2c9e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f291c5.5d0a0220.328e5a.2c9e@mx.google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 24, 2024 at 12:17:36PM +0200, Christian Marangi wrote:
> On Mon, Sep 23, 2024 at 11:34:53PM -0700, Christoph Hellwig wrote:
> > On Mon, Sep 23, 2024 at 12:59:32PM +0200, Christian Marangi wrote:
> > > +#define BOOT0_STR	"boot0"
> > > +#define BOOT1_STR	"boot1"
> > > +
> > 
> > This boot0/1 stuff looks like black magic, so it should probably be
> > documented at very least.
> >
> 
> It is but from what I have read in the spec for flash in general (this
> is not limited to eMMC but also apply to UFS) these are hardware
> partition. If the version is high enough these are always present and
> have boot0 and boot1 name hardcoded by the driver.

How does this belong into generic block layer code?

> > > +	partitions_np = get_partitions_node(disk_np,
> > > +					    state->disk->disk_name);
> > 
> > disk->disk_name is not a stable identifier and can change from boot to
> > boot due to async probing.  You'll need to check a uuid or label instead.
> 
> This is really for the 2 special partition up to check the suffix, we
> don't really care about the name. I guess it's acceptable to use
> unstable identifier?

No.  ->disk_name is in no way reliable, we can't hardcode that into
a partition parser.

