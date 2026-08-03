Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D96427A06
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779027; cv=none; b=id7fF40CzCTaRFgpVCQyBYKthyn1qauKCsAGjFN7eR3jCtrjIILyvhC9m+JOtkAqDhD5vzzVfiQSfJOblHBRrYovGDAsMDYMG9X83xnv2FCpRxU8zDpIepsUkr4OT6SIERk1s3TV3KqzH/NW3coWjej5lwQKQYOD9HX2PuiLAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779027; c=relaxed/simple;
	bh=W2T2O8UvRXHhJn2X0SmtJz8OeED2gT4+PIg19wW+l6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RM2LvvIKAfxMdHLhNbkLtcV3gJNatt4YCXTv7Sj7GPPaO7w5m4E5+BCKroAI+RXAy8ri2Q0L3qUJvze9Y2X+GrnK55YJMOCt1RuDYg9Cd7l6pwMODXgl+ZoJxzR/DLNBKC+g1F8hyWhKFWX1ghMHjwoRbdZcw8jn10SjcTV5+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TLEEq1zT; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TLEEq1zT"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hDPDH0GQ4zlfvq4;
	Mon,  3 Aug 2026 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785779019; x=1788371020; bh=tpyd1SeAJjf6XBGjZaDngmlq
	OQrfj+XuTFD91mdfO+g=; b=TLEEq1zTLouAPOnOV+apTZnawxyHj9L+bw8kfRwN
	l27t0QnlkbrOMe9ug3VM5u4SPNx0c32nc6rAiHrlq0LDskpRWk+Mo7xX4hA/clgJ
	cUzJFa7435yPHMSe6MoTFWIh5dCNjewMdype/jB2xkhj2l6+gGggFJr6bRQh/FRG
	A25MNtJsxmRAqZvRb5TnJxlisvJzauDGHdjXr/XkPYVHzRMJ3mo2ZwNTPpYgXaqt
	tO4h5d6Qg75ExnCt1rzyVeO9EF8n0HKwS5z6Bf66HR7y7ygcNZhXZb99881GUkiY
	HVJoBcTOg661xM1unQe04rn56t6nuAqff0DOdNNzxN4hTA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uRSbLWMY7t57; Mon,  3 Aug 2026 17:43:39 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hDPD95KXHzlfvpM;
	Mon,  3 Aug 2026 17:43:37 +0000 (UTC)
Message-ID: <3f42cecd-98e1-4db7-b026-f673e38d54d3@acm.org>
Date: Mon, 3 Aug 2026 10:43:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] loop: Add lock context annotations
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <cover.1785440858.git.bvanassche@acm.org>
 <db7c5b870df403fe97229f6bb59144122e16aa41.1785440858.git.bvanassche@acm.org>
 <a41ebd1f-f115-477b-a3b0-5ca9247ce465@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a41ebd1f-f115-477b-a3b0-5ca9247ce465@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/3/26 6:11 AM, Nilay Shroff wrote:
> On 7/31/26 1:28 AM, Bart Van Assche wrote:
>> Add lock context annotations that are compatible with Clang. Swap the
>> loop_ctl_mutex and loop_index_idr declarations such that __guarded_by(=
)
>> can be used.
>>
>> Cc: Nilay Shroff <nilay@linux.ibm.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>> =C2=A0 drivers/block/loop.c | 7 ++++++-
>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index a71fe763c933..e2ac19de11f4 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -90,8 +90,8 @@ struct loop_cmd {
>> =C2=A0 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
>> =C2=A0 #define LOOP_DEFAULT_HW_Q_DEPTH 128
>> -static DEFINE_IDR(loop_index_idr);
>> =C2=A0 static DEFINE_MUTEX(loop_ctl_mutex);
>> +static __guarded_by(&loop_ctl_mutex) DEFINE_IDR(loop_index_idr);
>=20
> Can we define helper macro here, which is more readable?
>=20
> # define DEFINE_IDR_GUARDED(name, lock)\
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __guarded_by(&(lock)) DEFIN=
E_IDR(name);
>=20
> This is similar to what we have defined for guarded LIST_HEAD here:
> https://lore.kernel.org/all/20260713115444.465704-2-nilay@linux.ibm.com=
/

Maybe I missed something but it's not clear to me how such a short macro
helps? It doesn't seem to improve code readability to me?

Thanks,

Bart.
