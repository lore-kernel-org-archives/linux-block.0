Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF521018A
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812765; cv=none; b=NXLluKqG1H9HtTmgrVh7tWmoJY2kP+CKQZGFbNyAEngAGkz4oUaQfyDXt3sH6McNt+hYXCTON5xIDS2k3bDoNMf7iupxXk1GAyfP+2ke+15KipB3l+DGRBfm7QglX1HvMRmHAe5/vKKv1wDtJlCP/LX0UUbkizL+8Lg/4Nr+LUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812765; c=relaxed/simple;
	bh=7KQuQY+z5lmandK6lDHf1l0pixbGUyiXgGM8OAGz2dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIWsc0oN3GkrDpA4TgS5d8naPjohjPqI6CFP8XN6wHsrbg+hD3pEDFvcpqrsGgIshDrSfK1c6JZV2OHdmRr0/gw77oNKAAYWgl80mZcwSe9ayddqTg/Aren61mGhPPIURXE57GOsC4ujqIchKxGC6oEytwqo+1YV9bWBdyuwhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=jt6aEi37; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="jt6aEi37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1778812761;
	bh=juH4/2LtcQFOC3Mvl0hMLSOSKYO8G6JssK+pFuVHxm8=;
	h=From:Subject:Date:Message-ID;
	b=jt6aEi37NRCFA5LiZLK97MgFGSJxSpvVJIiECiP3Z4xv2jajBUVyd/0DBzfmHMuK/
	 xQe3CDc3hLl0Psot7ghDvEuLrTlgH7xV9pofLPIgCEeTEHttbLxA2MWngwVMYhmFc1
	 slO6Q1hs2G7vjJOD8IkzoFniRHyuBuf8LjjN6IRg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.32) with ESMTP
	id 6A06873000003E37; Fri, 15 May 2026 10:38:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4351434456928
X-SMAIL-UIID: 03741D15D2E944F5BB77B88B30414870-20260515-103842-1
From: Hillf Danton <hdanton@sina.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] block: add task-context bio completion infrastructure
Date: Fri, 15 May 2026 10:38:41 +0800
Message-ID: <20260515023845.684-1-hdanton@sina.com>
In-Reply-To: <20260514-blk-dontcache-v6-1-782e2fa7477b@columbia.edu>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 17:51:14 -0400 Tal Zussman wrote:
> +
> +static void bio_complete_work_fn(struct work_struct *w)
> +{
> +	struct delayed_work *dw = to_delayed_work(w);
> +	struct bio_complete_batch *batch =
> +		container_of(dw, struct bio_complete_batch, work);
> +
> +	while (1) {
> +		struct bio_list list;
> +		struct bio *bio;
> +
> +		local_lock_irq(&bio_complete_batch.lock);
> +		list = batch->list;
> +		bio_list_init(&batch->list);
> +		local_unlock_irq(&bio_complete_batch.lock);
> +
> +		if (bio_list_empty(&list))
> +			break;
> +
> +		while ((bio = bio_list_pop(&list)))
> +			bio->bi_end_io(bio);
> +
> +		if (need_resched()) {
> +			bool is_empty;
> +
Checking resched is not needed as workqueue worker can be preempted
while processing bios．Given batch and delayed work, I suspect completing
more than batch, the bios accumulated within a jiff, makes sense.

> +			local_lock_irq(&bio_complete_batch.lock);
> +			is_empty = bio_list_empty(&batch->list);
> +			local_unlock_irq(&bio_complete_batch.lock);
> +			if (!is_empty)
> +				mod_delayed_work_on(batch->cpu,
> +						    bio_complete_wq,
> +						    &batch->work, 0);
> +			break;
> +		}
> +	}
> +}
> +
