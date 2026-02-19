Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC733ADAA
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512820; cv=none; b=JCYyOGCIXsgFswqVtm+TuzwYfoQuscSYWj+4mriFh6cqvTZOTOQxXRb5c2a8dPX4G2dIbGvosVysiQ0opFGsBcuwhrlj85c/Qo7HzA9Ufik2iQ8K/N3PbskkUomzJafrZW7Q+vghCGqiSvqYxa67tMQabxVf/Pi6R5oO6sTrM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512820; c=relaxed/simple;
	bh=UrUjai8u6cXHh2+G8/qX0EhH70xOkqAzUdC8B16/41w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TvaxF7WLaOG/mx4zeirg0WTGtVUhj7bpd1g540sjISg//Vjh/n+WaXLt7UUl9Asoq2o4oxFVvQA0nUBi1Eqle317WXS0ZC9jyKNs/+kkjRAaSz2bZ6L2bHzBXd3qPn3j2IO5JmA7jUV0bTBzlByeQ9ozBaKrGXrz0obdQmMNjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=33m25o9O; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="33m25o9O"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fGxG53hkfz1XM0nn;
	Thu, 19 Feb 2026 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771512812; x=1774104813; bh=Hunk2Dv1mebPSEeGUspQczD4
	2feWNf6sRslRoqaD9x4=; b=33m25o9OsFO5l3zjvISU1ttAkoFEsdWWD7CgzOx6
	fC4HehvWZSOk3tjy5SD4cMAU8Lt99d8I/f5YC8NmHFO8wz+m75fWLW3TX/tXiN9y
	PPKSBfZmsgmnTuQPOzARa1MGLiCP71c7dT72r5OxKVSYB2UtapBdyfaSqpTvUTaC
	sjaMkrANYElMsbMEIlliiDx/T6lUR5hk6hSlvLoBLSldrGFiTLaV0Af4mfqt6Fe0
	D7AN6/3OzTpCgoCufHH3hLRO1rasGIPT5ndOrNaqobxHy7Pp2mifDFeWHXRVCPke
	gM81OQAepWn2NKRQH5OBSsD/lJyVQFA4vn/TP8BMvtyaNA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yijDWlHsKgO7; Thu, 19 Feb 2026 14:53:32 +0000 (UTC)
Received: from [10.237.57.149] (173-255-98-114.utilitytelephone.net [173.255.98.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fGxG232syz1XM6JF;
	Thu, 19 Feb 2026 14:53:30 +0000 (UTC)
Message-ID: <e2733d9f-823d-433b-9bfd-24df20b98b7d@acm.org>
Date: Thu, 19 Feb 2026 06:53:28 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
To: Hannes Reinecke <hare@suse.de>, lsf-pc
 <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2/19/26 1:54 AM, Hannes Reinecke wrote:
> I (together with the Czech Technical University) did some experiments=20
> trying to measure memory fragmentation with large block sizes.
> Testbed used was an nvme setup talking to a nvmet storage over
> the network.
>=20
> Doing so raised some challenges:
>=20
> - How do you _generate_ memory fragmentation? The MM subsystem is
>  =C2=A0 precisely geared up to avoid it, so you would need to come up
>  =C2=A0 with some idea how to defeat it. With the help from Willy I man=
aged
>  =C2=A0 to come up with something, but I really would like to discuss
>  =C2=A0 what would be the best option here.
> - What is acceptable memory fragmentation? Are we good enough if the
>  =C2=A0 measured fragmentation does not grow during the test runs?
> - Do we have better visibility into memory fragmentation other than
>  =C2=A0 just reading /proc/buddyinfo?

The larger the block size, the higher the write amplification (WAF),
isn't it? Why to increase the block size since there is a solution
available that doesn't increase WAF, namely zoned storage?

Additionally, why is contiguous memory required for block sizes
larger than the page size? Does this perhaps come from the VFS layer?
If so, is this something that can be fixed?

Thanks,

Bart.
