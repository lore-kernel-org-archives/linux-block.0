Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582193;
	b=LmL7X0V6EObkvcziQSwUDtx5SnTxD8mDgXaWfDxBwP4s2+P7NIsWE4K4moacl4n0bRx/
	 4FEpkkhOCZCd4PWhWZcAx1wT0fPhpM3EIYhi6Ab9e9eYDQR5gYjkRkrjKJ/ZmRivwywSW
	 5LtJLFJBx+1uHN8prLW+RMpujec+20UX8meWGEgIVHWmf/BxPLK7+C9yn0bheOhq125zv
	 1mguiV1W3cRV0YYHMbjC5KYqLvVNURLI40LeULBo+ZNGoRiOUJXmDHYGs7o/QvU/+rNmV
	 PGqBCzlD9eQc3KPXtHZdPpYH9t4VwyzOJNdPkN71gPTfn28PjkrpPEkv26l3IekGEEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582193;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=iAtWl3ePut9bU4J1pXfBSYnkdXkYmaA4x+A+a8E8r4fph5r678Iw1+Y136HY8rF4xq/W
	 m7sjb8iNqmpGLOK93RaloAVM+MWVthYj3DNP7dTO2b1p4YiAtGRoGmHiyAf2nAETDVHdB
	 ybk7UBBSw7KgLwRDEXELAkVCgLFE9ppXNjauBF9joMiersj3cJEtdRrsmnl4lKwsiNWFU
	 19UC8RQewvtcKZaUM4aJqmK0oYgTpxXUzzc9nYalv7fAEEl9XDybzGZ1Ycv601oZVvhff
	 lqbm0eLEZ9cAXE6nOS1ppyPKtv9ecJ0OPi+mIfcte996Tlk/OmtTKTQciKfFJh9C2jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DgWwtZIk;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F288606A321;
	Wed, 25 Nov 2026 04:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F288606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DgWwtZIk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DgWwtZIkxXh00d969uwVXzoHd9
	JoQkoJFiq4O0/UDxwr9g0zMMprh/TVd1AMAJwL0a0oVcbLUf3cvPNG1ZrkdwQ13u02HtsxGVUmM0N
	jab8ve9ssoT6ccDWpHjBc1MBYuvrSxAv8Ajtc8BnpmdhQ6tItqF5V/jTsUqnRdRtgD6UZDuFLjVox
	WKg4TX57mgr2Dx0fSr+nhivnbvL8m6396QHWt7by98dKNua1aDx4EwX2MYOSufNraeyjWMz3pTums
	jRqAANaj2n29DgKxHp1Dk/DjAXJoPKGNXZ2lg35/82t0u9dcHac8tDnFe1VsVmcL4RuEWOOhj+u58
	fNTrPfwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW4wz-00000008QFb-3lfR;
	Wed, 25 Nov 2026 04:49:45 +0000
Date: Tue, 24 Nov 2026 20:49:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block/t10-pi: deduplicate
 blk_reftag_remap_{prepare,complete}()
Message-ID: <awZo6f_htvceejen@infradead.org>
References: <20261121042743.1139584-1-csander@purestorage.com>
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
In-Reply-To: <20261121042743.1139584-1-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
