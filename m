Received: from mta1.migadu.com (out-96.mta1.migadu.com [95.215.58.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F013B5DED
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950292; cv=none; b=iZRz6LQeRhrzEXIOCo3BwSkBXThiEg7j/v5WCQeFZCCeMVk2Z12WwHySOVgTpnzJW56z1NokzJKjJr7QUEwgvWuCCE6G1/XeJpbo/qYg/I7IBTPeM5LrDUa8YSSlFOzbUShbF8GEWtH/TK+zcNbbt2w4SZigOcX+v4VcOGt/4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950292; c=relaxed/simple;
	bh=/ukE8K+IgxS36hVzqpKwZP3D7V4JgjIuAr8r5KOR2RE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XgRNHk7MP3TsF0Tw5F/t1+3nRWGTFzxB68EpEpH68A9WN47ACxx9HN2QMK/AOqArlG4bHaBDK4cCMrnE/mzqOWL0AQi5hXRN3UgEW4LaA1wAfwiJMX4dbuEo5tVH8fh0L1l6J6HPY5vVe2wQeDYi/v9aKxzd8kONvfxLRfQF4Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g7ILlky0; arc=none smtp.client-ip=95.215.58.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g7ILlky0"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/ukE8K+IgxS36hVzqpKwZP3D7V4JgjIuAr8r5KOR2RE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786950288; v=1; x=1787555088;
 b=g7ILlky0JSQWNh5DqDEBoFxEhttD+1nohvJL13Xi1xL5VJh8wcNt0LJnFbY7Q1C1LN0O8lI+
 /PDR4ofzfhJiwNp5q6tG0gjlaYnX947w85pzp54NXEA5QWgLtIYijL/2E8Tm1yhvePIANKAcpD6
 wbmRWnjJ6P13TTP8JRckZ7M8=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 4c771c4227a84ed3;
	Mon, 17 Aug 2026 07:04:48 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <8880be8c-2231-461e-b338-e462cea2acf6@linux.dev>
Date: Mon, 17 Aug 2026 15:04:44 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: block: fix the sector 0 error injection
 example
To: Md Haris Iqbal <haris.iqbal@linux.dev>, Jens Axboe <axboe@kernel.dk>
References: <20260815191100.43956-1-haris.iqbal@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260815191100.43956-1-haris.iqbal@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/16 03:11, Md Haris Iqbal 写道:
> The first error injection example is introduced as failing one in ten
> reads of sector 0, but the rule it shows does not set nr_sectors, which
> defaults to the remainder of the device.  As written it fails one in ten
> reads of the whole device.
> 
> Add nr_sectors=1 so that the rule does what the text says.  This also
> gives the documentation one example that uses nr_sectors.
> 
> Fixes: e8dcf2d142bd ("block: add configurable error injection")
> Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
> ---
>  Documentation/block/error-injection.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/block/error-injection.rst b/Documentation/block/error-injection.rst
> --- a/Documentation/block/error-injection.rst
> +++ b/Documentation/block/error-injection.rst
> @@ -48,7 +48,7 @@ Example
>  
>  Return BLK_STS_IOERR for one in 10 reads of sector 0 of /dev/nvme0n1:
>  
> -	$ echo 'add,op=READ,start=0,status=IOERR,chance=10' > /sys/kernel/debug/block/nvme0n1/error_injection
> +	$ echo 'add,op=READ,start=0,nr_sectors=1,status=IOERR,chance=10' > /sys/kernel/debug/block/nvme0n1/error_injection
>  
>  Return BLK_STS_MEDIUM for every write to /dev/nvme0n1:
>  
> --
> 2.53.0
> 
> 
Reviewed-by: Tao Cui <cuitao@kylinos.cn>
