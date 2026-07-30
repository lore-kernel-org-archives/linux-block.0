Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92238E106
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428602; cv=none; b=SJOyOj/txwQVamlk+vvC0VWbu+jP1JHZLyMbQzZWhGobyZDpK3064avWoxvCQRBANbk2DFtcWGhjHPsMl0+fIqJqOBbj3H7gEE54EEextLNW8WZnyNkC6fInngnqVctHd9sau1Mb64dr1IFXFxTH76v1dHuwDK0KiMZlo8PjWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428602; c=relaxed/simple;
	bh=JBBl12W5jAO3f1NQO9V6kLXpVGsPmJIXGnmgZPy1WWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhGqGPDj9d0uTCT1XLVmONVf7pPAqwSYIbGh788HNeG/Fur2Mp3Lk4agVi832ZgSJ2lTA1+Pi+OiqNCPf8Z0g4jqKwz1Z0lQz40tDnBERbDcSOUWPuVgHwmCXSZngY/rwSxZJMp9jagwj7BRdpRrRTAetBlp4zOs6MaUwMEBw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bqGngMzM; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bqGngMzM"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb6573bd52so1671347a34.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785428600; x=1786033400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2vuxkBUmVJ6H+F0FBU1KBLH+mojm8weuh8i8FR4JAI=;
        b=bqGngMzMyUQ/OuVng4Q+ZppdAfvq4yIOa2Vtd2msMFGVwTRmrVgMEEuFzcNudDjhBb
         XMZ9rnpN/ffA8Pi4JIASt4OQQ26UVlLSr5Nf6trhNRA4oKZzv5dT2XtfJrHf1NqwvKD7
         c6tvBzKrS0kWwOAjAAzaog8WAIlrhYO2eZd1Noa2VbTslRtkQisrS37haeVKX1vZT1KE
         oqUS1okTWt2sZo+nJfH+vVVPPF3o4bH+KQ4Ztb7+rt5SewWXJJ2+j9uz+z3I0SA+QItO
         gCW0nAfOcQf32HbrLJ+Dt1am4uYXbR7+IqIRjukw+3LGxmSubCGYjwghuOhdEOZgxjJN
         MRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428600; x=1786033400;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2vuxkBUmVJ6H+F0FBU1KBLH+mojm8weuh8i8FR4JAI=;
        b=WsYZXrKqHNqCBBhrDMVtMXfCkitOeXvdMuwmy/nTEemtI8VQPhxZ1WIjGFtLNGWbY2
         0TcZqs6diu8g0snaKijczZpWeqYcPW3xySUVLRoHtcVyErmF3HlHCrTFE27GEZ5hT4z2
         vTS/U12II9vHRQvC0F2IJu6QGutBAOpJyIsk8Ty40XjxfxuI4cvm9Q5rcMYeuq0rXhOt
         nhuBD9JtwZ4bd7Q/gXUjCYFuPyR/IFtpIGl9laLAvNFFZM2M/1evO5aPwSqH14qj0kE4
         Y53n6bfXM2Os2Vuk2pgBm19JFfLBXF2yRj+V/ACPFooKwLBM/C+63zSkcuXrGc/hPK/f
         Xtzw==
X-Forwarded-Encrypted: i=1; AHgh+Rq34wvukXG1fgw/LLVIqeacqGKiJxmB8Gu9BclTAQ+U9S0VXOOCC/KoO0K6PhvwAzobqhmhPxf5X475pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgvgSoBfx4uORtRZax8416qOFSQb1S4ajNqRT9mHVbPtVbJ4H
	WAd5NS0vKVfzKcLvI8zhu5t1Hc/ucAJsO35IIgfiNq95QM5pF1KmLUArPXbBapa/DJE=
