Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007141A0BD0;
	Thu, 12 Sep 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147190; cv=none; b=I0/6AVLXfk0EkFZy13zEcH3jbiM/qu+T68BautNtNFDB/VjwC5nayaFH5toklejWcXrezk+JCLubwb11arKDJRABm3RxfagAI9CXM7+cygEr+imWWnDAbmQs1YeyCvTAyNqurd1/xymPHRjC8FD26inVP4Gc7qotv+DccH+EHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147190; c=relaxed/simple;
	bh=/26s98bTNvSj5M/BlPsuAYPYyynLUzG06LntovkizxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuT7yBQ0xVZTGR07T/uMn+bYhPVbxLOjGCYCLe6ydh0Dw2tcaz8rvEnoUZ6QZTV9jiZI69FLgS/+C9NVjYFHG3NZKRN5Hw8JsCMB0y2vAXY5hz7QTXzsNGDVbQ+8pyO6p6gLM13cSmAB6ss7VXq5RHeInBkIjn56OXdYLGDq1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ek6r3+GX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ek6r3+GX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/26s98bTNvSj5M/BlPsuAYPYyynLUzG06LntovkizxM=; b=Ek6r3+GXY7P2xOtPBNBq3e+iIU
	abeXNP6vl/BlvYviQt4qrNql39HE1ptkWwZAM50pepyU0RWZZzJ0te9q+sn6CEvsBtRPhG9dmaUAG
	lOyN1DThCTEn1IUaKV1Go1957CAMWdo2iJePECdFesc1TlxSGx/ZkhTQ472B24LtZWKwbF9LzTR+W
	U3bCxjB7syPLuuHjs7hWyq7Q4a197OjZkR7I3ia8v1+4JF5P17M3ta/iDSV+YDCNT8d97KHBrnuPG
	FiJ+HofHqnEvQRJq9TUMdOkkVYZexIb4J0ZO7D+9OqVB0SV10OlUiD+KVatasQ37yVUOm+RqgInEG
	k53qh4jQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojje-0000000DBQH-3YY9;
	Thu, 12 Sep 2024 13:19:46 +0000
Date: Thu, 12 Sep 2024 06:19:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, axboe@kernel.dk,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] brbd: Fix atomicity violation in drbd_uuid_set_bm()
Message-ID: <ZuLqcjFuPtmq_7Nj@infradead.org>
References: <20240911091619.4430-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911091619.4430-1-chenqiuji666@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I can't really comment on the code here, but the subject needs a

s/brbd/drbd/

