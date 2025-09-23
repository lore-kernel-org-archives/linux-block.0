Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6724A069
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643180; cv=none; b=fLzPuQnT/u5v/4guZjY0mo31bWRU2X+KXRl8FGUPKqln5VzpBMkvh/mQiu7dY33xUwL1Uefvx4I5n4F034u5DOMSGvMohsulLlYbTuhdvww9dppzX/20StKwqqyu+DsSh5sT6enpJAOq+KBD4sXwDe8WcCZVudKKj/2AGv/c1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643180; c=relaxed/simple;
	bh=X91FR3w8sKFfIVYpQ7WoSHQf7FUzhUn5Y/Bq/a7bFSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZVJCicnG2Vt0IZrNd5CPAyg+Gi97Hmqnrd1XhgErnowohj32+UKJnq1lxEorM69xF20uAyVYxiDTh1XRTX7ecHL0OWYec7w2u/fbZ0dC6wOOHcf9HAQLMhrKI/XVaITQFOdtcxMkE64M/05CV/lkOeolJ1f2TksNjgs1N7VUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rKlaqWVr; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rKlaqWVr"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cWPmz6PfQzlgqTt;
	Tue, 23 Sep 2025 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1758643170; x=1761235171; bh=X91FR3w8sKFfIVYpQ7WoSHQf
	7FUzhUn5Y/Bq/a7bFSE=; b=rKlaqWVr2Y2RDCp/tO7H4lwlIvfKy/lVHj6aYn40
	GucDpQ62uBegUWP9eTa2nn4fAYY7d0onCb4E2yWtSM6YCjrWdfRD25LQFz5TSmFo
	IWY8iYB0go166XQ8wCXwZyEXOawXT6VmvN8uTBuK80VVwAy6MXoeRUE7pW7oGMDA
	Z2Mx1luuDNl5ZkA4KhBXkgdM/Yr0Wi1PuBLKaCwCXadDhpwd2NlU+MIAxkFIWQFu
	uR6E8mVjIDNsY7pGtND4AuSLAuU60DwOvagfwj4IHO7qEVf3OOBcg5g6pjdbPMHD
	y5rOvrMDkGnJC7HXX6SgIOwYGjSNjX3JNbPcNkejnpz80g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oJtnKahKNBZF; Tue, 23 Sep 2025 15:59:30 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cWPms6rGqzlgqVL;
	Tue, 23 Sep 2025 15:59:25 +0000 (UTC)
Message-ID: <3f32e7ee-e532-4d69-8848-43d44693e93a@acm.org>
Date: Tue, 23 Sep 2025 08:59:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Fix more tag iteration function documentation
To: John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
References: <20250922201324.106701-1-bvanassche@acm.org>
 <d61889c5-a3e2-4a4c-a569-041c9f3e916e@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d61889c5-a3e2-4a4c-a569-041c9f3e916e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/23/25 12:51 AM, John Garry wrote:
> On 22/09/2025 21:13, Bart Van Assche wrote:
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 0602ca7f1e37..271fa005c51e 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -297,15 +297,15 @@ static bool bt_iter(struct sbitmap *bitmap,=20
>> unsigned int bitnr, void *data)
>> =C2=A0 /**
>> =C2=A0=C2=A0 * bt_for_each - iterate over the requests associated with=
 a=20
>> hardware queue
>> =C2=A0=C2=A0 * @hctx:=C2=A0=C2=A0=C2=A0 Hardware queue to examine.
>> - * @q:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Request queue to exa=
mine.
>> + * @q:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Request queue @hctx =
is associated with (@hctx->queue).
>=20
> eh, sometimes hctx is NULL, so it is odd to be saying that it is the q=20
> is associated with that (being NULL)

Thanks for the feedback John.

Jens, please let me know whether you want me to address this feedback in
a follow-up patch or by posting a second version of this patch.

Thank you,

Bart.
