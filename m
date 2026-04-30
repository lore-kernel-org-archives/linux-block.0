Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C5363085;
	Thu, 30 Apr 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565502; cv=none; b=riXFhSJH07uHmzJAprTdJ57DjAVxMaRd7ZBu0GpNj6P9ZoC7yin6cLInhWfmvcTUeOGH3TWRgHZ8HtI7LTGaw0BFC4170oPlAXLZseZ8vS1loVUfkTwFV2ZJXn37nd7yQ/II+tCFXHi14oFq5VpSsAtdpQzYlL14iTa9qZAwWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565502; c=relaxed/simple;
	bh=MHlck2e/Hb1QfwM33OFr42LzUq1pKBAQW97diut9QYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsmlRG7Oo6VYNTN8UxukC6JFBuqX3v89PTxCb7gzSUZEU6jG76dr1HRZcS3Q4ne0Tbky0uexu+YeAtuVWa+g+GUPnowOjlH+jG4hE2mh0wL3DZ3YcFtAw1kAl1kU+vLsM5hsh28vxSNyJYOPzb3rOLpA5qVbgjdyF05KOZGXMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cz6reARn; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cz6reARn"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g5zgx0Mptz1XM6JH;
	Thu, 30 Apr 2026 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777565497; x=1780157498; bh=jX5PsWdYSXGF02xLtBrGT0J9
	CbMwhYacpFpZkn7LJU8=; b=cz6reARn9MuMDRwWSts74rDmCIZcAkR1CCpsnyT2
	y3uQhkB2guN9FONkU9i8BttJrnFa+6wlIWk7F9SqgG9n8032bxfUFN7AzP2x8wb+
	R7y/lpiQ/3AiDT1TiZvzwhuw/XesgtBc+937D4XFvw84C0zY4uv2aG4UuwZmjHvk
	rv5KTBSO9RWzF7LIp0g4PPl7L4nQzdUrt8/un4V062fDBsppSwnUmKIEWm7hHBe8
	lUmXyhKYTPiJF/YWCBDd1N+sdl67He/WyP6+prIFjDuJdPQjAy3olzcRh5ErcL9d
	2hA6QxWhJcU87jpnbC+YfIR6z5vFkLQEnywllzkXzkdlmw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tX6F1ont_6_s; Thu, 30 Apr 2026 16:11:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g5zgs0pyvz1XM31H;
	Thu, 30 Apr 2026 16:11:36 +0000 (UTC)
Message-ID: <1f9a69b4-a8c5-466d-bb18-9c8bdbe45e80@acm.org>
Date: Thu, 30 Apr 2026 09:11:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: blk-mq: fix UAF in blk_mq_tagset_busy_iter
To: l1za0.sec@gmail.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430042821.29120-1-l1za0.sec@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260430042821.29120-1-l1za0.sec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/29/26 9:28 PM, l1za0.sec@gmail.com wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..4357625a512d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4738,6 +4738,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
>   				       int new_nr_hw_queues)
>   {
>   	struct blk_mq_tags **new_tags;
> +	struct blk_mq_tags **old_tags;
>   	int i;
>   
>   	if (set->nr_hw_queues >= new_nr_hw_queues)
> @@ -4751,8 +4752,10 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
>   	if (set->tags)
>   		memcpy(new_tags, set->tags, set->nr_hw_queues *
>   		       sizeof(*set->tags));
> -	kfree(set->tags);
> +	old_tags = set->tags;
>   	set->tags = new_tags;
> +	synchronize_srcu(&set->tags_srcu);
> +	kfree(old_tags);
>   
>   	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
>   		if (!__blk_mq_alloc_map_and_rqs(set, i)) {

The function blk_mq_realloc_tag_set_tags() no longer exists.

> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449

That commit is too old. It's description is as follows: "Merge tag
'timers_urgent_for_v6.18_rc8' of git://git.kernel.org/pub/scm/linux/
kernel/git/tip/tip". Please develop block layer fixes against the
for-next branch of this kernel tree:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/

Thanks,

Bart.
