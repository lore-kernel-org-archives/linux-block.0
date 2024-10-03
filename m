Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C314D708;
	Thu,  3 Oct 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957414; cv=none; b=lcniQgR7a9VKGM5uGP1qTu2cAzME0FWuR7GSEtlg0GEih3sS0C288y4QHvhddpiFTiN0G5L2zFbjb+fWVHnbrMIGM3il8NdtNU+WvVWZ8TOjjTUqJkIeVKGdwZeoXwd+SmJKiiuWyCGmQAbe2pzGrNda8Yp+VBnboDiWYZequTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957414; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR4uSo6/6PhLYM57jeADnyxWXvKZeyfoF3WcFtJodaHjr/IH24Co587N9QCNp0h8vz96PK154kFKyZewd9nkOprtgxFkyLkEY9gmUWEVyrg4SgpwwMkkKtvk6J6a5v9kWyqslt01apDrzB6Tf0Jp9qS266eBH2ELvR4JVnwhyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W8qqgZAC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W8qqgZAC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=W8qqgZACIPu/EEFOH0Vqr6JZ06
	KDSeR1/yEHFCX/6U6UDZXxhCdxB9z6yurVR1Dx8r5C9RcSLcdOGBiyf5HnnFyR+r/TozDpRT5eX54
	WMdxJfMaJIO1q4vG1HqshftVf1ZExujWwdV7ypXv5BlSw5clp8+8e8zUscTG2jrNx2z5IAA+nJmB5
	O5wsR5fpOiIWlyNSVPdSFOurGtqPRzpyb37m/ZbJ6vqUWYm/9YzpTAGR6GYDWUF6yWH3nRxZe1M5k
	YC82NQmNgPTyMyk6voH/9w/GFTaFznQstKqo/6C0n81sU2D8GW6c+QWSTX03eR6IRFibb1owsPRwC
	b938V0PQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swKeU-00000008yqq-23y3;
	Thu, 03 Oct 2024 12:09:50 +0000
Date: Thu, 3 Oct 2024 05:09:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 3/6] block: introduce add_disk_fwnode()
Message-ID: <Zv6JjnDLleKKxxsQ@infradead.org>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
 <20241002221306.4403-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002221306.4403-4-ansuelsmth@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

