Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7613D621
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458867; cv=none; b=f0ocU4VAZuE87jtgaEMPGGd4N67zd2MZCtVmPOdxSvHhYrgBG1nRogLRolx5EBpRw7Ix5wvLa04YAhZ6SzWdQjtGFWzE9XVcsw5uA343cXXrhwlJY6I8AuxVab+cnvGg6SwdzHmcdtbxpNNgs1tSVLzwaU8hoLs05JFiKmd4r8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458867; c=relaxed/simple;
	bh=V3Avyu3RlQui1rkCZfdtuNFZBa7XI363YTcKk9TDb6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra1cj2wUHmLabnGkuY+A+a5lhX2958wem5CBXPu7vb7EDP1+doT5bcVxtevs+Ir8KnpeOBet25YmfwJ1eEo2uPr6Wq8lNoLmnzxg/ElaadCGXBrlWe2fejnQyB9fxdf212ayoTuPw8vY0H7nKjP87bo2UyZxrvV7NSwGFJJHl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWowo0Sy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWowo0Sy"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e719bab882so58426911fa.3
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716458864; x=1717063664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvDc6jz8jmVSjn+VtLr77od5NBhOCfBZN97jv/y9bf4=;
        b=JWowo0Sy3WqSwBaQdpwbaxH0YtsLGSveHSrzEAt3XW+YS1OHZA7Yur+yrEhOtkrLya
         cVFXVcmR1AYZItKB9NNaG6ulXjZuc+K+EgA3Ttp1iu7x9A4fb1JECFj0at7LHLPCXEmC
         3U2r4A3llTY6SukSRmJ+lKjs3gWXYdiL48ea5YCGiTv0y+bYEh2D6z3gA/k0AImuKuyO
         lUNK+/gLxQUqlJmTDT0x4IXpJ5Axlth98CeN+bMznVum2wQCCWjFhD5xuI/GCU96GjUI
         aDU7+lyCYlHgSK5bKcC/wCC4hH6ZVXagH0FYZBYVbENTM0ntr9ZKxu7FlAZVN+n+Wy1W
         tXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458864; x=1717063664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvDc6jz8jmVSjn+VtLr77od5NBhOCfBZN97jv/y9bf4=;
        b=sbUuR9RM3SyxbAVzAJyTksdEM45yXESVPi5LtFfh+fndxeZKtM1uVjDEhPt0UvTcfr
         KOogAlA0GoKPg/TQqtQGBGzBbQvG05vWmpHhCqEcubEZ4QbVWPPhdobsGTZZQd7Ec7w2
         a/dm68/lKU6/XbTrmxgPFothh77rdMXPmdHbgoKwSc+MGxtgmk6xL3B2mtg+gVRuNRFU
         xeNibYNaXSds3SBiyW/EBepiH8ya/4Ub8r7QC+6H0+222YiOkX087ShqBapTYReBU5O1
         v+EBdU4e2Mobtgr44xM6uEIJJGiKLjr6N15kEarXhrEgpuMxw4OrITq20R0uLVZXJLxy
         VDCg==
X-Forwarded-Encrypted: i=1; AJvYcCUT/fU8FAL12weqV8B98oAX6f9qAIq7IzIESjSgPhYuOuIGuKBMRJlcvh0s+lUgm58rIHPjwESnouTil1CF7HoyI42PeXkSCfLQYO4=
X-Gm-Message-State: AOJu0YzaRnpiR1mOMNcaRo56wq2zDtdV+sV5r1JNNEQBp0SyD+/ZSAh0
	/IFWgNaEnqzE7YmvcGOi1TwVdT7YRuNOWcSDu4rXv7K6V7VoHXKIZQPDN7p7IxxYq+hv4svXqKr
	I0rEu080lkzUxzZjK2zTQp/lxPHk=
X-Google-Smtp-Source: AGHT+IHrA1NsHA9Fma+/VqiSWNGL7NWVMOXTNgRSQKXTZDEEmstymZjKm3aoDjR26g/8NDpgjO0maIk3sUoltAZerTk=
X-Received: by 2002:a2e:a58b:0:b0:2e1:d6d5:634b with SMTP id
 38308e7fff4ca-2e94961d179mr30904011fa.29.1716458863562; Thu, 23 May 2024
 03:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507144509.37477-1-kundan.kumar@samsung.com>
 <CGME20240507145251epcas5p29e95da982219c6a1c196182fe70a45f5@epcas5p2.samsung.com>
 <20240507144509.37477-2-kundan.kumar@samsung.com> <20240523085136.GA4777@lst.de>
In-Reply-To: <20240523085136.GA4777@lst.de>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Thu, 23 May 2024 15:37:32 +0530
Message-ID: <CALYkqXps+7yd-gDARg1g2FaSZDzaVLUFTHenMxhAqNbFb5EJug@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
To: Christoph Hellwig <hch@lst.de>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, willy@infradead.org, 
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org, 
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 2:21=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> This needs to go to the nvme list and all nvme maintainers.  Please
> just resend it standalone while you're at it, as it's a small and
> very usful improvement on it's own:
Sure Christoph, I will send a standalone patch for this to nvme list.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
