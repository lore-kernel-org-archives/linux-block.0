Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF32773F7;
	Mon, 10 Nov 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791103; cv=none; b=FnZpFNpLPviirefRfLtoSSeI7Yry4vaCPfUNkUeMRKehEtw0S9U4BufgO763Il2EdkuMoA9Tj6iTS7rMPJxDegAwscGr9y/z/4Avfb51eueiyUlMPdvqGs8i2bElOSrxJMaEcdzpUFi9eAN9QHFgRUFKJDiP8eaY8h5+HNDcxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791103; c=relaxed/simple;
	bh=nnm4iPQIjC2agrU9e3LGsSW7nSftkSgtjY0/Uzz8pYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kc7KDAb+gY7v1e3YzYnB9bttK2CnBrPfAQ3SM/kR12ie2Pepc487vRdwcNt/ZQG8kIB1Sx6DrvH87HdydjmU/3uavqrBixIpcHZ9p6zfNJjURFzUen9zMTQaBu3RkYmNUbuO1MrrZr+0G1huYWZSPYnWxuJnbtMxSDA2+J1mEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=5BLOgikf; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="5BLOgikf"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d4vmr5nfFzlgqVJ;
	Mon, 10 Nov 2025 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762791098; x=1765383099; bh=nnm4iPQIjC2agrU9e3LGsSW7
	nSftkSgtjY0/Uzz8pYE=; b=5BLOgikf2udXDA7IvX73Tsefnr2I18ec90uV3QQQ
	RBxqRVsBKDRVucM2XD4g0dhfxkErHmj9QWmA7Ga/Ve6/nEmYHykYW92suKk9/b6Q
	XKAqvqGS6/6abcd4CRs20fZWfF5+denJZ+ajuzIuIJ8QN3CwSloYvsgVnIXo+7tv
	+phb/tAEc8o3LnRN5YwXnQ3zeKgjNP65eG5ouLsyfRjrvhEkVD+L6MxO6+gtbr+6
	xeFu5lFNh+3++vZMRc4Ie6/ANroOtPiIdP5qJdvOCsVJuKvHDAY+V19LX8byvpPS
	1gwzC1IHBcWHbP7DCEK8p/N2Jl0symIC60+PSHqLhqBfog==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id u8vEJFQqw-KG; Mon, 10 Nov 2025 16:11:38 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d4vmf4FTXzlgqV2;
	Mon, 10 Nov 2025 16:11:29 +0000 (UTC)
Message-ID: <ee49da23-55ad-48fa-9a34-8057462819b3@acm.org>
Date: Mon, 10 Nov 2025 08:11:28 -0800
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
 <e7c3d79e-6557-4497-973b-5038f9f35958@acm.org>
 <c72447a9-73a3-42af-aae5-55c042b3974c@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c72447a9-73a3-42af-aae5-55c042b3974c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/9/25 2:37 AM, Nilay Shroff wrote:
> On 11/7/25 9:48 PM, Bart Van Assche wrote:
>> No. As the comment above the data_race() macro explains, the data_race=
()
>> macro makes memory accesses invisible to KCSAN. Hence, annotating
>> writers only with data_race() is sufficient.
>=20
> If the data access is marked using one of READ_ONCE(), WRITE_ONCE(), or
> data_race(), then KCSAN would not instrument that access. However, plai=
n
> accesses are always instrumented.
>=20
> So, if we only mark the writers but keep the readers as plain accesses,=
 KCSAN
> would likely report a race at unknown origin =E2=80=94 because the plai=
n read access is
> still being watched, and when the variable=E2=80=99s value changes, it=E2=
=80=99s detected as a
> data race. This is exactly what I observed and reported earlier with th=
is change.

KCSAN watchpoints do not include the value of a memory location. Hence,
I think that the above conclusion that KCSAN would report data races
against writes marked with data_race() is wrong.

Bart.
