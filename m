Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56E3C3C16
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193642; cv=none; b=cBdMhyxwsAsOM1jRrwBWa+kvzyzgNUcmQvOuHWQK66skx+Gq35h9g9NjKL0qRkmfrKoMghVOfanWHcYZAL9OsP9oc281CHaU2BdYsRUqQabXDdtYK+zdclmrg2gWomb558ecuvOBHbFevYnaAgKtdDI7ZXSMsccRu8fLKonsUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193642; c=relaxed/simple;
	bh=XEjPBjTgHO6BcnSXeCk4nAUcSApgQSh3ypo9JLbSJcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaCp1WopapBxyo74xrrHHJ7RU/aTwCIaQLGBAiBgeNhKQWGZpV99LmlIBS3h38Ae5UZb9Zc16PRU96T0K3Z4pLDVjF89b2Y9+4uyJJOhOd28kp27SI2aXZRQz5ZfqD47FP9zZnTMX3aXOhU8b5UzMljOj7yG3Jr9VZKgq+mTtB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gn1xDf8X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gn1xDf8X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HtWv4AHcE+MVeAfnT5DsayLGN/ak2Hap7SADVNqJWto=; b=Gn1xDf8XHjL4HA9yW4EeobwdwB
	95qo7xxIpJ1od9mvuW1LsnPN63l5EsYKI2FsVLHX/ZgYATEFZtzw3oRJ6uXIro7VnNPkvP0SuFA3C
	fsDJYmoudwqcdYIPnbcPpxTSLjzOCc38ZdGnbp/jSSmuNBRYaC3FtfdZWeLoT60+Y2KsH3EXQpC9i
	9zI7WSsyrnNJAOpgmg4Bt78oUEm/AFmHGQLVkGcv6gN7CNzSv19s6zlLR7xN2yRR2V/FluvYPBLwm
	nJFEaZN3cvUO1ih44Zk1a7FInd4ezGjIfSRaaT7+cmMQY2adH+7Mn/c39eJhT0+nMUh3iC7HMqDMd
	qfvV0Xgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIGm-0000000GqTI-2CoK;
	Thu, 16 Jul 2026 09:20:40 +0000
Date: Thu, 16 Jul 2026 02:20:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: xboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: show operation in error injection rules
Message-ID: <aliiaJIvu4MXzAHX@infradead.org>
References: <20260715073341.95129-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715073341.95129-1-liu.yun@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 15, 2026 at 03:33:41PM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Rules listed through the error_injection debugfs file omit the block
> operation they match.  As a result, rules that differ only in operation
> are indistinguishable even though op is mandatory when adding a rule.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
