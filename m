Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622836F404
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875053; cv=none; b=R9l5P9H3cABPUh5M49xqiJayDHs8DQv9gpYV/9Mlh6zcejQFErSkg9ynf+/vGGkXHb+pyWkFnVp+QVu152ir7BN7cA16Idm0k1QYdMNStShoRh8QAWdslcep5Dw9NmF9Pz5+n3zlpPcQnSSHvEMz04+8RLvgzuUdZg+sQzmSjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875053; c=relaxed/simple;
	bh=BiJUTLsrufEVEuEaEfHWG/EwBRYuOqwzlhOWSc3I3A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V/M+sAKLYaTUkTcyXcG33Z3KXNdkMQqii51YSOBiLMkxJ+ZQVNd6+ZiSAO7XnJKHC5k6CivFNVTf6FW0PjV+ifmxM3Lc6YoxxtHCgEjLu+pRywa/CU7pzUAL8sTOWPU1FphIVkPqUpPn0+xPRMjr/FbLGpKJ8D/gTNSV4ULNN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N0z2jUZQ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N0z2jUZQ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKWD94Stjzlh1Rx;
	Mon, 23 Feb 2026 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771875048; x=1774467049; bh=GWnxIhjxfGEEdVsJ8bbQAUzV
	us1gXMqtJslNJc1WYmA=; b=N0z2jUZQfawwu6OA9ll+aGLt5dUZQoWCN126k7xP
	EjIXdkgPoGoS6Ci6U7PxZ+cE0OiSUtYxP+c0DL8XrgZFxC9A8MY5r5B0HU70oBUR
	bjzYLvTbG057y7/O14HCdx9bwpQlC61arCUraZrFgUDwH3mboJIrE9WVIY5vPE28
	2VMduxQt7dqCpku4E2ypuCElEm4fYKSszjcNG+lWGlcxe7kpWEkUHvK2PKiYlTiG
	qv2/BzmW04r/tp+AdeyuaOQm49nQ83VLIWcKT2AyethLW4qc0kZm52QnNQvP+lso
	sup3DZatGCm7OW4PiKnwMitbGgeBjPz5Cbtzzkl3/sRduA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0NpHabkIlBsC; Mon, 23 Feb 2026 19:30:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKWD74kq6zlgqsJ;
	Mon, 23 Feb 2026 19:30:47 +0000 (UTC)
Message-ID: <ed42e14c-6378-48f2-891c-87463a6ee9eb@acm.org>
Date: Mon, 23 Feb 2026 11:30:46 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] block: fix zone write plug removal
To: Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-2-dlemoal@kernel.org>
 <ab25a49b-0732-4d0e-94b7-1785934a1a5e@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ab25a49b-0732-4d0e-94b7-1785934a1a5e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2/23/26 3:56 AM, Hannes Reinecke wrote:
> On 2/21/26 01:44, Damien Le Moal wrote:
>> +static inline void disk_check_and_put_zone_wplug(struct=20
>> blk_zone_wplug *zwplug)
>> +{
>> +=C2=A0=C2=A0=C2=A0 lockdep_assert_not_held(&zwplug->lock);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check for the need to remove the zone writ=
e plug from the hash=20
>> list
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * when we see that only the caller is refere=
ncing the zone write=20
>> plug.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Since this is racy without holding the zon=
e write plug lock, this
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * check is done again in=C2=A0 disk_should_r=
emove_zone_wplug().
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (refcount_read(&zwplug->ref) <=3D 2) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gendisk *disk =3D z=
wplug->disk;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&zwplug-=
>lock, flags);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (disk_should_remove_zon=
e_wplug(disk, zwplug))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 di=
sk_remove_zone_wplug(disk, zwplug);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&zw=
plug->lock, flags);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 disk_put_zone_wplug(zwplug);
>> +}
>> +
>> =C2=A0 static void blk_zone_wplug_bio_work(struct work_struct *work);
>> =C2=A0 /*
>=20
> This looks slightly odd; a simple 'refcount_read()' always trigger alar=
m
> bells with me as it inevitably races with 'refcount_dec()' /
> 'refcount_inc()'.
> And similar the check 'refcount <=3D 2' also looks odd; typically one
> would check against '< 1' and let the refcount destructor handle
> things.
Hmm ... I think that the above code is racy. Here is an example:

thread 1                                thread 2
-------------------------------         -------------------------------
refcount_read() returns 3               refcount_read() returns 3

disk_should_remove_zone_wplug() is      disk_should_remove_zone_wplug()
is not called                           is not called

disk_put_zone_wplug() decreases         disk_put_zone_wplug() decreases
zwplug->ref from 3 to 2                 zwplug->ref from 2 to 1


Result: zwplug->ref became less than 2 without=20
disk_should_remove_zone_wplug() having been called.

Thanks,

Bart.
