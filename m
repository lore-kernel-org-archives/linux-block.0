Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB33A872A
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412950; cv=pass; b=TyljNv5OndKCVkKc3NuTsJZsacIzsfnJzChpQKF7LmHKQ6k38fi5qZUWFP65CP+/FsCP5vlSU/Ejrt9uI0V/YT+bAVJctlhLY/KOdpyllyu4SMJCVBVbHABKAD1yOJUbwFBHbVKOHyfb3nz2s20iNx6UzDYqwkhLoxL/HmJoShg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412950; c=relaxed/simple;
	bh=l3q1P09EzWZcb9nezxuUfanl437Rdh8lbY1S+Z5oQXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh+yWvqkNo5jSuAsndEL+JgEiETwgRTRID53dk3VjSl5EY51Oj58oLrtEutZTDFNBLZkZtptnIHpMTs2oRGV3q9uhasBRthSnlXZ/aLPDWpd7y/QLUWDUum4dVh4v9qWGVjz+yXV0ILgDNxMlKRnf4u9MQaujhVSDrCDtaYGNpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i94YX5lp; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i94YX5lp"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d75ed779bfso2357384a34.2
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 07:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412948; cv=none;
        d=google.com; s=arc-20240605;
        b=i8PL80NhxF9Wz/tiW+0pd6pAvP9SJP8EU1MogBDAcpzQPgoYOXdRyCXTQmaoMA7L0N
         fUw745QfuoEssqTrp98kaRClkPmbKPk+KAm+BiwX+fPFFAHI0XOVyF4hn9H5PreKvuHB
         G6seuac8WshC4GedsDVMJJxpLoZlY2iWQ+tSZWRIVfN/Nm4wH+9Pmk7b6IqK2ex/1aPj
         CrPq9b0Q/fwDi3OkpX3sferFR8j0Sv5I5po+gk02czELrzZTXuAWT0K75HSwKjgg+KGD
         7ovdVXm7xUa4u/kfY41wdo//b+/8qU8kCfjJO1q6dP/OKGXnGOOja6MnEBMtfjz5bFlP
         6Lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3q1P09EzWZcb9nezxuUfanl437Rdh8lbY1S+Z5oQXM=;
        fh=2Sfl9zWjb/2Wmc2sE0kExOjZPnMIIBCTCGl1XMtWo28=;
        b=ECCBx6lL5ZMBGSco2kltS3d9Ksv1GAMrlq6RN2SGNox9pO7R/wIEm6bzsbbrkrJ7GR
         xuVL6S//vZnGvPkutD4Yv+nQwHbImW9P1kYzQLBv39SnJkN+k7zP4uiR9QJthVmhbTTp
         XBnoHFDBqlaLUhw/o7xxPeYId9S7eT11h6gJAiwQRuqyyInnuTo7DljEGEGyRSD6K2cN
         9zr6pJYoNr2i6q/PVPZ0dZvURpfZ0GhrFc0VTkIWEhTW7Tfy1NA2ZsJ3lR8+DmJIGLbI
         Sh7RYCvv2yXbFcERkkkTHlzFdJTz4tSiLEjT6NJC1JNBMMTHPghw7iLYTlRXGFonDYmE
         V4yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773412948; x=1774017748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3q1P09EzWZcb9nezxuUfanl437Rdh8lbY1S+Z5oQXM=;
        b=i94YX5lpCpydiVrIUjiLL5jm/xaG3++pUbcN3E7ZAFoskGS89B86RFCOB1zy0luxhV
         JytSAfE2Z13LJ0KR5sRPsoMohtFTMPE8Rdfbs79q5+ypTRt9n9izE53XEiqr20Qk4fr3
         5iBByAXoMd6wLsSPHWS+Vs73RwMBXN7pi0h51tge/UZjTzjyWqNLijSOG+iCCKCkuQ5j
         w3ELmo0YyC/FvYCFE8RevVF1s7jL+UfgUranY4BY60eYyOgZikKdNIZSF713yMh6CcyX
         4wTf15voxDyo0vEdI9E4cur7D+pqq0/h3KNOQea4R1WMaj/OeGf6U/AdnUPlXSrKCQOx
         mqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412948; x=1774017748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3q1P09EzWZcb9nezxuUfanl437Rdh8lbY1S+Z5oQXM=;
        b=D422la2VN3Clwlde9oFAkt9UbqbxU8f93XsDPUPFQs4vwhUFjm5NoSRDi49UqOLoKK
         BYR4uuyQwCvclQ2FGNOoJM2On3azDC67GC7KapTqr7EyQgrLcRRPYMDjc3Hit3kt/5CJ
         PG3ORDqtmAQYRgg/dCscl8y5phumE120HN7Wxa00xHIwveZC/8+H19730Q3+iqnRy9yx
         nnRHrfnjDHW5LpK9OSAXQHNZid02LL9YkDC0STrNcpvnObfsEWphol7OEC/Ofv2F6VrA
         iy8nHqVCssHHlM9yC5IgRbr9m+TmhPNKKZIoessN5LDraHM3aBf7I3xeWEHhDRITE9bb
         JWGA==
