Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA58130A49
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476413; cv=none; b=D829uazjr6Jit3Yekm8cHpyM7flwUdGkiburNTKgha9yNRyFv6uDK2F30wKVAyTSoRBVKgcgSbOBUfGDLe7zezWRf0brPk3yFJHLXkSASjCi9ntQKTeLFeGloR4SMxJ6eFnD4vEqVBS2zgfcvsSCyF3MxtH3X06TG+mf5/9od4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476413; c=relaxed/simple;
	bh=fPJJ9TP3Q/wiKZi49/63345U3OGK7pY9el+rt/LGr+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYNSLAeAaAYvs6tgUQLeK1p9tMpsXo7Zur/rezy1t28ubFxrlw7duoEcL2teHuHG16G729xseK5Y3BBOE25fQH5n8f4jpAkNEXaLShW5LCFDTQ4BtyOi1fp6TxCdnB4eDiyse7IMk3wC7B6Kr60kajsuVRvVGKhs+mvji8dWoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3mfR1yKP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3mfR1yKP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fPJJ9TP3Q/wiKZi49/63345U3OGK7pY9el+rt/LGr+A=; b=3mfR1yKP2QQsuN3ut2ufQGCxau
	FU5iBdQmV5RVedyzweE7A2DB91jZTGeSc5pAXBTPX/lNifQqbaRmyJFddgWSH1FuJFC9iczPFOC18
	SLVq309F/qQxtWRsCMcgXTw4tW2DF5hr79whON9Q6isuMLxf4a1PncFE+rkiZbyezGJk1tZ164cnm
	IzgzK9TLVFn84JX8A213+JsbuQaesJcY0y86oC8glBWMG97KJ0WrTpbTQgPCNjt/4sW4HUehyu9g5
	4VypTb8uFKDH3I2wo0hVNgU+LzST9mrF9VMsBVXGGiUYtkeMFglOyfmQyDN50Nm/npfsFJKZH047b
	aJEyGIJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEM4S-00000001CaL-0WT2;
	Tue, 04 Jun 2024 04:46:52 +0000
Date: Mon, 3 Jun 2024 21:46:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] README: add dependent command descriptions
Message-ID: <Zl6cPMysMCyHHAkL@infradead.org>
References: <20240604004241.218163-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604004241.218163-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 04, 2024 at 09:42:41AM +0900, Shin'ichiro Kawasaki wrote:
> Even though many test cases assume the availability of the systemd-udev
> service and the udevadm command, this dependency is not described. Add
> it to the dependency list. Also add optional dependencies to other
> commands: mkfs.f2fs, mkfs.btrfs, nvme, nbd-client and nbd-server.

Should something check that they are present and warn if not?

