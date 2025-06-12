Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF221B9FD
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743833; cv=none; b=hpIRa4BfJremQ+o5ykYHykljf9xBJqmGuJD6mo8BL6RqMtDbIMUKQ15l948NEM1j1p2zW6acROXa+z9HbBcZjSfdPuRw4PupBvN/t7rSsJE2DdrCBhPk/xLyia3lcd4bhVa0PMnDYV1jukFGojFmhyqRJjNWyMmbr3yv4Y9thyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743833; c=relaxed/simple;
	bh=06gdggT9OulnHghyPWqzkLI3HUVPaExW0knGetG1gIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmHZ5cD6awRvx4arhwXzToSp/BVTADpNzO7ABUEdOf2wlZ56zQP2M4Eo4Ib9bxmk2C7sXU1nubljR0WK591tk1rZcQcjwXeLEGVd/QTclOQ2IHUCMwMVPA7icm6M8iaZhpTCMEgHxsCqiCQ9dgWHokMbBp94Yc0CiT1q8sskNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yh3MAVty; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yh3MAVty"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bJ6bp5bN6zm1HbV;
	Thu, 12 Jun 2025 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749743829; x=1752335830; bh=5p6cHRm8hsfc8/y1E2RfscJy
	p4zfnr8NndeEoSw1ldQ=; b=yh3MAVtypHH+C11SK01HQLWQy4k/YTadAeVtT52Z
	gRlQ3SQYldlgarOIGzO5yuSBuBPIlVld8bWqoPhOCSGXVeLNm4ary9s8Uf/dI1yf
	aPyo01AE77qDDMm7PHNJur6oUYJowF61IooTxfEvSK5oWuCmedLrviQOR1BrWtUm
	DtABcaPJ5iJTrgDz8nWzhaOPhc6fcjzrT6H9ITh4zy8cQOSmfCVEH63VWjeqhL5L
	gb96Ab874jkxjvwhocIlqHcOTTWm6vYGX9mOvUhEc8p3dLVci7TLlCjYya6KO4K6
	5HMR9aQuYiHlKPl+sSzt4mw424sMdCGsF80WXUfiqsOHVA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tKenOyZuqI6X; Thu, 12 Jun 2025 15:57:09 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bJ6bn0VcDzm0gbb;
	Thu, 12 Jun 2025 15:57:07 +0000 (UTC)
Message-ID: <1bec0b1f-704d-438f-8fa2-fb19738e3254@acm.org>
Date: Thu, 12 Jun 2025 08:57:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
 <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
 <6ov3repiplxgds6jcprle5jhtg33myba2cgf3bt7lsklqlvmy5@igjg7muw2hv4>
 <e9c4235a-1c60-4a61-a152-f65ae973992a@acm.org>
 <3et7jqzna2n2e7henrbr2foiopjqxl64pqxaadszrbmmuqorei@xinbpunqb2ye>
 <b36df65a-1b59-4c03-8d6a-d0a90729ad7d@acm.org>
 <f7uik7sjmi4ta57auekhlzv56p3enab4mufidfd2mrk5zhpphc@tsvmhjkbiyvb>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f7uik7sjmi4ta57auekhlzv56p3enab4mufidfd2mrk5zhpphc@tsvmhjkbiyvb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 10:16 PM, Shinichiro Kawasaki wrote:
> I'm afraid, no. I'm thinking about this kind of test cases:
> 
>   - it uses "set -e"
>   - it does not use subshell
>   - it has clean up code in test() or test_device()
>     ('IOW, it does not register cleanup handler by _register_test_cleanup())
> 
> For such test cases, the clean up code in test() or test_device() can be skipped
> by error exit by "set -e" regardless of the "set +e" in _call_test().

Let's rely on source code review to catch test scripts that use set -e
without subshell.

Thanks,

Bart.
