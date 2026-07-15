Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2831AF24
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097740; cv=none; b=CNzcKWVyYtBE3m2wvAQA5hrrJQzPNNti/UeUhsvJQxfX95RRnc4G3Y53nJIVCxl7L5iq82wcTmsRY6k/5ZyDSOHO6ZpzQXfuNnxOYfh9E95+0hCfaZUFg4LyFxX3L7NIxOl60XQWw5jvKTS4Z8csjqOzGO1zX5qmJADjqpAKS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097740; c=relaxed/simple;
	bh=ZVvgexlrf/1s3VbHNs1EzlDNfGk8dfDVB4CJDHyODtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BygV/jQ0m1W5qBDFjOV9/R6MAqkR+VQH1etV2mlVTcTF0GL3EhqnmRvq/5RKbAtJRpPVmHCKOtzoFiypsDOPVJq/g9MA4F6Y8iwsNWU2DuF+VPvYwFe5Ozg2aTB8Eab2MWwZjmELf9t7j6ZMTEioHPhbQRIWF6px9gcaT77m2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Er3Af5iA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Er3Af5iA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+oL3wn4GlbvfiY6ZMzCI1i6UGLWuphTFg3VE/qTImiQ=; b=Er3Af5iAbrvA6wsXLw+RjzvAxH
	LcblBxgBe7AtrI2v43JCmE8AxHNb0TDF0tcc14Txgnb/S7olCd/5AP7rahELYgg1NQ1KtL7AtM1mZ
	gZ2C1ZPbQ0bLzkB4fSm8YDz0sMXYQu0uw/S9GHWnot8iHFFaCskRt0Ken9k3g8Fcf5+rKXs27xJTt
	p/7wpMAyV2C1/1WTI7xP9m/T7+FiXFJwSRje4PC17zyIL7Ip0kP0rvVQEjHri8FztSkUvULDp4VkC
	i1V8QF4vQGSVrJf6727p7Zn7mh+Zyz8HVQWhbRAok8Y80yKfQ3Kyat1E302rJad7I33PUotMVwyaG
	T4QctlAA==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtJy-0000000DvhV-1Fww;
	Wed, 15 Jul 2026 06:42:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Neptune <z1281552865@gmail.com>,
	linux-block@vger.kernel.org
Subject: bio bounce buffering fixes v2
Date: Wed, 15 Jul 2026 08:42:06 +0200
Message-ID: <20260715064215.2934345-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series fixes a few issues with the bio bounce buffering code.

Changes since v1:
 - go back to the previously tested approach without iov_iter.c
   changes that break small vectors
