Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437969;
	b=3Ygxp0LiLRiOkwtQ89eh7eI8eVbfNOAG41bNYfWqbivi62/OoPQvK7OaEXGK5LF4LPzg
	 W41yqKHy+mVZP+yK3/4xH8QqeFwrXdhCU4V7co/WeptujGbibI1xG3Q+cWYq7JTW8/bF8
	 4fGcfFDcIgv2MUYY0YNDnBwP6W/ke3m/Da7WPbJvILMNoLnDECoNLaSchxzn8l4IIQYd2
	 /DE5FM8HuZg7FUGpow/luUklH1B/4THkZKxDg0N06FBl/fks734O1esECZvJ5YcI/yeHT
	 nsOm2MQIAGVmzsnEyxF52Ix2pSVbdTY6zh+D4Q1CazzDQVo9XeyOBRvSoHG8cECEI6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MKk8pS8Vf1bXwxj1SK95UJHCC43mO5YEaAXmf2ft/vc=;
	b=t0eRUpZq7QL/nBUeAmhAQArsLVzreHafU9wyjxuOql7wHQ5OnG/4TUdMbbj2pGEyYSt1
	 2M7WRJrSQfe7wWr8UcDyC3rVxq9YJn6CnLX0tIGLUW4f/mCB4Xy0mGU+l4himt/D15znO
	 6bCn8fl+WH2RRbfsNEkUIsZjB1cS3vRnI8kxf/cPP8WyjKLNkpakZwUQbEtIk/BG5YEGn
	 1hoEtSqovp17zTH7Xu4BLDS3GmFPKm8HLhmXbWFHYncwyEoOKHBIRILfldzW5QBT+Z2ea
	 v4s6vIN3RVQ5W0mu/swkaWc224NhGf/4iRgEKiWww8Nqc22AcqRkdcxOhULkJVpf7ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=E0BbqP+n;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBD606A31F
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 19:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BFBD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=E0BbqP+n
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6de1ca1b05aso1838735eaf.0
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 12:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792437967; x=1793042767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKk8pS8Vf1bXwxj1SK95UJHCC43mO5YEaAXmf2ft/vc=;
        b=E0BbqP+nHzVnb9kxYgPijwdeHaehuef1gZ2ZmePQmRQAMgbcx+l370sQk7+k6vWeyZ
         f7LIffJUq723oU1ZeRn2SOktMhZfC+sIctOVPtSDfmsFricH2yJ1qGVVvEZfokh7beAh
         ksbs+6Olf6SEYpPiZVYOy+5AayGr/lMs3w8amKUpuz5MPouBwyy9ADfSRNMdppPs3RXO
         iOxUnmbcTqbjxsnz+sNOKNh2PWCCwEJ+Lyxj/huZ10aZ8MU1oxVC17lZTsW2InRZhaAO
         GHeIZT0AxPZ8Gq8t1+qM05C356hYgPp4Bo+dop+6skyQUhvUrts0eA9QI0r+3Cg0ZKy3
         wSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437967; x=1793042767;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKk8pS8Vf1bXwxj1SK95UJHCC43mO5YEaAXmf2ft/vc=;
        b=uA6eurc5QvJC148ipw1gga9aOFzFvpGuReVowQATCXqv7fps9TdZ24z9sDuFvLM3k9
         nCfpKfO0gZQUoJblMLHVhtDcn3RnFkaonPJsrEjlSHS/gbxhVzSaz82VQat2CVa1pZ8H
         fm0SEw0Ue3mjDSTq6g+UbNsPVHBPhHykf/e8H5iLuKcXOI/evJv9/54B0perQkMF9Sev
         +dlUYj06cNUJhN8AGUmn+0LBPv7x4DTh8oo0KSuahkoDm0qJqS4Qv5dIlE7MT/qzVZxD
         Wf7gOpRxCmn/LJXhzDKx3AgOSTpYu9mi8cZ3VnC4TkzPND4lg9jpcCRYIB30JmqkCeyT
         /cTQ==
