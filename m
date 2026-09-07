Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4744237C
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770790; cv=none; b=CYSOb/Ca0A5w6NPCiTTwCDDXNm0mSVdPm//bmPmqQ2QF3rELhsQWxSQL3Ted1Vng/sra+hj4551HmNH3rRixoYqU1TA2mBXu3um+YGjQxZVM2Qh7kh69gea/Iou02Rd/0hm7OHv4qjJZS//oCZ5NU29S+X/XCkLhAiGbqz+GmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770790; c=relaxed/simple;
	bh=wIqVUBTU4NhuNS4I/LXKojgEIRQR1f6CWW1l4H8CRm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1cFrahfw3fydUh6g4oyjWT7p8rOz0OsDohtGOiO0JpPgUcPYB6K3NJy66/lUgezrehsJ1zQzJxFe78ba5XqBx2B9P2fBl1ZTopQE5qzKqNaQpLYhMhY1Budvyd1Z/0sV8n6JvvkRNJA/z77o0TB3Mee3FQMRl4VjR79X8K0qEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70C2B68D09; Mon,  7 Sep 2026 10:46:22 +0200 (CEST)
Date: Mon, 7 Sep 2026 10:46:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
Message-ID: <20260907084621.GA7391@lst.de>
References: <20260907074111.721054-1-hch@lst.de> <20260907074111.721054-3-hch@lst.de> <8c16f727-c840-4a8f-94a7-fbe09bc3735a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c16f727-c840-4a8f-94a7-fbe09bc3735a@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 07, 2026 at 09:09:47AM +0100, John Garry wrote:
> On 9/7/26 08:40, Christoph Hellwig wrote:
>> As Sashiko points out, 
>
> Do you have a reference for that? I'm just curious, as we don't support 
> atomics for integrity writes. Well, for SCSI we don't... we impose this 
> restriction via sd_config_atomic(), I need to check for the same in NVMe...

https://sashiko.dev/#/patchset/20260831064010.2574896-1-hch%40lst.de

Search for "atomic".