X-Gm-Gg: AR+sD101djHh+v5SjlikDIGHhCQk1ZyVa6rvFvOjN/jiCrUm60qzd2PdxePCXjh16et
	bTqbTid4kh+qgjg3Dt+V2OBslpZCcbJf+v/dSGZbgFSPoprZYHWezJ+zTI7sdm+6Rc0i1a0ttZE
	NBBWaUykWmI/IRvwQCeLpYb2ADVV4W1KuxW8WUYW3+qXeg6+mg7a4vgtzJuHJfcKP2Vy9H7lDh4
	YuZH4XWVUUCJh2lNKDAybAAhEwYuhC4eRlaNOcBcZqA27LF+/yCuTista9JMUhqccroJ2Y7g8L3
	EHUtDsvL6z9EcG0rLEVZm+5yGNiGxak7ZwBel18BppqESTYNzf5fH/sKQxydmGNxF4L48ZX1Ru+
	0I/1gon9gyZUC/aVpzNjFdx0hEnJzLIqaHp764RF5ZaypfM5POS+mYipznc6w1OxNIOuCHaCU3H
	Pjq5ilOVs3+nIt49tDmvY2o/P5uSG194djP4BOMSsAfpIw/7zWgQfSKDW48PKMwcZBMBoG0Hk6W
	wwTH0trIMFvcHZixukmVprlY6WdPGXcBrKBdjztCT4kOg==
X-Received: by 2002:a05:6808:1246:b0:4a4:e11c:7b56 with SMTP id 5614622812f47-4ad87782f6amr2123750b6e.8.1785428599570;
        Thu, 30 Jul 2026 09:23:19 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6ef595cfsm4494333b6e.10.2026.07.30.09.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:23:18 -0700 (PDT)
Message-ID: <bd7249ff-d0a6-4a3b-8aec-3b5325f24b08@kernel.dk>
Date: Thu, 30 Jul 2026 10:23:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, brauner@kernel.org,
 djwong@kernel.org, viro@zeniv.linux.org.uk, regressions@lists.linux.dev,
 torvalds@linux-foundation.org
References: <20260720201057.1862857-1-kbusch@meta.com>
 <ampRQyXDbGgeg49V@kbusch-mbp>
 <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk>
 <ampce7mxSmxAwAiu@kbusch-mbp> <20260730112626.GA24827@lst.de>
 <00104e90-48b8-4419-90c4-ac0c4a2e1c44@leemhuis.info>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00104e90-48b8-4419-90c4-ac0c4a2e1c44@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 7:25 AM, Thorsten Leemhuis wrote:
> On 7/30/26 13:26, Christoph Hellwig wrote:
>> On Wed, Jul 29, 2026 at 02:03:07PM -0600, Keith Busch wrote:
>>>>> Hi Jens, have you had a chance to look at this one yet? This addresses
>>>>> previous issues with certain device mappers under direct io.
>>>>
>>>> I they look fine, but at this point we should toss them into 7.3. Yes
>>>> I know there are regressions around this, but from 6.1x days. And the
>>>> series doesn't apply to the current block-7.2 anyway.
>>>
>>> This series is kind of old at this point, but yes, it's not fixing a new
>>> regression either. I'm okay if this goes to the next window, and I will
>>> handle the stable follow-up.
>>
>> Honestly, I think that'a a reall bad idea.  This is a regression in 6.18,
>> and while it took a while for people to hit this with their a little
>> more complicated lvm/md setups, it has stopped real systems from being
>> used.  We need to fix this ASAP.
> Thx for this, as I had been thinking along the same lines already and
> was still considering if I wanted to speak up.
> 
> 6.18 still qualifies as recent in my book, but YMMV. And it's not like
> people "took forever to notice"[1], as they reported this for a while
> now -- and there were a few attempts to fix this; it just took us some
> time to see the full problem (@Keith: many thx for that and the fixes
> for them). And some of the linked reports are quite recent, so people
> really hit this.
> 
> Sure, as always there is the risk that this will cause other, bigger
> regressions. Maybe that's why it's one of those situations where the
> right approach is "submit this separately to Linus and let him decide",
> unless of course he speaks up here.

Sorry that's nonsense, because how is Linus going to make that call if
we can't. It's on us/me to make that call. We're not first-timers around
here, we've been around and know how to make the call that we can stand
by.

-- 
Jens Axboe
