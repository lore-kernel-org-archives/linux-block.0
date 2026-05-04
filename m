Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C43590A4
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885563; cv=none; b=uo1LftMtvvoYzoWt4hmKEf+iHOvE3YwRbvBErktsbZsesSAvLAINPDAyLkZJU7JI80CqN2BI22+I9gOhCl0lDpns+rsGzPoh/0g56WRXA12aDNSkvWxqcozB5NPNkaO0cya/zL7H4wIQ3tlII3RXwxbuyMwA0HkX0WKB9NWXiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885563; c=relaxed/simple;
	bh=Jk8DjIwtSgRzibN3X2t/wMdUSa6oMFBpDIDWhZbYEIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcFFqOIU1eP9ctGhTU5dRZMsyxbvxgDe2swZDTdV/I3ircL7SUMZR2KyyEnmWIDwRtrwm3TejYI7HeqkH/M7Wr4KJ5gzDbWbeqGMW58o0/huc+Owc/kaU2mBYVpV4F2Sg8NXNZyPoWxRAwc4Y9l+b6ZXifFCXL2D3oeM14wlfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=tUOR269P; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="tUOR269P"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48374014a77so43680575e9.3
        for <linux-block@vger.kernel.org>; Mon, 04 May 2026 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1777885560; x=1778490360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk8DjIwtSgRzibN3X2t/wMdUSa6oMFBpDIDWhZbYEIU=;
        b=tUOR269PbqHtHZjwxbhVEueffWVgTNCl8z+rObRQV4y89f8K+mOe7RZ7oh2bzOmSPH
         VgB/7tZk+nr3AieW1792J6gcWLWUrBnp9S3lH8kRW9LTj0CstA4KAaHVAcgbkZLexQqE
         h9LKoYFGzfpxgWEoKmLX3oGMKbRqFdgHTTvzL3KnBZN41YCfkEuzfqXxP06RphXGEc6B
         utev2WuNRraycIwqt+3hS88z2T4IM8gvo4jW7gJEcgjMOhme7uCpsxhICDOqscdvw59c
         kW3H1MhTQ0VLjExWjaZdtZT39OvJG0ZMLlU2n9Q7KBYrXeLJlzNVmoFBF800uDOP2rxK
         BsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885560; x=1778490360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk8DjIwtSgRzibN3X2t/wMdUSa6oMFBpDIDWhZbYEIU=;
        b=LFe3xIV0wk61lpJ73Mmwz76t0VWGsWE+Eao2HNC506WHxHXZ4e0xPvByZwVhNKK8SL
         44s3tV00xQEUVmynsc7ukxJlctVHRyM1qrp1Gtm6e0mOEC5OGHRxsJflDZeSDzzMZ1cN
         Bc42+w3Wv8UVBd98a+AGOS0d30rRiE9E3sjV8IDDvSBFYU5SYth11XfJvb9I/wNMTcEg
         jEHv90n9CCjtEkPTwFnyq2EttQ/xHN2MH3HHZScjAj+6eXXTADEuy2SkaWXVO8UOhvjL
         LKfdtPY+LzPmQ20R2djkxsZVfJxxyWOv+PRqA3i6hER7aXHBlqvZOgjXHwYyb/LIRRWt
         JXUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ps29QShLjdCXDS17E3fiXsSZ6g6i7h/ZznOtz8f2/9300NIskM4r99fUlMEKexYPv/JJqtUGXm3tMGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8X+M18qbn/AGX4D4ee5m0ZyRi71R5d7ihWU4nCAzMpNftwl4
	rH4dKDiZhTTd/R0fEh4TFJUZ/m4CWfq3K+hEu0V722JwdmQTsPmrDv/fLK8u41lMKuM=
X-Gm-Gg: AeBDiev61Gp/9CSPFsQ5jmEHNuNOVByKVjQ3dah+JbfSTg396wsmCQQqnkPWMOwkrXC
	M+8SgwX8lAbsHNIw16VrvynLzywBhNmBK3Xg9cqE6bPpvfQcG1joTJCAxxa/B3G1OmhhPp8aIN7
	IDLqfC0i9AP6jiaqKkY5jna8IjnhbZyGuXM6ge8S/olNot/mWuF+FsqZVYmEd19w1vsFr9Oljj7
	LO9OOQOLQkKGe305r2Fdx+6lOX6hbS95V9RafCH2WLMstjFRSu0q01U2LYxLl4ht+bQNueDl4Sd
	Q4bH7K72sCTbBgtQOgJ46+z19kz1KXLvVcx3OkZC0UK1MOWxan3hkVXaJ/YnNkI/udh+/pWA5HI
	6jV+Y9FJ2UJE7ZG0hMEmRfzKHSWA3iceBwmXLBUSnDx2++47NKmErnSsA1DwN7IbUnMpkVe8uU4
	H1z5CXhJWN3vbjDFGTRv7CrXiCmYqlyvQwD9Qh2RQ48tunhV5axB5JCBVXBS6CEjWZajv9r65Zr
	iwkUlJ+17n4YyG5
X-Received: by 2002:a05:600c:4445:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48a986380ecmr140685845e9.11.1777885558358;
        Mon, 04 May 2026 02:05:58 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f28sm526970305e9.13.2026.05.04.02.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:05:57 -0700 (PDT)
Date: Mon, 4 May 2026 11:05:55 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <afhgQgySpoxXFCn1@localhost.localdomain>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
 <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
 <20260412125502.3f8ff576@kernel.org>
 <adzVUdf74CVk2DwJ@localhost.localdomain>
 <20260413104939.5ef4d9dc@kernel.org>
 <ad4ox7ibZoiW-tje@localhost.localdomain>
 <20260414083548.02f76970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414083548.02f76970@kernel.org>

On Tue, Apr 14, 2026 at 08:35:48AM -0700, Jakub Kicinski wrote:
>On Tue, 14 Apr 2026 14:08:58 +0200 Christoph Böhmwalder wrote:
>> But we still need to support the current family via a compat path, and
>> I would much rather have two YNL-based families than one genl_magic and
>> one YNL-based. Carrying both sounds like a nightmare.
>>
>> So the spec proposed in this series would never actually be used to
>> generate a userspace client, if that's what you're asking. We would
>> continue to use the current libgenl-based approach, with some userspace
>> compat shims to make it work with YNL. Then, when "drbd2" comes along,
>> we could "do things properly".
>
>Let's jump to the drbd2 work.

We have a bit of a chicken-egg situation there.

The drbd2 work depends on the DRBD 9 upstreaming series, since the drbd2
netlink family will use the new DRBD 9 semantics.
However, the DRBD 9 series depends on the current DRBD module already
using YNL (or rather, *not* using genl_magic anymore).

Our plan is to convert the current family to YNL in-place first, then
incrementally add the new modern drbd2 family with DRBD 9 semantics in
another series.

How would you prefer to handle the YNL switch? If it makes it easier for
you, just committing the YNL-generated code without the generator is
fine for me. The old family is effectively frozen, so that would work.

Thanks,
Christoph
