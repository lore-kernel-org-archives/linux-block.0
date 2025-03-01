Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D963A9
	for <linux-block@vger.kernel.org>; Sat,  1 Mar 2025 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792412; cv=none; b=ocix8YHtv1qTps9h56XupVrleisM8nf8rMa94QrCtX/bz7it9HsavbW0j+XINZV+XhbjjgZv4tmgfDy0C1CrH61OEnJUO9/pAddarMr2Z4xY0bFbNHPPO4lylOAieC7w7//dZ89UKcdiWn+S9MnCfFd8VXwhwP7W6ltyThV0xPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792412; c=relaxed/simple;
	bh=GJRdH7Py2r4TCQURAl8QCe4ysMucIaXY8Z8uqx8/VG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwQXHYzjJm6Jjtl7BD/5ZjTAUM3O7Ngi3vXknmtsEt7AKSMhtIdnl97WIngPUX9vrYOH8yIsmmngW2VKhwB1SLZJKnAUOhDdQ3SY46eC50KXWSIZTX+L4BqKNx4jpwErrwDGnnfvvLTFUZZzWbrAFIkgEqDNHKZusbwYuANUor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHeGYUMT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHeGYUMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740792409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6dnxp9WYsNQwZ9vI6v1G24aXs3uhHVto8Xb5zEf7MI=;
	b=MHeGYUMT8DYeJ2c4l/n9g/iKHIWgcSRW8NEA9t5TbLbqMyjSy87c/fF5g1KEAxr4zEBnY3
	0OMl/YEnJEpWissG1lV/X0+1LmFp7Hib45k1BE4B98Lz9NBcMgi2OKvXu/ey3Wt56g8/yX
	uJWEYD7pn8S2sxhlBkPuiYmKOUrjOQc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-SfSh6rU6OUO2J50z4yqYLA-1; Fri, 28 Feb 2025 20:26:47 -0500
X-MC-Unique: SfSh6rU6OUO2J50z4yqYLA-1
X-Mimecast-MFC-AGG-ID: SfSh6rU6OUO2J50z4yqYLA_1740792407
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-8617b6c6d03so806098241.3
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 17:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740792407; x=1741397207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6dnxp9WYsNQwZ9vI6v1G24aXs3uhHVto8Xb5zEf7MI=;
        b=e5gupjDmxGWXlJbQvklQUU0nEGQuLgEEAtYn2uqJrcJNXLfpVOEYwYE9VC32HLB6v5
         loKAn3Rf2D7R+Or8OREgXJTUeVQiZXSw7yF4W7v6hBTQWGAz2KZXPQbY0obH/+8swQGb
         u+PtgxM3YjJBTxOK2PzTDRwXimLVKNDxXOSjeYGHXfp/WKgmrZ+f1DiLE4npOiw+/9F8
         Z811wTTP5Ay1uP988KHQqBiMIrXnoHCSkQnawU9WZSYUb2ShSCIegY+Q7XXPP8hHK3my
         hMS7uISoph7Xgbl8zShP0J3ip7acK6oDOSFlR8DO6pPzqnucEpAs7U5qRPSEtWn7Cmsp
         Nsvg==
X-Forwarded-Encrypted: i=1; AJvYcCU27uxGdrPioqb6FOC35rZWdmIny6I18IXi50feCr0kky71HNqIU+M6UeSCifs7KSpVlNJG+hJEnjxuJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgiV9OQ9c0tnlGuL1SvgqgZN1vPMcXqJRJGycZMRX1NexUwmNq
	U1TIc7LIh8jiMXGjhJ/IU7FIenwaC10kvtapkniQZ+xqEC5nZ1rfe1tVBigJCI3lI3DxfA+Gnhz
	qoCC8cuPPXhy48nasrstkqHNFrh+r/XyLIKIjXw9rz1JuOMj6P9XHQrm/wezTv9/RRp2pvncn7V
	6hSCHwh/24Eyf4PpVAi4gejP+hSzvBx+/vgtM=
X-Gm-Gg: ASbGncvufvwNPETjcXj6Kl548ToNwh+qpDg9rWlkltIt4vITTlriYyBN94HBdSX8yn7
	CwHCIUnftnJlYjAYOWMTouH0Pra8pspRNqrtg0Bdy2vYgjMX1f5LFQXMR9JrWFJXz88zN41WMBA
	==
