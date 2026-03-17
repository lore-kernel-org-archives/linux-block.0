Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3D346FD0
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756504; cv=none; b=PMHXQTL8IiHC3OlhbIDIsirxrQicCkKkRDJ7DnvY1kJUYKaLgHPSeAaZvK+ldpiKkHCjv56NuIzDbncbK4MNMfG39T+wxPKERGDWV/EtAb/QGgEvfyDH4SSFtpT9OE1iTKszrYhy2mXmKg5mnlBnxfJG2VxAtqoFMAKuR/T/FfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756504; c=relaxed/simple;
	bh=bej7SLdUkT1pBlnL4fOeHE2Q+QLCOpSo5p0o6OGjxXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkzHYwN4sAtaTIT4V6Oewktvxrt8SACbIz4yS/xvIjaqmeQhIc1y7I/KYqw0T1YDTZyjsdvsLC6VxKO9pnnnWNZoyjebhxYpnvzdFhWiKFo8Xx6gu84ab9xRE1cTpxYXJedLTsV+Zr8UgutjkhJHdmuadr2bGW0KjtCthDqcREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D911068BEB; Tue, 17 Mar 2026 15:08:19 +0100 (CET)
Date: Tue, 17 Mar 2026 15:08:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 11/12] zram: Add lock context annotations
Message-ID: <20260317140819.GE2670@lst.de>
References: <20260316200901.4111651-1-bvanassche@acm.org> <20260316200901.4111651-13-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316200901.4111651-13-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> -struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
> +struct zcomp_strm *__zcomp_stream_get(struct zcomp *comp)
> +	__no_context_analysis /* acquire related to return value */

Which should be supported by the latest version of the annotations.

