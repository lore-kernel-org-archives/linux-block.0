Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682D17D2
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741921823; cv=none; b=MELynt4IIub3xLVTCzxUi2XKTNubUXXeBRXi8UzazpmNBG/CuwGXGmndS6wJ4tZ3LJvgehDLuWOafzbQPESjxKJRFo45LXXrlL7mlhb3v88KzpmwwByh4gWyhKFqUj93drGSPyVehP/iUFhHE3gl+rXOqPKxZzB9HhUGfEqVPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741921823; c=relaxed/simple;
	bh=X/z3UUdvR9yrMohMTgdeXILcgZ23zXPuPhYy86N+Txo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ipe6IsWi0VG/pJMCDSRsDC+qIL+m+nKW7rFE7qu/AqRupfxnbmyT1HvdrnBppWsSsjtC4WfcOna8WfoJjQ+kf2OfkzuDibKt01ruRmZaAM4uUB8dA/ax53QVZ8Mqwa09UfyqB8GosQo+AWF3y/XrMfoxfW3DAtWTahNYjhzjeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ttd2Xdwo; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ttd2Xdwo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741921808; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=acmQjGgV4bYuowmso9MNII6qc3Z8p1Ma9HC0CJSoDGc=;
	b=ttd2XdwoaLEcueQo79G5ZoeQ05hhxDhhGBmOYrzZ73cVXuzgLFormWnHiVNf057wtj4sjU1XjLFR+kl8n3rl9SSL0jdLVIsC2fY+uQ7GJKvS8LO8wyOk4C3MIhZMAeH3+Z9RZbddLg2Szc8PaeRbFyE+frbRc6h1OPClX68YElw=
Received: from 30.178.82.115(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WRJ.WO-_1741921490 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Mar 2025 11:04:50 +0800
Message-ID: <97516917-9dc4-4d1f-908f-3bbdd8d7cb97@linux.alibaba.com>
Date: Fri, 14 Mar 2025 11:04:49 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] block: remove useless req addr print in debugfs
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20250312084743.130021-1-kanie@linux.alibaba.com>
In-Reply-To: <20250312084743.130021-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gently ping...

Best Regards,

Guixin Liu

在 2025/3/12 16:47, Guixin Liu 写道:
> Using %p to print kernel address will only print a hashed address
> which is not the real address, this is useless for issue
> identification, simply remove it.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   block/blk-mq-debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index adf5f0697b6b..b4da95150d8d 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -265,7 +265,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
>   	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
>   	BUILD_BUG_ON(ARRAY_SIZE(rqf_name) != __RQF_BITS);
>   
> -	seq_printf(m, "%p {.op=", rq);
> +	seq_printf(m, "{.op=");
>   	if (strcmp(op_str, "UNKNOWN") == 0)
>   		seq_printf(m, "%u", op);
>   	else
