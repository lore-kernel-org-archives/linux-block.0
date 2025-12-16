Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E823366569
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887370; cv=none; b=ZIBKlBLXH7oH+nJwIjf5KNcIHl8pG0ULmij8fNL/HYaloWclT5BKLuekejN0VftRj/YJ/WkzfsSmaSgpYTBQ3ibcIQswpGKo+EeiMdZJffq0BmcRpko+ki9jlIcbjveQ8WOJWNRtJsg+AUji8oML1pUpIoKZe8rVKJCxvWxv3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887370; c=relaxed/simple;
	bh=ygM6iPCH2TydP0HkxyKip8E+b6Ls9AqBqncVC7h+DLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLJ/Y7dssHBiH7XcoX2gbweZz9DxVCOVUhYGkkr5VHBEdyVpGunNqfPzCB0gzRgRuScpmUBMkRtvTweZojUOCAVAIHHMrSKKo7ldb/MHzH76NOnsdV/velDhaXs4O1fhxQobXwswQnuqazu1K0Cs0lFl5C3y/s6m2LZPVHl65+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=spCzNCAf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spCzNCAf"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b99da107cso44282431fa.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765887366; x=1766492166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5bBHT5GO4OwWFNFQ9+2hmY0RqEYQdKcZYHd8MT27q6k=;
        b=spCzNCAfU6diO0rVR89Z7huXTIT1rPDVEjDuzwPwACYmuoEddq1o5nyZ6Al28HUY02
         wFa2GEXvd08ONKMrTIucd2DaAuqSw5gRD4W349C8w+hQQindK+0VkQD4AnQNf5etRfMS
         uaac1IgHT8kHg3ljn1ZsVfxRGiMH1pY7w0dXPuQP0xvYa0mPpeeRm4S511wuYS9Uuki5
         ng/Lw7TH8XbEW8dr7ZtnyHpuaRtX1N+5N+Yk3gBD2Pgu22MsOJkP+n8eGTdxgKk8cZvn
         oX5Kq6HV8rY1A4Fsf7MVq/eoGJaf6AOxrK9Lkzwgu2dXmZXLSunxGvFZF1K9MMEJ2LhL
         9Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765887366; x=1766492166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bBHT5GO4OwWFNFQ9+2hmY0RqEYQdKcZYHd8MT27q6k=;
        b=G3C9bL8uLYSvbJRG2JS4KNkN6MFsx+PcGd0z5/E6Nk89ptK/AJcKyUT4hsczIu1Qo7
         TMuzkHPQhI4gTGkiePEEO2SmaVvZ/nLj/6o6T1olmUb01BU9u2Ufcd5EdsLXPfEiIbkh
         AA3oTtY8RnU0GSUFN3c9wkPHkjgz2dcrfYte5GoVs5Nwggc9nzTHkVig2TyzdA1qzjxf
         RYXKC5yqmgG8kulA1Pg2pAt1rfiwhgZsQTzUSMdImXqOubML//NlmidJFDNJfKZGjpzp
         mn9Yp6L7dsHrCEnU5UMP0sU54isiksVVYx+y8YK6j4QvKH7f4FMBaO8pwNmpnd6/eruj
         DUEg==
X-Forwarded-Encrypted: i=1; AJvYcCVt43m49gtwaI8B33uw6yLVLwfAF7jQEwaCI08s8smK25PeCOEoXP8Jg0wRRblN7a5IMhN922Hac7jYrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyaA6zsQ6YCw1o29z3jWOti6EHmENKx+IO30F9iKgVZ/i2c4Nx
	7fI67vXNj00dXFd9We8zpRSD8Xu4hc0rNio+Nf1rwlsj2Gf9rEj/UzEiOw77A4E4k50yHSiQ/C2
	Ug5YyixpEmg4cbuANmJILOleb8Q6x1GWT8JsMuPUHlYoJDLMUsnyL
X-Gm-Gg: AY/fxX7Y/guA8I9EzpvQ8pFvLLLwTQBvBEdXURYE0VdYDLYeVP1uITRJWuWD+EQxjK+
	orjrQAFlQhe6CtQ59NCAsf499I08KKpscMbz8KrORMaVV7CC1PG0NkXP6xJfXtQLF62eGHb3Xcl
	MCzYIcllhU01aR2UqSFY9JNVLAlADqP+ppZQeRf96pWhqhPu3LqIW48UM/ezNxasHT50TD0xblw
	Fdylz0vzOkNAiU+zvUQBSN7JGRRKZGa0/s9GZvo/d/pGUZa5BYg9hQ79kpWmPqzc/nOTwV5
X-Google-Smtp-Source: AGHT+IHSOzKJUAD0VWoqMbAG9/IlbO2ZSE7puMKuCAi60z6RaWldMe2JJwlbhcYrPz8NDWuyAEiNqo14NocbJW/sTAU=
X-Received: by 2002:a2e:b8c4:0:b0:37f:b5c8:7cc0 with SMTP id
 38308e7fff4ca-37fd08c7ae4mr55985981fa.33.1765887365959; Tue, 16 Dec 2025
 04:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com> <CAPDyKFoLmo=qDru67rj63gQwMjLqVKS+wEQecukuC+3Pz_CjDA@mail.gmail.com>
 <DU2PR04MB8567C09C52C66C59C9CA6607EDAAA@DU2PR04MB8567.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB8567C09C52C66C59C9CA6607EDAAA@DU2PR04MB8567.eurprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 Dec 2025 13:15:28 +0100
