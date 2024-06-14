Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9B16DEB8;
	Fri, 14 Jun 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383264; cv=none; b=TGzftrV6G6Qjj9Ou43PyBuJITD5IWzhi8Lyg0murnZIWx1n+oU1gyOwtJU6t7Ic3yirRwpa4TvjZ5DbxFyXC69bNx4XVOeachLTjwBQMeM49LsrT267ToOphWd8nAxuIQu8/pw8NQJVrKP4DOOyH7RzYVBC22y7wZuXhqQYNh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383264; c=relaxed/simple;
	bh=wIraPb9VQXYm5SoNAvp0k7o3Dy4+lK3Cw/Pmy1Hz3GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlcfqFue4k2mOYT6o2MdcMGJu26JYwqpTKl+PFPTi0wEVRX/G5KCj2+UxKq/eJU5V//80MUWeJjUsd64oJeq/pkNTnBq+V/YWShKb9WVKdmhQ1beYRRGm+rmEU6rVpdqe35lJWmB6rmOoRoZCfCOdiiVUE7L8t0Yq6bnsBvNTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=VfoSh5vt; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="VfoSh5vt"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W14ly4QbCzlgMVX;
	Fri, 14 Jun 2024 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718383258; x=1720975259; bh=vJEHFGnp4hZ969Zf9Go58Qtf
	Z40TWQLEFE9qlxIOIMQ=; b=VfoSh5vtrT6+iBjkBnbhHkhykAykC4tL1yLzj/pT
	8OBoOwmoi8es/CB1s/6ki8jqRWNJRG+x9QCv01ZG4KEkKXe9cNq6qGEB/0rzmNjd
	cUuFFLskqQvLtI6/u74H7AZEsmpEu4QZiH09cnQeQ9s7hMRq3NXuptoMEz2JHtCb
	1/yYXYt7+uGHcJCYmJuny7TLGyc6GzuGnAuuwn50t9YY3P/KzFcXwtSWHnpITCKj
	iavDlFfz1OfVPgUZCCTGpmrHIfGz/XWuDcKrc0auZ8EfBVkuYyCaUlqoP8eLOzcH
	k6mMyfBLp+XjW4ZM7dGIYVbXDg0l0aKuTgN45JlInj7scg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FPHsg5PxlvJu; Fri, 14 Jun 2024 16:40:58 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W14lr720fzlgMVV;
	Fri, 14 Jun 2024 16:40:56 +0000 (UTC)
Message-ID: <7d0f68b8-ecdb-45fb-ae10-954eac5ed32c@acm.org>
Date: Fri, 14 Jun 2024 09:40:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: Add ioprio to block_rq tracepoint
To: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 ebiggers@kernel.org
Cc: ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com, cuidongliang390@gmail.com
References: <20240614074936.113659-1-dongliang.cui@unisoc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240614074936.113659-1-dongliang.cui@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/24 12:49 AM, Dongliang Cui wrote:
> -	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
> +	TP_printk("%d,%d %s (%s) %llu + %u %s,%u,%u [%d]",
>   		  MAJOR(__entry->dev), MINOR(__entry->dev),
>   		  __entry->rwbs, __get_str(cmd),
> -		  (unsigned long long)__entry->sector,
> -		  __entry->nr_sector, 0)
> +		  (unsigned long long)__entry->sector, __entry->nr_sector,
> +		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
> +				   IOPRIO_CLASS_STRINGS),
> +		  IOPRIO_PRIO_HINT(__entry->ioprio),
> +		  IOPRIO_PRIO_LEVEL(__entry->ioprio),  0)
>   );

Do we really want to include the constant "[0]" in the tracing output?

Otherwise this patch looks good to me.

Thanks,

Bart.

