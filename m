Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB22E06EF;
	Thu,  6 Nov 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462202; cv=none; b=P7IakD2J+ZEw/Zmd4JZXa8WDV4A5LREC8P1dpUcsGowZU+Q99o3B8UIJrQIj7fERIK/EbvwpedZyZEK0geZk8nODttPy9B0ROf65YtIsSTYUoxxV238wSpf7HnVmly2zBezfGzzG0Fr0Bls4Tt+DfY3af+Tf5tY52+0KDlqqhhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462202; c=relaxed/simple;
	bh=2AwQ3IDLnb6+FSP3TkhhA4joJAoyn1FBg6BmmrKVmaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RD9DtE5RqgMMNF3lZbLjAiHVcLu1qL3L+1tO0YSG8KtXwxwYGs6/M5bOIKZjthXCQlCwXO5RdFE7O9eHNSSsffeT/jwuHk+I+hWLAsv2BIYO5y3v7yUJ9WNUB31DhYnzBRnNaS0WjCmMVHD40VMA5oND4ZUSVPUfCLzxGCSKzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LlCj8f6j; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LlCj8f6j"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d2Z7q2L5kznPZHN;
	Thu,  6 Nov 2025 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762462197; x=1765054198; bh=8zGAhFrEJhhIS5XW/674msGy
	I4MQLq4mz5DTXDjfjGU=; b=LlCj8f6jFxBUgT8XT9xFfexgZuEk2nHnZsttz/f9
	rup+xMfEBHFMzK46b0dI1/+cyNCfuGK3Kb/zUBt32cL6MMoFz0LpjWtHUYacyFvt
	ufuNnX5vr5NCgWwqDGgWn5KEN3Dq8Bfeuk4FS6oDTSzmZe8w9YVilYyFJBJPIXpg
	ZJJuJ4H3BHSPenaL4jSi/lKCesc0sIe1iJr0l6gE8MK08AsmrWsGygOpK6Vl3IcH
	YRoKXhuSeeBoGst/kQTBnJzYz9q/dVYjqT/vn8qPojD9RtCAHJ2PG9CEZOYu1dGm
	RVMzVjCoUn2xHmk/9+IhNYI44p7VuG4LPRfiDeqBDDh0Pw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uyRB1QcSQaFA; Thu,  6 Nov 2025 20:49:57 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d2Z7Z00xSzlpBdt;
	Thu,  6 Nov 2025 20:49:44 +0000 (UTC)
Message-ID: <7f2d2486-6b74-4ed1-81c8-2aa584cfe264@acm.org>
Date: Thu, 6 Nov 2025 12:49:43 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Remove queue freezing from several sysfs store
 callbacks
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20251105170534.2989596-1-bvanassche@acm.org>
 <b556d704-dc3b-4e6c-a158-69fb5b377dac@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b556d704-dc3b-4e6c-a158-69fb5b377dac@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/6/25 5:01 AM, Nilay Shroff wrote:
>> @@ -154,10 +153,8 @@ queue_ra_store(struct gendisk *disk, const char *=
page, size_t count)
>>   	 * calculated from the queue limits by queue_limits_commit_update.
>>   	 */
>>   	mutex_lock(&q->limits_lock);
>> -	memflags =3D blk_mq_freeze_queue(q);
>> -	disk->bdi->ra_pages =3D ra_kb >> (PAGE_SHIFT - 10);
>> +	data_race(disk->bdi->ra_pages =3D ra_kb >> (PAGE_SHIFT - 10));
>>   	mutex_unlock(&q->limits_lock);
>> -	blk_mq_unfreeze_queue(q, memflags);
>>  =20
>>   	return ret;
>>   }
>=20
> I think we don't need data_race() here as disk->bdi->ra_pages is alread=
y
> protected by ->limits_lock. Furthermore, while you're at it, I=E2=80=99=
d suggest
> protecting the set/get access of ->ra_pages using ->limits_lock when it=
=E2=80=99s
> invoked from the ioctl context (BLKRASET/BLKRAGET).

I think that we really need the data_race() annotation here because
there is plenty of code that reads ra_pages without using any locking.
>> @@ -480,9 +468,7 @@ static ssize_t queue_io_timeout_store(struct gendi=
sk *disk, const char *page,
>>   	if (err || val =3D=3D 0)
>>   		return -EINVAL;
>>  =20
>> -	memflags =3D blk_mq_freeze_queue(q);
>> -	blk_queue_rq_timeout(q, msecs_to_jiffies(val));
>> -	blk_mq_unfreeze_queue(q, memflags);
>> +	data_race((blk_queue_rq_timeout(q, msecs_to_jiffies(val)), 0));
>>  =20
>>   	return count;
>>   }
>=20
> The use of data_race() above seems redundant, since the update to q->rq=
_timeout
> is already marked with WRITE_ONCE(). However, the read access to q->rq_=
timeout
> in a few places within the I/O hotpath is not marked and instead access=
ed directly
> using plain C-language loads.

That's fair. I will remove data_race() again from
queue_io_timeout_store().
> BUG: KCSAN: data-race in blk_add_timer+0x74/0x1f0
>
> Based on the gdb trace:
>=20
> (gdb) info line *(blk_add_timer+0x74)
> Line 138 of "block/blk-timeout.c" starts at address 0xc000000000d5637c =
<blk_add_timer+108> and ends at 0xc000000000d5638c <blk_add_timer+124>.
>=20
> This corresponds to:
>=20
> 128 void blk_add_timer(struct request *req)
> 129 {
> 130         struct request_queue *q =3D req->q;
> 131         unsigned long expiry;
> 132
> 133         /*
> 134          * Some LLDs, like scsi, peek at the timeout to prevent a
> 135          * command from being retried forever.
> 136          */
> 137         if (!req->timeout)
> 138                 req->timeout =3D q->rq_timeout;
>=20
> As seen above, the read access to q->rq_timeout is unmarked. To avoid t=
he reported
> data race, we should replace this plain access with READ_ONCE(q->rq_tim=
eout).
> This is one instance in the I/O hotpath where q->rq_timeout is read wit=
hout annotation,
> and there are likely a few more similar cases that should be updated in=
 the same way.

That's an existing issue and an issue that falls outside the scope of my
patch.

Thanks,

Bart.
