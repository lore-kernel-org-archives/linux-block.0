Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7819ADBF
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017849; cv=none; b=oCuh2ao87Rl2juhIn6TtthOmHuHlZ88y/u7ghFakQUe17msHQxr1jigY3tGqYZ7o22XqqPvbX9m8H/Safr027WeUXwU+LpWaf6DEv03BJopmh15KALofIHfpF3DueeqI/J5pD9XDDWNzx5QHDTJbDRtouboxeXAL8bR+3kMzfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017849; c=relaxed/simple;
	bh=Lj3d3lg3PWcOzgRdvSfH/FXfWervLeaupK2o4zl9nMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnLzBa0KCi5pRLuC4kBErgUoEZicDDh42doc3NZgU9OF6vo35+vOerETT5bl1qMiw5wbvG0lab/MkdQY0K6OFXyFYA53adtmacdquI3kPXPro6LW5nTxjED+sgPWRD2fpuGjWljDsF+I6a2S7JvKX/xmgYGzps28Y7RaYLPVsqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JpK8Aucq; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JpK8Aucq"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b3rHn6TPNzlssnY;
	Fri, 23 May 2025 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748017844; x=1750609845; bh=19OzV+0i/RHfUktBrNxmh2vE
	sUnTCNlRReWKu0lJefI=; b=JpK8AucqQoYmpcJfgI+pFSnCmmfiLqgL3ZizUV/B
	07Fa+IfK0u7ck4tYmHDJq1zShB9ekuhH2lxseBOcjD6O4fcy1JCgBlLzkD1y37xi
	tAQ7deQrkTgeRoFLobrtvtYR51amIU6S03Il9KVg0Lkgf4fIS6tcQ9ZNSrg09FlU
	w2Tb54J/1V3JVKhLOGr5UiAgRcSeyuSAkQ5DL/TAFRBXWk9k+y+mOpq3sTHdD4JW
	6bC2nDLTc3nDzt57LNHMkiFz9idzjpl/Z4AjrPtkeS1D6d89L1hfeAVO/IWOmXXo
	ZjDGyawAe1ASr3OV5ZveS2tQs5sELdBBGJmhiRVLjMXy1A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XqV1SfFL2WrP; Fri, 23 May 2025 16:30:44 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b3rHf3x3qzlgqyV;
	Fri, 23 May 2025 16:30:37 +0000 (UTC)
Message-ID: <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
Date: Fri, 23 May 2025 09:30:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/25 11:02 PM, Damien Le Moal wrote:
> On 5/22/25 19:08, Bart Van Assche wrote:
 > [ ... ]
> Which DM driver is it ? Does that DM driver have some special work queue
> handling of BIO submissions ? Or does is simply remap the BIO and send it down
> to the underlying device in the initial submit_bio() context ? If it is the
> former case, then that DM driver must enable zone write plugging. If it is the
> latter, it should not need zone write plugging and ordering will be handled
> correctly throughout the submit_bio() context for the initial DM BIO, assuming
> that the submitter does indeed serialize write BIO submissions to a zone. I have
> not looked at f2fs code in ages. When I worked on it, there was a mutex to
> serialize write issuing to avoid reordering issues...

It is the dm-default-key driver, a driver about which everyone
(including the authors of that driver) agree that it should disappear.
Unfortunately the functionality provided by that driver has not yet been
integrated in the upstream kernel (encrypt filesystem metadata).

How that driver (dm-default-key) works is very similar to how dm-crypt
works. I think that the most important difference is that dm-crypt
requests encryption for all bios while dm-default-key only sets an
encryption key for a subset of the bios it processes.

The source code of that driver is available here:
https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12/drivers/md/dm-default-key.c

>> Earlier emails in this thread show that the bio splitting below the dm
>> driver can cause bio reordering. See also the call stack that is
>> available here:
>>
>> https://lore.kernel.org/linux-block/47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org/
> 
> I asked for clarification in the first place because I still do not understand
> what is going on reading that lightly explained backtrace you show in that
> email. A more detailed time flow explanation of what is happening and in which
> context would very likely clarify exactly what is gong on.
> 
> So far, the only thing I can think of is that maybe we need to split BIOs in DM
> core before submitting them to the DM driver. But I am reluctant to send such
> patch because I cannot justify/expalin its need based on your explanations.

Backtraces do not fully explain what happens because a single function 
(__submit_bio_noacct()) processes bios for multiple levels in a stacked
block driver hierarchy. That's why I added debug code that reports the
disk name (sde) for the first bio that is inserted out-of-order. This
output shows that the bio reordering is the result of bio splitting at
the bottom of the stack.

Thanks,

Bart.
