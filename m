Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB1CA52
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728715; cv=pass; b=mLngysgB/xnUPkNRtWUkwNM0UwUINDHBbpcgaM75b6r5B/URqmIFoP5bOw3XUNvZXbSAk7KwVpveBiEFoyNEhYVlG8XfUylkLpHvxJ1w5BMWvvcP3YVGUxBzkhQibbJuob63FSN7mL+llLnIUXONH+HRhNw4FNfRzIEeQTcpEVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728715; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPAfqLXndjcsO2em9T4nwfVk/ux2PFl2zg1LiUxkPYpqGXfKbrNvAFr/bU1GnfsfJqH6sPu/1+38PIKa3M7/tXmlRslSf2/EQQY7mR6MAJ5IjY4dnS+2vjsBvbBIbO5UbBHOHqQIv0yetsjEs/d1iLFrdKZVZNN6GjB9tx3E5zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFugBvSv; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFugBvSv"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso13946927a12.0
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 06:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784728712; cv=none;
        d=google.com; s=arc-20260327;
        b=G1wTuF1DI3NoAYxVKA/oVpyz952KVccc4/6wynNo4hv8MUnN4VpE2N54JQAyrmewGx
         lqaOLSqtgBg2w7ue5qs6iE98jLghEC5wPgQVwYmBdn4bhQ2AHnI3fsqz5LCRnkGThfvX
         okYiS0hh0VIdcbvJhgBEhue1rTKq6m0eV1LEN7POah/UbVhxtuSCgQT2aiVo+cV5Wu7P
         c93J2+uubAaOwPCyTBlXqfYfKAF9Y/0OLu0fQd3gQp+LfImE+9tp9w6Ksrj5Tc1J9kEM
         JGEmKfEa4k4+tnrW3phZDhK+NcpZs9TbUVZHEJox5eIZwtxyBQGKoczqMvSX1m1Z6xqw
         QBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=xg4Y7G4xsJ4CTE1d0MUKJJ7uK89cEdw6pEsKOxSgsys=;
        b=OiUyHpXx/3qRzQONgdZz64DNlaxOUEstpUkPRBsgPN1X3tK1xN5dHJJ6USaVIK14ZY
         GWVdMCZu6b1bhwuGIVeA4BiP3dHEh6wjaSumTIwh3KqYngFDURGiWU56lmLQx5TYq2VW
         TSyI+MVtH6nd06iA3pHuoFLrtKhj5VnAWwJWiF/IAN2qR/7wtxYjbXhVzMRX3X8klHBX
         I4GOzOzEmG6F4hLcbFRR3phqR7+N36xT5gk4OUwNcKg1orZaZZF6Q/dv0Ikj3G00FFlW
         a481cDNucyo23Mc8SX54XuxrhfRTFhai/b6Y0efZcB0p4n57E5f1BbxW6OrvlbqiWubb
         e9AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728712; x=1785333512; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=ZFugBvSvvkNQDzF/Y6bBkAsMmexJxhwMPu9JA+IrEbuSfYx2OKER0l2dVCng6WNxgK
         UZzDEn4UkEYeJyKsr1FSS/oXeGH/q1cZBLMjf9UItTA6jezwXU7JZyXwJzeEYQlrjSeM
         3l5ZeeCE4nWOR7E+scdgGURb6F6IovcGxlEhHlpfLQv6snKDK7i1HN4lyI+gz30mgA9T
         cBSy3eiv3pqTWci2hss18cue/9kKKE4JpC3cx+lj0MO8qGGryPiUFNnHlskg153FR5Va
         SAEsAEPwZn0XPtkDHV0geIO430kDc/Aw9lO+VRrXJ03WMHPl6wByb5wZJtxl6RLX6oMc
         I8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728712; x=1785333512;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=qv7MFpqoWW5kXyy62vYRpPm9K2wcCyDhKT+jJd0oOSWCTyMpFbfY5OTfAd6zb2VxGJ
         eHeyYQKnGX3IB+iGiJKQhXzkfMWgtV/FOI1GDArWIxrN7K7/PDk+zbqIQfDE499OfLg3
         yGJFAcJmSy032wIGjaaJUHr66RURtjwZSRaeEe6CwGP0bUyx8XLyeZb7zgDXmSKsjGk8
         zULE3YWkygiooYNIO7nRy2YUfkioFm9EJgtFCX2eklyZChIZkw4oIbQH6JbHnH09pq8+
         PwaOZZnmbFlihzLT6XygJ4M4HNHOyGCm/AfL8I0je5QHzmMx5oyAt5yrtiAurVBxY4fe
         p9JQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQ3xPNQVggVuDCbnafJ5A1wIiSVmwUiLQaI3XAxJvy6KWQtVoUTBzxdJbGOiSNGpnSLv+JXlMPKIiI6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRt72XRKrP70UCp/McfLzbUplJMArYv60vHMrvNTQbsEVPV9ZU
	/W3iTc/2h3dfoxlkTNPNlTpcVOJiT3nBRqiV5kT2ad5jx7sbBTL5cQkD1/7cTxFRnQYzD46awVL
	rIoLnp+rq6Fj51QOxbtHSdQfksGOnMQ==
X-Gm-Gg: AR+sD13sbQVsz7NRA3n03WQnr/huycT4iqzjuzfKEt1WKoSU3L+BqDt1XAKkpHibtjv
	9ThigLUN1AWfbzZZ+vwKEaLwWfcNwsOWXwy4QJhF2c6U50rjRzLgGRYdBU2ssBTZN+7KLwbpw+a
	FWywijxalW/r4YOyEjlpkmKx4agPLZ2qAvZLIJxfnoNGPact83X6FAI6QXW/RQQwNXWvzHgLhGo
	noFaB+gjZir+xnYh0tfyqWFxjFa0NdK4+S43qGr5SMAWcSfMci0dRgIBykUp9bLLYkzcKLAt0Az
	MSUgTQ/OjYxz15qAPgpSBD8mAloIBBhA
X-Received: by 2002:a05:6402:44da:b0:687:7fa4:faa0 with SMTP id
 4fb4d7f45d1cf-69e652ddfe4mr7379201a12.23.1784728711629; Wed, 22 Jul 2026
 06:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721071739.2514228-1-hch@lst.de> <20260721071739.2514228-2-hch@lst.de>
In-Reply-To: <20260721071739.2514228-2-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 22 Jul 2026 19:27:53 +0530
X-Gm-Features: AUfX_mxCog6DJT1UpwVnr2jExjcpi3_xKLRWjwEyfTCmYS5lmCCN1PlqdSjVmzU
Message-ID: <CACzX3AuRaqxThqb_e+YCpWQP_yySp3vjfYskMb1HC-8vop85=A@mail.gmail.com>
Subject: Re: [PATCH 1/4] block: remove bip_should_check
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
