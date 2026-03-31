Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF63FB051;
	Tue, 31 Mar 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969364; cv=none; b=PeZa5E3Lh+TMp0Edyi0TH0jP2bsxAUrPT0EKnJxo6a35g5KAbMIDBahg4RsfGWdQFloOBwcbew3+y1S4PMLuwSNisv8SdSJnxX2YLdygZ4A+Ibzk5MdCmuqC6j3uo+CkLuFDV+esMuTAuAazEw8jonBmrkdadLsru3GXZuUJrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969364; c=relaxed/simple;
	bh=TnFqPxS+nne4CNvOdZqaK21h6+DMjiAvm5cHKnlgihk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjQJhEJseommB3sFG1qdebSFldO37jUFF4GSjroV9qdiCT/b56j5zBvDBS/AqBA5r+2Skszwi59IwPNeIClNIqwHRMvyakEPOhZHT46q/lsiA4c9mDYHyhP/z38zrTDmnzH7amvACRWCyrcvXjCGUSZJkZAONViT1oYvn1ijIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NfaVlKpa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NfaVlKpa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WASmCAWx1UhfnKlYBZL3c+urkfeQsSetCQn2fwEVnx4=; b=NfaVlKpabFacyAs01YZ6CnLmLo
	RzRIY6HG0V6sl2ORkyPgai8L9Nb/vs+hFfpk9vwLFiuKEKZKeQ5aXfrFaQuBlNlYwWyrxUwcvY2Xy
	DIVzLLtSUHUyNYrqB98PPJUcrc8flWGEjRHzHv7AGqRuwMBif8GumfIaNbgEs8jeV87LLHcthBTva
	6pgaGP0awiy4tSLrQFudx4FMjbi2GM3WOlwdStOIaXMQinrWnw5eJuhgmYrOgGVgyCExr0gETG280
	XOIAJw0S5b8FqLenuWgQf/rHp/L6sbkuyiSifcw4xP4CgDdSks0xDp8KV9Gp1jf0rCQpR2RQLIk6y
	zWxaSpbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ac4-0000000D8u0-0i6K;
	Tue, 31 Mar 2026 15:02:40 +0000
Date: Tue, 31 Mar 2026 08:02:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
	Deepanshu Kartikey <kartikey406@gmail.com>, axboe@kernel.dk,
	dvyukov@google.com, adilger.kernel@dilger.ca,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] loop: block changing lo_offset/lo_sizelimit on
 mounted device
Message-ID: <acviEBik3OrtfiRV@infradead.org>
References: <20260331054648.4548-1-kartikey406@gmail.com>
 <act2Kh8u2I5HPVlv@infradead.org>
 <20260331122408.GB74409@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331122408.GB74409@macsyma-wired.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 31, 2026 at 08:24:08AM -0400, Theodore Tso wrote:
> Do we expect people to seriously be running with
> !CONFIG_BLK_DEV_WRITE_MOUNTED? 

Yes, it's the only sane option.

> I view this as a syzkaller noise
> suppression only.  As I mentioned earlier this option will very likely
> break grub.

Yes, the horrible things grub does won't work with this.  But I thought
with EFI-based systems people had mostly stopped using the access
to the root file system misfeature in grub.  And a lot of specialized
distros seem to stop using grub entirely.

