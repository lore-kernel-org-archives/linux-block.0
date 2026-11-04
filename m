Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819528;
	b=eG1/KiCXqs8iubY+Vu6Ik1xBiUmsfzPIqpnazYmyIdecKQER26II1upBVLkHcjNw4Qpn
	 IUIIe91xPlxeBmmiCx4GcMsb85hffqsxPySa+Zc2sFMDR9JE6RewXQ6XMNfb+zNoz5kFP
	 EY2mhGFvOTxUaOUW1UX0e+Tkb7FAkQuCPBEIjQCgiu0gKa9n4NP9ox2JSUnh7tNmG3L/F
	 7x1cyl8SwIQpvs/qqUf1/FvBn55L6EkKR0Itv8BdDQu0rUHlScv7ZiNsJyTI65/8PGHYf
	 SDqDuqOPp9taa5wNulqbMT0MqyddUoDdbck/VbDxvDMXfP6ybtrsrTOeFSeZ4Difp6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819528;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3DKxUDhIGrS0XKk3YGxhQanUk4e1Hk17J0HKDnLrC4w=;
	b=JxqW9z1OJORGt843ETUcwfAd7rItLP9c4iOLL5gp+ACk0wXKWaoCJhhzIJ6eyJe7Artr
	 WuAxiKJvd9FvobTUE1vKRO/jcZQu0S6PhS5kzFK2jMBDvOB+QFfyVMz3M5Uc/cZHErLrB
	 yDeO7VWgVEENGzpgp2ThRx2FrDVbwitWjdYuYeD3gOWpwnzlL/xPtPT7vn/aR7r9/IHm5
	 NeuBTed7MJ2ciiiZ97PcTk1iVynh5jIkaWvziakWuarQIg4lANnpB4ao9FLrt8MQl8YUd
	 JqZdwyfhCWbUYn/fMZnfVj/qo2GhC2gc0+4hINQ1pfvrzsLavwQp0xnsKlUKcvSXJMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6BWhVAu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C1606A31B
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6BWhVAu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C311F00919
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819527;
	bh=3DKxUDhIGrS0XKk3YGxhQanUk4e1Hk17J0HKDnLrC4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E6BWhVAujpHKz0HBPWfMuhI0XXUt+yp9/6ZuVZ1TU6mTuV1ZzSVOS4IdADWTV8hCr
	 LQ0ZrqnUh8V6ahlcAptxCCUaE6Gsii+LRJ95oD1ujXoR3XbM/+ofsUOdw+flCmWzAR
	 tttyyhsFOuA6Z0TxoapeB1vau8qI2/5E4/UzlYEuphhqT2EeBJbfzA8hT9tPzK8ywM
	 jCTFhnfQtIW+Fb095szIl4Z4sdfi55VrPT7ZKY/bHSNwiUYMBnmIUdR5yjUYyJQBGP
	 Cn0ZOAWu/WkWXoVsVW3JIW8PBN3Jb5C0XImVmkt64vm16BgdsraokB2p6S8dsAC5JH
	 5EEok3qIQ/DlQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3acd523a802so8565521fa.2
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 11:12:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxFRkiHmKETebBw4n1ATA1F0Q3IMA4VG9tzXwditEXvk4b/Z1EGy9Edg+wq4S+f4onKcEYJy1hkebQuzg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9IukjOC2ApSL+L2UU4BK8XSFX6FSact9iBOQXhhClPR9NKxOot
	MwJbuDN6ku3tXy9JISlLcLn31r9LDRwbsIau3sGuwplvwWYChUWE7eCBWUtPaYo+1hC4yEGVZcb
	9sRZIV+GX5lRDhmoiyrt3NA4nNGzbjv8=
X-Received: by 2002:a05:6512:1247:b0:5bf:b144:fcbd with SMTP id
 2adb3069b0e04-5bfd95871afmr6554848e87.42.1793819526207; Wed, 04 Nov 2026
 11:12:06 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104151651.3035537-1-stanleyjhu@google.com> <8adcbd80-f684-4e00-81b3-a2661fac895b@acm.org>
In-Reply-To: <8adcbd80-f684-4e00-81b3-a2661fac895b@acm.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 20:11:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0guHKxUKXqB2MO037X_hn9B4Qr6mfqgKShP7xLaXt0xtg@mail.gmail.com>
X-Gm-Features: AclHuK82fCXfTCCutppNy8n6kl31mTAu99xE8kGJzMIP4eRpp98LhfMeiJfG6w0
Message-ID: <CAJZ5v0guHKxUKXqB2MO037X_hn9B4Qr6mfqgKShP7xLaXt0xtg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Update runtime_pm.rst for non-fatal
 resume errors
To: Bart Van Assche <bvanassche@acm.org>, Stanley Jhu <stanleyjhu@google.com>
Cc: Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Jens Axboe <axboe@kernel.dk>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 6:11=E2=80=AFPM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 11/4/26 7:16 AM, Stanley Jhu wrote:
>  > +  * If the resume callback returns an error code, the PM core sets th=
e
>  > +    device's runtime PM status back to 'suspended' and returns the er=
ror
>  > +    code from synchronous resume helpers.  Unlike with the suspend
>  > +    callback, failures in the resume callback are never considered
> fatal,
>  > +    so the helper functions described in `Section 4`_ are not
> blocked and
>  > +    a subsequent resume request can run the resume callback again.
>
> Hi Stanley,
>
> This matches what rpm_resume() does since commit eef1d74bf88f. A nit:
> suspend callback failures with -EBUSY / -EAGAIN are not fatal either,
> so "Unlike most suspend callback errors" may be slightly more accurate.
> Either way:

Adjusted accordingly while applying.

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Applied as 7.4-rc material, thanks!
