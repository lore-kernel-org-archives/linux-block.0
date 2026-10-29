Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279978;
	b=nhAOGeCSMzAwYMDF6Dsh01fJzbYM9l69WxqPAUjqS6Oa8+XbPDm+9cAOqVJyMpWGzHN/
	 5h/WKhUQulMzczQAZ57RPPvpHlk07gvCTQR3KeF2LEAF+FKmjkcAXGSKflJ/ec11RD2lY
	 wCf+pglyKyZ8hCilWsfwSN7LkRf9Y6O8uIPN2VQEZclGCgi97ELGQ0iUCx1Ca6bc3vkdb
	 H8DdB8OHuH9orHgt2itXswuO++BNsRhV1bYnjF5aQf90DLGQao8xItCkSJY0i8tgMDL/K
	 FaD9frMeqwGzcqurQqjpGPiHs28vhYjJNi+lDI107x0kC2FlQmP2E2cltDV5VUmqCAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4ZkLZqyH7kc4tNlXM20kJGxC4f2hW8508E6lc2iuQt0=;
	b=aGkICidTMmki5V1ks68slWbuYYHGMHmDH0AFWeoENLZbxmBoS6IQtQq10qZ5XPtEDiO3
	 Voi71RHqtSWsxGvvzyjmBB146wktt53IwZ1Pxfm1C66r8rDBt4lcarArKYLZpeKqXGImt
	 CA3N9ZDdDw+0LNsUGaLsS/IOxXReGwznA76BZo5sUJ3PaiCn6BWUfRiSgWmTY92xzPWOm
	 7Y+9OhJdIyTYkTPalLAc7+K5Xo00+ildH6XQBxCv2EdiaWgd+0SraOb3ausmX43MmjwjW
	 4upc2jtQXbTbrSf7obFpguYcmKb0yW1C10bD//a93vQW4P/GSDb9mo8h7fWTnfo0YDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WNDszNkc;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B458606A31F
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B458606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WNDszNkc
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so3880962eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793279976; x=1793884776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ZkLZqyH7kc4tNlXM20kJGxC4f2hW8508E6lc2iuQt0=;
        b=WNDszNkcMvKGb+OXt1aNpsk4ZWcql89IZvPrf0mN8mU+ycVg+eIb9bRhxoXd++G97W
         s6WsAFKu1/vVwvkoGkwPxw2uN8jS0T/R3rSpzYNTCGq2gtO0QJ8LcJAK9SjtiVoaeWi2
         ovSG9+elYWEW7rDPhlfHsvALcX7BVBzEXorUU2GFmxuzFsG1LRFqqIyKac8Sa91s3uzS
         fCD2JqCp6M/UrdO32XZldNiaZ1vfDklgDprN6FlzD+cjgTCK7nFGEHsmd19OSh+vD9nU
         ylFbJMqrtz3LeF72is6AH9ol5KJU8Sz9QXquZC1KvpcVHZTUnMh4XfRAKloPZPN/mQJD
         7HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279976; x=1793884776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZkLZqyH7kc4tNlXM20kJGxC4f2hW8508E6lc2iuQt0=;
        b=Y2yNrQjam1yRviGFNoVi0HXqnutM0eRN5S3tLeXk4T+QjSjtPNVEfrh9LRXuyPmkvM
         B98OEwzefD7GQILtdmh+d9s67aGympv4v8vMueuhmHm085JMAWdlxQrZP8OMXBc+Pv4Z
         o49AjO0Y2zRSxG5llBE0QbNxDyBiD5KhIcB3dPBlG91y4Up+Wq2hwMdFGHexyAkLYXRP
         b5guko+vwYwwhbIjO274JUkEiNR3UbdXX9N9YsWLSegTliDkywDktI2iolvHvfwt45vR
         Tu65NxmOfNLvgT8E8xoNmTtF7U8BQ+zKku4Zogz/1P49u3n9bkRbXsPpH+4lo54TBB8E
         g4SQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMPuRiZ8bjcrzGQIuph2gvgROCmrdwv+JrdzCpX0zZMNOq9yS2F1pFuX7S0sSXkfTYk/YgWL8pNo7Vwg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvUvwLPbd1Z3EsrsAw2P4S8pJ92B2TTAdoZb4mVbc10SJ+RoPu
	53V3OAw7MQCi5sxOo1IjEvimvKl43CHECMdBETnD7SKi+VRRFaUF4L9ojL034MZN4TY=
X-Gm-Gg: AYBFou01Yq5Twk31vsRhMKTnhdCj58VGGfqetOY99/1qaXpvZve+OnzN61CfzKOAC0M
	7Q4d8kEpDm55+TSBe9CjWQuV5xtTU+dkNcDpsGJcvSQfsXMeLL39kzXh2h0daNMUnmXhOX5+Pux
	AUqx1JOxVttaoyjoUAhtTkNFwRiOQzCa3sehoeVfCPslXLkQFGLnR7goHjBRIOA/fUElNntL5Z7
	9IzIoTfneRCpIauilE3y2BuGR/IkZhNrVDAfWDe5cCR7RRwM2El8nO5q7WzbG+kDfLoSzRJisfR
	j6804UIgVv4yB6z7urAlz/nkWKBWJlW9waif/miGa0Ixdx3c7ncTEFdiq20xbrBvS5ecnfRMKAV
	Dg6eAd6q9Tqnk/5bfkHPq4bp2EWDyUMAjy/FEAPkfSMYRwbeRFwJC+2O6w5fUOEK44YjLN/Cjw9
	4+jLNSrYjVXkmDuxoc22plOS6wa2M14hALIaD1IGr2OjRmOf0PNdWLG6GExlWvVaENDDaw6XfXo
	QvgJseJBziDfHi550lQUn2h2FVPVfn9tiTorWzmwJ7GHflc7adhTsZ/L4lE/VmWWINe3kyzEQ9J
	Z5AHhPlc3lBEfm+XltIZPeMxU215YYFwCdLbpdMe4iwaU3YTpUTan07h1qNE7xXfW53e/4rvZUl
	nXdXMfwvAQ878/A==
X-Received: by 2002:a05:7300:e11a:b0:353:7d17:9a86 with SMTP id 5a478bee46e88-36a200bea2cmr8150120eec.26.1793279976291;
        Thu, 29 Oct 2026 06:19:36 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2392ecfdsm19548374eec.17.2026.10.29.06.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 06:19:35 -0700 (PDT)
Message-ID: <98ba1da3-8273-4f26-84d4-e58c3ee309f3@kernel.dk>
Date: Thu, 29 Oct 2026 07:19:35 -0600
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
Subject: Re: [PATCHSET 0/98] Various block related fixes
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <c16356fc-662e-4939-ad76-355f3a62ed4c@acm.org>
 <3c5a116a-394b-44a1-bcee-0cfdcc43712b@kernel.dk>
 <b349b5eb-1bab-48d6-b2d3-c5a6bdd05109@acm.org>
 <108919a7-98af-45e9-8d95-00406f3d0558@kernel.dk>
 <82167bff-86fe-42e8-b9a4-252cc5c090a9@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <82167bff-86fe-42e8-b9a4-252cc5c090a9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 5:51 PM, Bart Van Assche wrote:
> 
> On 10/28/26 2:06 PM, Jens Axboe wrote:
>> Hence for the replies, also have your LLM actually suggest a fixed patch instead.
> Done.

But an actual patch... One that can be applied or swapped for
the other one. The diff looks fine, but it needs an actual
commit message etc.

-- 
Jens Axboe

