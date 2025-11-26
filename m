Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79A3090FB
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176900; cv=none; b=AXUzsobJLxrrYSbvjDZXtVSQZZqjTImWp8dUg0TpHxc+y2B0f0zCYklnuwJ8ooqkAB+zsMiOXTtMk3Q8gyTBOHFjbPD9JOuQysPhSBk4g/PuStN/T8r4T37LPCbUNkrbzhmEKDjM2feutkmcdZbcIIHh7Dbd4lvHGcv5cfo9XC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176900; c=relaxed/simple;
	bh=xY4XXik+VDjoNTiOxaY4mWM/8wJ3WHfmwRW/bl81YcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyYs0WGTbK18Av2dbMlSLB2qU235LTp9cnq3Cu4nefnsgeav1T+OMPXM6pT3C/m8T6Ip+9roPPAmK5GdXwXDM1jD9V/gaKAbRM2z39XJkOFoKQ4OraEiCp8XtyBHvwENUiwM/cshoxIgjyBntpWbDpZ3OsipW+7CS9MpWVBBPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtHDMm2x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtHDMm2x"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29845b06dd2so86453215ad.2
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764176898; x=1764781698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H70tQVp0jdRu6yLi1ZHSywEXJI9fMFla6cCqq4jxfcs=;
        b=DtHDMm2xPoIJc6kvAT0H2qwExIkwf4mA1TE5VXrzzMydnU1b0OA09jWBUQBYJiTyy8
         B0XeM5Kil9H4oz8PWpj/Y1FAPR+O0lvRZwPY6dyDs8oyjroTtORsfOBvMtWX219LQxo1
         JBsinrIrUJKyWgyWMiWyjcNyryHo3E4qUxnjavEPH4buHxj0rN0J0UwuP6DgOeTHeTZM
         CyLYHQcCKYtfXqmIPQza9UcxSeLG4rZ8xTduWGzXtO6WppuZR4t5rsyymQyU7Ncs4oPR
         6Bo41e896X8UeYa228D6PjoyJjpBMVip1Z0XTh8qA0VxIQSM53sh7GtVgYjYY/Iqt7tx
         3FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764176898; x=1764781698;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H70tQVp0jdRu6yLi1ZHSywEXJI9fMFla6cCqq4jxfcs=;
        b=DN79PBcMIZxAJGk5R4q7QkF+C6JWXHJtUxvS5k1CN4pBMFYh0c7AjDsbKEBBMPcEKq
         GyWVrum8NCNuouZms/MqSyKlySKGmC7VsqjxTLe+fsR2PGrZR2tb6r5Zr1/OeFZBpWGW
         BUT9yeTp4/0jAtjSUWyZ5iOjPxIBVogjg+D7nQ0ok7w6+ii5uIqNYzK8geBMG3oSpKW4
         /1ZfiNGPOzRNXTlOElx3tkl88p74a+lwLfcncGFl+P9uBSyZqMkmLhWpmgKYTgqDyDLd
         OKsoqt3X97t81cwx5U2SgbxN92dBQ2qf7m60Gm2xi7XLd4i8IxbJUnrsI8qehffPnkyz
         y4ew==
X-Forwarded-Encrypted: i=1; AJvYcCU5eTkUA9ysvBRAf0UK2Dfv9c19Zuy0Hoic45ceG3oC5S4qYXqGY//hlv8YiJ2hm1XDy6x4p8wgsrRVdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdRdI8OCUb8u8+318UcMCCqdUbU9qx1lPjSqV0w9cJG3RFCi8
	zt7UplSL5xVONYI1DJtPN1ElVRspFInHf/FiP4R04tmgGm/p9BO9+ivY
X-Gm-Gg: ASbGnctMgSBvQh1hz+ZVxNWtuk01fCIQJ4ZNKZa0Ndl58TutJ2wnwlwcMKpZOlNhBuT
	sTirf/HLluXg2uIoGmo2b46lKir40zIsgW4M/yg3aPoQpobyJiMHA2AoqeYH8v22HIL/MQSptRw
	x67joKWsBMaL8s0djNFavSpSEeGZBgUbKKOJ2K8xUpkEb+1B8GBcDIzU6GNxwAhDAzhVDHxIzEE
	BKU/FBE5XB9HpnB+dU1TaWump0gRwaIbx2SfGCR9+m559VRsBFE7JIJz5prmMr748bExgock0EQ
	6+Amc6SyzkXz0ifANzva7KTKYFj2Ied/cqVaEaCRMtOxXjeq4AcKR2Aa+wUiTQekJ5cF/waxS2Q
	HJgsmY2wE2h0qly96r3Y0CGcWeDsOUO2ibl9FaWgvoVV5nr+3n7gXPiHD7MOnW9vZqeSED/6P0f
	dKR3c6SCQuvpbq1RKJzds3Aj1iyDKUftI6lZ2nigtPYwxaVClgMOnauRx01HA=
X-Google-Smtp-Source: AGHT+IEm/eX5yuwpOzoClbM8zcPawe2/xqTQQviecb25Bk40JcOnKIa/X4pWfDT/0x83wWLQHNhjCg==
X-Received: by 2002:a17:903:234a:b0:298:55c8:eb8d with SMTP id d9443c01a7336-29b6c575114mr249233285ad.35.1764176897825;
        Wed, 26 Nov 2025 09:08:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2a155fsm201208015ad.88.2025.11.26.09.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 09:08:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <55bedecf-a4ab-445d-b6b2-c6dcbcd5bd95@roeck-us.net>
Date: Wed, 26 Nov 2025 09:08:15 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] x86: Cleanups around slow_down_io()
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Jean Delvare <jdelvare@suse.com>,
 Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
References: <20251126162018.5676-1-jgross@suse.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251126162018.5676-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 08:20, Juergen Gross wrote:
> While looking at paravirt cleanups I stumbled over slow_down_io() and
> the related REALLY_SLOW_IO define.
> 
> Especially REALLY_SLOW_IO is a mess, which is proven by 2 completely
> wrong use cases.
> 
> Do several cleanups, resulting in a deletion of REALLY_SLOW_IO and the
> io_delay() paravirt function hook.
> 
> Patches 2 and 3 are not changing any functionality, but maybe they
> should? As the potential bug has been present for more than a decade
> now, I went with just deleting the useless "#define REALLY_SLOW_IO".
> The alternative would be to do something similar as in patch 5.

Maybe, but as you point out there has not been a report of a problem
for a long time (who knows if any of the affected systems still exist).
We can apply always apply a fix if it turns out that someone does run
into a problem.

Thanks,
Guenter

