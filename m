Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211F4C70
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962705; cv=none; b=bAqLe2q5WixjP+ThJb0BLcXbwJTRAXxYQjmhMo0pkpPCdB+T80IPxmMTgU0F9GrRS6DHKTc6w+k4diawmUQWGWxC6BlcjQqhKZCl0OjfQXrjYm5IPk6utWDTKguu9gh60hOUxU8YzYDFNPQeAjIeFz1ihB7lRIq6GxljuaANhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962705; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=engAST3p0xfIRuQKVn5cNmN9N8AuwPFfLfAdG5oxZHzEJSXmq51km3bWheiCxAUBkxvCW+teOaAK2q/qXltwlEet8nYDGmYvum91zebCsKbpT3oSxPiw89vGsBtP3bzyRHLdPi9SoSulrciell3vFqlCiEPv5bIhqmfR9zeLLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+Zb0A+E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+Zb0A+E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=T+Zb0A+EwKnDZhM4uDQkQY1tu3
	SnA+//rNLG/E4aGKDcL+SJHcDuOWgn4fzj+mhMR4r7EUb5cz85xblcAbqSiXp/mOTZ9Q/8aKnVsmu
	RyTPqazE484eeYKVKur5REjjTkwmD8g0DrRP/fOp48qorslE1sDSOwcNvYMDNkVsgYmWjdfcyJMQk
	gNiuvSzNvUxx0++jgifEmklc8zjTMtU6q0ZmlKF70ExA7nWxGEYGn7p6qB3nn4j4qfXMBR/r7WgjW
	ck/KOUdE8K0mxKaWWtDZIBdnatId8HEWXyKg1D2/XKGQg1MdjkSakiAxUXZcFFbcv659abG7ZXMfo
	I8JuPCrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swM2B-00000009E3H-446s;
	Thu, 03 Oct 2024 13:38:23 +0000
Date: Thu, 3 Oct 2024 06:38:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: remove 'req->part' check for stats accounting
Message-ID: <Zv6eT6_hnki0cSSo@infradead.org>
References: <20241003133646.167231-1-axboe@kernel.dk>
 <20241003133646.167231-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003133646.167231-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

