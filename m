Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EE4503B
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774659; cv=none; b=GwrCJzeLiYloDPhPnHBucN8V+C8dJZijDbkPlYFSDB5EXzZO9/rrIzFj+iObIpymlZin5gpjA/7U0/EVe4FXqF9Qxuuodzs3UcC/bmfQ53ij6uNhaz4z3Xiu2I4w8YckTb9ZXXSKq4jlpwvi25Vxf4/TYe85AmHvO+QZCd9Og/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774659; c=relaxed/simple;
	bh=AeoG5HiDKnBp1HYYNHx1uycIU61Ybj3lvnRl12OD5bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZk52sopQLHeZ+g2MNO/D6VZ4QKbuVeUikxLOqkBk0lq9vXC0lw8X6Tc61VUOkBQzl9EITaJoBIvLTl5ZhT1oDde5Olls80yyOrgs1wohIVXESK4YbdR5NIEroPhoTnVEEFKxk/2doXMUh0kma0BPLfiPIR0Ew3ixPKztgTMycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kguSdeej; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kguSdeej"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bjgSw6cQMzm0yQH;
	Thu, 17 Jul 2025 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752774655; x=1755366656; bh=DXgu9J61MDYL2WAdCyswZoq4
	NP9mKkrYIxMk0SeedEU=; b=kguSdeejycRDK4dOz35AfzfRIRFyXNaJ9CLjd5Pm
	b7VXBjvk9efU9zWDG5wn8MYUk78H35SQgm+v5sMlrojYlEeJ1jknrU5FGCUOnzQ5
	KLckTAxEDOLNBlRuM9/DRk1qHHWAPt9SFBQg4WNbDjUWQX0DNgGY3Ld2mach0t4g
	PjAsBZUd0ZxhtrMeu42DmK5DDMuOmdF3DopTbbuyMIlgUWt5x4IC4CQZFRa01uk2
	/D5EDFzGueqwXFGyJiOP3oT/ucoFyDHR+V0xkq/E3Xgn52+UY8JG+oQF1JJgT6h/
	1fWLyeWMOqv0vqJhMnKeGIdjfk/ZkG5mnfSMN2ZOPxR+EQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wEw0mAQDMEWo; Thu, 17 Jul 2025 17:50:55 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bjgSm3PsTzm0ysn;
	Thu, 17 Jul 2025 17:50:46 +0000 (UTC)
Message-ID: <42c51ae5-31ec-4c07-8bcd-b0809fe68843@acm.org>
Date: Thu, 17 Jul 2025 10:50:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] bcache, tracing: Do not truncate orig_sector
To: colyli@suse.de
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Kent Overstreet <kent.overstreet@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Kent Overstreet <koverstreet@google.com>
References: <20250715165249.1024639-1-bvanassche@acm.org>
 <20250715165249.1024639-4-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250715165249.1024639-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 9:52 AM, Bart Van Assche wrote:
> Change the type of orig_sector from dev_t (unsigned int) into sector_t (u64)
> to prevent truncation of orig_sector by the tracing code.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Fixes: cafe56359144 ("bcache: A block layer cache")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/trace/events/bcache.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
> index 899fdacf57b9..d0eee403dc15 100644
> --- a/include/trace/events/bcache.h
> +++ b/include/trace/events/bcache.h
> @@ -16,7 +16,7 @@ DECLARE_EVENT_CLASS(bcache_request,
>   		__field(unsigned int,	orig_major		)
>   		__field(unsigned int,	orig_minor		)
>   		__field(sector_t,	sector			)
> -		__field(dev_t,		orig_sector		)
> +		__field(sector_t,	orig_sector		)
>   		__field(unsigned int,	nr_sector		)
>   		__array(char,		rwbs,	6		)
>   	),

Hi Coly,

Can you please help with reviewing the two bcache patches in this patch
series? Apparently you didn't get Cc-ed automatically by
scripts/get_maintainer.pl. See also
https://lore.kernel.org/linux-block/20250715165249.1024639-1-bvanassche@acm.org/.

Thanks,

Bart.
