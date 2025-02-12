Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2F2063D6
	for <linux-block@vger.kernel.org>; Wed, 12 Feb 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354142; cv=none; b=k1yBwV1kOQNm0T7YWmb4x5PyMCFzL9b0+5amGrcU0thRHQmf5cm6Kofmb8dDc+BpAkGBD+rSLoZfNcstlQ/eDH3Df6H77mG3zq1fstdNdZrzd8mLJbcp/pqLj1XX2IpCAgZhwqhHrpwE9wf59DZlKZVxeEVYV7oc2LjXHv76UqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354142; c=relaxed/simple;
	bh=Tc/cG7T+M/sAxY1Ck/x8IJAYIxOhHEGgEt7sTf/dxys=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CYeCRTjjS4plcJ6Nlhw+4+nJPKiLNa0/MBtlMflq3yOT/JkOSYLb0J+eUhir4g8jZOFMC/Ov9svDWb/4kpQ/TyA8HuRMdon33rtgT/vGqOMADhef0whbRDiAP8T5xfL4dozB+DSJTRdIReQ7jv+bhNP7mlSOCM5GmGjE9FdR7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rQz5w4NW; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rQz5w4NW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739354137; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=kpD8O0/pBIrsC7i0Bb1MrYIHRtYE1F0jvyEMHEU1yRo=;
	b=rQz5w4NWNYx0kSTtJAPHV6046JGLRpMrr+rQZUplE3XBhOf/qgJlnsU8Kqd0hhCFyRZ8A6iU04rbDSm4knQWrd+lGn9CjshJaJfIgq+de5nULYupdTWDWPGyHW48hFRkpCk1XC9r3s6xv6K9Ujz49gpSuEr44f2hYCp1IzdhhXM=
Received: from 30.178.82.44(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WPJreib_1739354135 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 17:55:36 +0800
Message-ID: <ce305c08-af9b-4f4f-86ca-3832791bb7a4@linux.alibaba.com>
Date: Wed, 12 Feb 2025 17:55:35 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH RFC] block: print the real address of request in debugfs
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20250208035224.128454-1-kanie@linux.alibaba.com>
In-Reply-To: <20250208035224.128454-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gently ping...

Best Regards,

Guixin Liu

在 2025/2/8 11:52, Guixin Liu 写道:
> Since only root user can access debugfs, for easier issue
> identification, use '%px' to print the request's real address in
> debugfs.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> Hi,
>    I notice that block dont print the real address in
> debugfs for a long time, I wonder what the community's
> concerns are, thanks, so this is a RFC patch.
> Best Regards,
> Guixin Liu
>
>   block/blk-mq-debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index adf5f0697b6b..c430d931512f 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -265,7 +265,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
>   	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
>   	BUILD_BUG_ON(ARRAY_SIZE(rqf_name) != __RQF_BITS);
>   
> -	seq_printf(m, "%p {.op=", rq);
> +	seq_printf(m, "%px {.op=", rq);
>   	if (strcmp(op_str, "UNKNOWN") == 0)
>   		seq_printf(m, "%u", op);
>   	else
