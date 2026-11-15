Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794735629;
	b=zK0DG3jXmMNORgYnrFNsXHjrlBUIPDep9RYOf7kfiWCQ1xIdsH/gmSE6hkBoLtcoP4MI
	 YfsZokAhJ671w2G1Ru+kqyT3z7Nt3Q2kyFTHKckzWVyYeA4UM2v+qtrpJWW1rcgeQEj7Z
	 pz6iWgbeyzLprJgnUTHv3/jAcnBjtVH1APB2Tky5O/ToQanvBn3aLIZtF68V7+A1faNug
	 XAMQEXZr96SQu17gzMGUe8hCUjMZOTGseKJFl/xyeNGVLX+U35jjpWJnjhKlo1nPYtWBo
	 n2FTiJSZxnoy4xJoP5yIb4V3qFZ9xaqzpyCZp8ewAplQxndxTuT2//ZuMWEUnbee3ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nK4+XntrB4g9UMluME3F97OBMFRl+N/3eQxGVOhuwxk=;
	b=lXHQf5YdP7PgXj5PfKVuP+aDa0fjUCBeigtyEls1pAPZZwqJdpNpv1tkrXyuWJMOTsQg
	 gJpE6ikQCsWjT3rx95kRfWWi1JFOPNuIcJEtnELEo8pSbbQ6CMMuUaFsCa5PhcbkVryBw
	 xR+ywCGr9SFI/eSlM4DlJTwZKzR41GXvNN/uumG/94DKVS7Con+48r+ohDrbgqOKxQWXl
	 DYQn4dapX1AXH67eVGPu1exf+Gz+aoVuhceojMRxU5g+VIIACC1TZwceyGlnWJFE3rZhe
	 DQwhuqlOeKYsLxFI37U3OhJtMYJgaRWjm5afbW352WeMGuWOVZc2RICmh9JWa6009kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5nDBfVG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A9606A31D
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 09:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 690A9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5nDBfVG
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4adba7b3399so747361fac.1
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 01:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794735628; cv=none;
        d=google.com; s=arc-20260327;
        b=hB0zGhMyDzhEXX4pglJPuD8GO8hX/59NwA2clCix6+3XjvleJkgIZovfoWO30CyohG
         eBlDatPkL9Jdn3O4HIVJBTR7E7qUEPAEQBI7rBfmvtRP/ajlCDYubkJaVCnkNxXKhmAI
         HMV3w6UY0gIFr5atbtXm+HXKcLjxFV1+2ExLtbHUxVl+uPEo1U+0WaCHhWi5XUE2YU4Q
         avCRX6Kx2580N3iK8DH/nAIzdDyEwaJq92mYWPxI+SnyEaMDHxG42dmT3YqRwevWky2Z
         ls3lWuQigvLuYyGygcXIdtKTFKvi/nnaNbZtcQRzcAVUsaq8lKASOtG4Evyrgg4F71yV
         88OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nK4+XntrB4g9UMluME3F97OBMFRl+N/3eQxGVOhuwxk=;
        fh=2AIj4g4u/OyHkDbirr5Vwr/NY4LcISmxo04TyPjdDw4=;
        b=jV1KMk+3ziEOQeOi0HDJ6WLTlNpxwLxztA6IHEdjemD8/ra0pqWnmSMlgoiuRioHbP
         C9qzdW7rikaP1wq1TkUMqippk/Er7VaIBSiuDXBePQlMHVaI6p8YMyp4uQZ3wq10+00a
         dxphIQeUzJsO7itj/u1D8zS6fi56NUPhd6MwhOUia1RyFkk7TnFbDyR8m148RCEKd4fW
         DqD1TFRb4Tvgli0jVv6I0rzk2m4R7uD9T7IJom1OeXwRw1oe2m0g0TogzdYk2PMFzrKb
         JMQVKV6t40KpmmYH//Z6DT4Ey9z+Kcz1Zbod1nsaUujSaWYj8c9qYVmP5qVUwmLF312v
         2Tww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794735628; x=1795340428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nK4+XntrB4g9UMluME3F97OBMFRl+N/3eQxGVOhuwxk=;
        b=z5nDBfVGkE/LDFntn+7Eq27TMw/rb6yuffGmNWVyuOAwSLOmt7bTre51083w9k0NEa
         dpJsC87HsLaCmM24kOEmubv6fgbidpJ1hTN0LTC2fX1nxbBDPHrLUfe7dSbYvQsCWW+7
         T46ihT9L9j0KHcYgeEM+N3mEsQpdw8LyxvJKQhjT3IvP4mMEZd49iLl/srj70vcRK1L+
         ME4F4I9K/Ykm7aQeHMnVaqoQ9N06JS/hf/+9dXUgoVsQjrqY34bwBzhtrnlEGTU9aPTf
         1y/3uwBz0brpSYIXIwD4BAZlCZ14x91HMHZhC/G9JDrRl143VRXcQGJ0jDpwUxaOsTId
         yHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794735628; x=1795340428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nK4+XntrB4g9UMluME3F97OBMFRl+N/3eQxGVOhuwxk=;
        b=Q8F3dH0x6ziBWst8+F164hGwfJWa5thNjHnAc1UMCISvSnYucGX+zGAOGrP3sszXyB
         kT5maQ7+7iMKF4Lj2YS8e50p3dQhlDbkfVVOfOmSLVr6W7+hGKbudo4c70HG4W2alqbG
         IRFSrUxve3gFSSvIQauSIIY5AO4aFriJNI8fQdpShHIxH1OP3tIHXxVAxasmF1fZQSFu
         59QfFFIZTQo5XDkhJZXKqdxsBp0RA4Nq7uEfThdERm6N3P8Hw3r3FX+ppTLiVU7bwv0T
         QZ+NJSHDL25m9pqEZDZZiAgoJVwadxXxkD7fEkupa8NJZj7oVjEnmCL9aJXrPyhJsUJA
         yHAw==
