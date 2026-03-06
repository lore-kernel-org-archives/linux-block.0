Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DD30E858
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806272; cv=none; b=F5FS1dPAoTio3INi62iXYZNfab6Q/lXsr6TtroLPvL9lH/RbcM0Bu9G9vasRK10W0tmLfxWylZ6+OGNVBlMYK5vv4NltTBc2syKiCrvtioiCsCpaGhvRilrBzLeCpOvc7PtRqgqZnEH8SFlJreERTapmwrlSFIqqLF1beFvJ5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806272; c=relaxed/simple;
	bh=TZDTyUP/OWJM0C4I/rZxQy/PouTuxpTXK+v2jl0Q5VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjlDJYUI9DaGFEJENFS7lmNpLDeddPibH0zislQJRV9GMjQr3ZdhOj+3D2QQ+qqDNpTk7YF1qN8u8Olnt2RgtUKvua1id0TRBpxZStNk/5mhrnPj6RJp3oSdVBzsWJhoRwdjMrpNOBzXfB0wumpqBJjDiBtGCpTBbZtqqY+EYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=y9vUTXkk; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="y9vUTXkk"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fS7cH0hd4z1XLyjF;
	Fri,  6 Mar 2026 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772806266; x=1775398267; bh=6m2ihEtaInK8g8aivIX/90kM
	lyC7t8007nV7nqLP3J8=; b=y9vUTXkkJAC0/POKUpDMAVn0VTClS9ZYbQ+YT0DJ
	+Y/W6jNDyDW9z9HfG82RhT9ORYViF5dKSojm8E3KdT0QYEX4yGTvWFmW7Y5ofTSs
	P4iRBcurA83h0joZYFGXPW6clYbbT5RfN1aI5duUS59rzy5Z30e4FsiObTlX7jmI
	iHynRCWIPMvZ/LyzCOgQoncw64YULgOTEK+79+fMFqyZvKrIiBfei9oHs3RiUGbc
	Tk9wDXZ5YoTJY4HwpMP8I6a5HxQJN5aFdU/iyRGWlbyb0WFZUPoP2wgsa3hbT87g
	DGfecmx7+jI2uooisOIDyhIUM+voFQPjHY1ilUeFdIDcTQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UJMQmVM-kA3e; Fri,  6 Mar 2026 14:11:06 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fS7c81ZW2z1XM6JT;
	Fri,  6 Mar 2026 14:11:03 +0000 (UTC)
Message-ID: <255978c9-1cb3-4fa5-bb91-c07c6ee7a498@acm.org>
Date: Fri, 6 Mar 2026 08:11:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] rnbd: Add more lock context annotations
To: Marco Elver <elver@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-11-bvanassche@acm.org>
 <CANpmjNNF4wjZout_zz9rW2eoH4nAHQy9YURmn1hNtiuSsk+9fQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNNF4wjZout_zz9rW2eoH4nAHQy9YURmn1hNtiuSsk+9fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/6/26 7:09 AM, Marco Elver wrote:
> On Wed, 4 Mar 2026 at 20:49, Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> Prepare for enabling lock context analysis by adding the lock context
>> annotations required by Clang.
>>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/block/rnbd/rnbd-clt.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
>> index 4d6725a0035e..7f0f29b8e75a 100644
>> --- a/drivers/block/rnbd/rnbd-clt.c
>> +++ b/drivers/block/rnbd/rnbd-clt.c
>> @@ -833,6 +833,7 @@ static int wait_for_rtrs_connection(struct rnbd_clt_session *sess)
>>   static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
>>          __releases(&sess_lock)
>>          __acquires(&sess_lock)
>> +       __must_hold(sess_lock)
>>   {
>>          DEFINE_WAIT(wait);
>>
>> @@ -855,6 +856,7 @@ static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
>>   static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
>>          __releases(&sess_lock)
>>          __acquires(&sess_lock)
>> +       __must_hold(sess_lock)
>>   {
>>          struct rnbd_clt_session *sess, *sn;
>>          int err;
> 
> This has all 3: __releases, __acquires, __must_hold. Only either
> __releases + __acquires OR __must_hold is sufficient. __must_hold
> implies that the lock must be both held on entry and exit - if that
> lock is released and re-acquired within the function is irrelevant.
> For documentation purposes it might be that one or the other is
> clearer (e.g. I've used both __release+__acquires in some cases where
> I felt it's clearer).

Let's not make more changes than strictly necessary. I will drop this patch.

Thanks,

Bart.
