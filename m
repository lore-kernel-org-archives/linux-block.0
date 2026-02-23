Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA22369220
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872981; cv=none; b=u66uoxzP4ABDe2ygMfSOW/duRWFPyngevD3TfD0TPTbKXjN2ExqWoGOQWAEx8KQjRei3LZgyzLcZIcKsSjodVmi1nQ8D3NhHZeQeTa/atIxDBE7HYFGfwqE8EtM9MiG6uyU8W98MZU34ZqfF1lhJFVramv78qmGfpenxG0TwVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872981; c=relaxed/simple;
	bh=LPYY3XJnTtMja8MBB7a6D1GyL8dz68LMBgQUbGdJ3n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jyJZ3if4LbjZkNRS4dfARAo39JRfaqKzNUHa4g8L8qSppunQ1e45hKS1he+FSZ22cQnnH6PBZKr774sjkbaZcoP+c475/ikvNw+MWqPoQs9xG64ZCtwo8ZnWY9cC0AOk8vJuv1wrUCmMt/D9prIhg8NEfv4bWaV4vuBkJdwycGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Nb/yEmIG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Nb/yEmIG"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKVSM3kCYzlfddy;
	Mon, 23 Feb 2026 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771872978; x=1774464979; bh=LPYY3XJnTtMja8MBB7a6D1Gy
	L8dz68LMBgQUbGdJ3n4=; b=Nb/yEmIGXGs6d+X7otiFvpfGsOWJY1oPZVLldbnn
	aoimMeI2R2zj1PMAsf9eQ19VQdeNcQeUVGhHTPB9z9a6mZGXelgp54SSj1tk91gF
	pddJIdG41ccPZ1eXXr1tr39OWfXJU10HZN0/92HrRQf9LcD/F7iQx1wKVXHVeG6F
	IACssc7/ihyroYeileW4MpPxEOMUkkxbWKhd6Dm8PHjCUU9/853m7KF3/SYc8Gfd
	8GjdIGvlAq6ejCl/WoxGx1VCdA09oSAxBf4627BB52PQj0OI8I55qllitiCp/pM9
	k7CpuxhuuRhF9zwDPFeiUKmG6PorG+F0rdPa0KNClB9F2g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DXouDC8TfYf8; Mon, 23 Feb 2026 18:56:18 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKVSK5MxQzlfl89;
	Mon, 23 Feb 2026 18:56:17 +0000 (UTC)
Message-ID: <8e62c3fe-ebcf-4e04-bbf7-5af0152a6130@acm.org>
Date: Mon, 23 Feb 2026 10:56:16 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: improve disk_zone_wplug_schedule_bio_work()
To: Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-5-dlemoal@kernel.org>
 <43213df9-9233-4d5a-8b56-77894052db67@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <43213df9-9233-4d5a-8b56-77894052db67@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2/23/26 3:59 AM, Hannes Reinecke wrote:
> On 2/21/26 01:44, Damien Le Moal wrote:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE=
_WPLUG_PLUGGED));
>> -=C2=A0=C2=A0=C2=A0 refcount_inc(&zwplug->ref);
>> -=C2=A0=C2=A0=C2=A0 queue_work(disk->zone_wplugs_wq, &zwplug->bio_work=
);
>> +=C2=A0=C2=A0=C2=A0 if (queue_work(disk->zone_wplugs_wq, &zwplug->bio_=
work))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_inc(&zwplug->ref)=
;
>> =C2=A0 }
>> =C2=A0 static inline void disk_zone_wplug_add_bio(struct gendisk *disk=
,
>=20
> Urgh. Don't.
> There is a race condition; 'bio_work' might be scheduled directly and
> complete before 'refcount_inc()' is called.
> You have to invert the statement by keeping the 'refcount_inc()'
> before calling 'queue_work()', and then drop the reference again
> if queue_work failed.

Hi Hannes,

I think that the above code is fine because the caller holds
zwplug->lock. blk_zone_wplug_bio_work() only decrements zwplug->ref
after it has locked and unlocked the same lock.

Bart.
