Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7A7464
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162406; cv=none; b=AqMdHiEqsHvwsTHl47CU59f53IXLgr22ChukEige/p1UOU6aXeVVS2YXM6rQOFrU4qLhISlfEQwptJVyxc2sOt3BwxMW4NigAu/8tbsqsKGyQphd7h+Dasz1dMsF0AjVpmdnAeuvnexdYYkiNou0LBqUtEmuYvfPmDIxjDt77gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162406; c=relaxed/simple;
	bh=+Wg9l5Y3HlX9gyPrnAJa82vEoKIKXmPX/gTCU4S+VOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4N0j1H9wCqNdfjUcl0zaWTQDlhcZRVfOT+SyZGbAPnOnUFzrJEYIvyioxDP32S6Qd8rkKliDmBYHxr/cuBQUvEyeYn++0PzVrofRFQjyG21ipTvOpRCxFix+dKvkZ92ra43ienPOV0Cco/EN+pKY7a5IVCZA9O+zIpUgzBNzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nFQ0awmU; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nFQ0awmU"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bdK2j6j1wzlgqV0;
	Thu, 10 Jul 2025 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752162396; x=1754754397; bh=+Wg9l5Y3HlX9gyPrnAJa82vE
	oKIKXmPX/gTCU4S+VOg=; b=nFQ0awmUIseyTFE2t6/0x2XODT7dIU3fgayJWlpT
	XkqUEfLqylxP43kCyRyg4dOwxFjodxybrPVqJP4NarUtCNcgy6T7yeqFOEIcRR4O
	Q82niIjhFgtWQdNZST/zzGdKEapoU4gnFKkwWVg38RCm0fdJxDsbFI1u+Xe9jij+
	HwaLC9Yqpu8juJO+4JLhQE6MITo8GVAS68fENQ/zPseiX97ZrJc2HLvOOZGyejet
	qMin5EiZFAVPiOtFNspdkiBIuXfiU6rQI7FRWDjUGIoPIvgIFxH3Rhh0kjB3dCIm
	T+CgmZm9z0H0Zw8SPtOl3rr33WgrKfdpHG0mwG9taWYccw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fH_WTxKPoznP; Thu, 10 Jul 2025 15:46:36 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bdK2b5GGPzlgqTw;
	Thu, 10 Jul 2025 15:46:30 +0000 (UTC)
Message-ID: <8e23a43d-4f86-451f-a7db-a88325d4abeb@acm.org>
Date: Thu, 10 Jul 2025 08:46:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block: add tracepoint for blkdev_zone_mgmt
To: Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-5-johannes.thumshirn@wdc.com>
 <ca6a5406-21cc-4faa-8943-b0eb5630d500@acm.org>
 <6443646a-fb74-44dd-b15d-ea37929e3c79@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6443646a-fb74-44dd-b15d-ea37929e3c79@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 7/9/25 9:10 PM, Damien Le Moal wrote:
> On 7/10/25 12:37 AM, Bart Van Assche wrote:
>> On 7/9/25 4:47 AM, Johannes Thumshirn wrote:
>>> +=C2=A0=C2=A0=C2=A0 TP_printk("%d,%d %s %llu + %llu",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAJOR(__entry=
->dev), MINOR(__entry->dev), __entry->rwbs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (unsigned lon=
g long)__entry->sector,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __entry->nr_s=
ectors)
>>
>> sector_t is a synonym for u64. u64 is defined as unsigned long in
>> include/uapi/asm-generic/int-l64.h and is defined as unsigned long lon=
g
>> in include/uapi/asm-generic/int-ll64.h. Kernel code always includes
>> the int-ll64.h header file. In other words, I think the above cast is
>> superfluous for all CPU architectures supported by the Linux kernel.
>=20
> %llu format will not work on 32-bits arch.

Huh? I think it would be a severe bug in the code in lib/vsprintf.c if
it would not support the %llu format on 32-bits architectures. Is there
perhaps a misunderstanding?

Bart.
