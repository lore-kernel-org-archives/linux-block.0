Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41763EED6;
	Mon, 17 Mar 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236105; cv=none; b=BehI7RIJuNf9xqKO8spBuqd+n+TRnQLhXuK8/f18vLP8gnlb6PuiQ8kBY7OJ+wKeojkqu1upJqwWbLeNEIhGzZvQf+E+qV6Y/NigYLUZkvk0ttLphezA/07PS7tw+ZquzJLBIVQ4GaufmkFYUCbAmZ6X9bYdnFYg1onFToCUSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236105; c=relaxed/simple;
	bh=Jic7LTo33nITNM3oJkdLiqyjphLqMZ8yFiyEQhuSp5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hS+1q7Y3wfA366UPDra84k1ISGrPhhWqzNE9yTmHkQQl5+qoUeUHvQBzRQA2E3p0gPPoueIViJx1aSedidaWDRrSbfIiJNUjOX/CM3hAH6oPItlupjQfDRF/bzXYFa5VkXhNnjlervGW1y0Ci/wtaqW3I1mr37nwOocnkj2GAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=o+MzdPFN; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="o+MzdPFN"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZGk4J1rMJzm0R40;
	Mon, 17 Mar 2025 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1742236095; x=1744828096; bh=7TPkFiJOJUHh3hlZJsWwzzO5
	re+hHlLP4IsNnjC0wkM=; b=o+MzdPFN33MspEhQwhPRfyGp1huUhEK+thVupdFU
	RO8Ye1VjTPe2blHwDHkE/uwuT3y3i4z2prbAcNPt+kIYgYl/ylSBZuVDniIE0GO3
	4GSBZg9CzzjGl2ZiQhF8Txx1GvKUkn7Jo0pLTAXIsBVH31JGcxysN44aryvWyZh5
	5VzZRpkTjj9GB0ELXj3Lm4jsLMVNMK8CiM71ZOd/mYrXvF4CW6MvPEagxJBbZhsI
	B8KVbyJOCKCGF68Xi4rQitODbAj3QXjkpxVjPMceEaDZNvVwEipgdsUfjOvoi13o
	rQeAgdgahz+XV5nasCYVzDrn38glFtAsbL76RNMxJBFa8A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZCOmU5wj8kFo; Mon, 17 Mar 2025 18:28:15 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZGk4C5fybzltBD0;
	Mon, 17 Mar 2025 18:28:10 +0000 (UTC)
Message-ID: <5b81f4be-427f-4083-8cbe-e201d0f255c5@acm.org>
Date: Mon, 17 Mar 2025 11:28:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] block: Make request_queue lockdep splats show up
 earlier
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>
References: <20250317171156.2954-1-thomas.hellstrom@linux.intel.com>
 <f46f0286-8052-4a29-9d89-376bf9b48d8a@acm.org>
 <13031d34692b0c97799de81c0b83875d56076e13.camel@linux.intel.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <13031d34692b0c97799de81c0b83875d56076e13.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/17/25 11:13 AM, Thomas Hellstr=C3=B6m wrote:
> On Mon, 2025-03-17 at 10:37 -0700, Bart Van Assche wrote:
>> On 3/17/25 10:11 AM, Thomas Hellstr=C3=B6m wrote:
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index d6c4fa3943b5..4aa439309406 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -455,6 +455,12 @@ struct request_queue *blk_alloc_queue(struct
>>> queue_limits *lim, int node_id)
>>>  =C2=A0=C2=A0	lockdep_init_map(&q->q_lockdep_map, "&q-
>>>> q_usage_counter(queue)",
>>>  =C2=A0=C2=A0			 &q->q_lock_cls_key, 0);
>>>   =20
>>> +	/* Prime io_lockdep_map as reclaim tainted */
>>> +	fs_reclaim_acquire(GFP_KERNEL);
>>> +	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
>>> +	rwsem_release(&q->io_lockdep_map, _RET_IP_);
>>> +	fs_reclaim_release(GFP_KERNEL);
>>> +
>>>  =C2=A0=C2=A0	q->nr_requests =3D BLKDEV_DEFAULT_RQ;
>>>   =20
>>>  =C2=A0=C2=A0	return q;
>>
>> Hmm ... my understanding is that it is fine if FS code calls block
>> layer
>> code but also that block layer code never should call FS code.
>=20
> That added code only mimics the locking sequence that happens during
> reclaim with the existing code to register the locking order expected
> by the reclaim code. If anything violates that, lockdep splat [2] will
> appear.
>=20
> So I'm not quite following your comment?
Shouldn't the above code be added in the VFS code rather than in the
block layer?

Thanks,

Bart.
