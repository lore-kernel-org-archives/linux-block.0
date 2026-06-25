Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4383DD879
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388467; cv=none; b=jAQ3NFHb4ar01QF1wgl73CB24pY5JCYNjQXMJEOcroBrupsiuSdh+DJ4vX8lRdTPnKLtY8q2EfqxnAZrjYZ9Ei7/lNr8Hdp0pN3u0o1scvYl4siRdHI8Zio0Mj0697K/VjRIR1Y/nsNr/XJY38yoTmqbf3MTYVNgj4fhPZvsR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388467; c=relaxed/simple;
	bh=tXYVqOcjCfxn26tem+ijBf34LD60ir7+kkLkK1qTx98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isoc6zH+v8fK2mPU/MQL1v9H5AgSWcKFv0pV5+Am4wrRkKiZrpxe9H5L8+Rh/ok/DdNDTgg3ZzMktuhjYc8mcmfc6evj+PjMxtbryyeEPExGJD9AELex/zQGyvJ4tHhez/QbgSnBqAYCE+qTXdKrqTT546hDFM9l0iX2heqvmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF2E368BEB; Thu, 25 Jun 2026 13:54:22 +0200 (CEST)
Date: Thu, 25 Jun 2026 13:54:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/044: basic block error injection sanity
 test
Message-ID: <20260625115422.GA18348@lst.de>
References: <20260622160808.1552568-1-hch@lst.de> <ajzJiWqsQc2EgR3I@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajzJiWqsQc2EgR3I@shinmob>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 25, 2026 at 03:36:19PM +0900, Shin'ichiro Kawasaki wrote:
> Hi Christoph, thanks for the patch. I ran the test case with block/for-next
> kernel branch tip and confirmed that it is working as expected.
> 
> Please find my comments in line. FYI, I atttach the patch which reflects my
> comments. If you are fine with the changes, please let me know so that I can
> fold in the change and apply this patch.

> > +# SPDX-License-Identifier: GPL-2.0
> 
> Nit: Majority of the blktests test cases have GPL-3.0+. If you do not mind,
> I suggest GPL-3.0+.

Well a mix of licenses is obviously bad, although I hate the GPL 3 with
passion.

> I suggest to add the line below.
> 
>        _have_kernel_option BLK_ERROR_INJECTION
> 
> This way, we can confirm the kernel has the required changes and
> the dependent feature is enabled.

Sounds good, although this assumes we actually have /proc/config.gz?

Otherwise the changes looks fine.
