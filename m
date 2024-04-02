Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC2A7F7D9
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063907; cv=none; b=esXHnUlZbdwBlPwW9AH/JM7Solyw9CtaShhLEF1k6hP9X3xA6nyuE+ZjPHfFBWNGrHMBt68YQqhsU8ZkDdhIBtIvTdSqlYSnt56+R0cqmyxpx0KzJHAHCUgTNoCccqFGX9Zw4tXdOkVu70WhwCdXvgG4iaYPiaRbjpqQXvWaaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063907; c=relaxed/simple;
	bh=xHj+OYZAThaaVrvr8J64x+GLOcWeFgq7fRLgriEawfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+rAli6DvB/25flz1JrZ8TMm2U/1XHUbVS73oOzpk1s7bH+qWKbAVz+VwgM2b77n+BcDW1gNX1SpAoMDbFg+jWoBILfCYvuqf4wudDdgBX899WAQa/yu6SSIiazoRPZLTGrhMOlTH9bttX3oWSSnLPTTeg/orsvtPAn29MysVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE68568BFE; Tue,  2 Apr 2024 15:18:22 +0200 (CEST)
Date: Tue, 2 Apr 2024 15:18:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Oddities in brd queue limits
Message-ID: <20240402131822.GA32081@lst.de>
References: <0cba8c5d-f014-4e48-9a6f-7724cf939c5c@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cba8c5d-f014-4e48-9a6f-7724cf939c5c@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 02, 2024 at 03:17:26PM +0200, Hannes Reinecke wrote:
> Hi Christoph,
>
> brd ends up with the following queue limits:
>
> optimal_io_size: 0
> minimum_io_size: 4096
> hw_sector_size: 512
> physical_block_size: 4096
>
> which I find particularly odd; how can the minimum I/O size be _larger_ 
> than the hw_sector_size? Wouldn't that imply that we can only send I/O
> in units of physical block size, rendering the hw_sector_size pretty much 
> pointless?

The minimum_io_size is always larger or equal to hw sector size.
It really is the minimal efficient I/O size.

