Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700007;
	b=PLoderf7FZ+7bvZ7s2QCb4xcFH3pz9SNMPTngacaR5CAHtyU8ifBrRsLz+eKg//+2HJ1
	 xnY/dmliNt0yENqWYWg8wrl1b0iUoP1Ws2d14kWXrj3jI05CMjVj3bN4gE92y/OPy4GfK
	 sUf3AGfl/N53B+rFQ/aj48vKJM8FkEGpdSfSVeYEF9iuAZmw/OcHhEkdTAZuUOU+Dtd/c
	 SP3HdijDNpSWoKpMDhVJMOHw+KwxrxLQTq5kIvbhUaoygXRW0grKFWeiZj9zpD8c8RFtp
	 8SAkVLZ8/LmzcQlNKIj1os2nDLrXAipgfocn9+qulTKzphA5aMkFYQdIjlPBQmgKMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700007;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=pDPcRYAD1Zq4GsCVSZKQUb+7+o7VG/jBpgu0WdZq2b8=;
	b=1SMi2NBYqQdNEeYk0YsPJ53OBTYdx4C8pSzqcSsi/sq1svBlFfg4eQ3uCE99WaDXVg/P
	 NkWUntoLJEU32fWzmKlbYmv5+JwAwqP3p59myuXL64ahbD/DsBoQdZ+SOSTWwsAEvhR7H
	 HYsqivFEy8OMEEc5Hv2gskh+Sl7S7i0FdeuZZT+SyNfgrixkEBFewmWH5FyzCu4e6XEaQ
	 sNZWe+Ps6hGhfCyXteBqRl+Mq5tT4tcc+zyzaOSxaiI5Wjcskwx+R93Rw/Xl2ENSH3+Yi
	 9YmOcwG9bXUKBm+XJl2dTK3ajoPMQyvxlqrRIOD0Cpk9Vw/NBBwxYTGC1rk2LQ4C8Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Cc794FKY;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F8606A803;
	Tue,  3 Nov 2026 10:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 585F8606A803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Cc794FKY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pDPcRYAD1Zq4GsCVSZKQUb+7+o7VG/jBpgu0WdZq2b8=; b=Cc794FKY5CB1dhp8HTLb+B5M+r
	/maz7vG8pDFlw/RRRM5ckrPNUzkP8xTFFzHg3sPjzShNbeyof3GG7FJQYJECozhZxOG4XpVVYW3bK
	3eEMO6NIjDPP0gAP8Ugkystx+fDzWolCkXePbb+8SE13jFscDf9/fx7enzhmmOMiderFkhdXdrdTT
	LC0gQrHsFzXn/xYY66+SazzrOFY7yJ+jSiYTaTvKtYeC+q4Vu7QTBbSZYwkIUAxFM29uH76sMQCfr
	28HfleVB5VtYn803Dmb6elWqBpMaMFi57FhNa6sN4Aq+mE3NiC7Gqz7KO2WJ0GKONLjdgXhwPgT7g
	a5rcVQLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBJF-00000001roV-3cNi;
	Tue, 03 Nov 2026 10:00:05 +0000
Date: Tue, 3 Nov 2026 02:00:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions: aix: fix kernel-doc
Message-ID: <aumwpa9S8x_FB9Tb@infradead.org>
References: <20261021110710.1721073-2-manuelebnerli@mailbox.org>
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
In-Reply-To: <20261021110710.1721073-2-manuelebnerli@mailbox.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 21, 2026 at 01:07:10PM +0200, Manuel Ebner wrote:
>  /**
>   * read_lba(): Read bytes from disk, starting at given LBA
> - * @state
> - * @lba
> - * @buffer
> - * @count
> + * @state:
> + * @lba:
> + * @buffer:
> + * @count:
>   *
>   * Description:  Reads @count bytes from @state->disk into @buffer.
>   * Returns number of bytes read on success, 0 on error.

All these stub kernel docs for static functions aren't exactly helpful.
Please turn them ito normal comments where they make sense, or otherwise
just remove them entirely.

