Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD516D9C2;
	Mon, 17 Nov 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422345; cv=none; b=j9U6OgMIfdT8dB1jIkqC5ctGaa7JL+MkvFtGebMPUeuWFs3B+lCnHr2V5FgVgpTRdVd+O3qvoEy0lyWLl8XNC3UjHmZyjWxzkKgALjG1lsL9qu8CCPyNg+J4m0ag806CDJgs/advX3EcpILttaMAhnUQ9gTFjBppE0zspKTkY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422345; c=relaxed/simple;
	bh=iuMq3JTiLZqCMy2kxXIFv4va3hqoDQqBEMAbgBPU4I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JW3wvqULBvP17n90ucvg/4htPM7YImBIa2PyfCno0OBTPwdd+XWGuTVepxT7yElIeCTZI8HnpySVL9XaPOQhsGfYufdMQK1bxS1D/t/Tw88DqFwzdsKUpig+qXogZll5go33bY3rBfn8WhEwm0RhFPF1mDEStQLNrBzAYQTM+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=223RORSY; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="223RORSY"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d9PD61N1zzlv4VM;
	Mon, 17 Nov 2025 23:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1763422340; x=1766014341; bh=XVZ6FS3tKKq4/qTqZnWjKb9j
	Z2y9vby0LIMsliUe/tw=; b=223RORSYfBiq8F0dHK8fJU2ju4S7tWYt479y57aL
	ccTooTdHRWXFEqFf2PqOZqud0uo0msopySnn1RXMJ/Xmr844t324O1zpKqFBxerS
	iuq1FyaZSbPKQcWwnMOEXOD2XZboJRpLHfQtHJhCBTTBHoYNiAILX9D2zl+gii+P
	QSqzaqg+OeStKyj6RuM0C5gINwArDvz+s1QkPLsYHPrnnZSwsnaMLCmZ5NvFsSOT
	RJ+IDdx3cHkMi4FH66G6ruj6qXIAfIfs8KVOqrFU/RdtCzFvPUgp9gAWpkwTF60s
	26oZY+ukpISV9zZBq5+5CAmbonZ9oue/zSjcCJSw3BKAeg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sQZA3Y-CP1UR; Mon, 17 Nov 2025 23:32:20 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d9PD03fZxzlv4Vb;
	Mon, 17 Nov 2025 23:32:15 +0000 (UTC)
Message-ID: <ed29bdb0-99c6-4b20-8ea0-016d62c3f9b3@acm.org>
Date: Mon, 17 Nov 2025 15:32:13 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper
 rq_qos_add_freezed()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, tj@kernel.org, nilay@linux.ibm.com,
 ming.lei@redhat.com
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-2-yukuai@fnnas.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251116041024.120500-2-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/25 8:10 PM, Yu Kuai wrote:
> queue should not be freezed under rq_qos_mutex, see example index
   ^^^^^               ^^^^^^^                         ^^^^^^^^^^^^^
A queue               frozen                               also

> +int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
> +		       enum rq_qos_id id, const struct rq_qos_ops *ops)
> +{
In this patch and also in the following patches, please fix the name of
this function and change it into "rq_qos_add_frozen()".

Thanks,

Bart.
