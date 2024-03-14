Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA16FE10;
	Thu, 14 Mar 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436098; cv=none; b=Kl8yOh7l/Puyr+lyerMrKfMwLCCYREiwOgn4tRTh2HTCOlaCqi7Q4Ad3ivA0wVT1+rX3i1UtZL4bgJlm4HhtVXiWQii6rWrphx3ZehNPCH0tivEZDkALXWsthEyyu0P5uRKabwPFpHinwG+3VqkBqYommDIkj7oX6ZwNDzTJG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436098; c=relaxed/simple;
	bh=KC56MJSNa0tlT6Fq7JOrWXDdPZMxnawzUzvFV5t+9NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCbrFK5KR4YebJZoHGACjb9TXUb5dHaKzmejilu1ORmKtTFT/dtC9v1l1sPqsmR9PppsIH4ZZpcfmnZttAWejxCuGnIVdo5NHI1mXuC0O4di2eAIQxWCHD0X5G5SmWO0JiP4YwCDXqoKPnLvbeIMEC7cx+qxv2avbnmsWzbiNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KKvXOOfC; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KKvXOOfC"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4TwYjr2tj0zlgVnf;
	Thu, 14 Mar 2024 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710436093; x=1713028094; bh=wNCX0W7TCjDPfMrpCKXRDDoj
	AVEQk7pec9rqlF/vD64=; b=KKvXOOfCG3MvTQ4/rqE8S+tViGS+L0oaAw4x4b0V
	QmEXAtqb9LsAOCftFCotaP/ouNp3mmmbljvmxCe1ronWqIjfrC+O0SndsYa+/wLn
	C4QN3Lua7BfRdxWy2T1kldRO9Y5WaaWAfipPFywuA6rFtDnvcVSDasMVz3utxnRR
	zvsCreLB7FRidUcAA1S81nQDOM6RXObmWdRVYoa7gosbwyqWOPcmXhFZ/7QgDyNm
	cf9203r05ZpT28f1VvslRyQbs6UfEop7qxN8GvkOKTJm3EBGg14UefMZeWOyvV+a
	fhW1ijPvY0/YAg28MqbcK/RqWe3g5HlWfnOKHit86lFNbg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6h4US87tAIbd; Thu, 14 Mar 2024 17:08:13 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4TwYjm5yn4zlgVnW;
	Thu, 14 Mar 2024 17:08:12 +0000 (UTC)
Message-ID: <cf7e6d94-63fd-4ef5-bbdb-9c3877d8560a@acm.org>
Date: Thu, 14 Mar 2024 10:08:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBSZXZlcnQgImJsb2NrL21xLWRlYWRs?=
 =?UTF-8?Q?ine=3A_use_correct_way_to_throttling_write_requests=22?=
Content-Language: en-US
To: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 =?UTF-8?B?6YeR57qi5a6HIChIb25neXUgSmluKQ==?= <hongyu.jin@unisoc.com>
References: <20240313214218.1736147-1-bvanassche@acm.org>
 <cf8127b0fa594169a71f3257326e5bec@BJMBX02.spreadtrum.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cf8127b0fa594169a71f3257326e5bec@BJMBX02.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/13/24 18:03, =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) wrote:
> Just as mentioned in original patch, "dd->async_depth =3D max(1UL, 3 * =
q->nr_requests / 4);", this limitation methods look likes won't have a li=
mit effect, because tag allocated is based on sbitmap, not based the whol=
e nr_requests.
> Right?
> Thanks!
>=20
> For write requests, when we assign a tags from sched_tags,
> data->shallow_depth will be passed to sbitmap_find_bit,
> see the following code:
>=20
> nr =3D sbitmap_find_bit_in_word(&sb->map[index],
> 			min_t (unsigned int,
> 			__map_depth(sb, index),
> 			depth),
> 			alloc_hint, wrap);
>=20
> The smaller of data->shallow_depth and __map_depth(sb, index)
> will be used as the maximum range when allocating bits.
>=20
> For a mmc device (one hw queue, deadline I/O scheduler):
> q->nr_requests =3D sched_tags =3D 128, so according to the previous
> calculation method, dd->async_depth =3D data->shallow_depth =3D 96,
> and the platform is 64bits with 8 cpus, sched_tags.bitmap_tags.sb.shift=
=3D5,
> sb.maps[]=3D32/32/32/32, 32 is smaller than 96, whether it is a read or
> a write I/O, tags can be allocated to the maximum range each time,
> which has not throttling effect.
Whether or not the code in my patch effectively performs throttling,
we need this revert to be merged. The patch that is being reverted
("block/mq-deadline: use correct way to throttling write requests")
ended up in Greg KH's stable branches. Hence, the first step is to
revert that patch and tag it with "Cc: stable" such that the revert
lands in the stable branches.

Thanks,

Bart.
