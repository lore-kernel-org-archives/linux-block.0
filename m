Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5126B755;
	Sat,  6 Jun 2026 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730097; cv=none; b=iltDsTlIYWyL6W5nnAn6IALZIqaxawBeCLVaKgABBP9jQZYSqUH2ZPkxnidFxYkkGIy1Bo61uqg84ZqJ7U1zctDD8HQL9wk0I3qXJwJmG/q5i6e74agj2txx0cSGO93kWGSXJls5uwUsKu9la85jlHx5j9zgCzHqU9Hd3t+QhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730097; c=relaxed/simple;
	bh=TnS7422DmVPb160bVG826GnKnvow1WQ19aspgIRgDNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiicLJfKyOQ784ei2iBPZokzhHr02T1X0VCfqrJt+BT5HoMa5cSklDjTg7EVDfj5Xy5HZbIsRvfB1o7gCMIFp3n3NGe49x8hNchfsycT8pMyFSdtny1Jrur6ytUhAox3Tccp/V6NeEWRLPEYi+z0DfxPYqXAZQeKo3fIcpHUx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB/Qipoz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB/Qipoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359B41F00893;
	Sat,  6 Jun 2026 07:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780730096;
	bh=S9TKnr0jUrpLPiALjIbDdTwl2faU9LAlnTbHQCYW5bk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kB/QipozwDVXw6hNWbkOsv/JUMU3PcKvLNTq6YiETvCxqJN/izQHExAtDj9A71oFn
	 1XgU7VJuh7fzzNbRwqdP0kEMaCV4huZGZ9ojMS3T87nHwFRvUd3ACytUVvWjssxVEc
	 jWgy3A+bDtOK1aagwRpHmcL66Udgg2UQBFrK7yN6kpvdD8UJz+JooZZy8dgV2rhTJD
	 jz+SfVO2ZQ6F6QDIJtTII7k7rV+NWJvBoorlHx949UxJqSk8nZ23Ty9qL6x2TF1Q8+
	 cZrtUgZ0kaJHkAinK/T0rd0iyMx2Zc7/xN7Iu3FDfGdpzzT3tWRH7+IW6nUMrA2KwH
	 3Ei0TtcxJ5kiw==
Message-ID: <83b4e64f-4f86-4bc3-8c8b-855e05192312@kernel.org>
Date: Sat, 6 Jun 2026 15:14:48 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: add a macro to initialize the status table
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260605184441.590927-1-hch@lst.de>
 <20260605184441.590927-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260605184441.590927-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/06/06 2:44, Christoph Hellwig wrote:
> Prepare for adding a new value to the error table by adding a macro
> to fill it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
