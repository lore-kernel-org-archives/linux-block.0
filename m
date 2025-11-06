Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA82264D3
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443792; cv=none; b=mHMMqIro2/B9C/wD1IHAfhccgDFnV3BG6X+5pm3jwsflqmJbTpeaRWc3oQK8/D7S515PeUV838Pdj5vlSSlfry1XMONnFURO92gwhezxXKSR64LUHykFt/SgB/fhi9y5rzTN8iSeX5xU05SA03YZE8RfU/SVeGOsy/cHczSZTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443792; c=relaxed/simple;
	bh=Z1ywaSkGxz5zKfCRi3/vIwBj8gAIMntptUaPAB/vUKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqr7roXQYIALv2n6DNOgIocOgt20MmlnS5kNkwxR3DebW6WptRmj8ZwTupf71LaaCzD7J7raDM5tZ0Go/Lwefl86EsIg+eap90mRX8EM7MTgoRihYH3exnGC57wdGQZfK9kivMqMP+igqSZHriY9Zvv3i8v5jno1fQpI+sSorH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 028AC227AAE; Thu,  6 Nov 2025 16:43:03 +0100 (CET)
Date: Thu, 6 Nov 2025 16:43:03 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, hch <hch@lst.de>,
	Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Message-ID: <20251106154303.GA19533@lst.de>
References: <20251106015447.1372926-1-kbusch@meta.com> <20251106015447.1372926-5-kbusch@meta.com> <20251106120131.GD2002@lst.de> <aQy9onvbbLaD_6Gx@kbusch-mbp> <5c39e22d-40e0-4803-90c2-64f82227ed7c@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c39e22d-40e0-4803-90c2-64f82227ed7c@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 03:42:14PM +0000, Johannes Thumshirn wrote:
> On 11/6/25 4:25 PM, Keith Busch wrote:
> > Anyway, it started to look like all those little cleanups were
> > distracting from the feature, but I can redo the series with more prep
> > patches to tidy things up.
> 
> Or just merge this series as of now and do the cleanup on top? I mean, 
> it's a small feature and has no negative review comments.

Yeah, that's probably easier.
