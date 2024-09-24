Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8B80025;
	Tue, 24 Sep 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159543; cv=none; b=ISgOL7pysbq2V6dAj87jSGjmdCtFUGtnm5eb+/7WBjwxaeohgR616ncWS2DgET+2sw1a1hWJjqLLO4vuwIofeMUUzNYkbZEArpLKQZW8N0/lE0fKE6mkTlXV2zv9JnIdiMLK8fMNuwiB5AbZcu7NUVxCzZSlnF7TuxcA+2UqGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159543; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP+zG6dkETdMKPLHa1CZTcci/WwAg70+oze6aHYZHA6R6phXjfqgaHx+T9SoIEdhawZkPJhmJzgur+SxGyoabEzB9a1hht2kkaFbJ6kktmWh8yIPV94M+Yaog/GJEj7wYDcqmeIZx9p1E1dtuidDGH+60Q7fLE2Bqjo3xKG1seA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QEEFkCq0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QEEFkCq0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QEEFkCq0rEYWQiFcHA26MvQwjJ
	zcnnGDMZM1tmC7MBf+vEs7cjMzfCeLKeS+qlus0adkBh+RCJyiekngrqnecRtp/sDgUnfRO86FdPh
	zqSK8QCQKRfeKsRL/MyMd/wanN9qvWRs34w4nugLuv+KQUxvnPFKFdD+EInN/94tnzjOeMnQdF0J+
	CyH9i84TSO4UuLU1ibPjaPoJb7ODH7RtwvUxc921EIh51DXfAOp3//COfgCl5/kjXa8nMQNyRK7oN
	3DRBr4c1fi7WC6lP7jCoRhDWANUFEJBM2ze+KXRBuY+DzHplSlSSKUtjNk2g21tPdC+s7Sg7HLoOk
	6Ik9WDNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssz5r-00000001GSA-1kxV;
	Tue, 24 Sep 2024 06:32:15 +0000
Date: Mon, 23 Sep 2024 23:32:15 -0700
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
Subject: Re: [RFC PATCH 1/4] block: add support for defining read-only
 partitions
Message-ID: <ZvJc7yVP_2UEn8MU@infradead.org>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
 <20240923105937.4374-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923105937.4374-2-ansuelsmth@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

