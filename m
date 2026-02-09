Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8A3815F1
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655243; cv=none; b=EbaY9i6NlTzOhrd69Bn6MqblRq1Kh6tVWs+81pSVq/nEHoUbMlam8pfqWFq83M1ve3Oy/jAClKPxmuWFdop0DEnGBlODPxnB/rIelYWb1dqPCMIADgvETTD8GyoXQ0lXnHFghsh7hcDkX9yD6rHT3sxVaO79IPS/EM9CaE5rwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655243; c=relaxed/simple;
	bh=j17AXHvSfHr99CYKY7pg836e+SsOVBK4hwZSWsKn9nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrBqnDF9YnUxjks3lwZbKQ4t3DGXhONF85ckPe5S1YMgHSEoBuTLiMIOWwYYEGK/cckS4aGDu5X4GMdL8z+KjhOB24LH8Ywv9woUf1kglNtJc8wokrYbmVnhIpsNMbBVnFaTo1bqm+SxSlN/Fk8KNlU5nvfa2fARP5kyMuq4Syw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gXyMG2vm; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gXyMG2vm"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f8r6F2zhFzlqg85;
	Mon,  9 Feb 2026 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770655234; x=1773247235; bh=Q1K6d3mqNvtObYRv0jI7YV2Y
	MQtcUg2MGGkrrLlVLPg=; b=gXyMG2vmyAaNcISogIa5KKaPQuWdvp6J9luuWn66
	ue2QPM8f0nsc/37ME9JxNwoY+mM3+/sDEoyiBNvIRsP32cQnWf3FIn3xKmMKx/t1
	9y0LiGmQNVmsAF60sdkCYczQwyxs3IqGJIV3WYOclERGVj9pkOSg/exSX5lE65Iu
	NLW1v2gBcgIdTvkSpIfkiVFCa2b89gv3CX1KJdN9jOxZHWRV7G/TRjIEvSU0/Bsk
	ct+CTFp/bZJ23+RJPk2XQZeQf8rcEltyLt3WtU+CdMOCs1YGytpPEC8qMZuh1GPg
	SGMYVkGjgNtc04pntPO4QjsgU00JHYyPsrUD5IznkRjtKA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id i-vtrfhRE5Nj; Mon,  9 Feb 2026 16:40:34 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f8r664BhGzlqk1m;
	Mon,  9 Feb 2026 16:40:30 +0000 (UTC)
Message-ID: <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org>
Date: Mon, 9 Feb 2026 08:40:29 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs
 file creation
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, sven@kernel.org, j@jannau.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com, neal@gompa.dev,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-5-yukuai@fnnas.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260209082953.3053721-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/26 12:29 AM, Yu Kuai wrote:
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index faeaa1fc86a7..03583d0d3972 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
>   				 const struct blk_mq_debugfs_attr *attr)
>   {
>   	lockdep_assert_held(&q->debugfs_mutex);
> -	/*
> -	 * Creating new debugfs entries with queue freezed has the risk of
> -	 * deadlock.
> -	 */
> -	WARN_ON_ONCE(q->mq_freeze_depth != 0);
>   	/*
>   	 * debugfs_mutex should not be nested under other locks that can be
>   	 * grabbed while queue is frozen.

The above looks fine to me.

> @@ -628,9 +623,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
>   	if (IS_ERR_OR_NULL(parent))
>   		return;
>   
> +	/*
> +	 * Avoid creating debugfs files while the queue is frozen, wait for
> +	 * the queue to be unfrozen and prevent new freeze while creating
> +	 * debugfs files.
> +	 */
> +	if (blk_queue_enter(q, 0))
> +		return;
> +
>   	for (; attr->name; attr++)
>   		debugfs_create_file_aux(attr->name, attr->mode, parent,
>   				    (void *)attr, data, &blk_mq_debugfs_fops);
> +
> +	blk_queue_exit(q);
>   }

This is not clear to me. Why are concurrent queue freezes not allowed
while debugfs attributes are created? I don't see any code in debugfs
that calls back into the block layer while creating debugfs attributes?
Did I perhaps overlook something?

Thanks,

Bart.
