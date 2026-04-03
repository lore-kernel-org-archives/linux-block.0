Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA193AA512
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222815; cv=none; b=KVSEAsH9j6ofRYyxiGIUcLTNlus/+1zUDGbmGtQi1tWQTt/Qc8WmRVk9NeCQZuJlzpwMTbZchcdc9Xl9/Ssh7AAxqidQZwnrKV9ZyNDqO6ifiUROq32T6dqAf4xAxU0yPckIH2EhCyydNdSJWq+pjK2+SMJAdzsaTRyoIXtdYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222815; c=relaxed/simple;
	bh=9H5kfR7p/ZTwqX+4inopwD8C0Hgj+vUvjdEAMaDtClY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IpeKavijuNrzDUFCwAK7gUN7b2JwSC0FksC78jaSogvUaEKXiegGlYDvABcZB4E3IZv+qB1RIiGHZ/G3kXFl6jyVrUhE3ocraV7rVvDxpI+KGFzYuwNV4mNgwNL7xKbOMitknWN7UoSUIlIM/HXYFJLs3E1nCuJ/pYdJffhL0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=onsBdyN1; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="onsBdyN1"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-466ec4c6846so638188b6e.3
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775222812; x=1775827612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JONLBlI3XYJkxNPpF/2rKjlHB/7dcJeK5Y2dEWRJxWo=;
        b=onsBdyN1Gz3Q2r7EOAMpzH8Lkh50rZywXJBnN8SweOfT3yCVzJ9TyOlc451XJxSLsU
         ODpSBURwuCX7qYfWqBM5Yc9c1rmU9LScUqS3nouwweBm7ZxXMlmYX/Gl1Bh3AK6ve0Gr
         R8JpVsqeZ+GJRJ8UDW0ssKyP1KEnxxOQwcL8T/GaP35cOdNbDKEgIKLGoxKRqPXi62w8
         yW/QupNQIQvPP2K836E21k7mnzYEnG54lFyJNt3GScfSAd35SkTAye9AJe4lLrB2hQwu
         JnVrrAVC2/JUHB6a2XnEuCSJ3QuhLhEjOckjono8b+igRPeA7CIlaNqp6XqWVuxCqBho
         iKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775222812; x=1775827612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JONLBlI3XYJkxNPpF/2rKjlHB/7dcJeK5Y2dEWRJxWo=;
        b=PFLocANOT1GlLA0WBzSEm9mO557JoqHLYfgVPmLTeeY2TwDXGRPeRiY2vbG9JukHZs
         qG3ffPXjYWj3wZhRlXiJyob8EgIJwSAaQmnAYtq7A87mJuMx9jQnJ7Le4mzFucWXnsPr
         MfXyVAF010m/Lp3z5Omd0R/+V8JguPRNcqaf7FmwdTYLWqviAXQQhR/W8vFYIz9r6rrP
         iiW7dfDbNl55fIuRBI2AOymzJHTYLni+lzjyYpXveU1cDedbZXEPu9s4VnQ2d9eBWNin
         /TuZc/6mD4z8cjiAhHU5SEinBNXANeRKDJUkoaSnmf/SGk+heHPkmqB41yItlPyXYZGt
         vhwg==
X-Forwarded-Encrypted: i=1; AJvYcCXv/eqDRauj/EATH1Vg/bvsz3xMJvqMeFxmkBKG8UFJX3NsliiuHg0VL6S4cylQ9J8K9EA1D44Wzvw2fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3Y0ygWwMOEo4L8PgivFiGRVx9CbDKIOUQ32dByPOE4OEAHkV
	gHt7yeEnzOvijspT++gca1hCUCnnXe9gfKOl+UNHWL3TAsGUpB4wikStjesPC3wRw04=
X-Gm-Gg: ATEYQzx+9dUoVF6Q/dGrcv3MGaH9RdtU2bwIucqoe/nSxHEwf8ro39ZiRttK5mhatPb
	tS08SMkIIj/8BhRhfYtcoO+swhgWFgyHJYYATJaoZMu3yPw1uHOwSaEPz7S5PcFemMLJ0j6msLR
	Uh66WdiFiBjFe5vgXMtKnVh94tH1wGfNw7FOoUrC3fzoVTS3zJlkFRhWYtylwBX67GYHhJ4owEK
	uNvFX4VV/gpl7ikWnOkVD29JV89ic3WN8dt2l0fE5I5r1XNpEncIPVil2xGKb00wCXchZPHAId9
	xBEzPojiLSwHgNQmHfLS18x0SLlNvoHjSmr5LcjG7b2Lk/dZ741YaMM+G1aWmuSxn0i8L+fRNkb
	cnWrn+krsanjU5fVtoM+keS/yJYWuK8ghQpbzIhToGUZSfLLvCzwPy59A0pROOXFMNTFYd3hBuw
	p/xsVRi6T5qoBqH4gvd8CJBLUtxvnNYHmEH81DrZVkSbyixXYprrWcECDgj6McbddCqk8kN8Sjf
	JKKVUo2
X-Received: by 2002:a05:6808:4fc8:b0:468:bfcc:11fa with SMTP id 5614622812f47-46ef821476emr1462878b6e.38.1775222812486;
        Fri, 03 Apr 2026 06:26:52 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d92a53169sm3469134b6e.10.2026.04.03.06.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 06:26:51 -0700 (PDT)
Message-ID: <21dc6f1d-5413-4a94-b0b2-e385ec555915@kernel.dk>
Date: Fri, 3 Apr 2026 07:26:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] DRBD 9 rework
To: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
 <ac-_fAsaSk-E_80R@localhost.localdomain>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ac-_fAsaSk-E_80R@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 7:24 AM, Christoph B?hmwalder wrote:
> On Thu, Apr 02, 2026 at 07:30:35PM -0600, Jens Axboe wrote:
>> On 3/27/26 4:38 PM, Christoph B?hmwalder wrote:
>>> As discussed (context: [0]), here is the first version of our DRBD 9
>>> rework series, intended for for-next via for-7.1/drbd.
>>
>> Will you fixup the kerneldoc (nits) and the assigned-but-not-read
>> issues and send out a new version? Also looks this series doesn't
>> actually apply to for-7.1/block, patch 12 fails.
>>
>> -- 
>> Jens Axboe
> 
> Right, the recent genl changes now cause a conflict. I'm rebasing now.
> The nits are already incorporated and will land with v2.
> 
> Just for my own planning: what does your timing cycle look like for the
> -next branch? I assume you also want to have that ready before the merge
> window opens? Or is the schedule for -next more liberal?

There's no timing for that branch, it always exists and has whatever is
pending for both the current and next release. Since linux-next rebases
every day, my for-next is also quite often rebased as it's just pulling
in everything that is pending. Hence there's no timing to worry about
here, it'll get updated daily basically as patches flow into various
branches.

-- 
Jens Axboe
