Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4679A920
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185462; cv=none; b=Om9sHPicchpEBPepg7LW0IN5/J5P/ln7PE6MVXTuQzyGjhcN1Y2OCILsadd4JIodM/dVJPVjCQL/kn5yh2y9W88HffrXPG1gfwT17cHPxV0rWthLPrysrzxLWNu9FNNCLh+Dy0WMC1/oQfHkf1X3FIBvdCu2+RNjRUqbytaonFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185462; c=relaxed/simple;
	bh=XMGQh/zyfxVWSHnYYnjLTSzIKpMxaH6QrUZBb+zOr6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8V0jwuVzaFNwca3BmqbcBbpzxhX0O9ny3n2oe5arjifu2juHXGlUWioyd/SFV7RwtGRLcmCKacGnusrhApW4VWpyFehTcI3R6wWDMR8cTRrnatlsrQ+CMiomlJgPZodHywyN5hJA5Wjz1yIE4XiSqyRXk5FWyTGXihAk6vw8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G99BRHIb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G99BRHIb"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so879487066b.2
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753185458; x=1753790258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMGQh/zyfxVWSHnYYnjLTSzIKpMxaH6QrUZBb+zOr6g=;
        b=G99BRHIbbb20ReZ1X8Be3eVwALr1gIOlXtxobR+1dR1PAzAt9q/HiXOVPZdS/PW6SO
         0Uq2e5MOa+ka3+OgPERpH/eFe9esictgeOGX6FqX2zIManywvwrLAs0fsac9fqs3Q821
         ENYYYQYchK0E7luLROxaX6euepyNqtc/yxoDvkeUn/K9Gya9dysIe232tkt/FdzlEJOY
         eJSY+QumpXBtR+l/J/L6hF+tiNfUinE4ZkyvQvAyzS5WxWY7YG4k92Y1K2bPQPI5ixyy
         VZUpnX4S1TkKfFYUV5TAUCl15UOkQRgBXK8V4i3w0CEQipE8Eyxw9TdK+WqhsCk9zPBk
         7ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185458; x=1753790258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMGQh/zyfxVWSHnYYnjLTSzIKpMxaH6QrUZBb+zOr6g=;
        b=VuOMQpW5JArKKNYkT+q6CQJbHeF3HDZakfDPSFTQn7r5/RrQ7H+gaX28a9SWLHqebD
         kFFh7x7e20Jp7BG1N4136RjVzgf/IzEwWYHcOQb8hothyIefQ7bm4cb3bFBEXd4USrTR
         gs29lXLS/JUAnwnSv6jKVAeeagpA2qBBJaFzi3aAEE096QwfJVSgidUiFCfq8i5Kdajc
         wcGeyVd6SiZEl2LVzJ1R0bDZR0oBtQ4a4IYEQnl46tR7RdrTHjucQTgowVaUp4DlHZOH
         Gk2gkn0/R+Ag5igeNURJqFhv89xHClQfimTgqguZHj8PjzFvJ7gLn7l+5xdtpeYzya70
         4Vzw==
X-Forwarded-Encrypted: i=1; AJvYcCUuEOia42JQB21u6uA0Odz2h+husgFA6uez45Rnu8p26VjtIYWJJ6RvL8ka4IJrkE+2pvBAGzDlbJH1BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvv2/wJ9JlThP2pDo8ggi/Ev0/y/XHnxnUyaUxyPOX6HB6eiwN
	I7o1tZmJqXiynpwi2woftJUsPWNAFt7vGEZnv1tgei5aJ9Q8yMMYnRa+Mns0miZ167N6TuFGv30
	/Kyn3vjPXdVRAWYcfCyhDD/GMDNq7Vted4q4Cgw==
X-Gm-Gg: ASbGncuSLZL4p4YkNmuQ/jfzGx58mtgPHmm/sKodTcd0XAcLGgXlwhFw1iBHJfZDsqq
	dagAb7AHDVaaVuvn4UfY6uosa1PatT2V2MtQIReMmJ6rGz1g0Cb0Z4GsqwHAoW4OH93567CnuLH
	gpd8LCaGo+9CJLPmWOg+sEhnTU+YZ5mGNgTPm8h6NQ4I85Wq4c2S8DPqDxVm2obcykaTauRqlF0
	qsdYXe2YNaz+SzuLw1lokwZxN6x/WYVT+jo+g==
X-Google-Smtp-Source: AGHT+IFecnxQGo7tjWR/0rrEMMAULIS+3LWv5b3qyFFlBUrRWIzqkGfpRjO04WtozbnO0N6+lwqkKaAchBGGm2U74A8=
X-Received: by 2002:a17:907:7e81:b0:aec:4aa6:7800 with SMTP id
 a640c23a62f3a-aec4aa6a010mr2117114666b.20.1753185457529; Tue, 22 Jul 2025
 04:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e@epcas5p4.samsung.com>
 <20250722091303.80564-1-anuj20.g@samsung.com> <e4bc2fa4-5137-43b5-b11b-4a9ca6519b54@kernel.dk>
In-Reply-To: <e4bc2fa4-5137-43b5-b11b-4a9ca6519b54@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 22 Jul 2025 17:27:00 +0530
X-Gm-Features: Ac12FXz0YF0peij3D90SjMsM2M7AB9TszT1RXI1i1ZFQlxWgbNaY24duI92SQ_8
Message-ID: <CACzX3Av=CdrHfchof+LXpAS9=0eTAMxjh0Zs_Cu3O3e8nxYDEQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: fix lbmd_guard_tag_type assignment in FS_IOC_GETLBMD_CAP
To: Jens Axboe <axboe@kernel.dk>
Cc: Anuj Gupta <anuj20.g@samsung.com>, vincent.fu@samsung.com, hch@infradead.org, 
	martin.petersen@oracle.com, linux-block@vger.kernel.org, joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Where is this sha? It's not in the block or upstream tree, presumably
> it's in the vfs tree due to it being an fs commit? In which case
> you should probably CC that side, as this cannot be picked up on
> the block side.
>
Thanks Jens, you're right =E2=80=94 the original patch went through the VFS
tree. I'll resend the patch and CC Christian and fsdevel accordingly so
that it can be routed through the correct tree.

Thanks,
Anuj Gupta
> --
> Jens Axboe
>
