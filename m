Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A564D
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744611735; cv=none; b=gD6Gqfh+xsYNqBnXHcmHH7Ehh5bUijZsbbJ6uIJSi3c5n83YVuSKnU5dbZLNNW3ndkIIV6dJuL+e65zhyO9f7kXmXBFgZJjDQPPCyvIoB7WtJ3Z/KuWd+JSnO7L8A+JdbQLfDxTdOEIp3qmXBrxoTJ4A9oQmnT3kZAHu70vjhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744611735; c=relaxed/simple;
	bh=bi36p4h7k/uuv1GuMNQouB5a0cwMVbfVaw01Gysdjdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBfIflk7JoBrAUz+eG0UlUvYBrPF8eFltQOVbK+HkAKZ0u0FryYrXxEzqJN+Y7ZXKW/eVlbMJ0Ya3OQb41VZl7IA05hCGyKTEhAVvEdr/DluWcg+7kT6h5zid+Eh68Wo5FUtgQMvLUQ/EH+mQQX1OIVrnw4/K4foyPzHNRiUNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9787E67373; Mon, 14 Apr 2025 08:22:09 +0200 (CEST)
Date: Mon, 14 Apr 2025 08:22:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/15] block: pass elevator_queue to elv_register_queue
 & unregister_queue
Message-ID: <20250414062209.GC6673@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-11-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410133029.2487054-11-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 09:30:22PM +0800, Ming Lei wrote:
> Pass elevator_queue reference to elv_register_queue() &
> elv_unregister_queue().
> 
> No functional change, and prepare for moving the two out of elevator
> lock.

Can you explain a bit more why passing a seemlingly duplicate argument
helps further down the series?

