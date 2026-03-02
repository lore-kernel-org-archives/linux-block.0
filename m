Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4E3FB066
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460333; cv=pass; b=hqSfO2X3AUd4HSfvRNubSW+OZPRiKas72RqAxbe8h5E3HUiM+yHwftj1tqDOxWS4aGaVYoND8H/x/WDLHO+7/vcuyUufZiimptK2zXOuTV0MCr55TlkEyrQu0iRG81Ukh4amSoXv3bwzSGBUPKZFQkEDHVFdcJHcc3IYP8dfP0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460333; c=relaxed/simple;
	bh=+Jtnm0uNtymT1FwYm02Yav/dvzx9YAh1G5c3M9hH6fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iym8PyxUXvFAGOMwNM5P3Ttaqkx0o0uHWiDNj9xv1ENMMbrtUZ3rmSiH7dO8cI9sDGk1TH4u9bX9q+qctbH2wFYEeVM9bCQr9WOay9bXS1IpdfydhVAZ+sJGLc0hUJaFoYIvWiHZpln4DktM+AwDzu3+QIvsRQ+9uDT1iYI0Cn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfauPTL1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mPOZitxl; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfauPTL1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mPOZitxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772460331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVk/RUechncjGrn5kc8hmHddMibm8MU/p6vKSfehHUQ=;
	b=cfauPTL1hs2iTXZQU4xnwFuhHkCIrsStWvQB7wfK2VRps7vQIuYz0SswOSzTpRALGdroQ7
	MwiiHBjNlhlp7Ku5pxJ5LvGAqkYjTe+FlUykg0sor/eKwlZ5hJYhbCIExij0QKkXNY9xDy
	ncKniBCstnJXc2ZxWeKWbpQ7QLbchFM=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-NQE8WPWPPDqF03SVZ2wTzg-1; Mon, 02 Mar 2026 09:05:30 -0500
X-MC-Unique: NQE8WPWPPDqF03SVZ2wTzg-1
X-Mimecast-MFC-AGG-ID: NQE8WPWPPDqF03SVZ2wTzg_1772460330
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56a9f0319d5so47404572e0c.0
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 06:05:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772460330; cv=none;
        d=google.com; s=arc-20240605;
        b=Jy0aprC74JQrkXIGMG0tVwJy/FqzrGA/qUVGih1nAkppssbUKN5tBbJ/p9PO1Hv1TL
         9wmakVc7EU6rGppmhMWxkSN6Urr47FYYuhJjU5a8D0wpQCygllZxvZyC2scIyjaa5Wyz
         zgcLBA6x+1b5uFd0JbBFQyb2o1a0xTbNzw6YnCh2XfyN6mnxPoUFsg4nGEOEjdLiwibe
         chyh8qmsLuMkJXVEf8gNdY9CAbXTDW6NjNnYnLWb9XK3f61LlM9parlu2lykkkahqFWX
         31p7w9zjTCuzVCAvlQXfKqLo/OcdvZZbF0S/8ZWPKnuHPqumfgkFEujhRQqVwo62HwrH
         hpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HVk/RUechncjGrn5kc8hmHddMibm8MU/p6vKSfehHUQ=;
        fh=GjAikGrzv7zohtjYfVx8r3tu7SEq8poWytU597qzwlg=;
        b=TXsg8tCqvYYd6nOShQoToy9we8IAaxEbJ6Gkx0VhmMKH0tvEb6CRF8mfqgX1bvvthe
         soyNurc4twcPFMlZNzuY5P/QIuF4ZeARPQScOHFWXV10XDyjsubYQkgaRzlKsipZTNmS
         6zuGNhkIBzB98GKM/GTBlrgr8N0uQc+2mdM+76zAYkpgweyiXomS8u0LPIyLoMyGHpcX
         ya6tHaK12yrkpdDZLC3FWFdd7uxp3q9hNNcfZECHzdFNi3l+BbIoZjzObwwnzn33mfYM
         NuO/GlavWwiNUiheOSgI6Hm2mVvoRXuVD94+bagaP+NMN+jHf+6lL96wNFQjEd/6pAud
         FrAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772460330; x=1773065130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVk/RUechncjGrn5kc8hmHddMibm8MU/p6vKSfehHUQ=;
        b=mPOZitxlX33w9pT3aR08QrOcEWYhNXmeKvopDQ250HC7ZpSHSUgejkwbERI6EMLeZh
         thDN2BAvapqe/O1TLFZiKkKmUxpBLVAGOKLVNoi0+jzE76QePFaJgz1tnww8eAnZWhQ8
         91uJj4n/15CYrgVU89vhxNNsgsPEEJruPg5o7yip7Oon7QXznis4eavc65ZS+GIfK/xP
         mZ6gY+AlcbdQb0ENNnGh+Fj5S7dNtusnuIuT9aMMeqtlzJnE/Zp+urbOjjPhGIjJFR9s
         SxPdt8XAwW2T+j9nHIJFks0WeYoaUorpHinT2t+3vuMEGThA6cne1FDA9TYaxzRNhhmH
         AdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460330; x=1773065130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVk/RUechncjGrn5kc8hmHddMibm8MU/p6vKSfehHUQ=;
        b=lkLF86EJhA77REJJfGHE54ayefDVQkmUcyzRshVBT2ZU6oNz0WBfbVMbfw8qY0astp
         I2t3yky6F1J2STEDCQL9pobM15wAlZLEu4b24nrtgUSmZ/ZCX2HXNJj4FxoI62l5IM1V
         k6RuF8u6HsocCCx0wk8pfJtI5HOCm4aWlEAGU8NUjPzyxgUTf4/j7GBWU4NO2qKWTbNM
         8m1QrUvhh5pG3V5/iW8i2CCpIsKTO0qIagYg8+PztkOQUOz0wTV+kHLtphfhYsUwbCGD
         sEOIRqUAfykAjzdGP/+HjKe06nibC9mY0OGh421Mi/k4IbJ0U0Q5fsQGM3EVBQdIQUu1
         FThw==
