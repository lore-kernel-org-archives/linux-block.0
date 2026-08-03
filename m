Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A642BC5E
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780202; cv=none; b=KlBLrmtbYtGsjcN3XyZxp0nIWC5JNpGcCkeSwGcoqHPnt6zmWiQxdhYdaMQJK/U0pJ1gNVQ4Tt1qB0sKc9kPr76TZFs8yLTe+hcFZjNhqFR/Unsay1/0iFWC3Ui+R/QJ5YE1SLtBZ+B3kpWsZ5sDBElXV622aSr6aySxhdO9oRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780202; c=relaxed/simple;
	bh=oUgXVEdZgq8ePqiQQC/carmdV4scb1mVd33JFxuTVgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijTxpKz8BF47NuXjsFi2gFRayzuI5BChrZEqOUACbkXHYIzY5k/lAgaXrQjzxrwXNQlYWbbuu6KNXceWJLEfOuLIyucev1Fu9SdzmoVKwiOdV03/LK4CrmvOVNmN6HmMuTbTosReupt5Kv96ZiQBXNla7yF1QRM0IjkcfPVTphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=D9zFWS61; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="D9zFWS61"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hDPfw6bdRz1XM6JJ;
	Mon,  3 Aug 2026 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785780197; x=1788372198; bh=oUgXVEdZgq8ePqiQQC/carmd
	V4scb1mVd33JFxuTVgk=; b=D9zFWS61/Ru7v9JFWv5K7xoI01qysG4fkdOh2Y1H
	u91VRByYCCjW/SnLt2WoELGhTbIbP1BWCB5wupuzS1S0ZDLp7xo6JKDZrCRpqErg
	fwX8HhnMsf14d+OuXn/w/67KiWoCuvU60UhpI5LKfduTKQHlzN9ArV5IGF+iABXJ
	rqclCgWT9Ozx5MEhsx7NcXJ2nVXfhGrtcL95S/cDDPjo1bWDO3gDLMwnS+XEqhO8
	/RgwprmtfYWduUUlXDI+sJOJgU9FljIRMEnytyZ8Yk069zGp9S5DaHY7Mben9P6+
	tBGeD71dWdzIuoxIDS0U8C6ppcUXaKvlzXPpBAHfbXW+wA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TL_G3mfHKtKp; Mon,  3 Aug 2026 18:03:17 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hDPfp4ZnQz1XM4Sx;
	Mon,  3 Aug 2026 18:03:14 +0000 (UTC)
Message-ID: <7d5c9498-c471-4715-a264-17a4df4c2559@acm.org>
Date: Mon, 3 Aug 2026 11:03:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] nbd: Enable lock context analysis
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <5e1f54d3826b0d479242a9886ca2c7b6eb8cedaf.1785440858.git.bvanassche@acm.org>
 <a438f0ba-e2b0-4fa5-920c-bdbf49769674@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a438f0ba-e2b0-4fa5-920c-bdbf49769674@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/3/26 6:26 AM, Nilay Shroff wrote:
> On 7/31/26 1:28 AM, Bart Van Assche wrote:
>> @@ -2773,7 +2776,11 @@ static void __exit nbd_cleanup(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Also wait for nbd_dev_remove_work() =
completes */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(nbd_del_wq);
>> -=C2=A0=C2=A0=C2=A0 idr_destroy(&nbd_index_idr);
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __assume_ctx_lock(&nbd_ind=
ex_mutex);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idr_destroy(&nbd_index_idr=
);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>=20
> Could we instead introduce a scoped __assume_ctx_lock() helper so we
> don't need the explicit scope here? Alternatively, would annotating
> nbd_cleanup() with __context_unsafe be a better fit?
There is code in nbd_cleanup() that must be protected by a mutex so I
think that we shouldn't annotate nbd_cleanup() with __context_unsafe().

Introducing a scoped __assume_ctx_lock() might be overkill.

Thanks,

Bart.
