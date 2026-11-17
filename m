Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906273;
	b=W2ZmoJwI/st5nbHGQ5yhry1Yp8jfWlqmw+AToufvavGj9z0BAjRShEJKJPj22jwrFWd+
	 sc76fnxDoE9lmO3jXzcfY/yhc6BcuhnGf/BsVF4g7FgW2iTfmG3RMltrWV0fHkgooUvlj
	 4qlEwzB5eOOMwZBChLQ/0cGPV1WlkR9zlv15gig9LLW213mM9T8fzQWuhGXw/rli6Nsub
	 X8zpyyoSNYKZD392EvAwKsnyA9P2SMq2urP3w4TYVvjF8s9pBVdmbwI8pOywvxPUNVVdf
	 ohGmd3ZGLZHQ5vpW+yZq3UzjjwlPvS97vi3w6TVdLaQLrE7LXDT+CUxA3hIqqNifSag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=NFfn01r/I2+FlzODQuMnSDaVkhXc6007Ui5uRs6gM1U=;
	b=GY1u6jkso7kUk4WjAppjuWu7fAAehYf0ppb4MxPbrfLqXZmqYE744hrx7uSua0a0fY9h
	 LSbQ0EtnGdWkNTWkSOLBEnuOFQTiX5PIqOsAb9SSu5JCYBuztLaWfg80oDonX3XP0W1yf
	 kubEg9LREALyKXaq7JMn4UDuTTw4/lSPdRakiktM088A94dwolm/uq8N5EhXAWN07js0b
	 gTvxeMmhfs6JETEckazxjBRj9Wv3fP9frF/fdLm9WM+1x+F7JYYn3MmG+w3MLn3G/dKe7
	 JfJEkGrkZ6HpwbWL/ipwGgXinUnyDJekVxuSpeaRhWbXq1FpRyHRP/RSOvbbp7BdnGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=QR2IjSll;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50637606A323
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 09:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50637606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=QR2IjSll
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8c4cc85a315so229548b3a.0
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 01:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794906273; x=1795511073; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NFfn01r/I2+FlzODQuMnSDaVkhXc6007Ui5uRs6gM1U=;
        b=QR2IjSllwZCap7dIGsWvdGybMobHzhdf0K6ybXEmYE5E44+iEXK7q1GYERnNlXkhKY
         GC2wvGo73nc1+dmssWwyPDR4NH+7UtaHFaDiGWU2HvBNZCH0755DyexnRvKOm5LXrV3E
         Lf3PKTlI8WrlDJQEfJrk4qRjoMmsKTYJFbpbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794906273; x=1795511073;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFfn01r/I2+FlzODQuMnSDaVkhXc6007Ui5uRs6gM1U=;
        b=rFUxXw5BPUgutokh7VnG8g1uj+6XBBJlcCwKCtMq3t8TVcPiskr4CYpuqvdGiMQPmf
         6gknHwOJqPq6sBKFGCZBDdxQ+ulcO4bhV9w8TsO6/2FHXArQNCnI1z9HOifyRjQahUzS
         3BfaS4JnGzecFn3xVpzpBeWdSKxkOjPv5lJApdI0itxI6+B6Rhn921EBxrBj9oH3R20B
         v8sLXOxG6MiY5Cy32pg6hH3Mqi7SJSjCmFdvOWX0o/5wZSZbF1C0t/5Z5PyZY8Gfbsqj
         KqURz+CoegBRXXPO5eCCEPLdmKAy69kyiL+BQsUc7qDuRhYXe4wYCkYYgo8lgT9s1QIY
         Ithg==
X-Forwarded-Encrypted: i=1; AL+hErFnUoxfb+E6JOsG00AYlsivVRa1IaFZSVDX0ny2HTEzosXfdYi2IOUF9J168nVQ9EV4swDc4v7buks0aA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9BHyAgLw8osNuhJbdkvVqYvKdYUOp9IwbM8U2oK+MjgPoiPOTJ
	5LCruG/ZPxktNb5ypNE/UnlWkKzUShIGnGLRqQJgoAmdl5h3Fv7LuQR9PL8EgoGw8/w=
