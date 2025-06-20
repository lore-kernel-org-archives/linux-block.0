Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80E2DF3D1;
	Fri, 20 Jun 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435224; cv=none; b=hwEIupN16+ugIyc4kEgE8I3WYmlXU8qJaTZPmZqwzj7bbgO8sgIfK6N+8Y2B4NRxH6ZTjCT0r96MQ1Pagu546CqhR9H8K7wf63AFrJC8KF66YSX6jvXW5K8gXXCfk15mPSx8BVgSm7u4uX1iLsw7082CT4SFdBvutW5Q1HGP4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435224; c=relaxed/simple;
	bh=0Tra1843jmm9hB/IPbor7LgwCzJ0hIXr5r965/fV3JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZyY+MMhel2/n1cOh5t3lfwwCajoSjXfrebo+CB51DWPsuorBIX1K9bWPi8nS1OPnoMZEeJDc1buXNnH+TBLyf97PeIV5BsJ085r4eSpgeRmJGZiEv6DPJfg49DQwz9R6Ai8ExWQfID5FhCapaVqEGxqRP85rUbjqESUiashk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ylu/cWtj; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ylu/cWtj"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bP2Hg5XCYzlgn8k;
	Fri, 20 Jun 2025 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750435213; x=1753027214; bh=VfNRI3BjuugSr0OXWJjcf+of
	9TA6jIqcVZZJHTzRJeQ=; b=Ylu/cWtjYZcl2Qte27ZG2/YlLrjxCmJHBbxtnDv7
	68FMT/8DOJalAQvZNFj8aXIo0LR7y2rs2EyoFpxrOXF2VFcEvsUZ8TLSpK05ZwyX
	GLnu3xO5Z229ukv/CTIqkkTwsD473UgYvQTn4AS1Vv5zuiIvn/K1NwK6fpragQ+q
	L9kd111mJp2aC6GrNhlQ+JYeULbeOF+VaqeLmiz/VLn89pVWcvgjJMqX39np8OSr
	uhu8R6kWedXAlbNJAt7fZ9RjWiYY6hJ+5mwaDrHsg+A8Mqbhwget/q3h4yhIlAY8
	/9Rjhq7KcLnE513thGEu8tgOpvfyoGXhjbk5IMfuDJ10xA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uVJuV67gQTBt; Fri, 20 Jun 2025 16:00:13 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bP2HP2NXXzlgqV9;
	Fri, 20 Jun 2025 16:00:00 +0000 (UTC)
Message-ID: <ef9bcc7e-a726-43e1-a51e-47093589b01c@acm.org>
Date: Fri, 20 Jun 2025 08:59:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/27] block: Protect against concurrent isolated cpuset
 change
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Marco Crivellari
 <marco.crivellari@suse.com>, Michal Hocko <mhocko@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Waiman Long <longman@redhat.com>, linux-block@vger.kernel.org
References: <20250620152308.27492-1-frederic@kernel.org>
 <20250620152308.27492-12-frederic@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250620152308.27492-12-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/25 8:22 AM, Frederic Weisbecker wrote:
> The block subsystem prevents running the workqueue to isolated CPUs,
> including those defined by cpuset isolated partitions. Since
> HK_TYPE_DOMAIN will soon contain both and be subject to runtime
> modifications, synchronize against housekeeping using the relevant lock.
> 
> For full support of cpuset changes, the block subsystem may need to
> propagate changes to isolated cpumask through the workqueue in the
> future.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   block/blk-mq.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..ece3369825fe 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4237,12 +4237,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   
>   		/*
>   		 * Rule out isolated CPUs from hctx->cpumask to avoid
> -		 * running block kworker on isolated CPUs
> +		 * running block kworker on isolated CPUs.
> +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> +		 * here.
>   		 */
> +		housekeeping_lock();
>   		for_each_cpu(cpu, hctx->cpumask) {
>   			if (cpu_is_isolated(cpu))
>   				cpumask_clear_cpu(cpu, hctx->cpumask);
>   		}
> +		housekeeping_unlock();
>   
>   		/*
>   		 * Initialize batch roundrobin counts

Isn't it expected that function names have the subsystem name as a
prefix? The function name "housekeeping_lock" is not a good name because
that name does not make it clear what subsystem that function affects.
Additionally, "housekeeping" is very vague. Please choose a better name.

Thanks,

Bart.
