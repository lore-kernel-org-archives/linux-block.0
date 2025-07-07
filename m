Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423513AA3C
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867718; cv=none; b=rqrhvaXUJfbhqstq2vgPCNHT/Fh5W4FDAvQyQNDV7KhYXlhwfv1ZVsz3fwQ6Qhyf4JdilhYfhTbDOcZ3hKLWwCX9Zch7l44XZB1MZ3cQXLAuNJkp4pXXfcfFVjajemZwsSBSfFokJzhEvV7pgCKhLxC1TKoe2I0S9Chv7mzuGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867718; c=relaxed/simple;
	bh=KvhKuOUZ8zpX6OZXdzMU1NE9kvVb13C8v0ut4mocPhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaD3hajm+zilxWDlSL27XueKtfuwtl8pEniEAWY3ceQ8E245KZAaxSddUjyTm8LA8LkLgKRihUNC7RkmV+5/rF4KPgvoik/jOrmD2INyzvy24+NLInkKPH5pjWo8kQwLjgD96TOX+5WM/jbB8zJJHof+Zh9YhnSCSFGO/Pewfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dWAJ4IPV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dWAJ4IPV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KvhKuOUZ8zpX6OZXdzMU1NE9kvVb13C8v0ut4mocPhw=; b=dWAJ4IPVV7omuQaJkYGpVntRkA
	pGVN/iCX+2O5nLvWZhkrpSSnDXySE2jdiaEM+kypN9iYS8/RnB5Parvl/rTjthLlYCqySIK1ov2mB
	l0x/8l05rzK5rAJx1diLkTGSnnSHPAhabeGdXiR9FrU7wcsnmRNNpnZ3KJD29TnjLaJoC2SwUhXPC
	/kKXE8yr7/ElyeVcf/Jzej7PitdSyGRBGPWWFD8bObRH9c48t8kOVGuhdRvLgFJL4vdSLDw7MeoJk
	cScBRVE6ZLwyqJPsSbmFNkMsyUk5L/QVjvR0hlKWTayr9fjY0ImEdWvkEwGcOd0C7cldASSUwzHx2
	0q5Bm0OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYeos-00000001UCj-2iy4;
	Mon, 07 Jul 2025 05:55:14 +0000
Date: Sun, 6 Jul 2025 22:55:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove pktcdvd driver
Message-ID: <aGthQvKMYKBcHkwT@infradead.org>
References: <dcc4836e-6da9-4208-ad27-bbd44b3a2063@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc4836e-6da9-4208-ad27-bbd44b3a2063@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Finally!

Reviewed-by: Christoph Hellwig <hch@lst.de>

