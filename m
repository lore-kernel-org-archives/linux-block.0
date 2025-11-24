Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9BF4F1
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007056; cv=none; b=NS1Ni+E/WU9suRqgozaxbWJYe3tjDE3h+1DQ9zMf764PojhqWuuTtrhlZEuKlm9OwwIlAgAsF6XJ9KoYUtz4G49v+ZteJECrFpZSN5Eqvw/NkreO0u9JNhwB4xj7+rRuYqS7Tl5ZijlUaLfcm/tGRo1lDkpYwWCupb0wgW9v3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007056; c=relaxed/simple;
	bh=7bWWvU78tdaLgOmVn+BQPQmlP7VUP04s4RF1lWpBC2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0EqY6ci2Srj3P4TmFzqPa2RWM7OUkWsK5ZDg6Y2V+qB+2pgy3BpKKvhDzttG8SpwCdZuT13XeLrdyLjnLpruJCd+4k21na3B0wylUG6zzi3VlZqR0ErBDWjogCtvNfgqE+K1Sarae/ax584Oa8t8E4iei1478d5cxXtWEulgH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIdgsuso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIdgsuso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A248C4CEF1;
	Mon, 24 Nov 2025 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764007056;
	bh=7bWWvU78tdaLgOmVn+BQPQmlP7VUP04s4RF1lWpBC2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIdgsusoIyToqOntrVo16vpDkArUNiZyxfVd8GCOf821KrSglbuK6J9+azljQ/5Hh
	 UG6w3e77Wf5aGBKLahRZ3Jl9Ese+Zlyl1Bz/RE1FJyJHamQc6NT9D3QejPNne2J8mT
	 8O4cj4PLZqgGO0wajAw68SSUuQtejadBfcA2hQNXIU80uM6o4VFKhX+gvhJbo4CRyj
	 lM+0PZhgKmcbv5WKKBNZlKnVIQyrdfRbQTG24NvOkdwn+Lnz9i8Y/Q+nEvYRv9SOdE
	 CJpl3/cSK8ki1VbX104xpdIkKZY9GH91WW2BuiHzd+WICDNm8rEDlmnBt0qV1s0VzT
	 b0zejcRqjV+LA==
Date: Mon, 24 Nov 2025 10:57:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, ebiggers@kernel.org
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
Message-ID: <aSScjjoOZswC35nR@kbusch-mbp>
References: <20251124161707.3491456-1-kbusch@meta.com>
 <yq1o6or2y11.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o6or2y11.fsf@ca-mkp.ca.oracle.com>

On Mon, Nov 24, 2025 at 11:31:54AM -0500, Martin K. Petersen wrote:
> > A bio segment may have partial interval block data with the rest
> > continuing into the next segments because direct-io data payloads only
> > need to aligned in memory to the device's DMA limits.
> 
> No objections from me if NVMe needs this.

Truthfully, the users I'm enabling rely on the NVMe io_uring passthrough
interface, so much of this path isn't in the path. I just want to remove
the dma_alignment limit when a csum is used because the incoming data is
naturally unaligned in memory to the lba size. Most of this patch is
prep work to safely modify one line of code :) But I'm still really
happy with the result!

This should fix a real bug too: requests with data integrity and merged
bio's would fail without this. It's unlikely you could merge such bio's
due to integrity segment and virtual boundary limits so it's not
surprising issues haven't come up, but there are patches staged for 6.19
that make it easier to do that for capable NVMe devices.
