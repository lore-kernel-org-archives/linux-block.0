Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993137F8BA
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687116; cv=pass; b=uVcQ9lSu08gQ5vkoOs1Onj4Gwz/1NOz/wfvwwI2g2UYhJUYuMx/QwM0C4qOPdoCCC2Nx1WoJoP1XL42/e3K/01ytOwdRg5S1OXjCagoFEINhhTsCjFShiON9j/ZvqtT7pXQkVrjuO5/Wmc+INNT2TEc+aFuAE+dg2nAA+VNAxCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687116; c=relaxed/simple;
	bh=uFF7F5wwW25E5isy3/J88ERKGPqsBVkKrFrMt2UrdyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lc0fN42TienTXFLzqnuhURsRPUtMDlFI3510ugXmPOno3FL+wTTyU/bBUvFym4KAD7lOCzdLRm3lI4CmmZWsqrqLsXQsnmCJkESAY7D/14P/+HWNAGuLTI2bojdvpKPjqCAHtVdiaSjpBM24eW1MSFuqYaFnOC9iIGDpHAlF5ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbWL9OwE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/yEcbs/; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbWL9OwE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/yEcbs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769687114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFF7F5wwW25E5isy3/J88ERKGPqsBVkKrFrMt2UrdyQ=;
	b=GbWL9OwE7Rh5d341iLUKoLs1m6sktGlgOJvzPZTkOmkWLttKL7iE5/Bnad+3MVwnD3RgYI
	qpjE0OTgKlwJfjTQCvzDdP8aLdhKUNwBocWY9ECDfzsX3vbLz+cfLTxYyCEPMjvklaAOpB
	9tfTeTGomy3kWaSAAvvGQhfO3cOa090=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-2VFiGDfCOy2wD60XzLbDGw-1; Thu, 29 Jan 2026 06:45:12 -0500
X-MC-Unique: 2VFiGDfCOy2wD60XzLbDGw-1
X-Mimecast-MFC-AGG-ID: 2VFiGDfCOy2wD60XzLbDGw_1769687112
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9480078b2e2so1318874241.2
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 03:45:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769687112; cv=none;
        d=google.com; s=arc-20240605;
        b=PNlQSbkO+q4jJNRnrliNeMhYkMVhj/4Bc7d3LWCeJ/bQ9lZZGz04+j5zrgffg1bAhT
         fcBfF6TZ9pW53rJ1nizm2TZlPaSbKg9dE8pQwrjUI+znrsjKFsqE5BxMedDY3fLLCBsX
         /BeQGfyzDNcThZiK95wYO7Gga7wxTI5v7a4e7Qv8kNXkN5kup9vghtf+qm8nE7E1cQxH
         tCj9ZpPimKfPORBiKeRzEKi/6hw9nLZNlemSHZCIk76hLpm5z1vqYei26ESCSntMsuSR
         GTpE0725b5O2a4vv/Clyl/F5RvVqyVCMLZXnY/9ZXMiEYaOTqow4C981Tknj61/AfM36
         VDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uFF7F5wwW25E5isy3/J88ERKGPqsBVkKrFrMt2UrdyQ=;
        fh=CysW9uMwcETs49snXGtxTC47IwNBK+R32FwTs9K6FHE=;
        b=CH8pJqcJamb/Lzo5PwJBiSSv05exCB9YGVeDkmdSeeIQBepWWQThIdKOSH0Aubk2S1
         8tGCez42fZ/PlzhYtSHAuPZ077upzTAKT7ygmSuuYeVsidt3CMxcihIbpW+jTdV3Hl1p
         TgxZVvtz00dMdVkNPzgMLqLP+jl9mfzwUUY0+Bi+/xgiSjoSWOey5vkLbQ0VQHY2P601
         UR+76GjOWovxZklXa7MdVoQBWeeqZ6wiGY2wSCec1c8UzmEPbsYXkGi+6O3vLN+ID9qy
         cTUNmB4bR4Zeg7EZ5grvLkNETokhlszzJF0iYi6bmqJNmDYq1N+JtEcoBTrXYtId9W4X
         NfMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769687112; x=1770291912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFF7F5wwW25E5isy3/J88ERKGPqsBVkKrFrMt2UrdyQ=;
        b=h/yEcbs/w0sVKKHnvlITM927UHvXk21YZHL/SYsuG18RROaKM09oxjR5jHZaoIrGbR
         rr25JCH/8YiWnfil5G7r3QU9jDymYrjsTNcFUwNHyoykd+VYsAHB3dwn8W/Xuom451pn
         3N3PAvw1C1rQTom+Y58+K2A9x07gG2BBOMEqh5QFe2xHcHTx7Qw0gTRFwCeg3VnKNetv
         ep0oy7sCXkOPu0gV6asgwA96dluzQ4aPt6qoqLEaK90yHKEtfG19tAMAdAFk5fdsnJEA
         CYc0GcLmZrA22oeqShVexNXVEq0GasgC8Vpg5rbVBOEaOpt7E+L5IiX0SxeGA10NAbCk
         uTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769687112; x=1770291912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFF7F5wwW25E5isy3/J88ERKGPqsBVkKrFrMt2UrdyQ=;
        b=g1FmeVvyreWi3nZJJaTGgJqniYLQ4U8ISTV8YAf6Q3sHO3KskHKKesxXFx+8dqXs2L
         eTJM7z5BqN3rueN1/6VTkg1oKNIX5Zv+XdhyL4ifLFqptFl1UhPYi3wMConQcQBI/rKD
         ciKWmhlRjCbvyE9q00AUp3vH7V1nkoFGQdaVTAdF3aEdMOsvnRwtu/rbF4D3XCVZCpWp
         GmLy5nSOKMzGODa5ubm1PohH8uz2nuS7vaOdh37oHHrFLAY2CZO7B9Rhf+wDZbi+MFHo
         Lw8/X5+kw5FCysR7HIuvODSGUkAgGIOC0zxl/qMOr6YitGscr6TQRlgsQORK5ZlBJjGR
         lRag==
