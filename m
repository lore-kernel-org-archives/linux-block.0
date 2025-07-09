Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB9224AFE
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096519; cv=none; b=f+aYZEndeyVXG6I4LnkchgP7qU6gbEpIsUxWmk6aTB5aAK+UZWBj/mO9nBSUsjiWkDxn+qd00lPLnhFzrKQhWoYKAqUwDJGCx0aoWn5fmRpouNCdGz/v2A1cBNNp94WBGbPDhEy53f3of+no8w3fJo1HPEvyurKjIB7coaYTTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096519; c=relaxed/simple;
	bh=wNZ6tpULyKOfLHD6cEnCg3swBF1wqgutcSf6Roj3i5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXX77goaXjDTizos9+G0nAvfshhjkKCjPgAsilQw7XcK6CmmKpbq/YbWQuG9cs8MmsQJiz/R4JhO9FR8zvmrzmzazdc3JhQqmO0Z3YsHN7FQQk93A0sz1aDlpnpokNoYNyIh2fkaB7436TFcUJMeaFk/Y9RGalS8kNEgjaR7LME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7V/Atxh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7V/Atxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F87C4CEEF;
	Wed,  9 Jul 2025 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752096516;
	bh=wNZ6tpULyKOfLHD6cEnCg3swBF1wqgutcSf6Roj3i5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7V/AtxhfKuY+hmTibOnZVi3aYorjjKV1Wb53XJ9sWnQH9v4b1wwBZSd/HodTxjAm
	 K402hAqsr5SjDZ/9SMAgsKKVxCeTB0eJc27oXUuhAcNSYSaMqfBVapIZQzS44EFS7T
	 vZugE/kwtZSYEgS75xrtdkPVq0BV2tjf2uxTCUvi1NdDUrT6hqAuGU+wya/aq0TPrW
	 TyryBsVKA1OnTHxR7STLZyUWwgNkmLXEkNUpECzFwSOCGcWXSDoW+09x+sjCLPTNVO
	 6cWWCSBQfT0B+y7HXD7RUi5SmWPBCNvhg7tWOnHhehIclnul5QNWoZKcGuFRY34b/5
	 FbNq8hrkkpCgg==
Date: Wed, 9 Jul 2025 15:28:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aG7fArgdSWIjXcp9@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>

On Wed, Jul 09, 2025 at 01:21:17PM +0530, Nilay Shroff wrote:
> I believe there are multi-controller NVMe disks in the field (including the 
> one I have) that do not exhibit such inconsistencies, i.e., they report a
> consistent AWUPF value across controllers and do not change it based on 
> namespace format. The NVMe specification states this (quoting it from 
> NVM-Command-Set-Specification-1.0e):
> 
> "The values (referencing AWUPF / AWUN) reported in the Identify Controller
> data structure are valid across all namespaces with any supported namespace
> format, forming a baseline value that is guaranteed not to change."

I don't think that's a backward compatible requirement. Controllers
often rescale these after a format command, and it was the only way for
1.0 and 1.1 controllers to report atomic sizes.

Lets say the controller can do 128k byte atomic writes, If all
namespaces used 512b LBA format, then AWUPF would be 255. If you change
one namespace format to 4k, AWUPF scales down to 31, yielding a
sub-optimal result for all the other namespaces.

> While the spec doesn´t explicitly require that AWUPF be consistent across
> controllers within the same subsystem, it seems to be implied. That said,
> I agree this should have been stated explicitly in the specification.

Considering multi-controller subsystems, some controllers might have
namespaces with only 512b formats attached, and other controllers might
have some 4k mixed in, so then they can't all consistently report the
desired AWUPF value. They'd have to just scale AWUPF based on the
largest sector size supported. Which I guess is what the current wording
is guiding toward, but that just suggests host drivers disregard the
value and use NAWUPF instead. So still option III.
