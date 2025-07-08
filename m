Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12682264C8
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968083; cv=none; b=kqP4pwsaxg/uMmVuG1DSlg6tqElHAAopOoHCR1ld5OLxTgSiGOLWTa68stbQMxiAGQAJzVOraaEemjBbAm5p8RvZnAlDDLNZhOS7NjMjd5phg+hfHVsOITXbTZJECxa4UBoHd2+FAADyyLAGauS9BeaMUZgQcv8mY5xjftAB7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968083; c=relaxed/simple;
	bh=1YH6y1gVH1i1QblWpW3Qk9dCmcQPjIiXd9jt6J612+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JozX9PUOaxQqYbFuWTaGhbc6LDhwj4ixiysgrE3FWiCvvI7zSsBvBs2WM3/kGWdokFKyRsy1/vqL1ng/LHiOpzGrdPc3TDv+j6o/JJBWPQBkrrJlZ+QOjfVPGErxLihSqKANhT7Os8RauYLHBSEfeXz5VhcARpmo2pNX4T4fx4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46FE868C4E; Tue,  8 Jul 2025 11:47:49 +0200 (CEST)
Date: Tue, 8 Jul 2025 11:47:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <20250708094748.GB27634@lst.de>
References: <20250707141834.GA30198@lst.de> <aGvYnMciN_IZC65Z@kbusch-mbp> <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de> <aGvuRS8VmC0JXAR3@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGvuRS8VmC0JXAR3@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 07, 2025 at 09:56:53AM -0600, Keith Busch wrote:
> I think the NVMe TWG might want to consider an ECN to deprecate or at
> least recommend against AUWPF, too.

Yeah.  A wording that every controller SHOULD implement NAWUPF if it
implements AWUPF might be good, eventually upgraded to a SHALL.

> Just to throw AWUPF a lifeline for legecy devices, we could potentially
> make sense of the value if Identify Controller says:
> 
>   1. CMIC == 0; and
>   2. OACS.NMS == 0; and

What is NMS meant to say?  namespace management support?

>   3.
>     a. FNA.FNS == 1; or
>     b. NN == 1
> 
> And if those conditions are true, then the controller and namespace
> scopes resolve to a single namespace format, so the values should be one
> in the same. The only way it could change, then, is a format command,
> which means there couldn't be an in-use filesystem depending on it not
> changing.

We could.  But are there many controllers where that would be the
case and where people want to use atomics?