X-Gm-Features: AQt7F2qlgonHE1u8usoQ1ApRhJuG8Mj0nOYZGlZ59wEK9NLeswsioWiDble_0qg
Message-ID: <CAPDyKFoH+B363wiPi6HoKg1VJXvJVNPoYaRTGXzEDgSTEg9TyA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 0/2] Optimize secure erase performance for
 certain Kingston eMMC devices
To: Luke Wang <ziniu.wang_1@nxp.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Dec 2025 at 11:02, Luke Wang <ziniu.wang_1@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Monday, December 15, 2025 11:38 PM
> > To: Luke Wang <ziniu.wang_1@nxp.com>
> > Cc: axboe@kernel.dk; linux-block@vger.kernel.org; linux-
> > mmc@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: [EXT] Re: [PATCH v2 0/2] Optimize secure erase performance for
> > certain Kingston eMMC devices
> >
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> >
> >
> > On Mon, 15 Dec 2025 at 11:18, <ziniu.wang_1@nxp.com> wrote:
> > >
> > > From: Luke Wang <ziniu.wang_1@nxp.com>
> > >
> > > This patch series optimize secure erase performance for certain Kingston
> > > eMMC devices (IY2964 and IB2932) that take a fixed ~2 seconds per secure
> > > erase operation regardless of size.
> >
> > Well, that sounds to me like the eMMC isn't really erasing the blocks.
> > I wonder how "secure" this is in practice.
>
> Compared to other eMMC, 2 second secure erase time for 1GB is reasonable.
>
> Using the default 3.5MB secure erase chunk, the total time spent secure erasing 1GB:
> Sandisk SDINBDG4-32G-I 0.8s
> Micron MTFC32GAKAEEF-AIT 4.7s
> Longsys FEMDNN032G-C9A55 0.6s
>
> In fact, secure erase does not guarantee that data is physically erased. We previously encountered
> an issue with long secure trim times on the MTFC32GAKAEEF-AIT eMMC, and got confirmation
> from Micron:
> "Secure Erase (0x80000000) is treated as a simple Erase (0x00000000), while Secure
> Trim (0x80000001 + 0x80008000) and Trim (0x00000001) are treated differently. So, it is
> possible that Secure Trim really is the heaviest possible erase operation for the FW to execute. "
>
> And the eMMC 5.1 Spec:
> "NOTE Secure Erase is included for backwards compatibility. New system level implementations
> (based on v4.51 devices and beyond) should use Erase combined with Sanitize instead of secure erase."

Right, thanks for clarifying this! I do recall the complexity around this now.

>
> >
> > >
> > > Currently, a 1GB secure erase requires ~300 operations (limited by max
> > > discard size), taking ~10 minutes. With these changes, the same secure
> > > erase completes in a single operation, reducing time to just 2 seconds.
> >
> > Hmm, is the problem really the size or is it the timeout? Why does 300
> > operations to erase 1GB take ~10 minutes?
>
> I think the problem is caused by the fact that this Kingston eMMC secure erase
> small chunk need ~2 second. In contrast, other eMMC secure erase small chunk
> only take tens of milliseconds.

Okay! So it looks like using a card quirk, something along what you
propose in patch2 could make sense. I will have a closer look.

>
> Also, the calculated max discard is too small. For the I.MX8MN USBHC controller,
> host->max_busy_timeout is 2684ms, and the calculated max discard is always
> card->pref_erase - 1, which is 3.5MB.

I see, so regular REQ_OP_DISCARDs are suffering from similar problems
that are taking a very long time to complete?

Are you planning to make a similar card quirk for discards or what do
you have in mind?

>
> >
> > Can you please elaborate what happens on the mmc host driver level for
> > each operation. What mmc host driver/controller is being used? Does it
> > support MMC_CAP_WAIT_WHILE_BUSY or do we end up polling for
> > busy-completion in-between each command?
>
> This issue is found on IMX8MN-EVK, uSDHC controller. We end up polling for
> busy-completion in-between each command.
>
> I print some log during secure erasing:
> Without this patch
> [  126.760429] mmc2: starting CMD35 arg 01294000 flags 00000095
> [  126.766530] mmc2: starting CMD36 arg 01295bff flags 00000095
> [  126.772246] mmc2: starting CMD38 arg 80000000 flags 00000095
> [  126.777988] mmc2: mmc_poll_for_busy
> [  128.616245] mmc2: erase operation completes
> [  128.628511] mmc2: starting CMD35 arg 01295c00 flags 00000095
> [  128.634293] mmc2: starting CMD36 arg 012977ff flags 00000095
> [  128.640089] mmc2: starting CMD38 arg 80000000 flags 00000095
> [  128.645811] mmc2: mmc_poll_for_busy
> [  130.456184] mmc2: erase operation completes
> [  130.468390] mmc2: starting CMD35 arg 01297800 flags 00000095
> [  130.474160] mmc2: starting CMD36 arg 012993ff flags 00000095
> [  130.479928] mmc2: starting CMD38 arg 80000000 flags 00000095
> [  130.485798] mmc2: mmc_poll_for_busy
> [  132.192309] mmc2: erase operation completes
> ...
>
> Apply this patch
> [  296.480818] mmc2: starting CMD35 arg 01294000 flags 00000095
> [  296.487219] mmc2: starting CMD36 arg 01493fff flags 00000095
> [  296.492995] mmc2: starting CMD38 arg 80000000 flags 00000095
> [  296.498999] mmc2: mmc_poll_for_busy
> [  298.712865] mmc2: erase operation completes

Thanks for sharing the log, much appreciated!

Just to double check, I assume that you have verified that the
busy-polling works as expected on your HW? The reason for asking is
that we have seen problems with this several times in the past, on
other HWs.

Kind regards
Uffe
