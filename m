Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582530;
	b=2PTDhdkBSdPxAH7V1qrnWhUPTrpf9VlDbsDeHsSuI8jOg1K8OsV58FRTSxOTG8ry4weh
	 bMKQFJzst3C/F3TJR6sJlTa+XZtZBwe0/Aj0nMOkH06CbrUt8vT22Cn70n2zWg/q/BUVR
	 HwDemAVqO7X0HNWJbSFb8uvRBLVqnJvBEP2bEfRAehPg1WNJdwxYBw9L8oSozm+VECGA7
	 h9j54SHPKTxGF6HDQF6dL68ztqqxTcQg+auFSBTaAirA3hNIzp7lfvZ+LYZC3iKDL1XVY
	 TzmtUdG99eqJI6G3ulsBzNi/e7EP8kpuTKGDT8bqL+LH2Dmi8nsnEeHfSmKqiqFiHmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582530;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=675CrbpeLKF8wsgb4p0LpSasn0RcCWtaWDsKBXElSLo=;
	b=XxiyvniNzRuHJzDY97z5zGbOjFlFCLnt6kb/EXUHETLknNdjR+Mz9paxWpXMadh6TAVA
	 5104oMp2nWjeN+ZqISeVAEkwM4KGcVsGlY0NHNld6+qcsBOmwDzhVQ+Xs3hSX2//nBT3k
	 f9FhDSUWnLYlGx88bip4eeyiqU5wNZVDz6YpV9dbw4efccwg9BeiNCI34zPaoF0YTht9g
	 ru6jJpeAiBEGHHDOFAXYctQ7wKzkHl5tGC+mbT2sWhBHzQFGZmyumXPkxmfGZK6XkM4lw
	 c5Fp5jFLN/dIXQa1aXH80RV8VK8wf28JKtNN9Z83yXIPGJ+vAXJPIEDi3cb7DkPSDzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZGRAxVbT;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481D606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 04:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B481D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZGRAxVbT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=675CrbpeLKF8wsgb4p0LpSasn0RcCWtaWDsKBXElSLo=; b=ZGRAxVbTvSHKfDiru1MsR/EPFO
	u0+853VMf8jaD04yswKzG5N9pCK2fkIF5SqbjvFewJXru3txXIzyV81G6KiwIH0NbkEcMxLn/EE2I
	AnzH4WzqYEv1sTqZH7+OM5mz4zU70CUJE+urpiCsakv6Eincotj6H9GUhMRjokXtKowvN9kMLYLvh
	/xq4nnNSm5IOM17odrGLvs5ilRSuBLz+komfFtCZhbFBcTXwUzIjZBLma5DpZillg3u19wm2DG2Hv
	4HXnYoBawAUXm1QQmG0xfWh1gQC4ZlggJbxzNCIL0k0cmc7cUDWwqAApa6Vw4xw2j2xu13MtT+Ria
	9MqpuNMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW52W-00000008Qgm-3QmH;
	Wed, 25 Nov 2026 04:55:28 +0000
Date: Tue, 24 Nov 2026 20:55:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()
Message-ID: <awZqQEp3W5Ewp45T@infradead.org>
References: <CGME20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p8>
 <20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p8>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p8>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This commit messages reiterates in annoying detail what the change does,
which is mostly obvious from the code.  It entirely fails to explain
why you want to make this change.

