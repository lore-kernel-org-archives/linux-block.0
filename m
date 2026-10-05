Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DE374A0E;
	Mon,  5 Oct 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189765; cv=none; b=R4Ck1Ya7iSVv8kEH29sULCRGKF8+dD6cn1T2sL76k+7ubpirh78dgA1gWOyAZWP2B6hLgEOv+TqB3+DkV4kEm7RIfpdPV/6wBLXD7oFAkxunydecy7ilfExOOwm9U5CD5/YClVWoFoioIyqXrzdptOrzJglE/Kdn90gWwh5nWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189765; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfLUnz2tVE1bxBOnHnK4bjAY4FGSxUyYyIDSueAUsNB2CLJzvZ3WH9idy9tGFPaiZ5/bO/7j8WOuzMwTmCrSZHhnGjo2ZI9SUasZiKRFoX7nXQAFtk6WeSqC0151SSf1z+GV8+mWidYDwmMeMn8Fs+hDyrBiNP0hh8FzZ4mLIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B7F7368BFE; Mon,  5 Oct 2026 10:42:31 +0200 (CEST)
Date: Mon, 5 Oct 2026 10:42:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Fengnan Chang <changfengnan@bytedance.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix kernel-doc of bio_copy_kern()
Message-ID: <20261005084231.GA8692@lst.de>
References: <20261005064848.2879898-3-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005064848.2879898-3-manuelebnerli@mailbox.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

