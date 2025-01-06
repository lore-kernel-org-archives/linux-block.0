Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9E360
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189689; cv=none; b=l6jIlQ4nqYDxCFqlohjm+RVZ/dzUZfkp5GZ8eN7q1da9xGRozIpEijCwy9CYJLKPl0WcTX1265CGMBRzF/WQpkktspfCV2wEHA8n7HL8gFz8WZANK6hGSW5a+bJgPgdF2A7aQm95rr7tRvVt+dcbumD1Uh8nFesFhAki2MlZz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189689; c=relaxed/simple;
	bh=2+XxHsW7KYOUa/JakZsrOPXeyANRrgO3QgX0AQdXpAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lr9DZXfu95b4Kkt8GIM9kwtvwtzPaY+Q8d2xl7RkYtj+BFedN1SeMTiQm/c5+9UNLbJEgkk5am5ors15nJuZeO8jeEHlooupxMLQoxwKDKgsHAvzmzBMtk4Sscf+cBX6iCj1lMuDwBUrjSP+Xula5Mp6Fqv2doTQnl3r4JjXZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tm4J5hWE; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tm4J5hWE"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YRjzC03Lyz6ClbFV;
	Mon,  6 Jan 2025 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1736189684; x=1738781685; bh=uqTj7zr12cGop9/O79p2Ronp
	zdl/TOKgzdECqDgrZTQ=; b=tm4J5hWEuQ2LEUYH+ikrcdo8SdnWmwXNapUqDzJv
	bAULqGHlJK6JC19TLQ3+iLwKC/y9r/9AU34rGGRHsjfH6jYSCKa+RbxLvScbBAA/
	VIggaBRT4yGmG7YOiBy743xl2SgKVQF6peG7nfDAU7RNMZgDk/pt6nHBxcXDEr3T
	+8LDK2jkvKQWuSsvaDRIUjEX1QqhJOecC3hNF0X5wdzmnPbdP2CsHgy12ptqq7GU
	MfTK7hxqWFaKIqpCnZj69bpqcwRQog8ZQJnZMrAymDkIcZ7oaj25e2vb5hntS9eS
	t7i1BZ/vYWoc1tKnM1Jof46fXFU6tX7bU29IrfKwvHpGFg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wwlRCv_mCuPs; Mon,  6 Jan 2025 18:54:44 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YRjz71SNNz6ClbFS;
	Mon,  6 Jan 2025 18:54:42 +0000 (UTC)
Message-ID: <0d377243-d164-4cc2-b8b1-17558cb031ba@acm.org>
Date: Mon, 6 Jan 2025 10:54:41 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org>
 <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk>
 <fb292dc8-7092-45c1-ae8a-fca1d61c6c9a@kernel.dk>
 <9e8e2410-53b5-4dad-8b54-b7e72647703b@kernel.org>
 <20241218065859.GA25215@lst.de>
 <78caa04c-34b6-4801-a57a-84251dd9d253@acm.org>
 <20241221081033.GA13103@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241221081033.GA13103@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/24 12:10 AM, Christoph Hellwig wrote:
> On Thu, Dec 19, 2024 at 10:04:40AM -0800, Bart Van Assche wrote:
>> On 12/17/24 10:58 PM, Christoph Hellwig wrote:
>>> Use the new append writes that return the written offsets we've
>>> talked about.
>> Here is why this is not a solution for SCSI devices:
>> * There is no Zone Append command in the relevant SCSI standard (ZBC).
> 
> Standard exist to be changed.

(replying to an email of two weeks ago)

I'm not aware of any interest from the side of my employer regarding
standardizing a SCSI zone append command. Additionally, last time I
tried to make a nontrivial change to the SCSI standards (adding data
lifetime support) I learned that it is almost impossible for anyone
other than the longtime SCSI committee members to make nontrivial
changes. All my attempts to introduce data lifetime support in SBC
failed. It is only after the SBC editor took over the initiative and
wrote a proposal that progress was made and data lifetime support was
added to the SCSI standards.

If anyone else would like to work on standardizing a SCSI zone append
command I would be happy to help.

Bart.

