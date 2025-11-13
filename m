Received: from sg-1-23.ptr.blmpb.com (sg-1-23.ptr.blmpb.com [118.26.132.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A03320391
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014922; cv=none; b=JeBkBegCkjfP+XBUjwKwIa2w8OsqoV7ZkH6496p9RRt9FkeTK5Dur+AIlwjrmRiFfNM3Bt61KwoZ20NSLE4Q2Vig1/JMJkMq8RmSrp/lo8rOjZuLiYedBldkpoIHR1Sm4pVn9+vTEWUuKsRZcwbnkjLVd1gW7+JkjfztysXAa0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014922; c=relaxed/simple;
	bh=VDppA1raBk3byxzOX9WJP8x+stA+99tJlfzq4C4LOLw=;
	h=Date:References:To:Subject:Mime-Version:Message-Id:Content-Type:
	 From:In-Reply-To:Cc; b=l8pQiz/+PeBhj7tLrlaxWsfrDM/a98Msr42++aHlUs51honjuCJHKv51I4LDwRNh6J1b+Mu+walQF+qR2ZKNnnJeodLTTlA42zNrq1LF6avbkCShnZE0eBrQTVl+FpP3Rr5i4QxnFKwSEhXjIuJhJCRSnhBeoctCV9/ETOsLqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=kEMtUpLA; arc=none smtp.client-ip=118.26.132.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="kEMtUpLA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763014907;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=O4FnNUGIVrWOlZj3gs8+o8dTf8lFMUoT5T1q6ALo5YE=;
 b=kEMtUpLAJTK2uTrl0UZTvEDfQpAgR6UNCKeQLDmHFUthzuRVOB8ZXT1sJX1vOF4nZPtofj
 RYnncKyVt+niUpLT08xntwuQakKQfbpmVgkWTPk/hqKDtmFMCPWRQdPqIHxT6/VC2EueY0
 wjKqIPvxg/TtmEPueX1e2/IOGfhtQ1IKjUpvl8NDw6qsMkcJQ1VrPgboYmAign3/cIjXq8
 r05u2OVI8/mP+e6zho7U7ZcW2bBFjVKZFzQEZoFlnQWwj2kso1AXwvkL8IZXSzu4VXIZF4
 b5HMEvKylhp/lq2/oJvFfl77s0EqC6/lUnb2gQ+QkdP2/Fy5z3Hm5a5duClGKA==
Date: Thu, 13 Nov 2025 14:21:43 +0800
X-Lms-Return-Path: <lba+2691578fa+9b108d+vger.kernel.org+yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.130]) by smtp.feishu.cn with ESMTPS; Thu, 13 Nov 2025 14:21:45 +0800
References: <20251112132249.1791304-1-nilay@linux.ibm.com> <20251112132249.1791304-3-nilay@linux.ibm.com>
Content-Language: en-US
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
Subject: Re: [PATCHv6 2/5] block: move elevator tags into struct elevator_resources
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com
Message-Id: <2d48520a-9352-49ae-ad7c-c3e71f12ac17@fnnas.com>
Content-Type: text/plain; charset=UTF-8
From: "Yu Kuai" <yukuai@fnnas.com>
In-Reply-To: <20251112132249.1791304-3-nilay@linux.ibm.com>
Cc: <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>, 
	<yi.zhang@redhat.com>, <czhong@redhat.com>, <gjoyce@ibm.com>
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2025/11/12 21:22, Nilay Shroff =E5=86=99=E9=81=93:
> his patch introduces a new structure, struct elevator_resources, to
> group together all elevator-related resources that share the same
> lifetime. As a first step, this change moves the elevator tag pointer
> from struct elv_change_ctx into the new struct elevator_resources.
>
> Additionally, rename blk_mq_alloc_sched_tags_batch() and
> blk_mq_free_sched_tags_batch() to blk_mq_alloc_sched_res_batch() and
> blk_mq_free_sched_res_batch(), respectively. Introduce two new wrapper
> helpers, blk_mq_alloc_sched_res() and blk_mq_free_sched_res(), around
> blk_mq_alloc_sched_tags() and blk_mq_free_sched_tags().
>
> These changes pave the way for consolidating the allocation and freeing
> of elevator-specific resources into common helper functions. This
> refactoring improves encapsulation and prepares the code for future
> extensions, allowing additional elevator-specific data to be added to
> struct elevator_resources without cluttering struct elv_change_ctx.
>
> Subsequent patches will extend struct elevator_resources to include
> other elevator-related data.
>
> Reviewed-by: Ming Lei<ming.lei@redhat.com>
> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.c | 48 ++++++++++++++++++++++++++++++--------------
>   block/blk-mq-sched.h | 10 ++++++---
>   block/blk-mq.c       |  2 +-
>   block/elevator.c     | 31 ++++++++++++++--------------
>   block/elevator.h     |  9 +++++++--
>   5 files changed, 64 insertions(+), 36 deletions(-)

Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thanks
Kuai
