Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60722288C2C
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023964; cv=none; b=oncIoUu629lpDYGfltFJbmirs/RRHzXgJJbqGSM3s+mRUrhAwXqLV4CM5Cd1EbWdlXSgJMrwRWiSHuePpIgAjEwUEZjE7GbXm3+evM1KAlqWLlj+zlQ8sOGggnss/3L6rNjFXKjNc5qgSZkCUW1e2gspX93jmLHFGoEzESqiYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023964; c=relaxed/simple;
	bh=/ilCW2xCbY4lwRFso6M90vzhoPUVltPSDyIfEyKmBcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQzLHSx/hZmrqTeXB+S9NICmAkfEdPlaZ/4QGI4jOoH611MskVQ119e5478DfRQav23EtilMp9tkUup91BIuCYo6Cq2MqEbngEgxaoxSZm43CJBcQ6LQ7+chWd79b1DliCQ6VhA8vBWjwaDYwNlXNOeMWrhjfWDPFfLePgsZ25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sYH7XKx1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sYH7XKx1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JPqbp3yaqUhFiYOxm6qv/ceOF6xxsDbADufNjCM4fGo=; b=sYH7XKx1QhlMTAsBYeCgnPQTic
	AMP/9Rcc0D4k9N6qj7fgLLSI+ej4oVvW63eAvWdKxuPEQJEuSimz7XVR9tSq+TjTk5MwpZkJZH8bX
	FVc5kg4C87XKDsVT98XVCEBHz+oQwpchsKnLZXInKjj05Sd0jle2yZQXE+Dc1GTIMgwY1ugnfXheN
	CtUyjD6Aya/i6IyqQizcS8pc60NP9LHsTESK9agKiuFqacvrbywD/ot4vHA/Q4U6Zg3SJ8CcB8Mci
	uMQsy+iFrBPNhioY+Ug4Q4iyaDyHcTnlUGMSuA874itdOxcVrpKxFP3PfJiRGrcZYDbbArLXZLtG0
	IYuaGceQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmq5Y-00000004hVF-13ev;
	Mon, 02 Feb 2026 09:19:20 +0000
Date: Mon, 2 Feb 2026 01:19:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ondrej Kozina <okozina@redhat.com>
Cc: linux-block@vger.kernel.org, gmazyland@gmail.com,
	jonathan.derrick@linux.dev
Subject: Re: [PATCH] sed-opal: ignore locking ranges array when not enabling
 SUM.
Message-ID: <aYBsGMWq3Vzhpft1@infradead.org>
References: <20260130163402.571854-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130163402.571854-1-okozina@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 30, 2026 at 05:33:52PM +0100, Ondrej Kozina wrote:
> The locking ranges count and the array items are always ignored unless
> Single User Mode (SUM) is requested in the activate method.
> 
> It is useless to enforce limits of unused array in the non-SUM case.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

