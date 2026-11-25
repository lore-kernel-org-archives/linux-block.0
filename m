Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591931;
	b=qN2xg55b7vAXt0c5WBl2F3utKiZqZqJOvLVC3020Lv8Ih6CTpD1LUf/Bdeu1Ya5CUUJ2
	 xAqU8aWE2vh5EkzhjYvTnoRmkuyRrvqyYDrxckfaQXmhxlPwPc6xWtAVEJZejPYhCAHqo
	 W4UQSqrwZANjZINYA8mmQeExErv5d1tuSxH05XNbopkU2GPNRAsBePGsXtVmrcAiWPwEf
	 mTZI9ScJsHgdB1cjOJWdV1nlEmbjsNhvU8JuyTnLauZfs3M9dZcLK5bXrZPh+c8XAZuoo
	 ZjLsvlwcKP/z4MfMKP6RkYfsMW0at1KnkyGP9P7IhYXi9FRlTpfYD8V6S3gfecW6dJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591931;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-SRS-Rewrite;
	bh=k22P/kSX/VbgYHI7J42M8nCRsBQL3aPOy7IVv9dF/sI=;
	b=iYiiT1pXBui9ylz/32SdMXcQnaX7396UIkMNfnjaIwZ2jvJyhaTvXc3+GDx8ICI4F9/M
	 XZLavPLYYfJ+wGYw0ed8bJe540m8GlgaDf8noJoPTiH4/5JQWsjRLUsnd/vnXizfydZi1
	 F37Gd6n4IYwhBwr50xR/+a4W/SKFRIsVV2oDDIEXT4sjHT2UhEtfpseqX7Xf9RWOa3kGh
	 yT21L/8ZzGPgehdOBtgvYndtE1vGOBa0DdViYfTedQqdtBNxFR/MZSfue2aQnVfVK54wq
	 H6O4tuCRJktyxVJWmwP6QhE3RugyUKtw+gpLyhFDtXDjgNr5Gji6Vzd+1LG3ZUZf5rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=llFSc5wt;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDB606A321
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2EDB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=llFSc5wt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=k22P/kSX/VbgYHI7J42M8nCRsBQL3aPOy7IVv9dF/sI=; b=llFSc5wtcw5NRVqYmnAcWOcHha
	p3dRi9PE3x/3X/ovDLDjP0MNY5c8QF9fct+SNru2cTDMbDW/Jz1u2o++w7ImKe4xPp0iAkJHAgdGW
	p1fneX64w0YUWr6H2SxXz5sZUPJx5M3XHDqqGN1i6yu/406L8y9Dr159B2bvUQSqtxwM2D73yThDC
	MCeAt5qApytAXDbJE1sWeSYFWK61QJPJWgJX1S5gNesf01aOT2OcmccjC2TW1I1DXA36fZ9WaPaer
	f5g0Tzc9b86fT7tbV4334cqGMVCYRj6eUkBXBpwL1Vbkhzm0DmV5Fbgku2aZhejKX/aLqpAoq7+Tx
	7ILhH2zw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW7U9-00000008u01-2axy;
	Wed, 25 Nov 2026 07:32:10 +0000
Date: Tue, 24 Nov 2026 23:32:09 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()
Message-ID: <awaO-btpePLcf10w@infradead.org>
References: <CGME20261125072500epcms2p4dbf32261de0ff182820c3a5ae8daec38@epcms2p4>
 <20261125072500epcms2p4dbf32261de0ff182820c3a5ae8daec38@epcms2p4>
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
In-Reply-To: <20261125072500epcms2p4dbf32261de0ff182820c3a5ae8daec38@epcms2p4>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 25, 2026 at 04:25:00PM +0900, 전민식 wrote:
> >From 6693953129c96668a266d9c55476eaf75eb3bb7b Mon Sep 17 00:00:00 2001
> From: Minsik Jeon <hmi.jeon@samsung.com>
> Date: Mon, 23 Nov 2026 16:24:17 +0900
> Subject: [PATCH v2] blk-mq: scope the no-sleep requirement in
>  blk_mq_alloc_request_hctx()

Looks like the headers got duplicated into the message body.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

