Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28C2869E
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751594498; cv=none; b=RIpWkYAcg5X3Aidfybcq7UOfh+/OroH24ki5fRLGd3J5vrTnlaYc++jfh4IcLoZbRy+0pSrbY/YOMruPuJOLioVzbeJB8TSZz63dxmDzPuS+8C+nCcKf9RvuiIutuyRZYly1FMQ5yS78rftQ+Jf+crmjAatCWDuZ9UyxCWU2iHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751594498; c=relaxed/simple;
	bh=/bwCDGiULWsk903yyj9OaYZBAvzld9j5ug75Ptf+UZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCVGW9nRB1QRpI/CgNOb0Sp2YrX3GulHkpHkrjb2kaWfuFSx+LE9FbC3/byI7sayJ8yljRtkN/xlVv770TdeaZN7tPkFwYOYCoduVLElsU5EzGriLuogPu7dvF7yJEGCzEx7X7CAqNtYMqWsSdMlbT6t2rHxT0xTJZXq3P0XNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZSNC/L8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZSNC/L8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73063C4CEE3;
	Fri,  4 Jul 2025 02:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751594498;
	bh=/bwCDGiULWsk903yyj9OaYZBAvzld9j5ug75Ptf+UZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aZSNC/L8UmSrhI0nuV5qWVlnAIjQQxvY839hTleCrIyOPRb2gcBgeL8ag4MDyPPD1
	 NMlhVooYdKwflRaNfi/d13/qeX601wTKdb9JQvD6jVnZBCDj2ZiF5ErgHCMxHYY3dD
	 vVG9y0SAcJ/dpSqv4XD83bDgjcRFVA6rXG0ErGLizmMAnsdBntbQebKYGSWTVaCBeX
	 PpLIFCun76Cr4gnHj8qdgVoRv1zQachT0Iw9Msgfz1wLGBMAn2QRQqfF6t2hSFxni6
	 OhsXZdLCDHpTBCJC6oyE18eYg0XF4l9EYqbqOTz51YpF7YwyRHAKjfVJHApA1YPMHp
	 wlUwiRPcZLH+A==
Message-ID: <4afa3632-96ed-44a0-afe0-a30144c84897@kernel.org>
Date: Fri, 4 Jul 2025 11:01:36 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] swim3: Remove the quiesce/unquiesce calls on frozen
 queues
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
References: <20250702203845.3844510-1-bvanassche@acm.org>
 <20250702203845.3844510-8-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250702203845.3844510-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 05:38, Bart Van Assche wrote:
> Because blk_mq_hw_queue_need_run() now returns false if a queue is frozen,
> protecting request queue changes with blk_mq_quiesce_queue() and
> blk_mq_unquiesce_queue() while a queue is frozen is no longer necessary.
> Hence this patch that removes quiesce/unquiesce calls on frozen queues.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/swim3.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
> index 01f7aef3fcfb..8e209804ceaf 100644
> --- a/drivers/block/swim3.c
> +++ b/drivers/block/swim3.c
> @@ -850,8 +850,6 @@ static void release_drive(struct floppy_state *fs)
>  	spin_unlock_irqrestore(&swim3_lock, flags);
>  
>  	memflags = blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue(q);
> -	blk_mq_unquiesce_queue(q);
>  	blk_mq_unfreeze_queue(q, memflags);
>  }

With your changes, the pattern:

	memflags = blk_mq_freeze_queue(q);
	blk_mq_unfreeze_queue(q, memflags);

is repeated several times. So maybe make that a helper ? Naming it is tricky
though. Maybe something like:

static inline void blk_mq_drain_queue(q)
{
	unsigned int memflags = blk_mq_freeze_queue(q);

	blk_mq_unfreeze_queue(q, memflags);
}


-- 
Damien Le Moal
Western Digital Research
