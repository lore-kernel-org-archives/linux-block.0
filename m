Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F333F8BE;
	Fri, 22 May 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456447; cv=none; b=Whm403WzjeTQTgejjGKNOl+wCYhix8KeHoEM4NRTnIjAbcUIpjN5aPAxU32/h9lMpEiSPfvwnAdLJRpyKWyqQlOZb9peOX5ccD5NW81HNoa1i34xbHRPZvSHrfpB2kfxaGcj5t469nqgUOBWNlxwBUOXgbaIMtZP7uHCvlpxbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456447; c=relaxed/simple;
	bh=mZn+IjG9V2x2qSOKnb0OXKQ5uwZfmUBdysUoRh0+MS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELS9pVoqs6ZHdA6Wa1ymPzsPZruA82AIisLDxOQr74jVbY5OVwQzZoz3gJgpl8+u66PXjoCd/+tnyv4ub7khhMJbh7vgIA71yNUsZn27YyqWf0TFeoslq3EQQkX6c6GO9gYHIJkUFty68eQZGIFEU2uE1emrgpd2i8A9T5uRVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB64E68BFE; Fri, 22 May 2026 15:27:21 +0200 (CEST)
Date: Fri, 22 May 2026 15:27:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, yukuai@fnnas.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: Re: [PATCH v3] block: propagate in_flight to whole disk on
 partition I/O
Message-ID: <20260522132721.GA27119@lst.de>
References: <20260522131409.261259-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522131409.261259-1-yizhou.tang@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Nice!

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