X-Received: by 2002:a05:6122:8293:b0:520:51a4:b819 with SMTP id 71dfb90a1353d-5235b519b28mr3507237e0c.1.1740792407168;
        Fri, 28 Feb 2025 17:26:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO3+RRkopwHC744q1bF4z/l7fKpr6okBzyltA/RQWqBy18J327LdjsIFzinZgD1ijE/BP+TkrCT/6/4YPSDv4=
X-Received: by 2002:a05:6122:8293:b0:520:51a4:b819 with SMTP id
 71dfb90a1353d-5235b519b28mr3507233e0c.1.1740792406855; Fri, 28 Feb 2025
 17:26:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4ae6d363-2f9b-5028-db1a-061b6f1e8fbe@canonical.com> <892c7de5-d257-d4d6-2bfc-62f543965cff@canonical.com>
In-Reply-To: <892c7de5-d257-d4d6-2bfc-62f543965cff@canonical.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 1 Mar 2025 09:26:35 +0800
X-Gm-Features: AQ5f1JrkB2tCsFeunXfn4giFbw2Z7oo7kEk_rkiaUrID7LrQOCtJb0ha_haUg04
Message-ID: <CAFj5m9JEDW0kLfnDhF4xNFzMTpHBH6Xpdb+XVLf73oq3vzCjQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: fix conversion of GPT partition name to 7-bit
To: Olivier Gayot <olivier.gayot@canonical.com>
Cc: linux-kernel@vger.kernel.org, 
	Daniel Bungert <daniel.bungert@canonical.com>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 6:53=E2=80=AFAM Olivier Gayot
<olivier.gayot@canonical.com> wrote:
>
> The utf16_le_to_7bit function claims to, naively, convert a UTF-16
> string to a 7-bit ASCII string. By naively, we mean that it:
>  * drops the first byte of every character in the original UTF-16 string
>  * checks if all characters are printable, and otherwise replaces them
>    by exclamation mark "!".
>
> This means that theoretically, all characters outside the 7-bit ASCII
> range should be replaced by another character. Examples:
>
>  * lower-case alpha (=C9=92) 0x0252 becomes 0x52 (R)
>  * ligature OE (=C5=93) 0x0153 becomes 0x53 (S)
>  * hangul letter pieup (=E3=85=82) 0x3142 becomes 0x42 (B)
>  * upper-case gamma (=C6=94) 0x0194 becomes 0x94 (not printable) so gets
>    replaced by "!"
>
> The result of this conversion for the GPT partition name is passed to
> user-space as PARTNAME via udev, which is confusing and feels questionabl=
e.
>
> However, there is a flaw in the conversion function itself. By dropping
> one byte of each character and using isprint() to check if the remaining
> byte corresponds to a printable character, we do not actually guarantee
> that the resulting character is 7-bit ASCII.
>
> This happens because we pass 8-bit characters to isprint(), which
> in the kernel returns 1 for many values > 0x7f - as defined in ctype.c.
>
> This results in many values which should be replaced by "!" to be kept
> as-is, despite not being valid 7-bit ASCII. Examples:
>
>  * e with acute accent (=C3=A9) 0x00E9 becomes 0xE9 - kept as-is because
>    isprint(0xE9) returns 1.
>  * euro sign (=E2=82=AC) 0x20AC becomes 0xAC - kept as-is because isprint=
(0xAC)
>    returns 1.
>
> Fixed by using a mask of 7 bits instead of 8 bits before calling
> isprint.
>
> Signed-off-by: Olivier Gayot <olivier.gayot@canonical.com>
> ---
>  block/partitions/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index 5e9be13a56a8..7acba66eed48 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsign=
ed int size, u8 *out)
>         out[size] =3D 0;
>
>         while (i < size) {
> -               u8 c =3D le16_to_cpu(in[i]) & 0xff;
> +               u8 c =3D le16_to_cpu(in[i]) & 0x7f;
>
>                 if (c && !isprint(c))
>                         c =3D '!';

Hello Olivier,

Looks like you didn't Cc linux-block maillist and Jens, can you
re-send the patch to
linux-block for review?

Thanks,
Ming

