Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706989;
	b=bzzpXfzK73XBEoXrVT45quZqdUOLFCwpHMdqtGTkdEWBRPe5EKzs11n4Z51FnOgwh6Ap
	 rYMioHqgqAZvggh5G3J9CeSM/3TtL/IkCzODYBOg5sEEK5GSqmWLqGj80ycyVEgYkfIWx
	 W/MqG4Mc/w1fSIpAf4Ijqu7ar0XRT0pOqvUZN6kyt8VKegWFw2RP5TND710lDhnvcForf
	 DdHA8GCdA28n+xiAPSt/iqQYZjcWiJTayEeR2OwozQJkeji7DbTT4N6kAzdaZWW0OROBi
	 PPgLriClTqBe8Xce4iGwseMllBzYInFv8HG40tPEevEGcZL6+Du+Q3txqJXNAl6ycnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3Z7nPEaoyhJ41r3bk+azLIXCJVO4Tkbh+/BIA8Q8SWo=;
	b=0G5aaPSe7HUCXtAk9WGeWFXFj2n3CMqHek1XHXKUm76KjfD5ZSr3ELjNzhI3KX8rYl6S
	 p/xtoBsj/CnaiOFT2zzlpW+kFzX9cH/lwQv8Hvv9hWYBe1TNEE6oxBpaUWOSW4wwL2r+T
	 oUufTiricrp4CFW77mtoEWOgmdj11p/jrxOU4hHQGygj/94inmtn0vfoKvZQk6GTI1nRA
	 eyzPw//zjd4N6YhvejHVT/g7zxgVZbkpS/sH5DzZuA+FhVXPFE/jqOnxs4wJvzP2l+pik
	 cJ/g2myc49LQdZcXY8MRwZkJdL1TsKjfyIINWz52RPd1k6Bwb9dVYHkBERAUbq58ZpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=GjMdjqQ2;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD33606A31E
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 15:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD33606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=GjMdjqQ2
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a070781f63so3467389b3a.1
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795706988; x=1796311788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Z7nPEaoyhJ41r3bk+azLIXCJVO4Tkbh+/BIA8Q8SWo=;
        b=GjMdjqQ2XrzHynrZkiyhonkCN8ImWYx7PiVDtrnvlMytNmMKcItTmoYy1yvs/VA0Jl
         GFnghbePsp/ef/ngLSGU+sQbm5hEn3sDd3mzDRlwc5LcKseyYcB3BW6e6c6iHBSdd035
         olFy8QGW/0j2acreNbQV7pWYc/rG20jU93MejM2AOpJ40k9vXqye01MLIDXMJUzM1thK
         47ErhQkoTzsZv6h0WAMeCigHqaTiQnV/JiVWKUPWFbV6RtgJvAe3YXpvYYjIU0gResRq
         cyTTOVXAIa6Zgg5TWvh6Esin+9Qc5WygvuRczrtFPhd3y0vb0uHhaqYtZakLA6grvD+E
         qm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706988; x=1796311788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Z7nPEaoyhJ41r3bk+azLIXCJVO4Tkbh+/BIA8Q8SWo=;
        b=xOCG8aeNe5JLjfdwMN9rVEendAxvYQLq6blCHr9/vypjClaZxGUMCd2ia9cfbnNnbv
         YVQdGrNMh0inFKAL4KWhgsuEsky6bM7h7g3DHYmBJZn+AsI0AwlECArm4Z1bduJANoaH
         cE0j6xXbaAxyhr93uNMnxO8oSBGPwv6w8TZqi95ZuZ+Yq4SdOAsRt6oZKgE/qjyf6ZSt
         kqomFpMKd1yH1oVibHLQ8hbzUgNUT7PPFGDDX5RqZGl5M09PR35zPIToHlAtT9y7Ntxi
         SPmrJBK7ZXPbkDpxK2hkPbsAkYyPt1b2uynUfxw3HRviV5Q06BxuAFULB4MFedh3tsTm
         dqAw==
X-Forwarded-Encrypted: i=1; AL+hErEu7k+3zF3H2yfEtmIswzMoeiRTg1FjqNx8V/Z5LWOLkeOLPeQCoKp22eJEq/UDjrVxQB5bRFEc03hqhw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+NubC8wAGgS3FYCzUfJMOs7stWs6tW0AmCJXR3EOx7hGvz6eMt
	7POwWmB5aGeqfrl5mOZkg8GnAFwfEj7oDqWGtObXwhdqkO4+LgaUZFpOve3+nycAZRDYHViedXC
	hVZDgFwE=
