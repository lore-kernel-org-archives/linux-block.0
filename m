Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902A282F06
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275952; cv=none; b=gQ9HOr3CJ1NOgE7n5ODQOUmjqkOUoccUGizXF+p1EsOvml6sk1NVGPdOqzTNlrGOPjQbN9d5FI0LuO6XGaGMSnRY6HNxjzJsUKvtC5DFD28ZkR8SB4ZBIc7XU+MIqDQsFyDg96MX/OvzkBi25hs7d6kPx7X/Ru2VG+AeM9D5AAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275952; c=relaxed/simple;
	bh=org1tST3u55CEeuti5JaPzcTY/96/v7zS86+8k9Yyco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tunGZ023NX9Qqg5LCXJ3eyvyoZFtMyN6HxhlhQ21fvUjDzEMcTsFyxhqlodKsIJgvhqi9vMs+PQqNnKBh6Y8ZIp761KZkPKz0tsN+JY7pHAq7D9yLfDQcSCTqDkhJiKs9ZrfknpfRe6TGL+Cu3le6KuFe1JcQcto/MGmeg7xG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrtBTIAW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrtBTIAW"
Message-ID: <76fa7dfa-70ea-42cd-91fa-1f2e64a345e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781275948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuaKQZbpHTJp0GyBmSBNC23x9gC02Y6fBRj7S1V+kVc=;
	b=vrtBTIAWkWnySTPE3LrsnAGUZkDnpGVKbuT2KI2hKzfoi51gjEh+86ozYRFkGIwaoz0Zfb
	FyXxbcXqR9qM9opusv/CedqLw4i7eDkC6fMoJDNMrE5WsIXCIp9tMwJ6lhq0VBi7Sjd4cM
	pa4Kg91ElshEXBkCd6iq86fb/NtZ68o=
Date: Fri, 12 Jun 2026 16:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 01/27] aoe: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
 Justin Sanders <justin@coraid.com>
References: <cover.1781042470.git.bvanassche@acm.org>
 <f15d4c4f4a22ab4788a40d51d88d228a649d0115.1781042470.git.bvanassche@acm.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <f15d4c4f4a22ab4788a40d51d88d228a649d0115.1781042470.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/10/26 00:04, Bart Van Assche wrote:
> Add a missing __must_hold() annotation. Enable lock context analysis in the
> Makefile.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good,

Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>

> ---
>   drivers/block/aoe/Makefile | 2 ++
>   drivers/block/aoe/aoecmd.c | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/block/aoe/Makefile b/drivers/block/aoe/Makefile
> index b7545ce2f1b0..27bff6359a56 100644
> --- a/drivers/block/aoe/Makefile
> +++ b/drivers/block/aoe/Makefile
> @@ -3,5 +3,7 @@
>   # Makefile for ATA over Ethernet
>   #
>   
> +CONTEXT_ANALYSIS := y
> +
>   obj-$(CONFIG_ATA_OVER_ETH)	+= aoe.o
>   aoe-y := aoeblk.o aoechr.o aoecmd.o aoedev.o aoemain.o aoenet.o
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index a4744a30a8af..54c57b9f8894 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -1193,6 +1193,7 @@ noskb:		if (buf)
>    */
>   static int
>   ktio(int id)
> +	__must_hold(&iocq[id].lock)
>   {
>   	struct frame *f;
>   	struct list_head *pos;
> 

