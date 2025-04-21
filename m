Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A24C85
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236157; cv=none; b=XyLfquACDVUE7U9LP2qi4IPdLEPhb4HEE66p3yw5XDize4zxvKM38x/VpTyz70VAdNZokSdYNjFHAS3S6kRN2cb8rStMl0vXp0gojz7IyIHKkW9MeLg/UvzgMUbiXJp2dR0Pl1pp/Er8XnnLMguyZO/xhFLli5xMgfxBlsGTb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236157; c=relaxed/simple;
	bh=M04FKXpmAhhpbf9TRM7btOTqWOWwbhlG5oB6LPnQf0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8QPDgNBCSM/568ExUGP+3pcqxQX1kLxpaC8V3FGRBk1a4mTgAJWIcoImfekGBZlxLO5W0g9hz+/K1c8jkcLeeE1N/jFjBwd0VQ54hcWUfG8ceR2ycvu8TyGo2peAoQKyylD0l+FvEn8FTK5gyYD6nEJ6CxzkTePbKQy2UJnezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t5pFlZTm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t5pFlZTm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GEUIWGfS0WripoL8wpY+5KKfh08VQUcucL6uciGlk1A=; b=t5pFlZTmV8cM5L6U2kx1n8f1LI
	JXl/yEVbJ5xVow2vWKYd34VRe9Map+hA0LV13BwyIT1owND6VGNz02Qba8TK1piOUuRI82u3omtfW
	dc7BFZayZ84Tg204w8YxTPNvFLhqS1o1Fq8bivyq4naqz7PemKPWjsMnoRUMjK7lAlVVox3aSlhhO
	m/z945Wg1WrA3ug1SR667Ero/t+tPDTICb/sDng4f1GL5S5SQxghFzBjDQzbMnNtNgPAYTFiRB9n0
	WX5Y3/QMhB6GrBsx9o0MTNe1PFeCdGti7yMc12bYanuVfSwo2H7Pdy/ANB41bcvSnTJquepCStugK
	a5BPlbRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6peB-00000004Drw-2kwZ;
	Mon, 21 Apr 2025 11:49:11 +0000
Date: Mon, 21 Apr 2025 04:49:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: linux-block <linux-block@vger.kernel.org>
Subject: Re: Block device's sysfs setting getting lost after suspend-resume
 cycle
Message-ID: <aAYwtwV7KEQ-GSbi@infradead.org>
References: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 19, 2025 at 12:16:35PM +0200, Holger Hoffstätte wrote:
> I'm reasonably sure it used to retain the configured value.
> The same also happens with sd (SATA) devices on a different machine,
> so it seems to be a generic problem with either block or sysfs.
> 
> This is with 6.14.3-rc2. I have unfortunately no idea when this
> started to happen - i only noticed it now. Will trawl through
> git history but wanted to see if this rings a bell with someone.

I'm pretty sure this is the atomic queue limits series, and I'm
actually surprised it was persisted before as we don't have separated
hardware vs user limits.  I'll dig into it and get back to you ASAP
after catching up from having a few days off.

