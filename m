Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF12D8DC8;
	Fri,  4 Jul 2025 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633250; cv=none; b=VcHrsMW761swXMb6m4LqgfT/pRRoMfMm67Uetl305uknWQvIxtg8xRN7Ke4LZLaPA6u4bu9UfPKl+Nvt4u70OKIsBaTE9Gx9JobiI89eicHiKrbVU6aBrzMzxqqSrzofIbKijE24D05Hlfnerm9SmWCkh8kr/9FzbZzUHB70dSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633250; c=relaxed/simple;
	bh=T90gNZWoeIwPdQb9kKnDO8z31RKQxyE2y9k3W8A2j4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENznDwKOABhlNx8+fMPFXnmQV5fPtYlZjj/T7RYkqPgoC/d98Z4aAIjza9UdwpqSID1TsSSIMzXGpB2rU38RGjqQ/V6q5BgH2cgqlpMshJ1vkaECyNSqLKHDTMObI5ps4j7G0orzLm8j9l4vWJAA00DGikNDpDhRmVqiwOx/zRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KCtfqo3A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KCtfqo3A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dF0QLrRnHi3q/gPd8eAQq74gho4ELrDX/tZACh7jpxM=; b=KCtfqo3A4oBwiDisV4+rPARY+c
	Uevmp12uGtkEP7tBjRwuC6ikO8G2y1WkNlYOb1519VvqrWUWYOshNs+LXgGaKim7XMr/2ttxIZRU3
	Fxvr2QCKTU+5h0djOBeHVaWl7xH/f+CFWBwcprqX1PSTvcGljoibqZ6KL6JpobtfDQJc3Z9OiosAD
	xhSy2S5Zh3XJV6yKQ6FaiMazM/j/SSUdRDW5ZwJlCQOdxzZFuPLXFRGQHGO9twyDkvWHKsZaVtY8V
	yTTV48gahvduciOuyC/7qwV+8iF2hkLRvBT0uERbKwENmKa3LP41N7THGe+W7N4dlUup6QwXl8okz
	I1WvluPw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXfp7-0000000Gvhr-3gxj;
	Fri, 04 Jul 2025 12:47:25 +0000
Date: Fri, 4 Jul 2025 13:47:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Hannes Reinecke <hare@suse.de>, mcgrof@kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	hch@lst.de, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2] block: reject bs > ps block devices when THP is
 disabled
Message-ID: <aGfNXbQ5ExO95Uf8@casper.infradead.org>
References: <20250704095036.293568-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704095036.293568-1-kernel@pankajraghav.com>

On Fri, Jul 04, 2025 at 11:50:36AM +0200, Pankaj Raghav (Samsung) wrote:
> Changes since v1:
> - Use mapping_max_folio_size_supported() instead of doing a ifdef with
>   CONFIG_THP

why?  v1 looked better to me
