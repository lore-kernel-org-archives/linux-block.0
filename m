Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221622;
	b=W2CQbwKrvCIh5o08TbpMWPXQY0h1FVqCpC2lBD2I2ap1JkvGYYbCHf4ca0c1amzMykPV
	 c74A5j1T+yDFSe5zQsyqRt2UA6JFz0wyZaKdbDJ51cGuPVl/ZbZ6pxsTnBGvivxSIT99c
	 zhKdUOemNoai+2+FBYpWAFv4QhAOjJ2B8vUNdqujdUatEsD8pvNBUJ1SaxzN7kE7T9KRg
	 lJZxV9cElRzkvuZSxuGbyTUAKbNEfvEn1D1JbH8Hv/d/+tjsX2Q8DK7D6hOP5Md7N3XfB
	 0eM8i5YIt5jaDctFacnhKxlAJLWBKyJH3oThT2UanJIByXMGA/7c0EpKDtQzREtpLsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cQr8rTsrGDDXrVpVYUKLdUyXCmz+S1cBrVVju5qKjI0=;
	b=EIgnZNzQp6hgJJ2kXsvZNq+TBCD0rg4z8zEDk9RdR2UZDw4hoR1O5opGBxZm+7EwEOy5
	 fmNZbTt/kNQQeZa5HlyZB6kFFlXA+PuVW0PVnGDi4S6wE64+iFRCsgDytOHo3z2iyc0tH
	 XiR+y6UP29OPgdC+c0Xm+4CSvZVpz71fPov5Hkv158pBEF/r+32pbOb7MSDSWPpCS9O24
	 uWhAlbwPCLNtSnnsD9yUZh9J/Oxk+Qf9GlY3FjGQWv4i9g1Yny8Kc1t8mtHJodZ9R2fsc
	 Ko1QvttI5mniGCqMLqzPJw2C8va8JWhlEbZ5GRKo9sSS/jVFvrqSGZpCJYNgt3Kjkww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mKFNflma;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA503606A31D
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 21:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA503606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mKFNflma
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso679496eec.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793221620; x=1793826420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cQr8rTsrGDDXrVpVYUKLdUyXCmz+S1cBrVVju5qKjI0=;
        b=mKFNflmaSEWrd8e2JBBBmIPJrcVBw+kHQ9sBKyXC/DCFTGi2MkMPQvjJQxghirc9b5
         E9CVE9Yai2gFMyLIZbwohbGCupZ9vzvi/Ui6rZM67dMZmP6iq/t7OJesOdtcQ2SrbKWf
         tJGNgh5bVFKOrNmI1aWwQkaV9TMqGrMs5pmZasNbR7wCI1rEbB9YZzB7V8kYv4mtZHkV
         i9EYOFwzKr0kCjBW5Qi36l9LDX32b/ARRnkcuZiugbeV1wcPeg8h//qmW9NZ9XC39Mos
         J//3WZFQFf1VwR4/4GVaA5Ek24Ik4GXMh7RB+vvOgRZHwljtzZVicUoQZQxt/WIkITvK
         U8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221620; x=1793826420;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQr8rTsrGDDXrVpVYUKLdUyXCmz+S1cBrVVju5qKjI0=;
        b=UhIjEV807QVi+jpIbTwPclTrdlV1Txlsa+W2ZqJAnQXK2D19oAppmrLLD49UXFoDGN
         BNoP/qM86J7e/hh1xali76un9ONVV383wZFVzkMOXBdH349vHs37YDj2j1V6BSDv2pI0
         DIucXx/br71O3hFGuerc14zrkYovBpQfuB8+VAeZMJKWV1zMg02ivDXhJWifb8Tofjk7
         v/LSDS1/OQ3UNy0Da0m/yLY+QGsf75RSr8paaakxZA1uLA0sku0ThVC1m/q+r+DWiXTP
         A9974x99Ubhogfa5PhH+oCKf6p7ETb8lKyvx3Wakzad4okE4isxi4nPRLPGuESypxz0S
         KdsA==
