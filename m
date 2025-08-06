Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A2D23CE
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754448669; cv=none; b=CeBZM4SVLaEgz0sUYCbgJuzEFfzmCUexcuo6ResHL6h+NDTd1uXr2Hc2tCIGUA2jvNFAWkApigtb1hvFrzbePX1jEnhLPBdVvGTY8on5eqU656uW2KE1cozBi6T6uFIh5xYvdiJsuOA+9ePdC3vs23SakwTlbF2IX/C/S3hroqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754448669; c=relaxed/simple;
	bh=xm1MIWKISHZ40f/YCIpZTONFAPQxhnknr8ymvqgQ1Qg=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=UFch5m++LMTf52cWF49O87IMRrXelDx4OiQx1yusbFXgnzAyQs5afj4rDU8rdtz4gczI/u1r2WTiWm7ZEasFpfGLgGgh5sLeG3MmOaaH4prtTPftJNZ0mvCdm2dqVxN/Y0ezod+TSGlzzPyUaJglZPXQ9oiPAuMIWD9z/5Mb9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bxZYF5LKYz6FyBy;
	Wed, 06 Aug 2025 10:50:57 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 5762omgm056953;
	Wed, 6 Aug 2025 10:50:48 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 6 Aug 2025 10:50:49 +0800 (CST)
Date: Wed, 6 Aug 2025 10:50:49 +0800 (CST)
X-Zmail-TransId: 2af96892c309ffffffffdf8-643cb
X-Mailer: Zmail v1.0
Message-ID: <2025080610504934810yy8xTXsec9HpIXS8-2K@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <tom.leiming@gmail.com>, <thomas.hellstrom@linux.intel.com>
Cc: <linux-block@vger.kernel.org>, <zhang.anmeng@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <axboe@kernel.dk>
Subject: =?UTF-8?B?UmU6wqBbUEFUQ0hdIGJsb2NrOiBtYXJrIEdGUF9OT0lPIGFyb3VuZCBzeXNmcyAtPnN0b3JlKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5762omgm056953
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 06 Aug 2025 10:50:57 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6892C311.001/4bxZYF5LKYz6FyBy

> sysfs ->store is called with queue freezed, meantime we have several
> ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> memory with GFP_KERNEL which may run into direct reclaim code path,
> then potential deadlock can be caused.
> 
> Fix the issue by marking NOIO around sysfs ->store()
> 
> Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)

Excuse me, does the issue to fix comes from f1be1788a32e ("block: model freeze &
enter queue as lock for supporting lockdep") ?

Thanks.
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e828be777206..e09b455874bf 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -681,6 +681,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>  	struct queue_sysfs_entry *entry = to_queue(attr);
>  	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
>  	struct request_queue *q = disk->queue;
> +	unsigned int noio_flag;
>  	ssize_t res;
>  
>  	if (!entry->store_limit && !entry->store)
> @@ -711,7 +712,9 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>  
>  	mutex_lock(&q->sysfs_lock);
>  	blk_mq_freeze_queue(q);
> +	noio_flag = memalloc_noio_save();
>  	res = entry->store(disk, page, length);
> +	memalloc_noio_restore(noio_flag);
>  	blk_mq_unfreeze_queue(q);
>  	mutex_unlock(&q->sysfs_lock);
>  	return res;
> -- 
> 2.44.0
>