X-Gm-Gg: AZFdTZcx3BcH1hc/9ccQrOF6tRCPwi3F1jMjTYNtZqwiuw6qLbjczhHpMxHGFXjhw5p
	jLlVaqAIJV4olWPYIeuPxyWFUndLcRV173LXNKJL4valfqukWELHbrHMVC75BPfQMZInkCsqvGa
	iJ5fGuR0agWnWDrgvAEEJrEPDGO1GHhIsd46eovY9mCT/yMUt9L8Kx7vgqokIiwbVL+d0BSXkZC
	11UMwH2o4I7BvNEzHkoYyTc9mTUjrd8TRN17Vbojsix1acP2A50lG8MhZfgYOcXoUjz/6LRRYug
	/Zui4JHvmAuP0issfGSqFvE1ccVvuzVrEX/WPzEgT26gq4C0M35Pjkj4ggCMAPGboWhBl5wBiOE
	MwSO6dKyfLNZ42F+G27RDMHuGa38FxQy3QrhXatCO31EueK8mnr3UxldCXgjmKN/VOJjKdnAycC
	avGR1M6lnMZK6lWJH+FPucVmoGf2DxIpIkP+UpiiG+3PeNItV7MWk1/Vbb6UqfTm5pE4HKVC+ck
	lZKjyOaTgKY2KF14LIuhbKsdx+3U5UqjFkhm9yOMsFQ2OFGg7suDijGjexsACXNzoDR+29VfbQ0
	3IODs31eU4rBdgCYveKAzAUYWolyv7jhenpsrsHdiLaTYETewFIPUBKytltQ7wokZNS92+s/Rax
	25ijBcODTWwNdnYSRA8jP1a0ZJ6m4WPqCy7dAaxdLfl9RUvaEZefTWfNEHek0UUwEmohYPZI=
X-Received: by 2002:a05:6a00:170d:b0:885:e2eb:23b6 with SMTP id d2e1a72fcca58-8c87b9cfab5mr20410631b3a.11.1795706987829;
        Thu, 26 Nov 2026 07:29:47 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285ccf4sm10534872b3a.12.2026.11.26.07.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:29:47 -0800 (PST)
Message-ID: <970946a8-855e-4d65-97d9-71c7cb2ceb20@kernel.dk>
Date: Thu, 26 Nov 2026 08:29:46 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 0/3] block: delay support for error injection
To: Christoph Hellwig <hch@lst.de>
Cc: Haris Iqbal <haris.iqbal@linux.dev>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20261111215838.103356-1-haris.iqbal@linux.dev>
 <179501806989.17649.3138860274842922761.b4-ty@b4>
 <20261120164416.GA32719@lst.de>
 <edb8249a-7bc3-430e-bbb7-243e1881a0b8@linux.dev>
 <1cf30693-44c6-4761-9900-e36259082e4e@kernel.dk>
 <20261126083421.GA7403@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261126083421.GA7403@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 1:34 AM, Christoph Hellwig wrote:
> On Wed, Nov 25, 2026 at 06:49:59PM -0700, Jens Axboe wrote:
>>> I can resend with the fix, or send just the fix to be patched above
>>> this, since these are already picked. Let me know whats preferable.
>>
>> Send a fix please, that should always be the default as otherwise
>> I have to rebase the tree.
> 
> Unless it is at the end of the branch.  And looking at your tree, it
> seems like you have queued this up at the end, but in the 7.4 branch.
> Which I hadn't noticed before, and which seems wrong.  Not only is
> this a brand new feature and we're at -rc4, it also makes it really
> hard to get the tree in sync for other features pending for 7.5.
> (which we plan to send after this lands).

Gah, yes that is certainly a mistake, in my mind I had it staged for 7.5
of course. But looks like that ship sailed, as it's now in Linus's tree
as well as part of updates from last week. How broken is this right now,
in terms of what fix(es) we need? We can always just disable it. For
7.5, we can just pull in the block-7.4 branch and resolve the conflicts
that way, fairly straight forward and usual approach.

-- 
Jens Axboe
