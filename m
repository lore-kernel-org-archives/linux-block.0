Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52F1F583D;
	Fri, 28 Mar 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159321; cv=none; b=fWt8LgcgfUl0ShRLl844CdxnftkDheH/QN663VaJiWM7VxbHQ9AgfMU88Hut4nEZ30h038QW2G+BFovAxJ1vZtNW3brxRR9X8WaErjBSOZcnxVGOxttibaIwKn2O7bubd++/astseSrRKm/khojU4rsSL6TU1JOXEeQZDbjzTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159321; c=relaxed/simple;
	bh=FOllFKRqF5bBq2cR+69jE9OQJJq3gVw/gnpRvT34u3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qznWQWXY42X7Ea2V9L93m3WtpNG2o/ZI1+/xkqAjJ4rcd45dFyLU6lm5ZiIv4iKBhVwU2TtzHplEC19v2ngD8Te3QMVSKv2C7IkrooaaWMCgV+EiVYjoqJaOKRyTx9/A2cw3Vby7ZwH5CHVDet9vNu1SYaNsP+eHWZcDudFC0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A73a8cFT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A73a8cFT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JbS8da8AxoXIq0TnjhuaWcxM7AcovnYAibDqa/WW/GE=; b=A73a8cFTgja0rTt+bwsiuXHMah
	MSo5fz48Pcca4ncUIm+L9F58YvCMxFjj/4kxLrQM0yELBwHpcukBWE0n7sU0trsiJwGb4ner9TTbL
	L9tnZJFFC3xobtAZ4bCOgv3H6CaTMjL4fVVeonUkJuP5q4MPmhFeDNxhP/2V3eaySJr8fcQgu2HZt
	nzM2a2/Zq+qQyxxJP4AVnr9twqXd19FdnUpS8Atn2qrK+YnkejoZQWakaSvfXbYs2ruTmYU85Y5j9
	knp007yARnsYD1PowgGFtePDcD4NQAGeA5JjUr1hKV0GhNVs0W2r2GQjPPSmQH6LpxVSLAGSBJb7e
	l/9sFMHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty7Ms-0000000DBIe-0bhL;
	Fri, 28 Mar 2025 10:55:18 +0000
Date: Fri, 28 Mar 2025 03:55:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fanhui Meng <mengfanhui@kylinos.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: optimize sq_hctx assignment
Message-ID: <Z-aAFkOm0KtFp9b6@infradead.org>
References: <20250328031321.790317-1-mengfanhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328031321.790317-1-mengfanhui@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 28, 2025 at 11:13:21AM +0800, Fanhui Meng wrote:
> Optimizing code for greater standardization.

not sure what is an optimization here.  I personally really like
initializing variables at declaration time, but it's not an optimization
and without other changes it the area this really just feels like churn.

