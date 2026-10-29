Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286240;
	b=esieMB6M9Q9xwCW9YkSO7Nb73emlyt7fvpEWsPUB/8CaoSaZLtKBgDA7e7cEzJvo08lX
	 ccuRkZ+tcW650CuBRzhMg3FmLXuUwfELDd2ft4XhlwEUIa/326rp5yyV3MlW0i+FLUPqa
	 SjR5yowNoJfQmwhXSuR0LLdiFeZ+wAvnUI3pcO0q/WbcuW1c7X8TTxhtLddO9oCcHBh7y
	 v+Sk3r+KmOxlMFRdV3wKd9lkk++cC8P6W4XNbt780mukdVVI+W7lZcB4aeJSVoSTMsPCE
	 6uVthT/nvoEn39yAPanoI0CUvCPZo88seTqM9KzbEMCQlafZsYhcFHMh1ibRKA/gMPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286240;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-SRS-Rewrite;
	bh=E6swetk1cmEtrfQWU5PI27B0UE68RUgJ99RlCezvErs=;
	b=VHn7IXTPEnuBmu/HQE5tXy5n1HbXXa2LpSoyPuGjlv4hdJeEOpeBZiNhMLSqtU3mvIL7
	 mefTOtsVhxtQ9MjOh5FE/R1Lydrdz7Sc7Nn/Fzhq2QOwbj524hvrBoDUJeRe4v06Jfaj7
	 1fh/wb/Pj6TE83pahJY+uIkv4fWSAx3fQtRSE6/+V+RMxd4wL2HcxywSfy/MalCS/2Cvk
	 UdDuiE537sIOvzxINototzcE3X4CKxCVoYzrMBikcspqB8Gir4KCI6/4/5itABoMRxx3d
	 KlcZLEqbTrLM1ubc8T5m73XlaXrMaRBbDUhBXe25Cwv7a+8SYLSCU7N/5jithjBZEVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=lst.de;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bxHXohKE;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759F606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0759F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bxHXohKE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=E6swetk1cmEtrfQWU5PI27B0UE68RUgJ99RlCezvErs=; b=bxHXohKE4lj3pxYaHaWKamVHTq
	GRLEhv5YGNlOEW9+u+g0GAgQyaM6ry85n9obaFptR7QUFAvxLGyGAnrgcu4aOqvFPiJP+UWuDFdei
	/93QW6Q2CkOJhgnHIkVLg7zu09bvcFmDxWPuCmRlbgkXr/TfNCu8cwc/1LlqxRkp8GpHEDQpYm35T
	q/xytRj/a7JrDNReHY0JqlffE8tNArPFlU26cAbWVOHwnoAySWLpY1KKw4Gvv/xl1i5qXgKMh8LbP
	GcDrbHyeRc50tZ4+8ava865gQd95tOPhGPn3iUl7W5hF4AhXeYXYkjJW7zG+1FbvnnV1XlQKy7Arl
	rLLgw7sA==;
Received: from 2a02-8389-2301-9f00-31e8-efb6-e973-61ca.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:31e8:efb6:e973:61ca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRfa-00000009bs0-0TI8;
	Thu, 29 Oct 2026 15:03:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org
Subject: zloop fixes
Date: Thu, 29 Oct 2026 16:03:31 +0100
Message-ID: <20261029150353.2503201-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series has misc fixes for zloop.

Diffstat:
 zloop.c |   80 ++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 38 insertions(+), 42 deletions(-)
