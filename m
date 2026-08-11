Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7293AAF54;
	Tue, 11 Aug 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463721; cv=none; b=aXyCSL1EZWdSKDtj9dXwV1i6P+iXjezg/AmRr9uPm/V6Xmj20Vep1LGsn9473Eb8J6RzPxftJTjenzbtPkqkuKZuUJqdlY6AtfI8gAbH7RYUCBmksdZRfbYs+KbTuUYjRpHJ02wRx0AZMAuwJcA8IHpg72YJztkym4FoZZSGNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463721; c=relaxed/simple;
	bh=o7pKqL+V8jHvqIC3uuLlht86aS8zCzuhVWtdTYXWgJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMYMObSeYlVMZUqO8krEeE8bnnhnkeiqMh8XsvjwKE1XOak4TdWqZC9W3hs2mhLTPAqXS+ImXHEuC2UgEioKhNQSHaGne+wjfueMSHoU84ZCUxgUofbzWAbTCpVp6jzaThDic+nUKn55SuQ0P37/Cwtf1DwxajgsPC7vE/OXQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4UcMMjaG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4UcMMjaG"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hKGRP5qyvzlfvqH;
	Tue, 11 Aug 2026 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786463708; x=1789055709; bh=/7jOoadU4RSr2ETMx8L1HcKC
	tEGOBpPdsrhuLKe1I1c=; b=4UcMMjaGp8XynFfNXvWqBF2MnrqrCG04lkKpQlnR
	f/EI6qut5eUVNApzyoMGOD5vKS7rHAi3uMA59PqLFUQT4WmT2/S9/TtMvgp5+4os
	McInG2g59g4M10/3rXPqKi14h6emTDR8A1o/HKDeF0ypjCX6/SmwzQ72Bfgc2NDb
	eNs4ztXRCwHtrcW61jmKsd8AOR9U+3/c6Wiox9cSa/WzR+JF/TEl/wldKahHIG66
	bt4dnbBYUNXMa51j/6DdYdksbudKzhPFquhnqIBvkPSd8AxPR5R3ARz4Y+cPerGN
	C9aA6dhVOFdazmHp1KTTH4cesDqaCcMEcElTB7Un7zESCw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g1OgSEKNaeRt; Tue, 11 Aug 2026 15:55:08 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hKGRB6Czfzlfvq7;
	Tue, 11 Aug 2026 15:55:01 +0000 (UTC)
Message-ID: <aa55e215-34be-44b7-b489-5dc71b34fa97@acm.org>
Date: Tue, 11 Aug 2026 08:54:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mq-deadline: Drop unused dd parameters
To: Hongfu Li <hongfu.li@linux.dev>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hongfu Li <lihongfu@kylinos.cn>
References: <20260811065401.87147-1-hongfu.li@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260811065401.87147-1-hongfu.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 11:54 PM, Hongfu Li wrote:
>   static struct request *
> -deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
> +deadline_fifo_request(struct dd_per_prio *per_prio,
>   		      enum dd_data_dir data_dir)

The above does not follow the Linux kernel coding style. Please run "git 
clang-format HEAD^" to fix this.

Thanks,

Bart.
