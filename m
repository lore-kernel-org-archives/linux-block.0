Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB23074A4
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760415591; cv=none; b=tMuXCkyMepsbbHzcV1c+uci5c/vNB6ui8sIm/UZxc7l7K2I42JNBUQLE0+YXQfmIeb2+qesD7W416PIJrThG73f3Pe5YkRjS/M91opTem9VOpAw+vt+tAKiMUOPUiusYaXEnBA2vnpj7ya1BIPkrlu8O9J+sZzIIfMNxBza3SvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760415591; c=relaxed/simple;
	bh=efRncSBox4EGtM3nSmQtO2KgUENSolfoFMtV3iP5wsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0SNZ9UthVCIYNKcXOVdrA5gaMi2c/i213lCJlPF02hzPqBuHOVIGHqeXZ0ZAzMtRmNzWVJzUTJQB/0zGL1IveTttIz2mUC5KGDDHoH4lY9AoAzF99Wzg5kvATAzQDpaGM/z+RndHRhlRFpJ0Cx40QbamRz/PYu0yzI81Pk7GOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvwrugtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvwrugtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56663C4CEE7;
	Tue, 14 Oct 2025 04:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760415591;
	bh=efRncSBox4EGtM3nSmQtO2KgUENSolfoFMtV3iP5wsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TvwrugtqZ23dFB/les8IOa7mhmzv/nj3tlgQQrlZCXnB3w49BZ2AL3pCKxQ5OV3tn
	 2NkaK0c4h5lT9/L6Ug6cxKhBvKmGCFswTn3cy90uuJ6GrB6QSNtOHtFkNXPgw6Z0gF
	 LlnxwmIF+ERrzreOWXOC7/cfwHzI2PqjplN4Oed3/K9P26kpJp+HAiOt/WOJweS3dk
	 UPy4NyC+9yKmv0m5QQSSlf5muRfTucRqK3p4nWefo/fTOnOkNEZgh7/GFD3YjuNR8f
	 dEbDt5ZXqjF86goXzuSXC+ZrQPty0Kqf4J6VfTnVk4kz2RqGejKCnkYG13ttJ2Ryq8
	 riHJsMocM5ZwA==
Message-ID: <19be10e7-3140-4571-bf0e-e8eec1188fec@kernel.org>
Date: Tue, 14 Oct 2025 13:19:47 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: Switch back to a single dispatch
 list
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Yu Kuai <yukuai@kernel.org>, chengkaitao <chengkaitao@kylinos.cn>
References: <20251013192803.4168772-1-bvanassche@acm.org>
 <20251013192803.4168772-3-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013192803.4168772-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/14 4:28, Bart Van Assche wrote:
> Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
> modified the behavior of request flag BLK_MQ_INSERT_AT_HEAD from
> dispatching a request before other requests into dispatching a request
> before other requests with the same I/O priority. This is not correct since
> BLK_MQ_INSERT_AT_HEAD is used when requeuing requests and also when a flush
> request is inserted.  Both types of requests should be dispatched as soon
> as possible. Hence, make the mq-deadline I/O scheduler again ignore the I/O
> priority for BLK_MQ_INSERT_AT_HEAD requests.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Yu Kuai <yukuai@kernel.org>
> Reported-by: chengkaitao <chengkaitao@kylinos.cn>
> Closes: https://lore.kernel.org/linux-block/20251009155253.14611-1-pilgrimtao@gmail.com/
> Fixes: c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Nice cleanup !

Reviewed-by: Damien Le Moalv <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
