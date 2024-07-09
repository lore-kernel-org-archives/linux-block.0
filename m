Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65315885E
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524203; cv=none; b=DqAOHlVyUkImkp8NToCqfShJsBP8tdxoWVa7AE6fKXWyP2ja+Fr0TA+yj8bmfZFrW+U6r9AoFAGotDTRETF0ZoMn/oizlQLL0GeCPEcbCelrPFPNEkADExUwHiNLM7oDp2rQjGEX0ZYYRcnSDPw2nB6zGGq/0RZ+nXBNUyIJdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524203; c=relaxed/simple;
	bh=7WJyIspG6KyCfdNBPmVkzl++cFRs2NW/Gbc52RX2F0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uznitCVEAurUX8IV3VrlnVZlhHxrVmGMtPbnw2cTQvOGpG7tIzkvgFbNoYeROk/TgAwtITNXb1pcV0tf30jf1gWKaJzOM+bzy5atKrj6sBuaxLtQwGdBeb7MF7Ke5wxFhZUwB/duWasLJNYREfaFRw2KXxTFvp+/WzgHRLrTHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4128468D0A; Tue,  9 Jul 2024 13:23:19 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:23:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/11] block: Make RQF_x as an enum
Message-ID: <20240709112318.GA5358@lst.de>
References: <20240709110538.532896-1-john.g.garry@oracle.com> <20240709110538.532896-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709110538.532896-10-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +enum {
> +	/* drive already may have started this one */
> +	RQF_STARTED		=	((__force req_flags_t)(1 << 0)),

Last time I tried to mix __bitwise and enums sparse was very unhappy.
Did this get fixed?