X-Gm-Message-State: AFq9FYKZn7XgH+8zeEyNWefbcqQl1nJlPA9g+U6NkeJsm/eWSUQPz9V7
	MQqW0cTk4bBIWe/315C0bAhrl8IbDQN2bH++0S4i7p5GXQ/JaX9I4vK9pbJnPlPn9hs=
X-Gm-Gg: AYBFou1Jytsxfvd+ruMDFrrDFepiEuxw+h25o8Nu5ENGw1rxIvO3M0Rsr/oMFcjdyaZ
	15mHftIFiSJZVVdoObjDNSf7wP1EOxhjBNvMG2WIpzKX31j0Y76JseDFErRCRbDXy+ID0hhPuTZ
	Ej6tk+2EYCBMoeyNKMPdSUE8N7p5liPo5fox0kKbMmT2+DI2ppar3j5aT3d5NRKbJfwkhv/mYM2
	ibDKUtD4n/7ziScW+cKElSeCIpsC7zN1jh1gstCAp4RGnRNmUspA4uVYXMNU7P65/6DZxSky8lp
	mpyJKfB+qSLBh1Ah7xoXt46WqWz0yTa9/hazjM4rJYq+DvV3Vl3pcYUnV96KHQU3hHDs/CKEk3Z
	voNY+K+qusoJaZX+hx5hetbF8xdNMHeszL25bYNOV730UeP2Zpid6kw+cZAWfP026xgeApzms58
	OGbBhg+dI3Ib0RwaHsk5KuNWPo2dLOfHiGx3cQHo0ayAN2VpHE1rLQx6tTQA1VtbR3K9DSCTsmu
	xDrZGneoz8BjWKHHzyyG/tS9v8rDuapyvIfsz63u3lsEpO3t0yHqhqNV2B87wbGug==
X-Received: by 2002:a05:6820:1686:b0:6f7:75ab:f969 with SMTP id 006d021491bc7-7035749fca2mr5657283eaf.66.1792437967242;
        Mon, 19 Oct 2026 12:26:07 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a782c94514sm3933455fac.17.2026.10.19.12.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 12:26:06 -0700 (PDT)
Message-ID: <50082b9e-2adf-4292-8d7e-a1d3af4cb7f6@kernel.dk>
Date: Mon, 19 Oct 2026 13:26:04 -0600
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
Subject: Re: [BUG] loop: missing BLK_OPEN_WRITE check on LOOP_SET_STATUS in
 lo_compat_ioctl()
To: Bart Van Assche <bvanassche@acm.org>, Dominik Maier <dmnk@google.com>
Cc: linux-block@vger.kernel.org, dmnk+artist@google.com
References: <CAE7N4Sq6_M610g6gOUJCkkoBH06Kqbndb7KhGGLk=WCHOqHbtw@mail.gmail.com>
 <51568a73-77a8-49cf-8a49-71f15cb6e5e7@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <51568a73-77a8-49cf-8a49-71f15cb6e5e7@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 1:23 PM, Bart Van Assche wrote:
> On 10/19/26 3:16 AM, Dominik Maier wrote:
>> Fixes: 604f275f9670 ("loop:Check for read-write open mode before
>> setting status")
>> Assisted-by: ARTIST LLM
> 
> I can't find commit ID 604f275f9670 anywhere. Additionally, I can't find
> any commit with the subject "loop:Check for read-write open mode before
> setting status". Did I perhaps overlook something?
> 
> Linux kernel patches must be signed. I don't see a Signed-off-by tag?

Agree, all of these seem broken, sha as well as title, and no SOB.
On top of that, [BUG] is also wrong, and the patch was mangled
and I even had to hand apply it. Fix looks good though - Dominik,
please check how to generate and email patches and resend it, I'll
drop this one.

-- 
Jens Axboe

