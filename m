Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD96439913;
	Mon, 24 Aug 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590896; cv=none; b=IFUsf5wlG1WDPQBSu5EU5BdL35rzYdiIiejIFrgUZaA/r5O9EFHIP+A+8JHvAtf+ATAbVRxC+OOFIY3vzYVCdFHprTMljCaaSfHchg4qRhsMWQwKb5pkRXNqwZVKOfxSOUhT+Ioi3IqCcUGfrsN41C6/BVBxrvg6RvJtGnDfyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590896; c=relaxed/simple;
	bh=/1QjHML3HJwoT2g9zgzvhEE9CLsjJrE55v2I0B/BjqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sCFhVkgtgVpsX8+lnIggE1UrhFD1aIeAnwzqZ9y2NAdP4PgcmWoS20NxdtSX7cBZDUpYf3gRsvMURhYzMepOnTyw4l5Cnx+Wy3/Yramd6okK5rmhX8iMfEtfEb9ZwdskCGC0irLmRmOXQpIqpVBhQSJTr3uH+2ohcDxsZJpskj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pSGhs56l; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pSGhs56l"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D6D92408F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1787590895; bh=VL4YZywc7DMdzQwO/8L0tTHLZcEHkKTDbKQ89lTT4D4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pSGhs56l+z0B1+GfJgk2rtkysFK8o9/oMIuaDirMgc/rw+2qQJ+OPFgnT/ZwMHf/Z
	 6xOF07cqqd0hYH3wYuy2xEWHYIXwMu3bsv2N9+9IJg7YaOcVaBQowGOCNNY0DU8edH
	 IrufpxsX5YrqWYD+qzieRZqeHSm2GU5EK5hhMYh/7+mfKdQt3rzNkrh+1Snd4eB0m1
	 5V33uJXP5DNEC5L32/xyN+ntBK1WOpf+zE41s3/wyDG26llNmqFmUWNRIk1IgK1ndw
	 KiBKt9brOD47+FosX0+vWE+u7Jn/uDy+TidAYw+zXLCgyecOEuHxReuRy7DcPUesYP
	 I1P+qOpvWzJDg==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D6D92408F8;
	Mon, 24 Aug 2026 17:01:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jenson Johnathon Reggentin <mail@jregg.de>
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
 Jenson Johnathon Reggentin <mail@jregg.de>
Subject: Re: [PATCH v2] docs: block: fix dead http link in blk-mq.rst
In-Reply-To: <20260819192422.42189-1-mail@jregg.de>
References: <20260819174635.37505-1-mail@jregg.de>
 <20260819192422.42189-1-mail@jregg.de>
Date: Mon, 24 Aug 2026 11:01:34 -0600
Message-ID: <877blfzc41.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jenson Johnathon Reggentin <mail@jregg.de> writes:

> The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
> https://www.kernel.dk/blk-mq.pdf leads to the correct document.
>
> v2 to add the missing www. prefix in the actual file change.
>
> Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
> ---
>  Documentation/block/blk-mq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
> index fc06761b6ea9..2798761efe0d 100644
> --- a/Documentation/block/blk-mq.rst
> +++ b/Documentation/block/blk-mq.rst
> @@ -139,7 +139,7 @@ completed.
>  Further reading
>  ---------------
>  
> -- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://www.kernel.dk/blk-mq.pdf>`_
>  
Applied, thanks.

jon
