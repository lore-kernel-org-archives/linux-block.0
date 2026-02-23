Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C1286A9
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878106; cv=none; b=qz4CzV2+REU7LMU7VqlBLmvMJEriN1D8B4cvwVC3ScZetchDEuH6g1A6BtUK48CXHllAm51kHeJgZkski8M/X36vau2tsaLnDcgom/GV+Q5tKM2OTszJx2GW2SJsn/ApUqwRa8GvZoOydkaOEiOGsD9Xq1gjGcTpy9HqEvomrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878106; c=relaxed/simple;
	bh=E5ICSL1jgDvFnBgws6zjYis25pO+1SukRjCCLlFNIpk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Cyj8R3LoAnL5OJEQ5NYyFoYKm+L9Hpdn/zcKwwsRBmrKmECAoqU9gxQ0R6LBQ5dMQw2aS12nvFkMgEaVKQOkJrwxUrnla1YlKFKqtCKG0GQSRPTHJv1w8O6GRRGXbh/xnLzhxU9FkY1osFlV8IUrhVCVHmq4tiY1t5z/Py86X/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=E41f/c9G; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="E41f/c9G"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fKXLw4wq4z1XLyhM;
	Mon, 23 Feb 2026 20:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771878103; x=1774470104; bh=E5ICSL1jgDvFnBgws6zjYis2
	5pO+1SukRjCCLlFNIpk=; b=E41f/c9GmwQ76Fz7q/x0EgkzWXVH36M9ZPFlwqvc
	2fEc5TQIrNKBq78UilgqLm6FsbiSsOL+OGc8xRBCz8my5ICLSEAbV8m56QL9B04p
	bhWylx8cApbF4pMgLwxcymWEbCDHPA4wrs8xGLxOQT5mUqRPJRI5Lim/lk+i0b2+
	a79tCgNM2n9OQlpBKLXR+nmCzDp3YButP/5TJDr6e5BR7S7GoVylZNTv1sni/vmU
	u++esIfxClKw2ixsj5mwN0XpULfIbcN6Y3eIZBUTfJmW0R0JbzG3VgMyceCMSyZS
	emNXijPRhyDR/i6Q/uI/Om+SFRBK9C1mTmb4eaS5/HQiDQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tsOGSi9ih0f0; Mon, 23 Feb 2026 20:21:43 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fKXLt5l62z1XM0pC;
	Mon, 23 Feb 2026 20:21:42 +0000 (UTC)
Message-ID: <03e14c32-8592-421f-992a-84301d1ec692@acm.org>
Date: Mon, 23 Feb 2026 12:21:41 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] block: fix zone write plug removal
From: Bart Van Assche <bvanassche@acm.org>
To: Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-2-dlemoal@kernel.org>
 <ab25a49b-0732-4d0e-94b7-1785934a1a5e@suse.de>
 <ed42e14c-6378-48f2-891c-87463a6ee9eb@acm.org>
Content-Language: en-US
In-Reply-To: <ed42e14c-6378-48f2-891c-87463a6ee9eb@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2/23/26 11:30 AM, Bart Van Assche wrote:
> On 2/23/26 3:56 AM, Hannes Reinecke wrote:
>> On 2/21/26 01:44, Damien Le Moal wrote:
>>> +static inline void disk_check_and_put_zone_wplug(struct=20
>>> blk_zone_wplug *zwplug)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 lockdep_assert_not_held(&zwplug->lock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check for the need to remove the zone wri=
te plug from the=20
>>> hash list
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * when we see that only the caller is refer=
encing the zone=20
>>> write plug.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Since this is racy without holding the zo=
ne write plug lock,=20
>>> this
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * check is done again in=C2=A0 disk_should_=
remove_zone_wplug().
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (refcount_read(&zwplug->ref) <=3D 2) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gendisk *disk =3D =
zwplug->disk;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&zwplug=
->lock, flags);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (disk_should_remove_zo=
ne_wplug(disk, zwplug))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
isk_remove_zone_wplug(disk, zwplug);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&z=
wplug->lock, flags);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 disk_put_zone_wplug(zwplug);
>>> +}
>>> +
>>> =C2=A0 static void blk_zone_wplug_bio_work(struct work_struct *work);
>>> =C2=A0 /*
>>
>> This looks slightly odd; a simple 'refcount_read()' always trigger ala=
rm
>> bells with me as it inevitably races with 'refcount_dec()' /
>> 'refcount_inc()'.
>> And similar the check 'refcount <=3D 2' also looks odd; typically one
>> would check against '< 1' and let the refcount destructor handle
>> things.
> Hmm ... I think that the above code is racy. Here is an example:
>=20
> thread 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thread 2
> -------------------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -------------------------------
> refcount_read() returns 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_read() returns 3
>=20
> disk_should_remove_zone_wplug() is=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk_s=
hould_remove_zone_wplug()
> is not called=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 is not called
>=20
> disk_put_zone_wplug() decreases=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 disk_put_zone_wplug() decreases
> zwplug->ref from 3 to 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zwplug->ref from 2 to 1
>=20
>=20
> Result: zwplug->ref became less than 2 without=20
> disk_should_remove_zone_wplug() having been called.

A correction to the above: three threads are required before it becomes
possible for the zwplug reference count to drop from 3 to zero without
disk_should_remove_zone_wplug() having been called.

Thanks,

Bart.
