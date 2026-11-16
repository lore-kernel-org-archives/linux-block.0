Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855926;
	b=BfZ460nR/fGbB7HvIREG9+0Nrk3ffZL1g5jQeYA5y/+ZOQ1uZc3cttDw8MWK7B2way+j
	 jHafWHChoebTmeQNvYmqaiOqLwj8huGn5lD3GepG/kI5m3/UpmWfbP+SuJ7/u47zz3eWr
	 QisMY62Ym09EZtI6CwQOS21vBi9RX1JU+nTFG4wIB5UIGSEEVO78Oh1eFQfPxGSbc0pTu
	 UsbGGVlR8oFpCDp3ESuFPet9f8k0wEr8QO/wXQ/WXZIfqe7jUzvcbfkHEkBu61NPRQ7d2
	 L7uYzjV8IytS88nG+3/WrZ5G4aZu4r6rRnIZpFq7S3wEWghEbfRwfg2jX2M45dhnLtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SvtPu7HA5/442GI6fZ7YSd7QFqtQyNHFF4UMh3VF1j4=;
	b=QSUEaouUtdDnTeaM82u9bq0JVpW5m6Tp/Os8VfEUv843tP8FOgh2bgWIcwyhJDKxi9OU
	 O7ktRjMBYCAMgcg3079l0oQK1BwYf//3t14BMJGUeeXBGe9XiL9/5srPRya1nSxMYG5FE
	 1SmdBE/e7VYFAHT3S/9bXKIWnrBz7JhzRsexFLYnbgHJ0/cQ96ZJdO5fUqgGDrBRp0G1y
	 NmBbEJgPum9mmpiWQs8vPo7ziGD6P63bLJYEoG4gAJlH9SbfrwwfKWWl9NXG4/vBGPMTt
	 qhd0Mc4hCd4ghNiaczZqV3BoJXG+yCYRxOP7wRsbqN1N04b742+93r6CnPAOAPJ7ZTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1TFRiBfs;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B5606A33E
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 19:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF9B5606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1TFRiBfs
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jSy451Jyjz1XM311;
	Mon, 16 Nov 2026 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794855921; x=1797447922; bh=SvtPu7HA5/442GI6fZ7YSd7Q
	FqtQyNHFF4UMh3VF1j4=; b=1TFRiBfsfr61+pGVqSc+DFAI8D7n7EyZRSn6P2Qj
	7EHSL5QVa5QvxpmJHX5DgdYRaPKpI1zkqvQXCAPfg65/oADhfzJyv94zcIcgIwjF
	0Qptm4118OgMFFfTggM0nP814Zi5YjMuK1umX1Pb6bKcGnPjhWVbuRS+OtQDBS9J
	QQdJeLRZM7F2vvWeCOhGcx2yYB8moivZ+eeh2SamTTSsMChhxUB+MzAqS96Yi+e/
	deKS1OHrD9bvdOFCO0j7M8OMOZPsM6tSmVX9wNfDucKb8ykuwgEkWEm7pozgJBER
	VeJw8pvtFx96sDHipl6BbOrbAkykTbqyrKfH7hs8o9zOWw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YmXim7l1YDlt; Mon, 16 Nov 2026 19:05:21 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jSy413tvdz1XM6JG;
	Mon, 16 Nov 2026 19:05:21 +0000 (UTC)
Message-ID: <27146c2b-c9d6-4cc3-969f-7a17bba661ec@acm.org>
Date: Mon, 16 Nov 2026 11:05:20 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blk-flush: fix a possible deadlock in the nvme timeout
 path
To: Ye Bin <yebin@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
References: <20261116132943.419435-1-yebin@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261116132943.419435-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/26 5:29 AM, Ye Bin wrote:
 > The root cause is that a flush request is moved to MQ_RQ_IDLE only 
when its
 > reference count drops to zero, which was introduced by commit 
9f16a66733c9
 > ("block: mark flush request as IDLE when it is really finished"). 
When the
 > last reference is held by the timeout work itself (PATH[1] and PATH[2]),
 > flush_end_io() returns early and leaves the request in MQ_RQ_COMPLETE, so
 > blk_mq_tagset_wait_completed_request() called from the same timeout path
 > never observes count == 0 and loops forever.

"PATH[1] and PATH[2]" is hard to follow. Please consider making this
more explicit, e.g. by mentioning that bt_iter() obtains a reference
via blk_mq_find_and_get_req() before calling the ->timeout() callback
and that this reference is only dropped by blk_mq_put_rq_ref() after
->timeout() has returned. Hence, if ->timeout() waits for completed
requests to become idle, it waits for itself.

 > Mark the flush request MQ_RQ_IDLE as soon as its completion is processed,
 > before waiting for the remaining references. Reference counting still
 > prevents the request from being freed or reused until the last 
reference is
 > dropped, so its tag cannot be reallocated underneath a holder.

It may help to mention that this is what blk_mq_free_request() and
blk_mq_end_request_batch() already do for regular requests: the state
is set to MQ_RQ_IDLE before the reference is dropped. Additionally,
commit 9f16a66733c9 moved the WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE)
statement that had been introduced by commit 65ff5cd04551 ("blk-mq:
mark flush request as IDLE in flush_end_io()") because flush_end_io()
is also called from the tag iteration code. This patch restores the
behavior of commit 65ff5cd04551 for the completion path only. Making
that explicit in the commit message would make this patch easier to
review.

 > +/*
 > + * Drop a reference to a flush request and, if it was the last one, 
run the
 > + * final cleanup. The caller must hold fq->mq_flush_lock.
 > + */
 > +static enum rq_end_io_ret flush_end_io_put_ref(struct request *flush_rq,
 > +					       blk_status_t error)
 >  {

Please replace "The caller must hold fq->mq_flush_lock" with
__must_hold(&fq->mq_flush_lock) such that this requirement is
verified at compile time.

 > +	/*
 > +	 * Mark the request IDLE as soon as its completion is processed. If an
 > +	 * iterator holds the last reference (e.g. the timeout handler that is
 > +	 * running nvme_timeout()), leaving it in MQ_RQ_COMPLETE would make
 > +	 * blk_mq_tagset_wait_completed_request() loop forever. Reference
 > +	 * counting still prevents the request from being reused.
 > +	 */
 > +	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);

Please do not refer to a specific block driver in a block layer source
code comment. Something like "e.g. a request timeout handler" is
sufficient.

Additionally, "Reference counting still prevents the request from
being reused" is not entirely accurate. What prevents reuse of
fq->flush_rq is that blk_kick_flush() only issues a new flush request
if fq->flush_pending_idx == fq->flush_running_idx and that
fq->flush_running_idx is only toggled by flush_end_io_put_ref() after
the last reference has been dropped. Please make the comment say that.

 > +/*
 > + * Called when a tag iterator drops its reference to a flush 
request. It must
 > + * not change the request state: the iterator may be looking at a 
request that
 > + * is still in flight.
 > + */
 > +enum rq_end_io_ret blk_flush_put_rq_ref(struct request *flush_rq)

Since the initial reference of a flush request is only dropped by
flush_end_io(), the last reference can only be dropped from this
function after flush_end_io() has already set the request state to
MQ_RQ_IDLE. Hence, not touching the request state here is fine. Maybe
that's worth mentioning in this comment.

Thanks,

Bart.
