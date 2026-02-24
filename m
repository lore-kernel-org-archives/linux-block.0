Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902D39B48D
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942915; cv=none; b=TEwja1ICGYNWja0MlrWVhGq5N9e8iKBPz0w7Sc//+TaLGhuGhEef7xLHh5VcytZJWLjO2T/cBfjsuPBYuIZrOJdn88tHvBD9xkOPeDMLO20Zpah32oMRBHzawEhc6NubKeWvKezoKtZu03dRzcgsa/q0szd0hWBOwW3KijlMsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942915; c=relaxed/simple;
	bh=UnvQI2apwlbtHbv4wbCmUb7yMM3vJ7tyiNLxSi73/so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ept5ohIvs2c9jA1amsb4naOCL1JNnBF5r/ulxT8lI9x+vv9syg2s2wRnuraeg7OUI7BNNlEaMkmvDsSfuJL6WQkvH4KEQt+uu6eELnuuLU47ZjG8kNmJguDF3yjYdutM6qCmP2Hl8DIX517s6icFTdadDzjY7t+LreHq+ryMP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pfLf016E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pfLf016E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UnvQI2apwlbtHbv4wbCmUb7yMM3vJ7tyiNLxSi73/so=; b=pfLf016E6nOGWRLVQ+wR079t7D
	+a3jEptAH3nEhD26RxCmfJAjx0mNHHk9Po+L6BOcsp2A8eOWAkCBbWou1LIzr5ul5wY6tVGswi0Co
	ICpZFVvClFWLnJSzlTIn+dT/saVWYuDCO9pETgElMJoC41fpwO4RNCTo04Sg4sZQTScg6C2wLfoBd
	alxo1SIDeRc0NeoZa4WWa0dTy9Rnp1oMjVQJ3bPAJKTkD55UNHLN88pBjFSlAGaU3L1LaKgxsPscJ
	vjaBnxiQr/llSAQ+7K4bu3C0bucfw4xZlTtUNZ+CR4wXU5zx7Ul4uLFR36hhYXeA+Dfk10jXgtIO2
	RUoD0Ddg==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutIP-00000002CXD-3cvu;
	Tue, 24 Feb 2026 14:21:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: zloop fixes
Date: Tue, 24 Feb 2026 06:21:43 -0800
Message-ID: <20260224142153.368472-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

two fixes for zloop found while writing new test cases using it.