X-Gm-Message-State: APuU4Z9su5HQAwmzKSWxTODvA+xUm6uH9Sz6cDvHByEUdCBXgxoYD82q
	fZXJ962L+bMZmu5s7P8eM1GyRJh/uCgyvPPD/raY8mC+mVD3NXWHCX6zkpEioC0HV0ateKGgkKv
	DyParXz3eqklUKxGq2k0/Bakm5CdTEN0=
X-Gm-Gg: AYBFou32dheqruQcUbTJjbvFhXuR2IVxhaHY7ozk+hBU5b+AgqDUcGDUqYSBHDxoYQI
	jb7yzmoLtlRFUKRqZilRBam5pgfpoefhdbHWEM2WoZ6rV4CrePsf3hHgX7nJM4nEDsd8ruDRs1U
	srhHqYvZ5LIdlJbPDgtzYw9OAr3JfZMniH95dmHW53QH5u4CvQCGtLpicAw3OpsZVDvFQDRnLJz
	LEElQ04MkYFxCRAQfmiuJvw/poCmp7/IEae8K631QZen4VzO2TaTf6nrJPwPQeL0fjl0hsFPjza
	LMxGm1GXKwhw5+1mkO6HeXFDu04Ti3kZt/EhqWNViQzY2bLX2o5zYWPtnusSaVR+O/EljEM2qXI
	5WDrtWSpGxJ4nzuSAQLgdxXvDw8uMGuLzFe4veaIjIzupcZQW/ftE+BWRHajIPxqGwT5HtGs0i7
	aBw5nOMfo8NTvppgpZxkhztnYhYOUj2JvaCKGe
X-Received: by 2002:a05:6870:2107:b0:4ad:9063:875c with SMTP id
 586e51a60fabf-4afdf088a40mr6658056fac.2.1794735628252; Sun, 15 Nov 2026
 01:40:28 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115003349683IFDCSTYhPzQtBozUiO8qN@zte.com.cn>
In-Reply-To: <20261115003349683IFDCSTYhPzQtBozUiO8qN@zte.com.cn>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 15 Nov 2026 03:40:17 -0600
X-Gm-Features: AclHuK9eC4Zpc1ALSmk_wwWzTYxdUwIRRE009JOi-jy2hde3HZ4BFkd_d0irHGY
Message-ID: <CACVXFVNCQ1KMiimy75WJs10GMV0cde9kfeAn0oNJfirNPaB1Kw@mail.gmail.com>
Subject: Re: [PATCH] ublk: validate all parameters for zoned devices
To: shao.mingyin@zte.com.cn
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 10:33=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> ublk_validate_params() returns as soon as zoned parameters are valid,
> skipping the subsequent DMA alignment, segment and integrity checks.
> SET_PARAMS therefore accepts combinations that it rejects for a
> non-zoned device, including integrity parameters without UBLK_F_INTEGRITY=
.
> Invalid parameters may reach disk creation or advertise an integrity
> format that the server cannot access.
>
> Continue checking the remaining parameter types after successful zoned
> validation. Preserve the zoned validator's errors and the requirement
> for zoned devices to supply zoned parameters.
>
> Fixes: e84025d2a9cb ("ublk: add DMA alignment limit")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
