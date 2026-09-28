Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD24E77E8;
	Mon, 28 Sep 2026 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616390; cv=none; b=I8vQELuTdYQ1weGnHvo07Id/JQPs7OtXyWRLaQpQ32RaY95zWTkxDM4M0Tcm0G5A6L7GNTgdthEoawvPKt0P/X0y2jBvT64OM7XrI1DFFzZ+geBb4sSxcOhdIuSDDN6ZQRZNx8W6Nsv0wqKGLOzzawwoi+bov6qy6HoMGReCh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616390; c=relaxed/simple;
	bh=a+H+MjfUL3lzqQXAOwtAg5XYBfUcFZYCT2CEOl4LhcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAxk/gQLTwIEFMVRiap4l1IF0USLUIutzukBHI5qXB8t4NfcFEfcqbxDg5wqVgCzN9P9mnnjDC/tie+VxVUJurqiymxG9JhBIaj4K/Wi5mou4BTTozSS+le9yOhyNCCXwyWpHW8w3b44VE069H+T76rWo/Hn3vA9zK655uSdqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GdcYo7OR; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GdcYo7OR"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4htpBQ582Gz1XM4TB;
	Mon, 28 Sep 2026 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790616378; x=1793208379; bh=I+yk2wik621uD+oNVuuWlDCM
	mKnUCm3MgHStGhfBNQ0=; b=GdcYo7ORQjBnK0/KP9ad/hCc8eId5Zz0oLKirrGD
	VpnnnqWLM7W2E8SLiMk+7csFIokF6ldEadHkem2zrUNpPUS39frijyucYLHK5XdD
	1T+rPnX2o02Pt9BvUEPpJdtsQBQcyp9n9B66ANdS9NcnJPwZYVouCiKhD4vfDYS9
	+JZwN3qPKHOzrQBVb2ydg4H0EscqyT5mjD64wKuJonUG0JxB8vTMdmYQDNl/0sXR
	i4qUodPvvLb56yCStA+KIJsCocVWQOiguQTuQHGDlhGwTGF0Bdvkd1KjAcv1olnO
	7q9dierj+07977CL8EhmZ/SDg4vuMttiR6xAvqM/eHtE/Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9QGnqzDpKY67; Mon, 28 Sep 2026 17:26:18 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4htpBJ54XTz1XM4Sx;
	Mon, 28 Sep 2026 17:26:16 +0000 (UTC)
Message-ID: <df36224b-7fcb-45c4-ab78-d7e726bfeb9d@acm.org>
Date: Mon, 28 Sep 2026 10:26:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260928093512.3153646-1-cui.tao@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260928093512.3153646-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 2:35 AM, Tao Cui wrote:
> @@ -1148,6 +1182,16 @@ static void __loop_clr_fd(struct loop_device *lo)
>   	lo->lo_backing_file = NULL;
>   	spin_unlock_irq(&lo->lo_lock);
>   
> +	/*
> +	 * Invalidate any clear that was scheduled against the old backing
> +	 * file.  Unbinding cannot race with in-flight I/O, so cancelling
> +	 * here leaves no work item behind.
> +	 */

This comment is wrong - asynchronous I/O can still be in progress here.
See also
https://lore.kernel.org/linux-block/69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp/

Should this patch perhaps be rebased on top of Tetsuo's series?

> @@ -1783,7 +1827,9 @@ static void lo_free_disk(struct gendisk *disk)
>   		destroy_workqueue(lo->workqueue);
>   	loop_free_idle_workers(lo, true);
>   	timer_shutdown_sync(&lo->timer);
> +	cancel_work_sync(&lo->clear_limits_work);
>   	mutex_destroy(&lo->lo_mutex);
> +	mutex_destroy(&lo->clear_limits_lock);
>   	kfree(lo);
>   }

Is the above new cancel_work_sync() call really necessary?

> @@ -2140,6 +2188,12 @@ static int loop_add(int i)
>   
>   static void loop_remove(struct loop_device *lo)
>   {
> +	/*
> +	 * Cancel early: the queue may already be in RCU-delayed freeing
> +	 * by the time lo_free_disk() cancels the work item.
> +	 */
> +	cancel_work_sync(&lo->clear_limits_work);
> +
>   	/* Make this loop device unreachable from pathname. */
>   	del_gendisk(lo->lo_disk);
>   	blk_mq_free_tag_set(&lo->tag_set);

Is the above new cancel_work_sync() call necessary since there is
already an identical call in __loop_clr_fd()?

Thanks,

Bart.
