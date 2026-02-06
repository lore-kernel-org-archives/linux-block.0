Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734629B8E1
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392089; cv=none; b=iVqLXd8KDlER4qmgHrMa7J9DmVhKzi0JILunza8+s8jqOCLNyaLkLSjQaTnttJw2orpmBMw/nWe6lMmvw5TshSPh6w7ghwR45tck9743zLIEusukjp6PDWBEMg1nkPoA+6ZSzcnuOU6arP0RTaL2Y6kY8I+Oytj5o3vc82PBtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392089; c=relaxed/simple;
	bh=LRmnAsJzMOl1lBwo1pl+gT+aMNy3YzxB7dLOb9tYVoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D75TlWm+yeRjTTD4MgoN1e+K18dL3+SzqKenYFlVk5To1oG4IroCQ4K1nnkSUQb6RTBtSeJzVRNdV1RNG/jVbJ92sEJmVneLv+5xK3fuRfqzB2kpkViHmkHoaorqGb3mJ9pKpbAzneR9Ca8DUS3xSU2HQI8+R1kWKBmGdUvh97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfZJsBh7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfZJsBh7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so21293755e9.3
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392087; x=1770996887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5dWbxjsQqbdlIK+2FBz3dITKreK2ZWSV4fiiN5/24Vc=;
        b=kfZJsBh70IkHePVQw6RqiNGJRej9f5SgGg4+tPKaKu9v4gKZgI4H9gdApar37cRE9w
         DdFvA49G8/Ha84Hzi/NFvKk7xtE18seNhDOuMNL98AwCAUAeDv28PoFx8jd6vXMMO97V
         LkD+8UlTuIyyUzY+qjheyblEXqdty0TZ96LNZK2Fcw+AiPYayD98Ly5v5IlGWfXA74yx
         K74yUTQWiGNMxnSNgwFkuZ8ampRSOiau2IS6eloVFsetw1tg8jofz8xYpC+uQJv6+t6o
         Zgi54vPstxHdy+vO+4HmC3mxHCB+5TkKyPZ1jIsPDhE+PmZq9nUjQbZhHH9YbAKXImm3
         HM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392087; x=1770996887;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dWbxjsQqbdlIK+2FBz3dITKreK2ZWSV4fiiN5/24Vc=;
        b=S0xRYaVwngJeLYAyDEygp/5A50EvjimrPE3u+xl89vyfYYRweVSFhveWVxvIGxSZpA
         8IdanOuVc0dgjeNfHqMwqHj5jOrZhrzwr3j8MFenPYK6MotpERNQKhsHOgRUNf1rXE6H
         /GvK0NcoWeXxF8GDmjbw1+Q5GW3xkXb37eTfu3mOcUwIi1FynzZg5h3rscqZSYgxSkAS
         EhQ1aVDXdiO1xfdT+GdI9Ak3FW05Tw81jQOAqnPOT4eQI6Qu4T9C/IeduHG9DN9ZYOVM
         sc+MlVTg9iFYRwGAvf38qgU2LOC7Iw+P99eLlUhuQuysCHTDk/slb4D+JcYqzoGHEosR
         i2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1dD6EyZrYyOJg1/+jwHSLveSxYqsBXQxo5UdgoL9hCBMOnEVVfPYMdXNdzLiTDETnYV5EHDfH09XWcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BBmFZGty4xhd6AyCD6oBODVi+gAXbsOcNqv/NtnkBYoEaATN
	gayl7sv7+NqlzeNQVKrfdiI6RxVVh2fK4uOJ4ZwcjmODuwB30ih0YzdE
X-Gm-Gg: AZuq6aLg71X09JhhUdE5S/4l0Ds7Ul8skZYm3EZsemH8cgiShSplJoSRRZSVAwcrEOB
	xVf1tSg+r3yteXC+dsEhino5MAFd/SjQpqFkpTZI4y4T+EXxrxUy01rGL14lnqPuxvQzxXbRsuk
	u1Z1O5VNURj6QQ0tbloAm/jRAyRfn6Eb5e8MKGvFY7l40ViWltk4P5X7C53/SmKUqZNrUHhmMyD
	SiBe/KdC2GcBq1C98oQpuMR89/A8pLBNacNn5D9ny2jrQEvrHitd3RPzIIKJl3pYKpiLu2pZ3Qg
	qSOnMfNeinnArSAMbUbTfQl/WFQiXfLegQHucJSeLT9u6+4CsJ2MynYNrpUQS95lYDtbhsGyNTq
	v3ZIHLtCni7rDv4PMB+UBo97ovKwALYrkU/vkbJjMxVg103OFHI/F8Cy/9hq+IGzS12wYK9PBeK
	EudZPoPfuGtTlRcOoHgi7HtTnp2Y90NTMcBabFdYrjCzRUWE4=
X-Received: by 2002:a05:600c:a08c:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-483201dc3d5mr44165775e9.7.1770392087262;
        Fri, 06 Feb 2026 07:34:47 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206d8c60sm82352385e9.8.2026.02.06.07.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:34:46 -0800 (PST)
Message-ID: <ec489caf-6171-458c-b391-12512ae3b38e@gmail.com>
Date: Fri, 6 Feb 2026 16:34:46 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] sed-opal: add IOC_OPAL_LR_SET_START_LEN ioctl.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-7-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260206141804.278721-7-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 3:18 PM, Ondrej Kozina wrote:
> This ioctl is used to set up locking range start (offset)
> and locking range length attributes only.
> 
> In Single User Mode (SUM), if the RangeStartRangeLengthPolicy parameter
> is set in the 'Reactivate' method, only Admin authority maintains the
> locking range length and start (offset) attributes of Locking objects
> set up for SUM. All other attributes from struct opal_user_lr_setup
> (RLE - read locking enabled, WLE - write locking enabled) shall
> remain in possession of the User authority associated with the Locking
> object set for SUM.
> 
> Therefore, we need a separate function for setting up locking range
> start and locking range length because it may require two different
> authorities (and sessions) if the RangeStartRangeLengthPolicy attribute
> is set.
> 
> With the IOC_OPAL_LR_SET_START_LEN ioctl, the opal_user_lr_setup
> members 'RLE' and 'WLE' of the ioctl argument are ignored.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/sed-opal.c              | 28 ++++++++++++++++++++++++++++
>   include/linux/sed-opal.h      |  1 +
>   include/uapi/linux/sed-opal.h |  1 +
>   3 files changed, 30 insertions(+)

Reviewed-and-tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

