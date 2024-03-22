Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002F57312
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123803; cv=none; b=RyrDSqM362bgH6BavZE0sNu8qMkGBaKo/45jp4VER7RTGXGsHHL0CS6Uo9hdeO61lISlZN6puiMXYkSZlUrQ/bMcD3dy5lM19KmzCKWVklpOIekdeshPl5rdu/2LypLDAl2XanPS42SVsyrqV+6x6KmZAJVcfCYMeXGtG5Pb43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123803; c=relaxed/simple;
	bh=qVR+Ewrk6qALPK3irfI4lfsChegLx2HE4lfftUl9l4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1wCc3uLa6/Si/L7qrxdm9RlyiEaxyiqvrD+sYdGzHVv1sdhBkk487koswAand4RYPSLa3T+3/l7apCOdpVcKtNpD76AK9rTwMFR/mwXz6CZ1Lpj8Rt7tcuzoyr/7DfqdxaH2XCtb22Ge1cbJaJaPLqXKM1kmZnZjJ/NOgvotGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Y5RU0lW1; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Y5RU0lW1"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V1S2q1D9DzlgVnK;
	Fri, 22 Mar 2024 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711123792; x=1713715793; bh=qVR+Ewrk6qALPK3irfI4lfsC
	hegLx2HE4lfftUl9l4k=; b=Y5RU0lW1iNBx/6rTUMXZhOhwvSfWlNf7fEpTID/l
	Hp5oheeG9bjHmYSnZvJdLrQat/8bWWFgqAkz7J8Qoe2jlhDICb4ymbQ/5lI/F34Y
	GteFxb8AnAtTnXmnhwa+fMUI++qeOEY4lmZkgvS4rRzDHp7yTbLdV+q4CGEAVsw8
	Zz7QKIpylGPQ/NQwazeAlUTvSqXsZhyV8hDm4Kv8P8Dm9cPIqIsgX54U+jFC3yzn
	XIT8kQPk/SpwoZEOwchV279yXXRxzQj0T57RZortGNT55HxVnB2dUtnPFBBphbrQ
	iEB6Nasmopp4u39EBhfMRDSNVJA2ijJdc68U+pNPxKz1BA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2pHSBe3ipPCt; Fri, 22 Mar 2024 16:09:52 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V1S2l468gzlgTGW;
	Fri, 22 Mar 2024 16:09:51 +0000 (UTC)
Message-ID: <c5b72b14-b523-4665-9499-4528e94c5b58@acm.org>
Date: Fri, 22 Mar 2024 09:09:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve IOPS by removing the fairness code
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240321224605.107783-1-bvanassche@acm.org>
 <20240321224814.GA23127@lst.de>
 <13f47d63-2140-4927-8933-009dae21f7e6@acm.org>
 <33581b6a-c350-b523-b31e-787f74d97e71@huaweicloud.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <33581b6a-c350-b523-b31e-787f74d97e71@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/21/24 18:14, Yu Kuai wrote:
> =E5=9C=A8 2024/03/22 7:03, Bart Van Assche =E5=86=99=E9=81=93:
>> That test does the following:
>> * Create two request queues with a shared tag set and with different
>> =C2=A0=C2=A0 completion times (1 ms and 100 ms).
>> * Submit I/O to both request queues simultaneously and set the queue
>> =C2=A0=C2=A0 depth for both tests to the number of tags. This creates =
contention
>> =C2=A0=C2=A0 on tag allocation.
>> * After I/O finished, check that the fio job with the shortest
>> =C2=A0=C2=A0 completion time submitted the most requests.
>=20
> This test is a little one-sided, I'm curious how the following test
> shows as well:
>=20
> - some queue is under heavy IO pressure with lots of thread, and they
> can use up all the drivers tags;
> - one queue only issue one IO at a time, then how does IO latency shows
> for this queue? I assume this can be bad with this patch because sbitma=
p
> implementation can't gurantee this.

Are these use cases realistic? The sbitmap implementation guarantees
forward progress for all IO submitters in both cases and I think that's
sufficient. Let's optimize the block layer performance for the common
cases instead of keeping features that help rare workloads. If users
really want to improve fairness for the two workloads mentioned above
they can use e.g. the blk-iocost controller and give a higher weight to
low-latency workloads.

Thanks,

Bart.
