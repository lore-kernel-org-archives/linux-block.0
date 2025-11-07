Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC525C810;
	Fri,  7 Nov 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532360; cv=none; b=IIhK6GdrfeU9jmAeuLvGxQ43DJikTiaWNRcupUKq8zpF0NHP4PzhwWSu8mQMbL0F8ffJtKM60Oauo5Y9OOEziJ+RrUyAVKNoqHFK/qWYtzdw4p+L9RmAfCIuQ+n0ozUrxNVW699LF6xk1THj5x5pd2DMhtjbZ0+x24JvLpUC8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532360; c=relaxed/simple;
	bh=WbRX7mezc1hkSGv/O3eHZdEH+UlazBmlAxDE8/oSk84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGa9NmYQhfC6Duqm8Cd4kQGEU2F5M5Drh6uMRLJzTvZlpj5vp00qUfVcjH+ljoG7lVpa/FeNZSlEuFl8bdrEqKx89V85tdaZZIazMWBk6KsS/FLuP4OQzEVk6gGHfAUPUWRXhqxqkP9ZKYADzLapH5ZGku3IvwvqQ2rNnnkkQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Hj0+XCX6; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Hj0+XCX6"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d344w3L2ZzlgqV6;
	Fri,  7 Nov 2025 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762532348; x=1765124349; bh=jbhPWfJ0xDnjiVPuOPTte/So
	5DeOuewRoHeum+5O9+c=; b=Hj0+XCX6K9hpi/dv7rjOs/7RqfSJcus3Mfq515Zp
	3HXoEHWddqwaK5H9Jkn8KT1lb5sh8NyvYufKasQAXyCE9ElxzPtZI2DMdv+hQoms
	q2RV89lh6YfeMc2Pz8jdaduQgy92MFNvyG7GrqUqBKfZd6pf9pJB3vbtM7lmdNke
	RwZtlbXBotlsEYrtpcICA1l0A4/7M5XMK1xHQBg5M9U0gFoyUOXzdiqqZ/z2mcMz
	TGqVQBOqrT0f5aT5Xkv5AgvismJUrZ0eL5hX52InwVsgkKcozA6C36xYXH9CyxQU
	GymF5cTL8DUoYJID6GIPAHhDYbiiovLY0IouximsZBRqDQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JogAQFbsZk9F; Fri,  7 Nov 2025 16:19:08 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d344f2KNXzlgqTx;
	Fri,  7 Nov 2025 16:18:56 +0000 (UTC)
Message-ID: <e7c3d79e-6557-4497-973b-5038f9f35958@acm.org>
Date: Fri, 7 Nov 2025 08:18:55 -0800
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
 <7f2d2486-6b74-4ed1-81c8-2aa584cfe264@acm.org>
 <096323ad-529b-4b5c-a966-ff7cd6315ecc@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <096323ad-529b-4b5c-a966-ff7cd6315ecc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/7/25 2:41 AM, Nilay Shroff wrote:
> On 11/7/25 2:19 AM, Bart Van Assche wrote:
>> On 11/6/25 5:01 AM, Nilay Shroff wrote:
>>>> @@ -154,10 +153,8 @@ queue_ra_store(struct gendisk *disk, const char=
 *page, size_t count)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * calculated from the queue li=
mits by queue_limits_commit_update.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&q->limits_lock);
>>>> -=C2=A0=C2=A0=C2=A0 memflags =3D blk_mq_freeze_queue(q);
>>>> -=C2=A0=C2=A0=C2=A0 disk->bdi->ra_pages =3D ra_kb >> (PAGE_SHIFT - 1=
0);
>>>> +=C2=A0=C2=A0=C2=A0 data_race(disk->bdi->ra_pages =3D ra_kb >> (PAGE=
_SHIFT - 10));
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&q->limits_lock);
>>>> -=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze_queue(q, memflags);
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0 }
>>>
>>> I think we don't need data_race() here as disk->bdi->ra_pages is alre=
ady
>>> protected by ->limits_lock. Furthermore, while you're at it, I=E2=80=99=
d suggest
>>> protecting the set/get access of ->ra_pages using ->limits_lock when =
it=E2=80=99s
>>> invoked from the ioctl context (BLKRASET/BLKRAGET).
>>
>> I think that we really need the data_race() annotation here because
>> there is plenty of code that reads ra_pages without using any locking.
>=20
> I believe, in that case we need to annotate both reader and writer, usi=
ng
> data_race(). Annotating only writer but not reader would not help suppr=
ess
> KCSAN reports of a data race.

No. As the comment above the data_race() macro explains, the data_race()
macro makes memory accesses invisible to KCSAN. Hence, annotating
writers only with data_race() is sufficient.
>>>> @@ -480,9 +468,7 @@ static ssize_t queue_io_timeout_store(struct gen=
disk *disk, const char *page,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err || val =3D=3D 0)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINV=
AL;
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 memflags =3D blk_mq_freeze_queue(q);
>>>> -=C2=A0=C2=A0=C2=A0 blk_queue_rq_timeout(q, msecs_to_jiffies(val));
>>>> -=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze_queue(q, memflags);
>>>> +=C2=A0=C2=A0=C2=A0 data_race((blk_queue_rq_timeout(q, msecs_to_jiff=
ies(val)), 0));
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return count;
>>>>  =C2=A0 }
>>>
>>> The use of data_race() above seems redundant, since the update to q->=
rq_timeout
>>> is already marked with WRITE_ONCE(). However, the read access to q->r=
q_timeout
>>> in a few places within the I/O hotpath is not marked and instead acce=
ssed directly
>>> using plain C-language loads.
>>
>> That's an existing issue and an issue that falls outside the scope of =
my
>> patch.
>>
> Hmm, I don=E2=80=99t think this issue falls outside the scope of the cu=
rrent patch.
> Without this change, it would not be possible for queue_io_timeout_stor=
e()
> to run concurrently with the I/O hotpath and update q->rq_timeout while=
 it=E2=80=99s
> being read. Since this patch removes queue freeze from queue_io_timeout=
_store(),
> it can now potentially execute concurrently with the I/O hotpath, which=
 could
> then manifest the KCSAN-reported data race described above.
Annotating all rq_timeout read accesses with READ_ONCE() would be
cumbersome because there are plenty of direct rq_timeout accesses
outside the block layer, e.g. in drivers/scsi/st.c (SCSI tape driver).

I prefer an alternative approach: annotate the q->rq_timeout update in
blk_queue_rq_timeout() with both data_race() and WRITE_ONCE(). That
guarantees that rq_timeout update happens once and prevents that KCSAN
complains about rq_timeout reads.

Thanks,

Bart.

