Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CF278165;
	Tue, 10 Feb 2026 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759579; cv=none; b=UnZvVXpPmCR9WLmH1323XLmL4ixpJIWRk2YeBwDE5EEVGXqNJ5N/syiOlHAb2r7EjZ7NIzR69R0NwTbfGiI3OW1V7A/MgbQP/JXGpjqWFJBm1PIvlYKSnc1S2adbwWmz4R5OOKEwm1ADJ7OznJ4B5XD1GXmggAGo3fnPx0T40II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759579; c=relaxed/simple;
	bh=JdHRuYaS9bQXI/jdqtNFuAqPV2y9veTWk7cqMY3/2fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA3jlqMvsuTxzuiIhb/v/7s+4v/u1FkhdQI5M5Wx5u65lD9mk8mVMwGE8n3IAkBKc+mdjD0Q0lrvhc2Ncek1ZoGkvo+Znd7w84clXJnqoRTyY6ZldAuAoJL1bTrJ3HSaTojtHRbVyowfwo7LIWVYpsSev3ztganAUJAEszNpXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urOTVYFS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urOTVYFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667EBC116C6;
	Tue, 10 Feb 2026 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770759579;
	bh=JdHRuYaS9bQXI/jdqtNFuAqPV2y9veTWk7cqMY3/2fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urOTVYFS+mUondOoxL+l2oYc/a5lWLk1tUax5EZlpggIg4dk0s4lPbDpGNNpFkCoF
	 3Wha0EBFkwC/2OlsnSIHHg10kQUdL7eO9ssujQBJ9jqczEMtcpOHfXAtrN/O8Uewze
	 Q52vFd/Kq6wPYrB31+PMaBSB6HpL5sDFGMhMK83Xe93CcC94e3sZjzfnY6XPOaUju1
	 WYrFqK+Z3qtJv9oHBXg0LnFberbQduzfMN9ST6PUHFKEMK2E5SI+aIJsnAzvSYPxPp
	 oO9NP6nQ8LTG71ZGWcR28xv/CyVOPmmG4RxwmtnO52jE5nxH2IpGCfH8MbOLGPttSE
	 TQL/v56NhPzwQ==
Date: Tue, 10 Feb 2026 14:39:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	ming.lei@redhat.com, muchun.song@linux.dev,
	mkhalfella@purestorage.com, sunlightlinux@gmail.com,
	chris.friesen@windriver.com, stable@vger.kernel.org,
	ionut_n2001@yahoo.com, bigeasy@linutronix.de
Subject: Re: [PATCH v2 1/1] block/blk-mq: fix RT kernel regression with
 dedicated quiesce_sync_lock
Message-ID: <aYulmBtfi3A9TJZu@kbusch-mbp>
References: <20260210204943.21709-3-ionut.nechita@windriver.com>
 <20260210204943.21709-5-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210204943.21709-5-ionut.nechita@windriver.com>

On Tue, Feb 10, 2026 at 10:49:46PM +0200, Ionut Nechita (Wind River) wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0ad3dd3329db7..888718a782f88 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -171,7 +171,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,
>  		percpu_ref_kill(&q->q_usage_counter);
>  		mutex_unlock(&q->mq_freeze_lock);
>  		if (queue_is_mq(q))
> -			blk_mq_run_hw_queues(q, false);
> +			blk_mq_run_hw_queues(q, true);

I didn't see the reasoning for this path to run in async mode. Is this
change related to this patch?
