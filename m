Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3C2D6E42
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748353; cv=none; b=lzR3TJQ83ONc+sS0uWBVCfOF/anB8u3/0RzT530bERU9m46CySjUFxyWr/ZGPBVA6eD1WRIkkqBXbiuW0OHagHPh4NiH+5ZLsThGOXDjiVsOaJO87suoOWuUdbMQASjan+C9i/I6boiQ8iTJqlNnBK35jvAFIk1cWzHyknmdGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748353; c=relaxed/simple;
	bh=oAPJlhGmXaan1ypYpbKzjB0j8fvd7M3DkxXWQ5JB3uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGrq/5PvY6G1z7mbpDTRP5QGiYzeLyEru0zSwz+tZo7wdvkPhFMOjFn6TUJh5PgACzsexqw5TnPfo2ZYpKdLjrsVjn8GOWFyx5C++pOOKijVIpvzkISxQMIgY5DicQrAZ7XoIOdaZzw6ZwlRPu+KMwVN2uSY4SLy2OIf3Dyom6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Gvg59Xhw; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Gvg59Xhw"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4dCjnV3Mlmzm1LHP;
	Fri, 21 Nov 2025 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1763748349; x=1766340350; bh=ObbnwwedJj3NDzbzScrZ30Os
	au1jDM2IZIcyVkSNnHA=; b=Gvg59XhwtL9pVkuxrHC3Hj3h66xJNReaWjTFEhxl
	wpzSJ4kAoap5NbH2djfTPOxlcsVSG97w9DBmZCT0LpfyhCj3NmBgMCziGdhxS0JF
	cgn71eeCsnlc4D7ui7rgAMseahft1TEAEKat9DNe9V1ya/bVo9dV7dMZxADjsOBk
	nvekus2WAv5PeDLZk9XEu9HZ9Uq5MREnI60PEeC+/yXszmEqcKXEBNI50wSZQNGz
	03FKGF9LNXGItvbgljLu7akgIfgidB1L3cwIsaMGNxnl/xHsBn4tZVtvuwAAEmxY
	XNZUZjR4pKxZ8XaT4uS6F5oQXPbSJdJpbzl/9KtSCLzSog==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ngaiXUn9Y432; Fri, 21 Nov 2025 18:05:49 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4dCjnR3WPTzm2hrN;
	Fri, 21 Nov 2025 18:05:46 +0000 (UTC)
Message-ID: <cb0d1c57-7cb3-4434-b6a0-592ce370a4e1@acm.org>
Date: Fri, 21 Nov 2025 10:05:45 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for
 large PAGE_SIZE hosts
To: Li Zhijian <lizhijian@fujitsu.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com
References: <20251121013820.3854576-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251121013820.3854576-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 5:38 PM, Li Zhijian wrote:
>   # Prepare null_blk or scsi_debug device to test, based on throtl_blkdev_type.
>   _configure_throtl_blkdev() {
>   	local sector_size=0 memory_backed=0
> @@ -76,7 +87,8 @@ _configure_throtl_blkdev() {
>   		;;
>   	sdebug)
>   		args=(dev_size_mb=1024)
> -		((sector_size)) && args+=(sector_size="${sector_size}")
> +		((sector_size)) &&
> +		args+=(sector_size="$(fixup_sdebug_sector_size $sector_size)")
>   		if _configure_scsi_debug "${args[@]}"; then
>   			THROTL_DEV=${SCSI_DEBUG_DEVICES[0]}
>   			return

Why do the throttling tests query the page size and why do these tests
use the page size as logical block size? Will the above change break the
throttling tests? And if it doesn't break the throttling tests, why not
to remove the code from these tests that queries the page size and to 
hardcode the logical block size?

Thanks,

Bart.
