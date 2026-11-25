Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589940;
	b=rg6XHBCfy8iJG4cIq7d9lqjTtLgk7jnIWfcuxCgLOYmb5JCAJ+afvgKSS/F1O9WZsDyD
	 77u9pvKPmeL13uAkmVT4P6fHl4V8mJNpawrsDbdI+zuOy7fGtoe+8Rkhdc54zIbMlNG25
	 9tsrkoT6Nzu+jWD8vOjbqkb4q4n8ix46jNwzTambLwEXDmw/k/KMwed+Vv/MFtDKYkEvt
	 JYtTvozlA6uFVwUIWa5yFIn6gdo5FgBBJDfmignIzOtFPn3W2Gn1WMuU9dave474hUo0J
	 5Go7ibGLEofZmZrfbCmFyM6H7w5qqxshgRY6oOcL6fwIGN4yKzVGj/ccMHVZVzmEfxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589940;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-SRS-Rewrite;
	bh=Cp771HcOnxKakh2ZJZhds/f/JMRZrB95y7ARcpmRVYE=;
	b=V2uS+ABJm3SIC3xgovAYrtlJZLc4CrQNRBIvDL5WFBcqYDNaMS5nCx+XSvmGu4B9nzdw
	 8bZ6Tlj9pMq68jvAbDfJfZ/+gAziG9km2MFk26mR+Ov1xQj1pj3fHdeNX5fkqalaTeema
	 RH69md6AgpeRCJxMKDLefrdNhPjwa/c+NrDuepDsu1eL5UXxqskXf0jGgwvqkbY0gMAbr
	 KMsvF58K+PbrDNDWjgCw8Mbykr68FzJ/6AawoUoGHkP9USiCzx0hUOxXadKNWo8fB/qsn
	 8G4UT3hJM2mWn8SknhP+pGW11RPQj+cjV1n1ZE7WBwbYQghyceJPSI4wp7FmOR2isTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3DhzttrI;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A4606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 06:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 596A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3DhzttrI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Cp771HcOnxKakh2ZJZhds/f/JMRZrB95y7ARcpmRVYE=; b=3DhzttrIMjF2VZ+YADmsHkMxV/
	yupmmSXTYnONe6f7kiiOD5CizMqZHZBG3iUThDvVNDH5Le1lP+jw5TcaLfFhXZpmnNXuKqu/w+pnl
	mXDEUIKiXJuHxNth6D2PCA7vikCz87PcDVgkDK+ZU0a7X0o4zHLIiPdE3lvR+mdqeHy6m980RECx0
	TNkDxUlTdWU0jEp8i454viRsdJFCp2HGVpls28w0mz55JOn11SADTQ0EIblDUK3bxBdzJ+EDuwzQT
	JEKen+JPhUBdgNPvrJxbqU2ERUdgeAniQb3HkhGDOLWtuXmnzKr7MzTq07Ev1+pIzVpoi3c8MMbNC
	0W7BOGsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6y3-00000008m7s-1JDz;
	Wed, 25 Nov 2026 06:58:59 +0000
Date: Tue, 24 Nov 2026 22:58:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: RE(2): [PATCH] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()
Message-ID: <awaHMx0k45JIgWDp@infradead.org>
References: <awZqQEp3W5Ewp45T@infradead.org>
 <20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p8>
 <CGME20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p4>
 <20261125065332epcms2p4e172702703233beeab6a683dd69676f2@epcms2p4>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125065332epcms2p4e172702703233beeab6a683dd69676f2@epcms2p4>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 25, 2026 at 03:53:32PM +0900, 전민식 wrote:
> On Wed, 25 Nov 2026 at 13:55 +0900, Christoph Hellwig wrote:
> > This commit messages reiterates in annoying detail what the change does,
> > which is mostly obvious from the code.  It entirely fails to explain
> > why you want to make this change.
> 
> Fair. The motivation I left out: BLK_MQ_REQ_NOWAIT is mandatory in
> blk_mq_alloc_request_hctx() only to keep blk_mq_get_tag() from re-picking
> data->hctx after io_schedule(). But the same flags value is passed on to
> blk_queue_enter(), so a caller also takes -EAGAIN for a transient freeze
> that has no bearing on hctx selection. There is no way to ask for the
> hctx guarantee without also opting out of waiting.

Please put this into the commit log, and given that it is not obvious
maybe also into a code comment.  Please also describe if this improves
a workload you care about or if you just found it by code inspection.