X-Forwarded-Encrypted: i=1; AJvYcCXEn+8SvqgCwD7DDhg23p0OrveGzNrlu+euRdM53y89RoNuMy6+gcug7uwwnAD1p0ww6p7kUKCA7SSOKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqrtoHVVhYPkic0Vb+D1uRkvubnjHxSzOV5n9VyM/StJivC968
	IFOQpEj03UmM1Lkqw+4R6Lc4K/4RUTKW50hVugmVqjz1hgPbLC5nXFjFk6V2yXfKb8VjwYnrPis
	0oE+0ivROzvpJa8AsoktueV04NXt1oeo=
X-Gm-Gg: ATEYQzx9rMvGottgNoc3WlG+sDR605wNNhYx0Kx4YejUIRAHY8S8+wiWQpyFRCf1jcb
	STtjPLzsMHmyxCR1GaM8M2+bfuUIokFKvG57RYAbvLhAW1f1kQ+feD+qi3aNzgxPkKSIjGfhxtq
	o1o9g30TtfeVpwROkxEnJYDI90e/a4QzEzQ0kOFXLMK/Pl1+urlZ/8P7u/rCPmofii9qFvQCSHo
	G9bNVe92NGfc18awUtjcPbYigdau8tmaGT1dr7OSmcy++BXvP8/nig+AVa7Kmyr5qjS9QhuKaDF
	rcv+0Cw=
X-Received: by 2002:a05:6820:22a0:b0:67b:c4cf:9cc3 with SMTP id
 006d021491bc7-67bda98ddb4mr2281287eaf.11.1773412947998; Fri, 13 Mar 2026
 07:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com> <abEsgvG547veeuVU@google.com>
In-Reply-To: <abEsgvG547veeuVU@google.com>
From: Jihan LIN <linjh22s@gmail.com>
Date: Fri, 13 Mar 2026 22:42:16 +0800
X-Gm-Features: AaiRm52u47eggjN5ILSVJD2qajNpAe1MOhxFuX-Fmy8LWt8Dm7EhiDYU7aU65Vo
Message-ID: <CALmCz4q1WVGrTqibaxAnXK1qkOoLuC9TqLFdV43h-VNiDdCPzA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/5] zram: Allow zcomps to manage their own streams
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Wed, Mar 11, 2026 at 4:52=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
> So does such a hardware exist?

Yes, there are a few examples, as far as I know.

LZ4 is relevant here because it is widely used, and decompression is
already very fast on the CPU. So a compression-only accelerator makes
sense.

HiSilicon has hisi_zip in its server SoCs. For LZ4, hisi_zip offloads
compression only, with decompression handled in software[1].

I also found some out-of-tree examples, such as qpace_drv for SM8845 in
OnePlus's tree[2] and mtk_hwz for some MediaTek SoCs from Samsung[3].

These examples suggest a similar setup: queue-based hardware, while
software (or synchronous paths) is still used for some decompression
paths. These are the kinds of devices I had in mind, and deeper hardware
queues do not fit well into the current model. Well, I don't have any of
these on hand yet, but this is a kind of use case behind this series.


[1]: https://lore.kernel.org/all/20260117023435.1616703-1-huangchenghai2@hu=
awei.com/
[2]: https://github.com/OnePlusOSS/android_kernel_oneplus_sm8845/tree/ecfc6=
7b9e933937140df7a1cf39060de8dbd11be/drivers/block/zram
[3]: https://github.com/samsung-mediatek/android_kernel_device_modules-6.12=
/tree/4749bfe7783c045f53c50160e05b67a9a2acc3f4/drivers/misc/mediatek/mtk_zr=
am
