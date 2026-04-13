Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210832F749
	for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080917; cv=none; b=p7HPUHZ6yanBQbav50QhZlLeOMXJp09w7ba+LD4l6ezNCvObddPCS5PIfjkr2d5we/Hf6mpoFC0bwKVbQFfaYF/mKWXhLi8QeNGbNY3i5acLZU7ay2+Atufqh6ChOZ2/jI/z7CHx15+W7BiqU9I8HRqLJJdAChBPbzeVruhGhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080917; c=relaxed/simple;
	bh=GFVg8/9cUAJSWmjbziLE8FfOqMK+JQxCJrHsXIJt/Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtBcDmQ2Hyw6qg71jbaCFK2bNz+oy5lvQr8uSxGKJXkX3urEL6XBZjXeZJ2Pi/wWIYapJNb1sU1dVgfmhpEcHIYcdS8gKL8UJoES8EBeaoQ/zHZAyPMKUQ9xNfWo4AoPgidmPMHjkAwIK+wS1sLD2EkZb7JSvx5a4Z0ar6wpNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=YXOrG8gy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="YXOrG8gy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d77f60944so616467f8f.3
        for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1776080913; x=1776685713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0t/PovMpIgnGwUGYbYpIowv0ZhNrCZg5yAKqxRoCRU=;
        b=YXOrG8gykD6D1myRLXlvr/innTSDrT5iB04mJhEiZKeLc78WOF7rFI25qP5/7D93zF
         Hb3VNI+5DlCNdc3miWx3yEalu/GUsk7hFU8mr2hUdk5u8qSpjG242cDyeNJQ8ICHSaDY
         Tubitb+zxu7vuk5VlEf0LVwAqJi4R8ukFZQvVsa8XupsCqtcYUAbEoPg41T/o1W4IveN
         cpwEKRS3IkzljDLu0B6yF5sqsXS522GlydU9Z98NRG5XJW57ZZkv6srBQAji59+X/3BO
         fnoaootMVjU7CY0kq6ytNCjuoqHqEKM2lc00lofJsQTjWSeqrrRB3AAhXTLsxIJtJ2lg
         Xwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776080913; x=1776685713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0t/PovMpIgnGwUGYbYpIowv0ZhNrCZg5yAKqxRoCRU=;
        b=j/TFb7uluQ0iHCq1wrU90kd/TNE2/WNiPYme0uEcp71UHeBlPiKWKDHjUqcJgrB2Cp
         ywd1obWOfkOSQNNAd7znoRAjx+4yyJmcZcioO1Iez1Mg09zPHS1HqyTeoTwd9/7Rg8rB
         6E518BIwDwtrgzXmT37qLHyewO2/W2sgg97a2TIsFp286qKqqsGYtGGOfp+UEOqJ3GSd
         eAr57mS/amt80bn/kogQZJyR8jef/gXZSJ0eN2L6atDfqcU6c/e6rzf6iWARyh91m7po
         yh61TWWA0Ox9R7b7YozJTxJ+MwZbBzx+lGVUZ50oipeUjF2qKGWyIe9HsPOw+ZIMZLHn
         6iPg==
X-Forwarded-Encrypted: i=1; AFNElJ9R+0aEsAKmUi6y6bMTPB2TZXDuS8DEplgbI3eLRkd3fwUi5U4b4g/BRgVtQu746c9bAgqSLEUNwb9fgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0AM9PjN3C672MNctAEMUTBhuIaxYFRhviddkwolWdNMzQUvK
	5GIs4SOYo8vNWgo338nyv2p3xOhlOogSRzaUBDxIuoa/l3GZ82m5aQuBmFPgkg7t0dg=
X-Gm-Gg: AeBDies1Qm4e04LdwrUJMQ8ealP7bpbKIbXft7xpCg0Ovj1KaLfiDrExpXoCZc7sstu
	3hZyPPvBCAhlfxiRaOOPC+rkQCIGg9mAgonFdvrDkSAEbpU8PGylrUH3/92HKk1HOq5eB5K5R9s
	goYmIevVtKpg4IE5F8+QV5/lX+3SMmDXKnvQbbAZ67J/ERuPAhny957xCor4UT1CvwCnT1aSLae
	fTqLxou2PjuNm+KIS7KeMZvHwhB3IAuSf+NItaqLxdzQqROjawgG2mb7x5cB+TnRQ7MwGyz0sLp
	yeQrF1TDxHKH+Td5YNWLdAQcsOv1g7LmWJyTo825mavGwSW2OhMexyTKlab/vrva6uPilFeF+cs
	aG84n2vteQoao2jW99alwaq1ugpdn7L1jK9UDwqdXJkr9PQ44MineExKeoW83J7NiNQhWKBFJAq
	5EDgF9sg9GaOg4IXfyAEr9L1IEpTOCcCtnfBLps/CRe1xmBt00KIKGr8Xm9JVyRTUaqhVx3Fx+C
	YBuBw==
X-Received: by 2002:a05:6000:1788:b0:439:ccd7:cdb6 with SMTP id ffacd0b85a97d-43d642a4dd9mr20596625f8f.14.1776080913515;
        Mon, 13 Apr 2026 04:48:33 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm34224996f8f.27.2026.04.13.04.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:48:32 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:48:32 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <adzVUdf74CVk2DwJ@localhost.localdomain>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
 <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
 <20260412125502.3f8ff576@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412125502.3f8ff576@kernel.org>

On Sun, Apr 12, 2026 at 12:55:02PM -0700, Jakub Kicinski wrote:
>On Tue,  7 Apr 2026 19:33:54 +0200 Christoph Böhmwalder wrote:
>> The new flags in the genetlink-legacy spec that are required for
>> existing consumers to keep working are:
>>
>>   "default": a literal value or C define that sets the default value
>>   for an attribute, consumed by set_defaults().
>>
>>   "required": if true, from_attrs() returns an error when this
>>   attribute is missing from the request message.
>>
>>   "nla-policy-type": can be used to override the NLA type used in
>>   policy arrays. This is needed when the semantic type differs from
>>   the wire type for backward compatibility: genl_magic maps s32 fields
>>   to NLA_U32/nla_get_u32, and existing userspace might depend on this
>>   encoding. The immediate motivation is DRBD, whose genl spec
>>   definition predates the addition of signed types in genl. However,
>>   this is a generic issue that potentially affects multiple families:
>>   for example, nftables has NFTA_HOOK_PRIORITY as s32 in the spec but
>>   NLA_U32 in the actual kernel policy.
>
>The series doesn't apply for me (neither to Linus's tree nor
>to networking trees), so I didn't experiment with this code.

It's based on for-7.1/block in Jens' tree because there are some
prerequisite commits on there that haven't made it to master yet.

If required, I can also send the net-specific patches based on another
tree, just thought it made sense to keep it all together to have the
whole context in one place.

>Are the new code gen additions purely for the kernel?

Yes. The DRBD userspace utilities re-use the kernel headers and manually
construct messages using libgenl, so we can just do the same for the
legacy family.

>Can we just commit the code they output and leave the YNL itself be?
>Every single legacy family has some weird quirks the point of YNL
>is to get rid of them, not support them all..

Fair enough, we could also do that. Though the question then becomes
whether we want to keep the YAML spec for the "drbd" family (patch 3 of
this series) in Documentation/.

I would argue it makes sense to keep it around somewhere so that the old
family is somehow documented, but obviously that yaml file won't work
with the unmodified generator.

Maybe keep it, but with a comment at the top that notes that
- this family is deprecated and "frozen",
- the spec is only for documentation purposes, and
- the spec doesn't work with the upstream parser?

Thoughts?