X-Gm-Message-State: AOJu0Yz6BpR4XdJBXlhfXu5dnyvwwqtCfPVFx7kQahYNa0p8eBsGssmq
	RPtz/Q0X8CZR5LuJfZkP8k7BGeVSta7/ninfKUJG66Yd+3KS2LHQIqrs7dwK9O3DGkU3Xsy3L88
	cGuHukK6wM/bsfR/GAEJwlHYRQWu/m+RQtqnbClUvY8yaqZeyR8bh1VHukmiFHvKzhHh5xCK43W
	F5+MieAnniekhxMgQXwKJrs4BGt1Xyug1v9nLHnU8=
X-Gm-Gg: ATEYQzwsLiLNfK+XkVrHZG8XtU5myqGSfOzzqDyjnRACZU5YezAGzcm2PbqwcLy/r1h
	7ekE+la3mu0RXJF0wVYxzBzh4AWlPd3JSki1F1zwjumD7/HpLHzZu8JC0FdCY8hz1ejJLeuzkxz
	xpvQmLJo2AaS0Ihf1pdoOCJGDBLbT+qK4ySx/0AHpMtA5L4WhyPIuxnTlk4qBIx/MZrHtVfhscj
	dfZ+vc=
X-Received: by 2002:a05:6122:9006:b0:56a:899d:6869 with SMTP id 71dfb90a1353d-56aa0a2898emr5775995e0c.8.1772460329842;
        Mon, 02 Mar 2026 06:05:29 -0800 (PST)
X-Received: by 2002:a05:6122:9006:b0:56a:899d:6869 with SMTP id
 71dfb90a1353d-56aa0a2898emr5775975e0c.8.1772460329444; Mon, 02 Mar 2026
 06:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301125951.582690-1-nilay@linux.ibm.com>
In-Reply-To: <20260301125951.582690-1-nilay@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 2 Mar 2026 22:05:18 +0800
X-Gm-Features: AaiRm53k_qDAqeq_HN3lEGwxqGwH6GYN5oeNnk18JvPkU9701pScplXEESGkmT0
Message-ID: <CAFj5m9JWnSyCiQSFda6-cERmxsOc5GvJsNQF4veb1x+X9kEpeA@mail.gmail.com>
Subject: Re: [PATCHv2] block: break pcpu_alloc_mutex dependency on freeze_lock
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, 
	yi.zhang@redhat.com, yukuai@fnnas.com, shinichiro.kawasaki@wdc.com, 
	gjoyce@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 9:00=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
>
> While nr_hw_update allocates tagset tags it acquires ->pcpu_alloc_mutex
> after ->freeze_lock is acquired or queue is frozen. This potentially
> creates a circular dependency involving ->fs_reclaim if reclaim is
> triggered simultaneously in a code path which first acquires ->pcpu_
> alloc_mutex. As the queue is already frozen while nr_hw_queue update
> allocates tagsets, the reclaim can't forward progress and thus it could
> cause a potential deadlock as reported in lockdep splat[1].
>
> Fix this by pre-allocating tagset tags before we freeze queue during
> nr_hw_queue update. Later the allocated tagset tags could be safely
> installed and used after queue is frozen.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs8F=3DOV9s3La2kEQ34YndgfZP-B5PH=
S4Z8_b9euKG6J4mw@mail.gmail.com/ [1]
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>   - Make blk_mq_prealloc_tag_set_tags() return the tags pointer directly,
>     encoding error conditions using ERR_PTR(). Update caller to use IS_ER=
R()
>     to distinguish between success and failure. (Yu Kuai)

Reviewed-by: Ming Lei <ming.lei@redhat.com>

