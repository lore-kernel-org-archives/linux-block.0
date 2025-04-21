Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB001263F3A
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238821; cv=none; b=oNZGAON9PxpNhRx1+PO5vui74S+DnpVOzJ9BLW/1+KSvOxatMeCWpP5iHZeYJYKJ5HqdZQfDyb2JBOiWOUeqbHnawYxuP9Coi5slE04Wz+bD+FxpPN5VQc3V2W5WgTkzianTa0etIc45EafYzb9lkPjt6L6xnKGOTO++dbZrqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238821; c=relaxed/simple;
	bh=RrG2RP8q5Z2hEYDk0TFntJtn+ZrSDPsc06GBrxxq580=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhDTBG446Qs43nY2PL8RfOpQr0gkBG83yOlgnfK4u3yogAvUfjMZGe0lZh/R+HkvAn50XTZR+c8EMpGiLizYt95kd18Ai9smAyOie9s+Q4fiObuJOnw53o48sF23wCFWkObhnfg2qP9aw2kYxNPaAJ9HMl+XnyAu5uK86lLtYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D47C68BEB; Mon, 21 Apr 2025 14:33:35 +0200 (CEST)
Date: Mon, 21 Apr 2025 14:33:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 02/20] block: move ELEVATOR_FLAG_DISABLE_WBT as
 request queue flag
Message-ID: <20250421123334.GB24038@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418163708.442085-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

s/as/a/ in the Subject, and I also agree about the naming comment.

Otherwise this looks good.

