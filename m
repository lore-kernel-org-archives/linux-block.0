Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4132D73AB
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915158; cv=none; b=m6GOl/7bb2pIKiqlIMBiksdl2PJu0F3/KRo2bh69nfNt6BSdbBLUdqEpjjqvTfpkN0qLVMU02oGjNYdYBzYRPSZZMYoEV3p8PPMIk5c0VWK14m5HMiYOebM6o/UdJwd2M9kcToo61Aonaan1ofCBPtERWwu284JpFlxdIlYWTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915158; c=relaxed/simple;
	bh=vz6zEIxg/+wl/MDvP+RvMv0qeimFFpWWQmNPdyV4ahQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVajPJ09Lk+4aEqHlzV5YVWhzxrYBdi/XGhnHn4PQX4yBXhtnYogV/WT5rFwAd5z4l2Vh/fh+dY2BxrbXrqvKQb4O01/gnOf2ViAxxYcrUcd/sRkBqNFl+IbCSLzpPpOqOuKX0jhdn4Sblz5OTs9TrpFbo+Lt6QcMd/qu2ZMuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQkHgQ8r; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQkHgQ8r"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso33265295e9.0
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765915155; x=1766519955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjniS35+gFl94KgDPsESP+GSizMKZS5/qxbShY9gflU=;
        b=mQkHgQ8rCUqYWNQeWJT+spqbmbXpQXZBVbGCJeUWSHpIIPcLjCD4WKKtC8gq5X3V1h
         uPiB7fkh1u26HvOc8vP0tjZDG+gQ1gR9wTMPHbNV4zBRAbei19yhIG0FspKIuG3edPK0
         72/VM1hTUDRmIWXpjPpznytNY4UqOpmQIzRnuJTNADpvdQnHJgs6SgXGQuJsA6Sgqhxs
         zXqpHAPK7R5P+tZpGQWEYNg3Sz3YMI1g9UpKuOJMk7yQEFOBsLJQvZaCUvjWGEcJ4Are
         Fg2kSpbK3lzL89h7g+ICvVPL0tR3UUaUaT1nr57OdgNuQDNj8K+OUu9RuKEqu4L+p/RI
         XCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915155; x=1766519955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjniS35+gFl94KgDPsESP+GSizMKZS5/qxbShY9gflU=;
        b=TUoTzMxIZ/27hCMaH9jbstR1c//8QQFPTF37QJfn1Pca0JjVoRsMDwe+s/ygvI96+G
         dUG029DrHx/GP7rMS6SzUlDDzBmxcDaW7wDCbD+WpnS//0GxtxxN8xy8qsgh9qt9e3yi
         LaN1Pbrtbfvu+TTavG/VY/TFl2F0Or+IJUj+DPeL85JJxlFofriWzRJZqtdGuUO6hrVg
         +hvC9zsUCnmXrUuVj3+ipAShhs6bM8YrQn/gCMYTO8wa85vkti2kxRacmbOSBHn65mjj
         1IemWfPuPefS7QzvqmFRVVLP1dc2CeulO1LykO+5MzLTM7a1UPm9GuQPA/2xxts+K1E2
         pQCA==
X-Forwarded-Encrypted: i=1; AJvYcCXtxwMetEj6R7otih2ICGoSl1+TSCWhAoJsGVk7eShVTxFx2rFk5tc6ni0Qs0GbwS87V18cl3NR5L2XPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxapcKBNMNsNuH+PzbrVOYW2/FpLHE2sdos3lvqo++TM1hfOhcg
	klTapZcLKSMEXhfT/ZqFYQMphh2G0OtLK2uo09hmehNCemmXi2fQYhxR
