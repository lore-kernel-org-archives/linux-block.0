Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2424302141;
	Mon, 17 Nov 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398486; cv=none; b=lXzMgn2ykMlanHVgFPK5ATPjGL3gw4EvZklt3vsEw00FzAYYg+f2Z8nDggStDUra6WTif/70e7hrFbJy+kZkOwO+86aRb2yhwpeaaaZtmXbpz3/NVH0fJcJ40BVoD0vG3HBRITSDz8G0q/xBS7TRPC1UUCrgHRiMgL0u7dML3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398486; c=relaxed/simple;
	bh=E2Jd6k8ASCaHYjPHZ/TAnWmKaJoKIfNrrFtu5aWWang=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLJABDls32dLDVgg2+oNnDRns1sn06HN22yJy2ChcmX862DWqjNgLlSaor4F+9/SZO9LLBylV/SxoG5U6UjY6sIcL9ljqXIXT7NfMNjUHBukmaf4iP8oK/U8Vspqd2jSfWnnejitHn+duPQYq6Pm9peOGCiqiQollokcCkhKa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JUOvl7IQ; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JUOvl7IQ"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d9DPG4qfrzm0XCD;
	Mon, 17 Nov 2025 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1763398481; x=1765990482; bh=aakcOhZLQs4tB1ZycPZjCgK1
	Zpd/IsXOyidwTRbtc4I=; b=JUOvl7IQML9/xU35ul5bEsMpW42re53TAov9iFY3
	IzV0F6MBIfiWqspTx61eIZrxdzlZXmoXdrxUQzF62+SgXCgzxQS9ufVBEsJd+lWi
	nNudp7q4W8ngytIalYmd5LlbC353p/wNBN2PBNvyyXD0VgrnI9sZs0GwAeeCJogf
	Oa5fqxEsJjk3f/N5Ffgwh4uvo7CwL3mTCh/ji4YVKyI/49FxS4whlBLFz9VzOExQ
	SHsTDhAnUlG4jd+2Ruh4L4xHD5DQwesSLDu3usStvJjEb920qZ27cPYshXCWmU/m
	yCFjDxMqQsE6dEUzXRrSSSgrKj7pdjFvQqcXnxNuCtBdBA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eOvpHIxEhpht; Mon, 17 Nov 2025 16:54:41 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d9DP93lPPzm0yQ5;
	Mon, 17 Nov 2025 16:54:36 +0000 (UTC)
Message-ID: <39e01b9d-2681-459a-84a2-f96ade679764@acm.org>
Date: Mon, 17 Nov 2025 08:54:35 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rate-limit capacity change info log
To: Li Chen <me@linux.beauty>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251117053407.70618-1-me@linux.beauty>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251117053407.70618-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/25 9:34 PM, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> loop devices under heavy stress-ng loop streessor can trigger many
> capacity change events in a short time. Each event prints an info
> message from set_capacity_and_notify(), flooding the console and
> contributing to soft lockups on slow consoles.
> 
> Switch the printk in set_capacity_and_notify() to
> pr_info_ratelimited() so frequent capacity changes do not spam
> the log while still reporting occasional changes.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>   block/genhd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 9bbc38d12792..bd3a6841e5b5 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -90,7 +90,7 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
>   	    (disk->flags & GENHD_FL_HIDDEN))
>   		return false;
>   
> -	pr_info("%s: detected capacity change from %lld to %lld\n",
> +	pr_info_ratelimited("%s: detected capacity change from %lld to %lld\n",
>   		disk->disk_name, capacity, size);
>   
>   	/*

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