X-Forwarded-Encrypted: i=1; AKwUvBxmt95BmT7nP3GIQNTM4YeDtJHPQn4nbXE8Ft34w/38WmqISDaNT4LFAO1kEoxmfyoQXJtlEg16JwtGUg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLy/VIWosrnzjORSKTxVrf1zqFsOTSBGgBvwTBl0RhE4UkrqfMi
	5assUxZdU9E3cqwWrwfqQRLMqpIAtqCxAC2ckCVGZP6rPtfXsUmqJfakRq+yMHnnFJ/dj+YPh4k
	VKOhJHk8=
X-Gm-Gg: AYBFou0tIBSm6dW2MSg0DoFFpdbtJNy6kAMnVJdwQ988kNmWU+gPevUMbSArb1Bux8h
	p89RFA4k/V3Iv627yddnKdsNyB9gjlOqKPMGJhbx3JzCKOrgiwfC1Hf7n9I719aLb4tttuCI4YV
	I6qxUGgXWgl+gVMAX5SL/MaO/tO+ia+eraoEDxlizD+XJRq0RLPqyiyqpdeUZmwISuUEQnAVbyF
	jjMyBMJnybGebkLTjAGFDubW/o20ukNePH2G2td4FUu+/cCQ0RECxzSDMghBHtt2SXD/NTrXMXh
	sCGCvvmxxsTRR3vteax8sQ6ddMwA2Q3mjJkqaWspJcKUmBCw+11GUBWMbq/Ya2afREAPs3+vMiV
	GRyNNNS+radgFTA4eG4YbJE32MczkGNbj/EFLhZAqV7x7mW7KyVFylsVyiTko26pFOwQpau0hes
	9Vbi6GjBBZO1p9OyFGaFSQDIeJrbSn80Tn2Lf3QTho9ycxNO4qKUYuHHv3BHs3jTgGPBLQ+IY5J
	jtm2+Pr4k4Kz58icoqJYWYg7qohwGROCKNLoxl2UbCK9FTyuDSHU8WsRiUtWqNHI2d7XVpQPeIz
	q1vu4U/YHwuMexrJsMdH/MhkBdWEuO6hnr/PUhuK6ledtgF3G1UeFP7xnsOhVQ1k3jiwCppXhvy
	vDCQrcjyndA6o
X-Received: by 2002:a05:7301:4d08:b0:360:905a:7c27 with SMTP id 5a478bee46e88-36a20417e00mr4446296eec.26.1793221619621;
        Wed, 28 Oct 2026 14:06:59 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2395bee6sm9546412eec.21.2026.10.28.14.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:06:59 -0700 (PDT)
Message-ID: <108919a7-98af-45e9-8d95-00406f3d0558@kernel.dk>
Date: Wed, 28 Oct 2026 15:06:58 -0600
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b349b5eb-1bab-48d6-b2d3-c5a6bdd05109@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 1:47 PM, Bart Van Assche wrote:
> On 10/28/26 12:29 PM, Jens Axboe wrote:
>> And likewise, reading through 60kb of text is also too much.
> 
> You don't have to read all the text. Please take at least a look at the
> must fix findings. One of the findings is that a patch in this series
> includes a new use-after-free bug.

When you get a wall of text, eyes gloss over. There's zero reason for me
to do that work, when tooling can just split it and reply appropriately!
I can see you're starting to send them in reply to the patches, that is
much better.

And as a reminder, these are not my patches to review, it's on all of us
to get these sorted and merged. Hence for the replies, also have your
LLM actually suggest a fixed patch instead. I'm not going to personally
handle all of these, I would however be quite happy to swap a broken
patch for a fixed one. If you do so, feel free to grab attribution for
that patch and just put the original author in a Reported-by tag.

>> The plan
>> here is that people that are resonsible for their area/driver/whatever
>> will grab the patches. Hence I think any kind of review should be
>> per-patch, eg reply to the patch with the review. I'm not going to even
>> open a giant text file... I might, however, read a targeted review of
>> any given patch, but it has to show up as a reply to that patch.
> 
> I will convert the must-fix issues into per-patch replies.

Sounds good, also see above for actual patches.

-- 
Jens Axboe