X-Gm-Gg: AYBFou0TdxPWcw/YMDp+u6Hk5LqA3BcMJrDpJEE8LDy1JcKyRhRQggG4oL/0TKj/BI0
	ZF7g3PwFdgc+D4qyYyzJHue+7a4c1ILnFkdIcgMlKs4JrPArsy7vLjSRRBrF7fwtJGESOl0FZNa
	SshSOKnXLfUQg4x8bmdxaP5K8vJTxMSzyDKY7g32lPjg2Kh7AkmpGcDow1laTvjHM8Tqzo39djd
	Z35P1AZUGsvaqUO0XtTpw7O+zXrM/nc4Iwp7YVieGs73wAZg0p5IZ4ITyU6MmQHkKje17RfahjO
	0eydJSG56DOdfspV8GPzx5qQHJFPxvs9KsLmL6dsi1aMJ59akGPSO+0zaQyCJFraXz9ioaC22xu
	bHfqKe62/wxzvpCWwHnihdqqL4DKzmSdjNiMxUxTC+eHU2kpvUeQJUub+aBUXiy8irF0KNftrqz
	+Z62rqGn8KGux9XBcrXVmBisNC62RR3aUtTu9XfAqoKQ66NpK3pJLZ4tAXK5CBCMeQFAYD0Tz0i
	60CG7rDtTv1H90JQMrM4zY+QGvRCuAKL03GMRtFt6HWkx/jLbL/sFvl07TDiYerXbRkm9pEFC0f
	QwXjoSPWc7krgEvY5UwZOvL2W/Nt6vXn1nhpER71Yl060Qv47eTvlHTKhoiFn42mM+hBjJzNw+c
	YBJQC8hedOwrcVB3NOyg9jYJRD6YmTX8LPdfr67amf8FyTE7b9RJhTM8E8ATCH1h9tx/B7kwc6J
	w0b9pycJAajh7nH4OwRHt0WEM9ftkhdnp9nS98dPYISGHnRqqjb9/okZda1jODVpHv
X-Received: by 2002:a05:6a00:4518:b0:8b4:b88a:c2d6 with SMTP id d2e1a72fcca58-8beb6d604a3mr11459421b3a.39.1794906272633;
        Tue, 17 Nov 2026 01:04:32 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed20548fbsm5091791b3a.37.2026.11.17.01.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:04:31 -0800 (PST)
Date: Tue, 17 Nov 2026 01:04:28 -0800
From: Chris Down <chris@chrisdown.name>
To: Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-team@meta.com, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH RFC 0/3] fs/pipe: copy a run of pipe buffers in one user
	access section
In-Reply-To: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
References: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avwYnDc2Au4mnHTd@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Breno,

Breno Leitao writes:
>fs/pipe.c into lib/iov_iter.c. The main question is whether that helper
>is welcome there, or, make the party a bit uglier.

Hmm, I think the part more likely to get pushback is patch 1, rather
than where the helper lives. :-) It adds an x86-only user copy primitive,
and then lib/iov_iter.c has to look for it with an #ifdef on its name,
which the patch (rightly) acknowledges as a bit of a Macgyver.

When Christophe proposed another user copy variant in April, Linus asked
for the existing unsafe_copy_*() helpers to be extended instead of
growing a new interface [1]. And in a related thread he called x86's
unsafe_copy_to_user() "almost entirely unoptimized" [2], which is the
same reason patch 1 gives for not using it.

Based on that discussion, I'd think that the better way would be to make
x86's unsafe_copy_to_user() use the rep movs body from patch 1 for
larger copies. Then copy_bvecs_to_iter_full() can be written with
scoped_user_write_access_size() and unsafe_copy_to_user() for every
architecture, without the #ifdef.

[1] https://lore.kernel.org/all/CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com/
[2] https://lore.kernel.org/all/CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com/

Thanks!

Chris