X-Gm-Gg: AY/fxX7fZSjeeJVJwQ5OLmjnJGR12BWgcbV8xlKis22+4XeMKSFLr24lSlzTmNr8c10
	7uWLQxtf1UwVItLEPuGgR362CVRbQODwyh3CenF+77JudRYaMv+7tYAlw/k/SveJxoKvW04+oGD
	JetjhYNe8gM3ic3R5X6BkHlVuitpXoh2KwnJ2/RAB+6Gk+3nKxOyNSj3hRb4SxQy82Asr8VV7Mt
	xV59C3HfffRR+iAwFBZPOpKLjSnsPxSSK7P4Rd5NjNlKV+TGcfOYpPGpkmINOxS269tId4RG5Uc
	1nrg/JBBKZ0Im30Yg1lo7Fl0t3pv7I2EQyyaOz8Ip1dxaJ+9fRMjj4piZch76p3N/uL77dzOdZL
	kn0cdNhuIa6s2/yNdHkEC/WI8JqdqQNXsyvnMKEileWTSJx34p+rAv/FQrDYfcZh5TKx5SwbMtL
	rsLfqJl7ik2mtI2F/M5ww2wKfamaztjbo9K9EG4irfa1Kr0FcGShoZIeSc3MjWHc0=
X-Google-Smtp-Source: AGHT+IGkMCP0kONGgG89SYNUeIIN6orwCVUUHEl6uObTm3wydLwUSISgvgOvaVGUZQxtmSBHQ8CSsQ==
X-Received: by 2002:a05:600c:4595:b0:479:3a87:2092 with SMTP id 5b1f17b1804b1-47a8f9145edmr152180075e9.36.1765915154784;
        Tue, 16 Dec 2025 11:59:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ade7c3fsm779077f8f.26.2025.12.16.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:59:14 -0800 (PST)
Date: Tue, 16 Dec 2025 19:59:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Ingo Molnar
 <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-block@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Denis
 Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/5] x86: Cleanups around slow_down_io()
Message-ID: <20251216195912.0727cc0d@pumpkin>
In-Reply-To: <14EF14B1-8889-4037-8E7B-C8446299B1E9@zytor.com>
References: <20251126162018.5676-1-jgross@suse.com>
	<aT5vtaefuHwLVsqy@gmail.com>
	<bff8626d-161e-4470-9cbd-7bbda6852ec3@suse.com>
	<aUFjRDqbfWMsXvvS@gmail.com>
	<b969cff5-be11-4fd3-8356-95185ea5de4c@suse.com>
	<14EF14B1-8889-4037-8E7B-C8446299B1E9@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Dec 2025 07:32:09 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On December 16, 2025 5:55:54 AM PST, "J=C3=BCrgen Gro=C3=9F" <jgross@suse=
.com> wrote:
> >On 16.12.25 14:48, Ingo Molnar wrote: =20
> >>=20
> >> * J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrote:
> >>  =20
> >>>> CPUs anymore. Should it cause any regressions, it's easy to bisect t=
o.
> >>>> There's been enough changes around all these facilities that the
> >>>> original timings are probably way off already, so we've just been
> >>>> cargo-cult porting these to newer kernels essentially. =20
> >>>=20
> >>> Fine with me.
> >>>=20
> >>> Which path to removal of io_delay would you (and others) prefer?
> >>>=20
> >>> 1. Ripping it out immediately. =20
> >>=20
> >> I'd just rip it out immediately, and see who complains. :-) =20
> >
> >I figured this might be a little bit too evil. :-)
> >
> >I've just sent V2 defaulting to have no delay, so anyone hit by that
> >can still fix it by applying the "io_delay" boot parameter.
> >
> >I'll do the ripping out for kernel 6.21 (or whatever it will be called).
> >
> >
> >Juergen =20
>=20
> Ok, I'm going to veto ripping it out from the real-mode init code,
> because I actually know why it is there :) ...

Pray tell.
One thing I can think of is the delay allows time for a level-sensitive
IRQ line to de-assert before an ISR exits.
Or, maybe more obscure, to avoid back to back accesses to some register
breaking the 'inter-cycle recovery time' for the device.
That was a good way to 'break' the Zilog SCC and the 8259 interrupt
controller (eg on any reference board with a '286 cpu).

	David

> and that code is pre-UEFI legacy these days anyway.
>=20
> Other places... I don't care :)
>=20

