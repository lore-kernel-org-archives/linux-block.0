Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030B2208E
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074768; cv=none; b=BtnAuIUknE0GFv3B11PKXEvrEMiRLIzVms85/HtWtVLkhMt5dvz0lOGLe34NYQhtKyQRAZEd7C9Ciw5asksNloNvXz3LpQ2yMmSkIFRXBdMD6UEfY1nNISY1zaqep4Y0x/aihtXERfw9b0CaujrYasQzUtYRglEP4TCQ31kJQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074768; c=relaxed/simple;
	bh=M6WA8QMFafWpBW7EHeqxEmLBToawUbpNHQLradgTt4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiHDJjerdsVWiQmi1LzfDT5A2gbH2SF6oHdd7ayB2vvROdmGrouEK+JHHehMTlgeH378UEYYdyKPA1yGOTpM/ouxGT6D7h/l4G7XZSInVKcttf7bxhiYevNJDYHAQcwEtIWD6EOJj2aMvBUq3BPCDogfRFe7CUeakOWIwUkJoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A78DF68AFE; Thu,  4 Jul 2024 08:32:42 +0200 (CEST)
Date: Thu, 4 Jul 2024 08:32:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: t10-pi: Return correct ref tag when queue has
 no integrity profile
Message-ID: <20240704063242.GA21732@lst.de>
References: <CGME20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e@epcas5p1.samsung.com> <20240704061515.282343-1-joshi.k@samsung.com> <20240704062649.GA21024@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704062649.GA21024@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looking a bit more it seems like never actually merged the SCSI support
for an interval_exp smaller than the block size, although I'm pretty
sure I've seen Martins patches for it.  So i guess we should just go
with this patch (preferably with the fixed Fixes tag and a more detailed
commit log) and then sort this out later.

