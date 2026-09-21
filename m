Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422973290AA;
	Mon, 21 Sep 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011684; cv=none; b=MdVNziGvNzJLboucXtoiQioYGCerApkTbYEeHgG8S2nBNac9oMyo4HOOCgCJpT1rU2WLgNswYKWV0GQ4qQJbvA4TnA3J808wJEI1SfYiu2vKe6xEe5y+3QygiKlBUxhjY8dGGSZaMOEYnDtZtXnrCOWL6/+G8Ch+jqnGjlmfVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011684; c=relaxed/simple;
	bh=yUgPAsGODFo/WbxGPEZgi9eL2qVTmnv+llaOMNpBMXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nScMGZVlW7GKGnMJBg++XPIsbDU+H+8B1wROKf5oadeVtufsy97dAbX67vnW3N+8YSo4Dbv0Zrkw5bCJNdIJuzyO9+WeM34T0wgfxwJ1TF2Jnrb0YrxWeuQS/dFxOHtbGHr1rCLvUAqGKrDo0O3kxaOji1vYWLXDYAdq+/UN2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EGgzuX0q; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EGgzuX0q"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hpVYZ1WZ2z1XM4Tn;
	Mon, 21 Sep 2026 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790011669; x=1792603670; bh=Zu0vvQlvdONab+lcfCw2kySy
	AZiMONJq//ESXNNrzOI=; b=EGgzuX0qwhtiQXEmfTxNrs3qek8kpCU/e3wxDiTm
	7KOokRhVDJXLnTyEnC74/z8w2NcS7l+aTIwY0U31OwI+voTNksK0pcV8DEbJSt6g
	6P1JWb5ixHK13O3pWk2a9M4cdsC19iiaP5ddIdbeiWCVOeYOym/5hbi1cTyGEhCL
	AHfFyu7vbZhY7OrTep9V7NmR3t5TEF+ClHXkgzvmDQb1D5jYItQlhZD0P+HtncNM
	fL3F5g7Xi2qSaLinyw/4uu8YavaUPiiAsfW4336MnCH0F53OCn0+cspNFnIdz+t2
	0wEQPWI5NKofl1blwYlsmj1VlxvprMD/M4A8yA8VGps++Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 55PwjSU8twFO; Mon, 21 Sep 2026 17:27:49 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hpVYF0Tdhz1XM4TB;
	Mon, 21 Sep 2026 17:27:44 +0000 (UTC)
Message-ID: <afbf50a0-d409-45a3-8e95-99c04ca0e302@acm.org>
Date: Mon, 21 Sep 2026 10:27:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] block: Add run_todo() operation
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 rust-for-linux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/26 3:50 AM, Tetsuo Handa wrote:
> Add run_todo() block device operation which provides a hook for performing
> synchronous cleanup without disk->open_mutex held, which is needed by the
> loop devices.

I like the "post_release()" name much better. I think it is more clear
and more descriptive than "run_todo()".

> diff --git a/block/bdev.c b/block/bdev.c
> index cd8323083740..8f09aafbae11 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -974,6 +974,8 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>   	bool unblock_events = true;
>   	struct gendisk *disk = bdev->bd_disk;
>   	int ret;
> +	struct module *fops_owner = NULL;
> +	void (*run_todo)(struct gendisk *disk) = NULL;
>   
>   	if (holder) {
>   		mode |= BLK_OPEN_EXCL;
> @@ -996,6 +998,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>   	ret = -EBUSY;
>   	if (!bdev_may_open(bdev, mode))
>   		goto put_module;
> +	run_todo = disk->fops->run_todo;
>   	if (bdev_is_partition(bdev))
>   		ret = blkdev_get_part(bdev, mode);
>   	else
> @@ -1037,12 +1040,15 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>   
>   	return 0;
>   put_module:
> -	module_put(disk->fops->owner);
> +	fops_owner = disk->fops->owner;
>   abort_claiming:
>   	if (holder)
>   		bd_abort_claiming(bdev, holder);
>   	mutex_unlock(&disk->open_mutex);
>   	disk_unblock_events(disk);
> +	if (run_todo)
> +		run_todo(disk);
> +	module_put(fops_owner);
>   	return ret;
>   }
The above changes introduce a bug: these changes cause module_put()
to be called if try_module_get() fails. I think that's wrong.

Thanks,

Bart.
