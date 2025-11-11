Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1682836F
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887666; cv=none; b=eCc7xcdnFgkXgWiKXwxDJkvVzu0kX9zqHhMrlD4a49xrx1rXXpj1jk3vWLp7ytGACmwehMyOhkIRLjYDj+Rr7lBm7aocoDpxA40hyY5oCgJoAuJRDcWfc15ree9XKHKosRX1ldql0ZvGMgojzHcC/+wvxM4TIRJQzDjzPIC6UQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887666; c=relaxed/simple;
	bh=Qb/DPLUs+gZogJk9gFDiATcvyGQP9xtIifoqHm7qpRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVeZwAR3LopStckLv3aEYvlFZrobElG3taeBxh1BIBXZmmguekoh4jN0FFAZrKEC63szEvMBuJZJVbka7yJ1yY8qXJECcoAMxrheRW2HBqCd2rOAf1ntkSoyX2pOmYmin76qGA5pbLFbO4lvH3sBnN1XMXrjWD0XTjxvefFskyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dniPxLHu; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dniPxLHu"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d5bTq0hcxzm25LC;
	Tue, 11 Nov 2025 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762887661; x=1765479662; bh=Qb/DPLUs+gZogJk9gFDiATcv
	yGQP9xtIifoqHm7qpRs=; b=dniPxLHunL8bxd75pNA9hZZI22YqBW9Sl+4ero0P
	xht1GQXQP4+OZc9OWY2L6reygm+RxslW73ShMlXYkCZ3qPplDv7212EqWwS9DO+g
	kdkDaxSeSHjtcZcn3Z4NjsSj9fuiFQXYgLb1VNVcHRNXfmNDMkM/wgF5TSSjCj/3
	qTzCq6yfKD1jEGxCm4wVgxlN/rQeryuvWvm3BXJDEZOK4BEXO9gd2SqzFgD4WuGM
	SYvx+VnTfVzkWgk5vTTkQDtoSYpwReORgHjj5vdzD0p69nt+MRo5tr3fQq5KHS+I
	gQuAP9/g7YuJgZZ16r0m3EnhQhLJqE1yIPrQxW5DbTCuvQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SNCy7Be54vbC; Tue, 11 Nov 2025 19:01:01 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d5bTj3s3Fzlyqp1;
	Tue, 11 Nov 2025 19:00:56 +0000 (UTC)
Message-ID: <da348eec-b573-40fc-ad9f-f472703c6fed@acm.org>
Date: Tue, 11 Nov 2025 11:00:55 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add lockdep to queue_limits_commit_update()
To: John Garry <john.g.garry@oracle.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, hch@lst.de
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20251109074426.6674-1-ckulkarnilinux@gmail.com>
 <0ec951d9-c307-46b5-92fe-abca93b993bb@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0ec951d9-c307-46b5-92fe-abca93b993bb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/11/25 12:51 AM, John Garry wrote:
> On 09/11/2025 07:44, Chaitanya Kulkarni wrote:
>> =C2=A0 block/blk-settings.c | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 78dfef117623..51401f08ce05 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -556,6 +556,8 @@ int queue_limits_commit_update(struct=20
>> request_queue *q,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error;
>> +=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&q->limits_lock);
>> +
>=20
> We always unlock the mutex in this function (not shown).
>=20
> With your change, if CONFIG_LOCKDEP is enabled then we get the above=20
> warning. However, if CONFIG_DEBUG_MUTEXES was enabled, we would already=
=20
> be getting a warning.
>=20
> Maybe using LOCKDEP is much more preferred than DEBUG_MUTEXES.

If all goes well soon any calls to queue_limits_commit_update() without
holding q->limits_lock will result in a failed build even if
CONFIG_DEBUG_MUTEXES and CONFIG_LOCKDEP are disabled. See also
"[PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis"
(https://lore.kernel.org/lkml/20250918140451.1289454-1-elver@google.com/)=
.

Thanks,

Bart.
