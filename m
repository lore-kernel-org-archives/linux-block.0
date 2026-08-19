Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE944062D
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163879; cv=none; b=T66nyneYUiR8Dz3/UBuWmi2kdjbL3Y3rbQu5YUSVaSBvQ7UW9LqABPCoSqUNoS4oc2yggho9+xvK4biWYJVRfHAgEllEPwpEcp9PKeaP/00ANsJD2x61b3rfb5/HBb9yBVI+J/vdiUy83VBSpFMCAD/vTxyKqb9s5wcAWQfSN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163879; c=relaxed/simple;
	bh=oG9Qf5UgD/edWXXUB0tTbJH25ZvM4KVDkT94nOr+mxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8t7usbCx/CiLg25CPAfuhTO6WgL4wytnVisQgSMDVxl+2hg3SZYg1i14gVwxStBeZ0KjCXqtDMYPKId/hhtS0jVmG8oF+Wb4ihc2Ff9xfTzQN9a4fuJREb2H1JmXy9nW9WgjHgIf4kT2jmZDjKo1OWDTj/JtAIkqVTOBtbwt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oWxBWjJt; arc=none smtp.client-ip=91.218.175.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oWxBWjJt"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oG9Qf5UgD/edWXXUB0tTbJH25ZvM4KVDkT94nOr+mxI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163875; v=1; x=1787768675;
 b=oWxBWjJtXZI3uSYlmVxfNJA8bNu8fFyrzma8bc8TVSQHBoys3GGgxOwtvBS5MIsjYK1DL06A
 EmVkQKZcpGyYoLvf2vEDhiDW+8bq+znN7aaLQ03Zq6r/FIu9vwGAMmY0vPag6QfJzeOTYPahUo9
 mpGPjLPMZNfkNliL/u/gpk08=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [IPV6:2003:fc:df23:7a77:61d8:f7b3:6a7f:2b45] (2003:fc:df23:7a77:61d8:f7b3:6a7f:2b45)
	by smtp.migadu.com with ESMTPS id 37d5c9fc29c49f95;
	Wed, 19 Aug 2026 18:24:35 +0000
X-Mizu-Trace-ID: 37d5c9fc29c49f95
X-Migadu-Flow: FLOW_OUT
Message-ID: <64160992-4398-43ac-9128-0495c348bd1b@linux.dev>
Date: Wed, 19 Aug 2026 20:24:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: block: fix dead http link in blk-mq.rst
To: Jenson Johnathon Reggentin <mail@jregg.de>, corbet@lwn.net
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20260819174635.37505-1-mail@jregg.de>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260819174635.37505-1-mail@jregg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/26 19:46, Jenson Johnathon Reggentin wrote:
> The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
> https://www.kernel.dk/blk-mq.pdf leads to the correct document.
> 
> Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>

Looks good,

Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>

> ---
>   Documentation/block/blk-mq.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
> index fc06761b6ea9..c2af39f14d6d 100644
> --- a/Documentation/block/blk-mq.rst
> +++ b/Documentation/block/blk-mq.rst
> @@ -139,7 +139,7 @@ completed.
>   Further reading
>   ---------------
>   
> -- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://kernel.dk/blk-mq.pdf>`_
>   
>   - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
>   

