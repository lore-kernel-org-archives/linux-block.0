Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3E1F708C
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448047; cv=none; b=e5cMV0otwxbmCoPwdpD1D0T4WUzeXqfoWxQ70zCi9by1pUMOGDtfC0Cl+cCiHWTIxBrpJBRQ8yy4qItvREgjOpYfrZmbzEwWYmZymny9aaGOwPLN0QMyKmOsSYr/nmIkA9LixYU1GKlupLnS6E6g716qOYk+nDl48tj5HtE+rcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448047; c=relaxed/simple;
	bh=1d4n4EfjL4x2NK0v3nHck9JyomMVINfTALtdVRw5gDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqAO/vQ828V2rVdEj3txJTZ4Qri4yhWDv0ITUwBNh7qHDh7GuQbAF0KqQsTxDUlF2Ebm5FUBNsh0+xWXHjG7w7n/J7uXKnw3+VfoKsDi6dva4vJ9K+apO83bQU5sguya72hQlKp7oL4m+CIXS1nv7QAHcdJOi1HV4Wy8S/Yb4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iluxdyDt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iluxdyDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B02EC4CED4;
	Tue, 17 Dec 2024 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448046;
	bh=1d4n4EfjL4x2NK0v3nHck9JyomMVINfTALtdVRw5gDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iluxdyDttTPnj26akJPei+RGbkkMoozkuIL+sKfq2qQwYlEcLtNXVdDKOd0lJUmHF
	 +wSm3I34GoG18J6N04QqxQmBu7/T6XcVxlPi71jhkBh8O3jK/E7igUd/SKxnVg3xaB
	 8FYym26lz64rvdZvIa6fs3a1nF3E+YwxmXsruAWdeVxq/sfczaB47sY5bybvLtM/JU
	 JbbRwvBxx2A55wka5RJay/cp1RT3vqqljx61BKVFN0+z2O8P5QLG17BprSlDpl20iL
	 M5u6wRWqc4SFo47/9CL4MS0XbuYwfnX0+CCRBpkgujwraufveNuMl6RBZFBuubhIB7
	 Ym5Sr1mn5l+TQ==
Message-ID: <c24c73b8-4562-4ca5-a1e6-7a2c84f022a4@kernel.org>
Date: Tue, 17 Dec 2024 07:07:26 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] blk-zoned: Document locking assumptions
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org>
 <20241216210244.2687662-4-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241216210244.2687662-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 13:02, Bart Van Assche wrote:
> Document which functions expect that their callers must hold a lock.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