X-Forwarded-Encrypted: i=1; AJvYcCWOflKmQx+AgYOE53nCvn+AGOCPTaLN/VGTXZTszhWSTGb3dn1zZOspGYBJBRV4Ubr5cZrlcqjuGcmoHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQZO/TQqX+ArWX9uScGX9mYjXFoMcFv2SHNB0s12Sni30pEyL
	RfJOCktSHKaBMiSInMlPSade+g4P/S1+65QDzYaOYOay7IiMUNL/cb0wFLlwe4qkMZ6kXJNlMr+
	+WebCTGi6vv9WSv7iem9oMKgrqgnFTLvSKoIaLV9/W+f+tC1bYhDaHh07SwSAyePDLRypIj1US9
	aSVytMAcWr0vcszkwW7DOV6ASRctSTJSKYU1Pslgc=
X-Gm-Gg: AZuq6aLHK25deL6rZw2aw3xrWSqUeeMpWrJKqcf7kHdwXP4tC5fQHxxclFek2cKCwRL
	cQYJQQMNsPvtVx77aqUBv2Xowen7HQD7oayFGiKRN3U/ZeMMomaCVmjOj83AakKnn0YI75aZ57U
	QWlj4KhsYDdxEgeKLucFgOFE6BGhdZIkDSc+CiMFpmGF/IrhSf5hnt0ZRDYpKR2YOYNdQ=
X-Received: by 2002:a05:6102:3e89:b0:5f5:4247:8d08 with SMTP id ada2fe7eead31-5f7237859a9mr3031527137.21.1769687112272;
        Thu, 29 Jan 2026 03:45:12 -0800 (PST)
X-Received: by 2002:a05:6102:3e89:b0:5f5:4247:8d08 with SMTP id
 ada2fe7eead31-5f7237859a9mr3031521137.21.1769687111818; Thu, 29 Jan 2026
 03:45:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129031501.3403688-1-ming.lei@redhat.com> <20260129031501.3403688-4-ming.lei@redhat.com>
 <049F669E-AE1D-4FA7-8F97-3962ECFCF561@zazolabs.com>
In-Reply-To: <049F669E-AE1D-4FA7-8F97-3962ECFCF561@zazolabs.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 29 Jan 2026 19:45:00 +0800
X-Gm-Features: AZwV_QjFKeChZcQ0lojRfwNqtLTRMdxBQEucE80VUooIUdb8oOm9--rVgKF4C14
Message-ID: <CAFj5m9+2vdOtApDdy3xvf0zqasqv6y2r1M_AyD82g2Yd6KDPYw@mail.gmail.com>
Subject: Re: [PATCH 3/5] selftests: ublk: derive TID automatically from script name
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Caleb Sander Mateos <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 5:50=E2=80=AFPM Alexander Atanasov <alex@zazolabs.c=
om> wrote:
>
>
>
> > On 29 Jan 2026, at 5:14, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > TID=3D$(basename "$0" .sh | sed 's/^test_//=E2=80=98)
>
> TID=3D$(basename "$0" .sh)
> TID=3D${TID#test_}
>
> Scripts are using bash, so can save the sed call here.

OK, thanks!

